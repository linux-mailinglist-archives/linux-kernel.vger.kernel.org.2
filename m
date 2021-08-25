Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8783F7E47
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhHYWQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhHYWQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629929714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWpEmsqJr39w6Xc+i4JNDnieFbRONi2PhdcIf8fhsDA=;
        b=VlvX/euCVfiX/7AwKRl7FAjaWrnWvIB+LJ/lfxg1uGQrZRTPdy5j+dPYQWkSvjSffqzjq+
        81+8FmwXUEE8xhTXBZVbS9Vh8zXONrBkO7PeGguqmQrnCSx4Sqs8JpyQq42HZFBoR/S2dn
        X6PKVwumipiWhU7XUV5VI4G42ezzitI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-75Cztv9NMgGug4q5RvhRag-1; Wed, 25 Aug 2021 18:15:12 -0400
X-MC-Unique: 75Cztv9NMgGug4q5RvhRag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1C35180FCCC;
        Wed, 25 Aug 2021 22:15:10 +0000 (UTC)
Received: from optiplex-fbsd (unknown [10.3.128.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA73069320;
        Wed, 25 Aug 2021 22:15:08 +0000 (UTC)
Date:   Wed, 25 Aug 2021 18:15:06 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>, 1vier1@web.de
Subject: Re: [PATCH] ipc: replace costly bailout check in sysvipc_find_ipc()
Message-ID: <YSbA6n9kTXmAcUyh@optiplex-fbsd>
References: <20210809203554.1562989-1-aquini@redhat.com>
 <127e0132-50b7-9759-722c-3dea079877e5@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <127e0132-50b7-9759-722c-3dea079877e5@colorfullife.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 09:41:32PM +0200, Manfred Spraul wrote:
> Hi Rafael,
> 
> On 8/9/21 10:35 PM, Rafael Aquini wrote:
> > sysvipc_find_ipc() was left with a costly way to check if the offset
> > position fed to it is bigger than the total number of IPC IDs in use.
> > So much so that the time it takes to iterate over /proc/sysvipc/* files
> > grows exponentially for a custom benchmark that creates "N" SYSV shm
> > segments and then times the read of /proc/sysvipc/shm (milliseconds):
> >
> >      12 msecs to read   1024 segs from /proc/sysvipc/shm
> >      18 msecs to read   2048 segs from /proc/sysvipc/shm
> >      65 msecs to read   4096 segs from /proc/sysvipc/shm
> >     325 msecs to read   8192 segs from /proc/sysvipc/shm
> >    1303 msecs to read  16384 segs from /proc/sysvipc/shm
> >    5182 msecs to read  32768 segs from /proc/sysvipc/shm
> >
> > The root problem lies with the loop that computes the total amount of ids
> > in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
> > "ids->in_use". That is a quite inneficient way to get to the maximum index
> > in the id lookup table, specially when that value is already provided by
> > struct ipc_ids.max_idx.
> >
> > This patch follows up on the optimization introduced via commit 15df03c879836
> > ("sysvipc: make get_maxid O(1) again") and gets rid of the aforementioned
> > costly loop replacing it by a simpler checkpoint based on ipc_get_maxidx()
> > returned value, which allows for a smooth linear increase in time complexity
> > for the same custom benchmark:
> >
> >       2 msecs to read   1024 segs from /proc/sysvipc/shm
> >       2 msecs to read   2048 segs from /proc/sysvipc/shm
> >       4 msecs to read   4096 segs from /proc/sysvipc/shm
> >       9 msecs to read   8192 segs from /proc/sysvipc/shm
> >      19 msecs to read  16384 segs from /proc/sysvipc/shm
> >      39 msecs to read  32768 segs from /proc/sysvipc/shm
> 
> Could you run your test with the attached patch?
>

Manfred, 

Sorry it took me a while to get back to you here. (coming back from a short
leave). I'll take a look into your approach and report back in a few days.

Cheers,
-- Rafael

> The patch switches the code to idr_get_next(), and I see a speedup of 
> factor 400 for this test:
> 
> - boot with ipcmni_extend
> 
> - create ipc object
> 
> - echo 16000000 > /proc/sys/kernel/msg_next_id
> 
> - create ipc object
> 
> - time cat /proc/sysvipc/msg
> 
> with current mainline: 8.65 seconds
> 
> with the patch: 0.02 seconds
> 
> 
> If there are no gaps, then I would assume there is no speed-up compared 
> to your patch, but it would be create if you could check
> 
> [and check that there is no slow-down]
> 
> 
> Thanks,
> 
> --
> 
>      Manfred
> 

> From 4b7975d712db27c3d08731e0ebe4efd684256ca4 Mon Sep 17 00:00:00 2001
> From: Manfred Spraul <manfred@colorfullife.com>
> Date: Fri, 20 Aug 2021 21:08:12 +0200
> Subject: [PATCH] [PATCH] Improve sysvipc_find_ipc()
> 
> Initially noticed by Rafael Aquini, see
> https://lore.kernel.org/lkml/20210809203554.1562989-1-aquini@redhat.com/
> 
> The algorithm used in sysvipc_find_ipc() is highly inefficient.
> It actually needs to find the next used index in an idr, and it uses
> a for loop to locate that entry.
> 
> But: The IDR API contains idr_get_next(), thus switch the code to use
> idr_get_next().
> 
> In addition: Update a few comments.
> 
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> ---
>  ipc/util.c | 43 ++++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/ipc/util.c b/ipc/util.c
> index 0027e47626b7..083fd6dba1a1 100644
> --- a/ipc/util.c
> +++ b/ipc/util.c
> @@ -783,35 +783,32 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
>  }
>  
>  /*
> - * This routine locks the ipc structure found at least at position pos.
> + * This routine locks the ipc structure found at least at index pos.
>   */
>  static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>  					      loff_t *new_pos)
>  {
> +	int tmpidx;
>  	struct kern_ipc_perm *ipc;
> -	int total, id;
> -
> -	total = 0;
> -	for (id = 0; id < pos && total < ids->in_use; id++) {
> -		ipc = idr_find(&ids->ipcs_idr, id);
> -		if (ipc != NULL)
> -			total++;
> -	}
>  
> -	ipc = NULL;
> -	if (total >= ids->in_use)
> -		goto out;
> +	tmpidx = pos;
>  
> -	for (; pos < ipc_mni; pos++) {
> -		ipc = idr_find(&ids->ipcs_idr, pos);
> -		if (ipc != NULL) {
> -			rcu_read_lock();
> -			ipc_lock_object(ipc);
> -			break;
> -		}
> +	ipc = idr_get_next(&ids->ipcs_idr, &tmpidx);
> +	if (ipc != NULL) {
> +		rcu_read_lock();
> +		ipc_lock_object(ipc);
> +		/*
> +		 * We found the object with the index tmpidx.
> +		 * For next search, start with tmpidx+1
> +		 */
> +		*new_pos = tmpidx + 1;
> +	} else {
> +		/*
> +		 * EOF. seq_file can't notice that, thus
> +		 * move the offset by one.
> +		 */
> +		*new_pos = pos + 1;
>  	}
> -out:
> -	*new_pos = pos + 1;
>  	return ipc;
>  }
>  
> @@ -829,7 +826,7 @@ static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
>  }
>  
>  /*
> - * File positions: pos 0 -> header, pos n -> ipc id = n - 1.
> + * File positions: pos 0 -> header, pos n -> ipc idx = n - 1.
>   * SeqFile iterator: iterator value locked ipc pointer or SEQ_TOKEN_START.
>   */
>  static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
> @@ -854,7 +851,7 @@ static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
>  	if (*pos == 0)
>  		return SEQ_START_TOKEN;
>  
> -	/* Find the (pos-1)th ipc */
> +	/* Find the ipc object with the index >= (pos-1) */
>  	return sysvipc_find_ipc(ids, *pos - 1, pos);
>  }
>  
> -- 
> 2.31.1
> 
> 

