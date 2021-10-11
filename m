Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9675429594
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhJKR01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:26:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhJKR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:26:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10D9922109;
        Mon, 11 Oct 2021 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633973065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7stB6jM47hLBiQhjZ6wBkkCvpYpFkpHl1UWbrX99SsM=;
        b=b8MEPePfe4LSoYW402YcFxXDlzhdf+LkWMgnJlq7WtNG4zrXOgGbO2sbWUA9lz2YLHPr5Q
        5S76rnHRlMc5DFBawOAVk06gPrVmQ4LEaq9edx8ogdgg9/aYDXFnzR9cK2h1zfkt7+x3zI
        Kg8GE8bKv1iEw8tZatZqzW6SmLnd+SE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD1AC13BC2;
        Mon, 11 Oct 2021 17:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jh3ANEhzZGHUCQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 11 Oct 2021 17:24:24 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH] sched/fair: Use rq->lock when checking cfs_rq list presence
Date:   Mon, 11 Oct 2021 19:22:36 +0200
Message-Id: <20211011172236.11223-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal path checks cfs_rq->on_list flag without synchronization
based on the reasoning that only empty cgroups can be removed and
->on_list can't switch back to 1. However, since the commit a7b359fc6a37
("sched/fair: Correctly insert cfs_rq's to list on unthrottle") even
cfs_rq of an empty cgroup may be added to the list because of
non-decayed load that transiently remains there.
The result is that we may skip unlinking the cfs_rq from the list on the
removal path and the list will then contain free'd cfs_rq, which leads
sooner or later to a task failing inside update_blocked_averages while
holding rq->lock and eventually locking up the machine on all other CPUs
as well:

	[ 8995.095798] BUG: kernel NULL pointer dereference, address: 0000000000000080
	[ 9016.281685] NMI watchdog: Watchdog detected hard LOCKUP on cpu 21

Illustrative stack dump of a task that faulted by accessing released
cfs_rq (+unrelated deadlock on rq->lock):

	PID: 0      TASK: ffff8a310a5dc000  CPU: 16  COMMAND: "swapper/16"
	 #0 [fffffe0000379e58] crash_nmi_callback at ffffffffba063683
	 #1 [fffffe0000379e60] nmi_handle at ffffffffba0377ef
	 #2 [fffffe0000379eb8] default_do_nmi at ffffffffba037c5e
	 #3 [fffffe0000379ed8] do_nmi at ffffffffba037ea7
	 #4 [fffffe0000379ef0] end_repeat_nmi at ffffffffbaa0178b
	    [exception RIP: native_queued_spin_lock_slowpath+98]
	    RIP: ffffffffba0fa6e2  RSP: ffffa8505932ca30  RFLAGS: 00000002
	    RAX: 0000000001200101  RBX: ffff8a8de9044000  RCX: ffff8a8ec0800000
	    RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffff8a8ec082cc80
	    RBP: ffff8a8ec082cc80   R8: ffff8a8ec0800000   R9: ffff8a31078058f8
	    R10: 0000000000000000  R11: ffffffffbb4639d8  R12: 0000000000000000
	    R13: ffff8a8de9044b84  R14: 0000000000000006  R15: 0000000000000010
	    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
	--- <NMI exception stack> ---
	 #5 [ffffa8505932ca30] native_queued_spin_lock_slowpath at ffffffffba0fa6e2
	 #6 [ffffa8505932ca30] _raw_spin_lock at ffffffffba922aab
	 #7 [ffffa8505932ca38] try_to_wake_up at ffffffffba0cf8f9
	 #8 [ffffa8505932ca98] __queue_work at ffffffffba0b9c7e
	 #9 [ffffa8505932cae0] queue_work_on at ffffffffba0ba7b4
	#10 [ffffa8505932caf0] bit_putcs at ffffffffba541bc0
	#11 [ffffa8505932cbf0] fbcon_putcs at ffffffffba53c36b
	#12 [ffffa8505932cc48] vt_console_print at ffffffffba5ff032
	#13 [ffffa8505932cca8] console_unlock at ffffffffba1091a2
	#14 [ffffa8505932ccf0] vprintk_emit at ffffffffba10ad29
	#15 [ffffa8505932cd40] printk at ffffffffba10b590
	#16 [ffffa8505932cda8] no_context at ffffffffba081f66
	#17 [ffffa8505932ce10] do_page_fault at ffffffffba082df0
	#18 [ffffa8505932ce40] page_fault at ffffffffbaa012fe
	    [exception RIP: update_blocked_averages+685]
	    RIP: ffffffffba0d85cd  RSP: ffffa8505932cef0  RFLAGS: 00010046
	    RAX: 0000000000000000  RBX: ffff8a8ca0510000  RCX: 0000000000000000
	    RDX: 0000000000000000  RSI: ffff8a8ca0510000  RDI: 0000000000000000
	    RBP: 0000000000000000   R8: 00000000eac0c6e6   R9: 0000000000000233
	    R10: ffffa8505932cef0  R11: 0000000000000233  R12: ffff8a8ca0510140
	    R13: 0000000000000000  R14: fffffffffffffec2  R15: 0000000000000080
	    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
	#19 [ffffa8505932cf50] run_rebalance_domains at ffffffffba0e2751
	#20 [ffffa8505932cf68] __softirqentry_text_start at ffffffffbac000e3
	#21 [ffffa8505932cfc8] irq_exit at ffffffffba0a2cf5
	#22 [ffffa8505932cfd8] smp_apic_timer_interrupt at ffffffffbaa02874
	#23 [ffffa8505932cff0] apic_timer_interrupt at ffffffffbaa01d9f
	--- <IRQ stack> ---
	#24 [ffffa850402f3dd8] apic_timer_interrupt at ffffffffbaa01d9f
	    [exception RIP: cpuidle_enter_state+171]
	    RIP: ffffffffba6fc32b  RSP: ffffa850402f3e80  RFLAGS: 00000246
	    RAX: ffff8a8ec082cc80  RBX: ffffc7f053605e80  RCX: 000000000000001f
	    RDX: 0000082e557d390c  RSI: 000000003d1877c2  RDI: 0000000000000000
	    RBP: ffffffffbb55f100   R8: 0000000000000002   R9: 000000000002c500
	    R10: ffffa850402f3e60  R11: 00000000000002ff  R12: 0000000000000002
	    R13: 0000082e557d390c  R14: 0000000000000002  R15: 0000000000000000
	    ORIG_RAX: ffffffffffffff13  CS: 0010  SS: 0018
	#25 [ffffa850402f3ec0] cpuidle_enter at ffffffffba6fc6f9
	#26 [ffffa850402f3ee0] do_idle at ffffffffba0d4567
	#27 [ffffa850402f3f20] cpu_startup_entry at ffffffffba0d4769
	#28 [ffffa850402f3f30] start_secondary at ffffffffba064e35
	#29 [ffffa850402f3f50] secondary_startup_64_no_verify at ffffffffba000112

Fix this by always taking rq->lock when checking the ->on_list condition
(the modification of the list in UBA is therefore synchronized).

Taking the rq->lock on every cpu cgroup removal may pose a performance
penalty. However, this should be just moving the necessary work from UBA
into the unregister_fair_sched_group() and therefore neutral on larger
scale (assuming given cpu cgroup was populated at least once).

Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/fair.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6a05d9b5443..081c7ac02f65 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11440,13 +11440,6 @@ void unregister_fair_sched_group(struct task_group *tg)
 		if (tg->se[cpu])
 			remove_entity_load_avg(tg->se[cpu]);
 
-		/*
-		 * Only empty task groups can be destroyed; so we can speculatively
-		 * check on_list without danger of it being re-added.
-		 */
-		if (!tg->cfs_rq[cpu]->on_list)
-			continue;
-
 		rq = cpu_rq(cpu);
 
 		raw_spin_rq_lock_irqsave(rq, flags);
-- 
2.33.0

