Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B221335B86E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 04:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhDLCOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 22:14:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:44062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235543AbhDLCOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 22:14:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91B93B020;
        Mon, 12 Apr 2021 02:13:50 +0000 (UTC)
Date:   Sun, 11 Apr 2021 19:13:45 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de
Subject: Re: [RFC] [PATCH] ipc/util.c: Use binary search for max_idx
Message-ID: <20210412021345.lvhxhsro5wqm6w6b@offworld>
References: <20210407105926.198404-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210407105926.198404-1-manfred@colorfullife.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2021, Manfred Spraul wrote:

>If semctl(), msgctl() and shmctl() are called with IPC_INFO, SEM_INFO,
>MSG_INFO or SHM_INFO, then the return value is the index of the highest
>used entry in the kernel's internal array recording information about
>all SysV objects of the requested type for the current namespace.
>(This information can be used with repeated ..._STAT or ..._STAT_ANY
>operations to obtain information about all SysV objects on the system.)
>
>If the current highest used entry is destroyed, then the new highest
>used entry is determined by looping over all possible values.
>With the introduction of IPCMNI_EXTEND_SHIFT, this could be a
>loop over 16 million entries.

So the lineal search, starting from the end of the range, won't suck
as long as there aren't big holes in the range from the max_idx to
the next max_idx, minimizing the amount of idr_find calls - this was
accepted as the cost of doing caching the max_idx for O(1) access.
Of course, when not the case, the binary search can save a lot of cycles,
and I agree it's overall better than trying to predict rmid patterns.

>
>As there is no get_last() function for idr structures:
>Implement a "get_last()" using a binary search.

Right, nor do I think there are any users that try to avoid the lookup
caching the value.

>
>As far as I see, ipc is the only user that needs get_last(), thus
>implement it in ipc/util.c and not in a central location.

I find your implementation to be both obscure and elegant :)

Some nit comments below, but I agree with the idea, with the observation
that the search will always do the worst case amount of logN loops, even
when the retval is found (in which normal implementations would just
break out of the looping).

Acked-by: Davidlohr Bueso <dbueso@suse.de>

>
>Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>---
> ipc/util.c | 44 +++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 39 insertions(+), 5 deletions(-)
>
>diff --git a/ipc/util.c b/ipc/util.c
>index cfa0045e748d..0121bf6b2617 100644
>--- a/ipc/util.c
>+++ b/ipc/util.c
>@@ -64,6 +64,7 @@
> #include <linux/memory.h>
> #include <linux/ipc_namespace.h>
> #include <linux/rhashtable.h>
>+#include <linux/log2.h>
>
> #include <asm/unistd.h>
>
>@@ -450,6 +451,40 @@ static void ipc_kht_remove(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
>				       ipc_kht_params);
> }
>
>+/**
>+ * ipc_get_maxusedidx - get highest in-use index
>+ * @ids: ipc identifier set
>+ * @limit: highest possible index.
>+ *
>+ * The function determines the highest in use index value.
>+ * ipc_ids.rwsem needs to be owned by the caller.
>+ * If no ipc object is allocated, then -1 is returned.
>+ */
>+static int ipc_get_maxusedidx(struct ipc_ids *ids, int limit)
>+{
>+	void *val;
>+	int tmpidx;
>+	int i;
>+	int retval;
>+
>+	i = ilog2(limit+1);
>+
>+	retval = 0;
>+	for (; i >= 0; i--) {
>+		tmpidx = retval | (1<<i);
>+		/*
>+		 * "0" is a possible index value, thus search using
>+		 * e.g. 15,7,3,1,0 instead of 16,8,4,2,1.
>+		 */
>+		tmpidx = tmpidx-1;
>+		val = idr_get_next(&ids->ipcs_idr, &tmpidx);
>+		if (val)
>+			retval |= (1<<i);

Perhaps get rid of 'val', and just do this instead?

		if (idr_get_next(...))
		   retval = tmpidx;

>+	}

Mostly thinking out-loud. Suppose the caller is doing RMID(10) == max_idx,
and no holes, so the next expected max_idx should be 9:

ids->max_idx == ipc_get_maxusedidx(10-1) == 9;

So this will loop from 1 << 3 to 1 << 0:

	       idr_get_next(7)  == T   ==> retval = 8
	       idr_get_next(11) == F
	       idr_get_next(9)  == T   ==> retval = 10
	       idr_get_next(10) == F

	       return 10 - 1; // good

And with holes, ie: 1 2 7 10, so RMID(10) should update next to 7:

ipc_get_maxusedidx(10-1) == 7

	       idr_get_next(7)  == T   ==> retval = 8
	       idr_get_next(11) == F
	       idr_get_next(9)  == F
	       idr_get_next(8)  == F

	       return 8 - 1; // good

>+	retval--;
>+	return retval;

Instead, just do?
	 return retval - 1;

>+}

>+
> /**
>  * ipc_rmid - remove an ipc identifier
>  * @ids: ipc identifier set
>@@ -468,11 +503,10 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
>	ipcp->deleted = true;
>
>	if (unlikely(idx == ids->max_idx)) {
>-		do {
>-			idx--;
>-			if (idx == -1)
>-				break;
>-		} while (!idr_find(&ids->ipcs_idr, idx));
>+
>+		idx = ids->max_idx-1;

>+		if (idx >= 0)
>+			idx = ipc_get_maxusedidx(ids, idx);



>		ids->max_idx = idx;

We already have ipc_get_maxidx(), so the naming here is a bit strange.
How about renaming ipc_get_maxusedidx() to ipc_get_nextidx() and let it
handle the whole logic, pass along the ids->max_id without decrementing?

       if (unlikely(idx == ids->max_idx))
	 ids->max_idx = ipc_get_nextidx(ids->max_idx);

Thanks,
Davidlohr
