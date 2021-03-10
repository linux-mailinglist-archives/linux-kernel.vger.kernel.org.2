Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA69333349
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhCJCtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhCJCtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:49:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B334DC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 18:48:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso4145519pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 18:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SSM2NdMm5I7+I/4ZH3H1cFrXbjEOIb78kT0+qdRhlMA=;
        b=NHJz5ikagGAMmuCe4/xpZRWTs8giri08Ra4JAEwP1fHCylgU1kTW0axqrTFJagCOCG
         pqOQW/YGU0maQUcsnF0fBY8Ol/yE12Us64aVk3r3a0Wb3kAkbgmpGc3Xx81AIPMFqiWR
         q6aFXavmyCZzBqlyUdMD0+BLUNfYzfmQc+NMwCw7wbnHzFwuF4UuXXPXQk1gr2UI7Bt6
         fB1LhSXO6KTSYFYgvLRjWCvQKytja5mCPvCUSayJvE86gzMXfgHEuZ3GHYmXbbPcZqLq
         TYkjF80cxLSyAhr9bEf+iIrb8U9N8PW1h+LQoAy/QzeC1GWiAYaik/XddPiJ2PJlavIx
         DFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SSM2NdMm5I7+I/4ZH3H1cFrXbjEOIb78kT0+qdRhlMA=;
        b=LtW24uk721OhLoXC0ltxZ11tnst4yd0MPOotPi39Spbg2nmLCvnsfYVHbUGVFwWpqD
         EQvhMtW+ues++kCT18Wrph7srGQ8nkpl6QPwjay+zgGu/bXHFJjFKbJRaWFMJ9wlsTqp
         VtQctjmvigXZwirlaFxHg3bxHSVh1pQ8iQXdAs2HZGjglFpkXmv+tL+9Y8jPcc9MldnI
         N593gdzoJpkuU5OdzfkxRTMOcgZ6LWXqRxaQlZcMCpOmlxHvnsrqNOPrpFA1h8MZWKkF
         4iHhRv+SPHrRnEx6ES9cFB9EBGxpZ6VsTDNhnaSqsPSynZOiA3NJtZk0GcQSg74jBbL5
         Ra0A==
X-Gm-Message-State: AOAM532olmH+OJTxk2giYsLDN51YyOpS8RsB3I7gPTE8Hi4B6kENXMzH
        fu41MsyT637EIIYYe6Ms0jlr0Q==
X-Google-Smtp-Source: ABdhPJznsmRwat2YmybFdZ5bTxueFvrvVVQiG2apqCgI0KKf3BljkZ0EZcLavVVs/8YBwAlz6Cak5A==
X-Received: by 2002:a17:90a:77c8:: with SMTP id e8mr1109294pjs.48.1615344535032;
        Tue, 09 Mar 2021 18:48:55 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j35sm14785971pgj.45.2021.03.09.18.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 18:48:54 -0800 (PST)
Subject: Re: [v5.12-rc2 regression] io_uring: high CPU use after
 suspend-to-ram
To:     Kevin Locke <kevin@kevinlocke.name>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
References: <YEgnIp43/6kFn8GL@kevinlocke.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d333d67-9a3e-546d-ad1c-ecebfdbe9932@kernel.dk>
Date:   Tue, 9 Mar 2021 19:48:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEgnIp43/6kFn8GL@kevinlocke.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 6:55 PM, Kevin Locke wrote:
> With kernel 5.12-rc2 (and torvalds/master 144c79ef3353), if mpd is
> playing or paused when my system is suspended-to-ram, when the system is
> resumed mpd will consume ~200% CPU until killed.  It continues to
> produce audio and respond to pause/play commands, which do not affect
> CPU usage.  This occurs with either pulse (to PulseAudio or
> PipeWire-as-PulseAudio) or alsa audio_output.
> 
> The issue appears to have been introduced by a combination of two
> commits: 3bfe6106693b caused freeze on suspend-to-ram when mpd is paused
> or playing.  e4b4a13f4941 fixed suspend-to-ram, but introduced the high
> CPU on resume.
> 
> I attempted to further diagnose using `perf record -p $(pidof mpd)`.
> Running for about a minute after resume shows ~280 MMAP2 events and
> almost nothing else.  I'm not sure what to make of that or how to
> further investigate.
> 
> Let me know if there's anything else I can do to help diagnose/test.

The below makes it work as expected for me - but I don't quite
understand why we're continually running after the freeze. Adding Rafael
to help understand this.

Rafael, what appears to happen here from a quick look is that the io
threads are frozen fine and the system suspends. But when we resume,
signal_pending() is perpetually true, and that is why we then see the
io_wq_manager() thread just looping like crazy. Is there anything
special I need to do? Note that these are not kthreads, PF_KTHREAD is
not true. I'm guessing it may have something to do with that, but
haven't dug deeper yet.


diff --git a/fs/io-wq.c b/fs/io-wq.c
index 3d7060ba547a..0ae9ecadf295 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -591,7 +591,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	tsk->pf_io_worker = worker;
 	worker->task = tsk;
 	set_cpus_allowed_ptr(tsk, cpumask_of_node(wqe->node));
-	tsk->flags |= PF_NOFREEZE | PF_NO_SETAFFINITY;
+	tsk->flags |= PF_NO_SETAFFINITY;
 
 	raw_spin_lock_irq(&wqe->lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list);
@@ -709,7 +709,6 @@ static int io_wq_manager(void *data)
 		set_current_state(TASK_INTERRUPTIBLE);
 		io_wq_check_workers(wq);
 		schedule_timeout(HZ);
-		try_to_freeze();
 		if (fatal_signal_pending(current))
 			set_bit(IO_WQ_BIT_EXIT, &wq->state);
 	} while (!test_bit(IO_WQ_BIT_EXIT, &wq->state));
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 280133f3abc4..8f4128eb4aa2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6735,7 +6735,6 @@ static int io_sq_thread(void *data)
 
 			up_read(&sqd->rw_lock);
 			schedule();
-			try_to_freeze();
 			down_read(&sqd->rw_lock);
 			list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
 				io_ring_clear_wakeup_flag(ctx);
diff --git a/kernel/fork.c b/kernel/fork.c
index d3171e8e88e5..72e444cd0ffe 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2436,6 +2436,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 	if (!IS_ERR(tsk)) {
 		sigfillset(&tsk->blocked);
 		sigdelsetmask(&tsk->blocked, sigmask(SIGKILL));
+		tsk->flags |= PF_NOFREEZE;
 	}
 	return tsk;
 }

-- 
Jens Axboe

