Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6371B4448B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhKCTJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCTJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:09:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15281C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 12:06:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z200so2792129wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xm+932Z77OqixNlBxCr4RZynoIDrs1gAg4+R1gzv8Zs=;
        b=Mhetq47hme8VOrtls+qriiLgmwHcy+dasbZ7dfvAJAcsc6OIWUDT4BRblr7lFjE3I/
         NoZaLYrA0eb3Zj6BtuU5L+6ySuTJ8NGxHF9JmyDuyWglH+xi7EI0fynKK+JoNUs3B9Jh
         7agVIaOn+9H7Xzg+cImo7uByqBbBYthu+ob9MooKU5nu09gmLxX7yxQL16puK4DXGWX2
         xLhFS6F/mLs/pThzNDJ6v1ryNo+M5lLKud5YLcgji7XJvn2c6bM84bZ2VnSsTvXDVicC
         6yr3E1ENCyU/+pkNg5Txb0J5fDj7he3jeELT7oxoNeNeHFX5xggNJ+2OaUsKE54WkFDH
         i+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xm+932Z77OqixNlBxCr4RZynoIDrs1gAg4+R1gzv8Zs=;
        b=6O4lRyzTLoLpv0bQHtP1xYqqYaQHdkka3BigWiY++nB3E1eY5+WCXmQXBAb3SWXxlJ
         r/vAW6PRuWyprLNpaPIsIAnEGeEllhib47lPNtuxMM4hdgoVHpIvJ0SUWuMHhsoFPGa1
         DTyLzfyISkFXWmITY6FHMwVu2UTbFwP8UL4wLVVM5ZUP6ImSxNPH95vCJ/jv/j5GALCK
         KNTuOy8kEq/uNI0I4fQfrPDIir0qoNm64bYgzmTSSCKa4tvJO1/Dt2EDGBtWpUUmK1wM
         w8xzqUYJGV4OPxhhqDFSX5oDdQCKh6/ifMTXMlZ3CK6ezm6dPwN0cxYob6S4+yyFGKpZ
         oq0Q==
X-Gm-Message-State: AOAM533+ERUzWsj7CbyWaifdRDmq4GAuT0xs3QnakM4/bNTwOz7E77Ry
        LbMaDOHEwR5NTxuZarlR76f1Vg==
X-Google-Smtp-Source: ABdhPJxb3PqOjJWHuWFor6SQLglBrdNwiTJpLtXNoSNO+y2b1Ia6RpXDQZ+uTSANRNksx438GlaH5w==
X-Received: by 2002:a1c:7c12:: with SMTP id x18mr17799032wmc.95.1635966410509;
        Wed, 03 Nov 2021 12:06:50 -0700 (PDT)
Received: from bell.fritz.box (pd9fe9a3e.dip0.t-ipconnect.de. [217.254.154.62])
        by smtp.gmail.com with ESMTPSA id y10sm3433551wrd.84.2021.11.03.12.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 12:06:50 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Mathias Krause <minipli@grsecurity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
Subject: [PATCH] sched/fair: Prevent dead task groups from regaining cfs_rq's
Date:   Wed,  3 Nov 2021 20:06:13 +0100
Message-Id: <20211103190613.3595047-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin is reporting crashes which point to a use-after-free of a cfs_rq
in update_blocked_averages(). Initial debugging revealed that we've live
cfs_rq's (on_list=1) in an about to be kfree()'d task group in
free_fair_sched_group(). However, it was unclear how that can happen.

His kernel config happened to lead to a layout of struct sched_entity
that put the 'my_q' member directly into the middle of the object which
makes it incidentally overlap with SLUB's freelist pointer. That, in
combination with SLAB_FREELIST_HARDENED's freelist pointer mangling,
leads to a reliable access violation in form of a #GP which made the UAF
fail fast, e.g. like this:

general protection fault, probably for non-canonical address 0xff80f68888f69107: 0000 [#1] SMP
CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.14.13-custom+ #3
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
RIP: 0010:[<ffffffff81194af8>] update_blocked_averages+0x428/0xb90
Code: 28 01 00 4c 8b 4c 24 10 41 8b 97 c4 00 00 00 85 d2 75 32 4c 89 fe 4c 89 cf e8 74 2c 01 00 49 8b 96 80 00 00 00 48 85 d2 74 0e <48> 83 ba 08 01 00 00 00 0f 85 45 01 00 00 85 c0 0f 84 34 fe ff ff
RSP: 0018:ffffc9000002bf08 EFLAGS: 00010086
RAX: 0000000000000001 RBX: ffff8880202eba00 RCX: 000000000000b686
RDX: ff80f68888f68fff RSI: 0000000000000000 RDI: 000000000000000c
RBP: ffff888006808a00 R08: ffff888006808a00 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000000 R12: ffff8880202ebb40
R13: 0000000000000000 R14: ffff8880087e7f00 R15: ffff888006808a00
FS:  0000000000000000(0000) GS:ffff888237d40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000315b147b8000 CR3: 0000000002d70000 CR4: 00000000001606f0 shadow CR4: 00000000001606f0
Stack:
 0100008237d58b80 0000000000000286 000003ae017023d5 00000000000000f0
 ffff888237d5d240 0000000000000028 ffff888237d5c980 ffff888237d5c900
 ffff888237d5c900 0000000000000001 0000000000000100 0000000000000007
Call Trace:
 <IRQ>
 [<ffffffff8119952a>] run_rebalance_domains+0x3a/0x60
 [<ffffffff810030bf>] __do_softirq+0xbf/0x1fb
 [<ffffffff81162e7f>] irq_exit_rcu+0x7f/0x90
 [<ffffffff822d0d7e>] sysvec_apic_timer_interrupt+0x6e/0x90
 </IRQ>
 [<ffffffff81001d82>] asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:[<ffffffff822debe9>] acpi_idle_do_entry+0x49/0x50
Code: 8b 15 2f b3 75 01 ed c3 0f 0b e9 52 fd ff ff 65 48 8b 04 25 40 1c 01 00 48 8b 00 a8 08 75 e8 eb 07 0f 00 2d d9 e2 1d 00 fb f4 <fa> c3 0f 0b cc cc cc 41 55 41 89 d5 41 54 49 89 f4 55 53 48 89 fb
RSP: 0000:ffffc900000bbe68 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffff888237d40000
RDX: 0000000000000001 RSI: ffffffff82cdd4c0 RDI: ffff888100b7bc64
RBP: ffff888101c07000 R08: ffff888100b7bc00 R09: 00000000000000ac
R10: 0000000000000005 R11: ffff888237d5b824 R12: 0000000000000001
R13: ffffffff82cdd4c0 R14: ffffffff82cdd540 R15: 0000000000000000
 [<ffffffff8118dab9>] ? sched_clock_cpu+0x9/0xa0
 [<ffffffff818d26f8>] acpi_idle_enter+0x48/0xb0
 [<ffffffff81ec123c>] cpuidle_enter_state+0x7c/0x2c0
 [<ffffffff81ec14b4>] cpuidle_enter+0x24/0x40
 [<ffffffff8118e5d4>] do_idle+0x1c4/0x210
 [<ffffffff8118e79e>] cpu_startup_entry+0x1e/0x20
 [<ffffffff810a8a4a>] start_secondary+0x11a/0x120
 [<ffffffff81000103>] secondary_startup_64_no_verify+0xae/0xbb
---[ end trace aac4ad8b95ba31e5 ]---

Michal seems to have run into the same issue[1]. He already correctly
diagnosed that commit a7b359fc6a37 ("sched/fair: Correctly insert
cfs_rq's to list on unthrottle") is causing the preconditions for the
UAF to happen by re-adding cfs_rq's also to task groups that have no
more running tasks, i.e. also to dead ones. His analysis, however,
misses the real root cause and it cannot be seen from the crash
backtrace only, as the real offender is tg_unthrottle_up() getting
called via sched_cfs_period_timer() via the timer interrupt at an
inconvenient time.

When unregister_fair_sched_group() unlinks all cfs_rq's from the dying
task group, it doesn't protect itself from getting interrupted. If the
timer interrupt triggers while we iterate over all CPUs or after
unregister_fair_sched_group() has finished but prior to unlinking the
task group, sched_cfs_period_timer() will execute and walk the list of
task groups, trying to unthrottle cfs_rq's, i.e. re-add them to the
dying task group. These will later -- in free_fair_sched_group() -- be
kfree()'ed while still being linked, leading to the fireworks Kevin and
Michal are seeing.

To fix this race, ensure the dying task group gets unlinked first.
However, simply switching the order of unregistering and unlinking the
task group isn't sufficient, as concurrent RCU walkers might still see
it, as can be seen below:

    CPU1:                                      CPU2:
      :                                        timer IRQ:
      :                                          do_sched_cfs_period_timer():
      :                                            :
      :                                            distribute_cfs_runtime():
      :                                              rcu_read_lock();
      :                                              :
      :                                              unthrottle_cfs_rq():
    sched_offline_group():                             :
      :                                                walk_tg_tree_from(…,tg_unthrottle_up,…):
      list_del_rcu(&tg->list);                           :
 (1)  :                                                  list_for_each_entry_rcu(child, &parent->children, siblings)
      :                                                    :
 (2)  list_del_rcu(&tg->siblings);                         :
      :                                                    tg_unthrottle_up():
      unregister_fair_sched_group():                         struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
        :                                                    :
        list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);               :
        :                                                    :
        :                                                    if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
 (3)    :                                                        list_add_leaf_cfs_rq(cfs_rq);
      :                                                      :
      :                                                    :
      :                                                  :
      :                                                :
      :                                              :
 (4)  :                                              rcu_read_unlock();

CPU 2 walks the task group list in parallel to sched_offline_group(),
specifically, it'll read the soon to be unlinked task group entry at
(1). Unlinking it on CPU 1 at (2) therefore won't prevent CPU 2 from
still passing it on to tg_unthrottle_up(). CPU 1 now tries to unlink all
cfs_rq's via list_del_leaf_cfs_rq() in unregister_fair_sched_group().
Meanwhile CPU 2 will re-add some of these at (3), which is the cause of
the UAF later on.

To prevent this additional race from happening, we need to wait until
walk_tg_tree_from() has finished traversing the task groups, i.e. after
the RCU read critical section ends in (4). Afterwards we're safe to call
unregister_fair_sched_group(), as each new walk won't see the dying task
group any more.

Using synchronize_rcu() might be seen as a too heavy hammer to nail this
problem. However, the overall tear down sequence (e.g., as documented in
css_free_rwork_fn()) already relies on quite a few assumptions regarding
execution context and RCU grace periods from passing. Looking at the
autogroup code, which calls sched_destroy_group() directly after
sched_offline_group() and the apparent need to have at least one RCU
grace period expire after unlinking the task group, prior to calling
unregister_fair_sched_group(), there seems to be no better alternative.
Calling unregister_fair_sched_group() via call_rcu() will only lead to
trouble in sched_offline_group() which also relies on (yet another)
expired RCU grace period.

This patch survives Michal's reproducer[2] for 8h+ now, which used to
trigger within minutes before.

[1] https://lore.kernel.org/lkml/20211011172236.11223-1-mkoutny@suse.com/
[2] https://lore.kernel.org/lkml/20211102160228.GA57072@blackbody.suse.cz/

Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
Cc: Odin Ugedal <odin@uged.al>
Cc: Michal Koutný <mkoutny@suse.com>
Reported-by: Kevin Tanguy <kevin.tanguy@corp.ovh.com>
Suggested-by: Brad Spengler <spender@grsecurity.net>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 kernel/sched/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 978460f891a1..60125a6c9d1b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9506,13 +9506,25 @@ void sched_offline_group(struct task_group *tg)
 {
 	unsigned long flags;
 
-	/* End participation in shares distribution: */
-	unregister_fair_sched_group(tg);
-
+	/*
+	 * Unlink first, to avoid walk_tg_tree_from() from finding us (via
+	 * sched_cfs_period_timer()).
+	 */
 	spin_lock_irqsave(&task_group_lock, flags);
 	list_del_rcu(&tg->list);
 	list_del_rcu(&tg->siblings);
 	spin_unlock_irqrestore(&task_group_lock, flags);
+
+	/*
+	 * Wait for all pending users of this task group to leave their RCU
+	 * critical section to ensure no new user will see our dying task
+	 * group any more. Specifically ensure that tg_unthrottle_up() won't
+	 * add decayed cfs_rq's to it.
+	 */
+	synchronize_rcu();
+
+	/* End participation in shares distribution: */
+	unregister_fair_sched_group(tg);
 }
 
 static void sched_change_group(struct task_struct *tsk, int type)
-- 
2.30.2

