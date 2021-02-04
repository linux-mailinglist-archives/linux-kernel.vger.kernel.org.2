Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28BB30FF5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhBDVc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhBDVcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:32:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F660C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:32:05 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612474323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85kyx90/79wLI92vK72SUYO0ZAPcstHC58kNfIjWZJo=;
        b=nqhBLb4gYSR/UV7XJ6IxeDYZpwfRA1Z543BRaMysWUJAxr+6JgBbJdkg1o8KxoMqVZy9Kp
        MHVUi3yT0Eo14cMqoOnS3r+hbLYJgrsECdEq6LtgfvGxZBLgq2J+sln11wYp5cSGNrNPMo
        vnd36lX4mhvmPCcIZUwgRUw2KkK0ath47fS+Lu3GO0oLiHEa6pBQl6ZGMnegxijDbiGy0J
        S+y5A9CPabqbiu3gEN1mnr47C0hezHF9iONY6DPIWEGA0EepgQyHJSxQa9japArwnLIjkA
        6m9Ja0InxEGWkwSjiQbfIJO3ivVUti9HCRBJJy4LJQ12mOXVPfGhhG+TM/X4lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612474323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85kyx90/79wLI92vK72SUYO0ZAPcstHC58kNfIjWZJo=;
        b=/8nUPDcCTVDdpP3LWEj5nCDh2rO7Up7crHAOmsP3bf4codv/BcUgtIFIA+xTzOfLFtZ8Kr
        uzwQ+ktm50WXZYBg==
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com,
        "J. Avila" <elavila@google.com>
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
In-Reply-To: <8735yev1dn.fsf@jogness.linutronix.de>
References: <20210122081311.GA12834@xsang-OptiPlex-9020> <8735yev1dn.fsf@jogness.linutronix.de>
Date:   Thu, 04 Feb 2021 22:38:02 +0106
Message-ID: <878s83h63x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-22, kernel test robot <oliver.sang@intel.com> wrote:
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: b031a684bfd01d633c79d281bd0cf11c2f834ada ("printk: remove logbuf_lock writer-protection of ringbuffer")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

So I finally tracked down the problem. And yes, it is a problem with the
ringbuffer. And it turns out this is the same problem reported here [0].

If message sizes average larger than expected (more than 32 characters),
the data_ring will wrap before the desc_ring. Once the data_ring wraps,
it will start invalidating descriptors. These invalid descriptors hang
around until they are eventually recycled (when the desc_ring
wraps). Readers do not care about invalid descriptors, but they still
have to iterate past them. If the average message size is much larger
than 32 characters, then there will be many invalid descriptors
preceeding the valid descriptors.

For this particular LKP report, the RCU stalls started happening as the
number of invalid descriptors approached 17000. The reason this causes a
problem is because of the function prb_first_valid_seq(). It starts at
the oldest descriptor and searches to find the oldest _valid_
descriptor. In this case, it had to iterate past 17000 descriptors every
time.

prb_first_valid_seq() is used in devkmsg_read() and in
devkmsg_poll(). And worse, it is called with local interrupts disabled
and logbuf_lock locked.

The solution is to avoid using prb_first_valid_seq() if possible. And
indeed, in both of these cases it is a simple change:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c8847ee571f0..76e8df20fdf9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -736,9 +736,9 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		logbuf_lock_irq();
 	}
 
-	if (user->seq < prb_first_valid_seq(prb)) {
+	if (r->info->seq != user->seq) {
 		/* our last seen message is gone, return error and reset */
-		user->seq = prb_first_valid_seq(prb);
+		user->seq = r->info->seq;
 		ret = -EPIPE;
 		logbuf_unlock_irq();
 		goto out;
@@ -813,6 +813,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 {
 	struct devkmsg_user *user = file->private_data;
+	struct printk_info info;
 	__poll_t ret = 0;
 
 	if (!user)
@@ -821,9 +822,9 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &log_wait, wait);
 
 	logbuf_lock_irq();
-	if (prb_read_valid(prb, user->seq, NULL)) {
+	if (prb_read_valid_info(prb, user->seq, &info, NULL)) {
 		/* return error when data has vanished underneath us */
-		if (user->seq < prb_first_valid_seq(prb))
+		if (info.seq != user->seq)
 			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
 		else
 			ret = EPOLLIN|EPOLLRDNORM;

Once logbuf_lock and safe buffer usage is removed, this efficiency
wouldn't matter to the kernel anyway. But I am glad we hit it while it
still mattered because we should not be carelessly wasting CPU cycles
for any task.

Interestingly enough, LTP reported a problem with this code back in July
2020. The "invalid descriptor issue" was clearly stated [1] and Petr
even made a suggestion [2] which is nearly identical to how I propose to
fix it here.

prb_first_valid_seq() is used unnecessarily in some syslog and devkmsg
locations as well. And prb_first_valid_seq() itself can also be slightly
improved.

I am preparing a patch against linux-next for this. And although the
current situation is not pretty, I do not think it needs to be rushed
for 5.11. It is an inefficiency that occurs if the average message size
greatly exceeds 32 bytes and the ringbuffer is being blasted by new
messages and userspace is reading the ringbuffer.

John Ogness

[0] https://lkml.kernel.org/r/20210122235238.655049-1-elavila@google.com
[1] https://lkml.kernel.org/r/874kqhm1v8.fsf@jogness.linutronix.de
[2] https://lkml.kernel.org/r/20200709105906.GC11164@alley
