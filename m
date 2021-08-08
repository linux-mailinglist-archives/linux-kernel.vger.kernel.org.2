Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6435C3E3BCC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhHHRGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 13:06:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37856 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhHHRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 13:06:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C7261FFE9;
        Sun,  8 Aug 2021 17:05:42 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BC1B13398;
        Sun,  8 Aug 2021 17:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IT3FB+MOEGH8DQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Sun, 08 Aug 2021 17:05:39 +0000
Date:   Sun, 8 Aug 2021 10:05:35 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 56/64] futex: Correct the number of requeued waiters
 for PI
Message-ID: <20210808170535.kotqd5t677tijh4o@offworld>
References: <20210805151300.330412127@linutronix.de>
 <20210805153956.051961951@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210805153956.051961951@linutronix.de>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021, Thomas Gleixner wrote:

>From: Thomas Gleixner <tglx@linutronix.de>
>
>The accounting is wrong when either the PI sanity check or the
>requeue PI operation fails. Adjust it in the failure path.

Ok fortunately these accounting errors are benign considering they
are in error paths. This also made me wonder about the requeue PI
top-waiter wakeup from futex_proxy_trylock_atomic(), which is always
required with nr_wakers == 1. We account for it on the successful
case we acquired the lock on it's behalf (and thus requeue_pi_wake_futex
was called), but if the corresponding lookup_pi_state fails, we'll retry.
So, shouldn't the task_count++ only be considered when we know the
requeueing is next (a successful top_waiter acquiring the lock+pi state)?

@@ -2260,7 +2260,6 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
		 */
		if (ret > 0) {
			WARN_ON(pi_state);
-                       task_count++;
			/*
			 * If we acquired the lock, then the user space value
			 * of uaddr2 should be vpid. It cannot be changed by
@@ -2275,6 +2274,8 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
			 */
			ret = lookup_pi_state(uaddr2, ret, hb2, &key2,
					      &pi_state, &exiting);
+                       if (!ret)
+                               task_count++;
		}

		switch (ret) {

Also, looking at the code, I think we can use the goto retry_private
optimization for private futexes upon futex_proxy_trylock_atomic
lookup_pi_state errors:

@@ -2290,8 +2290,11 @@ static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
			double_unlock_hb(hb1, hb2);
			hb_waiters_dec(hb2);
			ret = fault_in_user_writeable(uaddr2);
-                       if (!ret)
+                       if (!ret) {
+                               if (!(flags & FLAGS_SHARED))
+                                       goto retry_private;
				goto retry;
+                       }
			return ret;
		case -EBUSY:
		case -EAGAIN:


Thanks,
Davidlohr
