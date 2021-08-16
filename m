Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14C63ECDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 07:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhHPFBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 01:01:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54404 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhHPFBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 01:01:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD0BA1FE64;
        Mon, 16 Aug 2021 05:00:50 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7337513D4B;
        Mon, 16 Aug 2021 05:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DXMrCv/wGWEjcAAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 16 Aug 2021 05:00:47 +0000
Date:   Sun, 15 Aug 2021 22:00:39 -0700
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
Subject: Re: [patch V5 18/72] locking: Add base code for RT rw_semaphore and
 rwlock
Message-ID: <20210816050039.nyor4xtiet77cn7z@offworld>
References: <20210815203225.710392609@linutronix.de>
 <20210815211302.957920571@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210815211302.957920571@linutronix.de>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2021, Thomas Gleixner wrote:

>On PREEMPT_RT rw_semaphores and rwlocks are substituted with a rtmutex and
>a reader count. The implementation is writer unfair as it is not feasible
>to do priority inheritance on multiple readers, but experience has shown
>that realtime workloads are not the typical workloads which are sensitive
>to writer starvation.

Ok so on RT tasklist_lock (rwlock_t) semantics would be similar to non-RT's
behavior in irq context, being writer unfair. And yeah, as with mmap_sem,
many of the sources of starvation are well known and not specific to RT.

>+/*
>+ * RT-specific reader/writer semaphores and reader/writer locks
>+ *
>+ * down_write/write_lock()
>+ *  1) Lock rtmutex
>+ *  2) Remove the reader BIAS to force readers into the slow path
>+ *  3) Wait until all readers have left the critical region
>+ *  4) Mark it write locked
>+ *
>+ * up_write/write_unlock()
>+ *  1) Remove the write locked marker
>+ *  2) Set the reader BIAS so readers can use the fast path again
>+ *  3) Unlock rtmutex to release blocked readers
>+ *
>+ * down_read/read_lock()
>+ *  1) Try fast path acquisition (reader BIAS is set)
>+ *  2) Take tmutex::wait_lock which protects the writelocked flag
>+ *  3) If !writelocked, acquire it for read
>+ *  4) If writelocked, block on tmutex

s/tmutex/rtmutex

>+ *  5) unlock rtmutex, goto 1)
>+ *
>+static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
>+					 unsigned int state)
>+{
>+	struct rt_mutex_base *rtm = &rwb->rtmutex;
>+	struct task_struct *owner;
>+
>+	raw_spin_lock_irq(&rtm->wait_lock);
>+	/*
>+	 * Wake the writer, i.e. the rtmutex owner. It might release the
>+	 * rtmutex concurrently in the fast path (due to a signal), but to
>+	 * clean up rwb->readers it needs to acquire rtm->wait_lock. The
>+	 * worst case which can happen is a spurious wakeup.
>+	 */
>+	owner = rt_mutex_owner(rtm);
>+	if (owner)
>+		wake_up_state(owner, state);

Maybe use wake_q to avoid holding wait_lock throughout the wakeup?

>+
>+	raw_spin_unlock_irq(&rtm->wait_lock);
>+}

Thanks,
Davidlohr
