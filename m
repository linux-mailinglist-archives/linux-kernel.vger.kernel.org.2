Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE643F9247
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbhH0CSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 22:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231613AbhH0CSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 22:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630030678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fO10uE/NOQ1QMOqhqK2ZdAOz3mqX6cifhVdS/LXHtXw=;
        b=EjmBmDddmX/var6qIjdMo9xIJ3UJ7f7wkeCOlm0pML2ZCw0l6JZ+CD0Q2VfxbhIJF9Z5mE
        PCWdavX/voOYWzmjKF4xOBHeWGmBZrwGCHr7FT/kkzqzEVYNNbq/3I98o3PQugiS0skrYC
        n9EDK395V4DzVY5K2MYZlyKnNenUNQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-bXSrgr6fOHyAS2o-_zCvgA-1; Thu, 26 Aug 2021 22:17:56 -0400
X-MC-Unique: bXSrgr6fOHyAS2o-_zCvgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71E141082921;
        Fri, 27 Aug 2021 02:17:55 +0000 (UTC)
Received: from x61s-fbsd.aquini.net (unknown [10.3.128.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6227F18432;
        Fri, 27 Aug 2021 02:17:53 +0000 (UTC)
Date:   Thu, 26 Aug 2021 22:17:55 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>, 1vier1@web.de
Subject: Re: [PATCH] ipc: replace costly bailout check in sysvipc_find_ipc()
Message-ID: <YShLU3VTtifYU8IR@x61s-fbsd.aquini.net>
References: <20210809203554.1562989-1-aquini@redhat.com>
 <127e0132-50b7-9759-722c-3dea079877e5@colorfullife.com>
 <YSbA6n9kTXmAcUyh@optiplex-fbsd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSbA6n9kTXmAcUyh@optiplex-fbsd>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 06:15:06PM -0400, Rafael Aquini wrote:
> On Fri, Aug 20, 2021 at 09:41:32PM +0200, Manfred Spraul wrote:
> > Hi Rafael,
> > 
> > On 8/9/21 10:35 PM, Rafael Aquini wrote:
> > > sysvipc_find_ipc() was left with a costly way to check if the offset
> > > position fed to it is bigger than the total number of IPC IDs in use.
> > > So much so that the time it takes to iterate over /proc/sysvipc/* files
> > > grows exponentially for a custom benchmark that creates "N" SYSV shm
> > > segments and then times the read of /proc/sysvipc/shm (milliseconds):
> > >
> > >      12 msecs to read   1024 segs from /proc/sysvipc/shm
> > >      18 msecs to read   2048 segs from /proc/sysvipc/shm
> > >      65 msecs to read   4096 segs from /proc/sysvipc/shm
> > >     325 msecs to read   8192 segs from /proc/sysvipc/shm
> > >    1303 msecs to read  16384 segs from /proc/sysvipc/shm
> > >    5182 msecs to read  32768 segs from /proc/sysvipc/shm
> > >
> > > The root problem lies with the loop that computes the total amount of ids
> > > in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
> > > "ids->in_use". That is a quite inneficient way to get to the maximum index
> > > in the id lookup table, specially when that value is already provided by
> > > struct ipc_ids.max_idx.
> > >
> > > This patch follows up on the optimization introduced via commit 15df03c879836
> > > ("sysvipc: make get_maxid O(1) again") and gets rid of the aforementioned
> > > costly loop replacing it by a simpler checkpoint based on ipc_get_maxidx()
> > > returned value, which allows for a smooth linear increase in time complexity
> > > for the same custom benchmark:
> > >
> > >       2 msecs to read   1024 segs from /proc/sysvipc/shm
> > >       2 msecs to read   2048 segs from /proc/sysvipc/shm
> > >       4 msecs to read   4096 segs from /proc/sysvipc/shm
> > >       9 msecs to read   8192 segs from /proc/sysvipc/shm
> > >      19 msecs to read  16384 segs from /proc/sysvipc/shm
> > >      39 msecs to read  32768 segs from /proc/sysvipc/shm
> > 
> > Could you run your test with the attached patch?
> >
> 
> Manfred, 
> 
> Sorry it took me a while to get back to you here. (coming back from a short
> leave). I'll take a look into your approach and report back in a few days.
>

Manfred,

as promised I re-ran the tests, adjusting the shm workload to leave a gap in
the ids between the runs (effectivelly deleting all previously created segments
before recreating the batch for the next turn), and the outcome between the two
patches is virtually the same:

* your patch:

     1 msecs to read   1024 segs from /proc/sysvipc/shm
     2 msecs to read   2048 segs from /proc/sysvipc/shm
     4 msecs to read   4096 segs from /proc/sysvipc/shm
     9 msecs to read   8192 segs from /proc/sysvipc/shm
    24 msecs to read  16384 segs from /proc/sysvipc/shm
    44 msecs to read  32768 segs from /proc/sysvipc/shm



* my patch:

     1 msecs to read   1024 segs from /proc/sysvipc/shm
     2 msecs to read   2048 segs from /proc/sysvipc/shm
     4 msecs to read   4096 segs from /proc/sysvipc/shm
     9 msecs to read   8192 segs from /proc/sysvipc/shm
    22 msecs to read  16384 segs from /proc/sysvipc/shm
    45 msecs to read  32768 segs from /proc/sysvipc/shm



and even perf stat numbers are virtually the same for reading
32768 segments from /proc/sysvipc/shm:

* your patch

 Performance counter stats for 'cat /proc/sysvipc/shm' (10 runs):

             45.03 msec task-clock                #    0.990 CPUs utilized            ( +-  0.27% )
                 0      context-switches          #    0.004 K/sec                    ( +-100.00% )
                 0      cpu-migrations            #    0.004 K/sec                    ( +-100.00% )
                70      page-faults               #    0.002 M/sec                    ( +-  0.61% )
       149,631,684      cycles                    #    3.323 GHz                      ( +-  0.25% )  (82.23%)
         2,148,928      stalled-cycles-frontend   #    1.44% frontend cycles idle     ( +-  2.21% )  (82.24%)
        67,488,510      stalled-cycles-backend    #   45.10% backend cycles idle      ( +-  0.73% )  (83.32%)
       249,186,578      instructions              #    1.67  insn per cycle
                                                  #    0.27  stalled cycles per insn  ( +-  0.03% )  (84.31%)
        62,268,386      branches                  # 1382.790 M/sec                    ( +-  0.02% )  (84.45%)
            83,170      branch-misses             #    0.13% of all branches          ( +-  1.57% )  (83.44%)

          0.045485 +- 0.000142 seconds time elapsed  ( +-  0.31% )



* my patch:

 Performance counter stats for 'cat /proc/sysvipc/shm' (10 runs):

             45.22 msec task-clock                #    0.990 CPUs utilized            ( +-  0.24% )
                 0      context-switches          #    0.002 K/sec                    ( +-100.00% )
                 0      cpu-migrations            #    0.000 K/sec
                70      page-faults               #    0.002 M/sec                    ( +-  0.92% )
       150,273,699      cycles                    #    3.323 GHz                      ( +-  0.25% )  (82.31%)
        12,288,154      stalled-cycles-frontend   #    8.18% frontend cycles idle     ( +-  0.95% )  (82.31%)
        61,198,482      stalled-cycles-backend    #   40.72% backend cycles idle      ( +-  0.91% )  (83.14%)
       245,485,497      instructions              #    1.63  insn per cycle
                                                  #    0.25  stalled cycles per insn  ( +-  0.03% )  (84.41%)
        61,736,363      branches                  # 1365.267 M/sec                    ( +-  0.02% )  (84.52%)
            82,381      branch-misses             #    0.13% of all branches          ( +-  1.17% )  (83.31%)

          0.045671 +- 0.000125 seconds time elapsed  ( +-  0.27% )


I'll leave it up to you, as clearly both approaches do pretty good in reducing
the noted overhead imposed by the old approach.

Since my patch is already in linux-next, may I ask you to ack it and follow it 
up there if you decide on going with your approach? The diff below applies 
cleanly on top of linux-next head (it's the one I used on tests). 

Cheers!
Rafael

--

diff --git a/ipc/util.c b/ipc/util.c
index d48d8cfa1f3f..261540154782 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -788,22 +788,26 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 					      loff_t *new_pos)
 {
-	struct kern_ipc_perm *ipc = NULL;
-	int max_idx = ipc_get_maxidx(ids);
+	struct kern_ipc_perm *ipc;
+	int tmpidx = pos;
 
-	if (max_idx == -1 || pos > max_idx)
-		goto out;
-
-	for (; pos <= max_idx; pos++) {
-		ipc = idr_find(&ids->ipcs_idr, pos);
-		if (ipc != NULL) {
-			rcu_read_lock();
-			ipc_lock_object(ipc);
-			break;
-		}
+	ipc = idr_get_next(&ids->ipcs_idr, &tmpidx);
+	if (ipc != NULL) {
+		rcu_read_lock();
+		ipc_lock_object(ipc);
+		/*
+		 * We found the object with the index tmpidx.
+		 * For next search, start with tmpidx+1
+		 */
+		*new_pos = tmpidx + 1;
+	} else {
+		/*
+		 * EOF. seq_file can't notice that, thus
+		 * move the offset by one.
+		 */
+		*new_pos = pos + 1;
 	}
-out:
-	*new_pos = pos + 1;
+
 	return ipc;
 }
 

