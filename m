Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6133ADEE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCOIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:52:45 -0400
Received: from mail.monom.org ([188.138.9.77]:60114 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhCOIwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:52:25 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 04:52:25 EDT
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 4224B50051C;
        Mon, 15 Mar 2021 09:45:13 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.96.195])
        by mail.monom.org (Postfix) with ESMTPSA id BA7405003B6;
        Mon, 15 Mar 2021 09:45:12 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
Subject: [ANNOUNCE] 4.4.261-rt218
Date:   Mon, 15 Mar 2021 08:30:20 -0000
Message-ID: <161579702068.3526.1632527232297488283@beryllium>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.4.261-rt218 stable release, but beware
of the regressions!

This is updates v4.4-rt to the latest stable 4.4.261. This update was
pretty painfull as there were many futex/rtmutex backports.

Unfortunatly, I found out, that we have two regression which are
already present in v4.4.256-rt214.

The first one is that the CONFIG_DEBUG_LOCKING_API_SELFTESTS tests
hang and there is no output at all. This is obviously bad for
verifying if the futex/rtmutex updates are working.

Next is locktorture for spin_locks is able to trigger warning:

 WARNING: CPU: 0 PID: 3091 at /home/wagi/rt/v4.4-rt/kernel/sched/core.c:7948 __might_sleep+0x77/0x80()
 do not call blocking ops when !TASK_RUNNING; state=2 set at [<ffffffff81a32085>] schedule_timeout_interruptible+0x5/0x30
 Modules linked in: locktorture torture
 CPU: 0 PID: 3091 Comm: lock_torture_wr Tainted: G        W       4.4.261-rt217+ #4
 Hardware name: Gigabyte Technology Co., Ltd. P55-UD3/P55-UD3, BIOS F3 07/31/2009
  0000000000000000 ffff88020c727b10 ffffffff81a136f2 ffff88020c727b58
  0000000000000009 ffff88020c727b48 ffffffff8105cac6 ffff88020c727c70
  ffffffff81eab6c8 000000000000005a 0000000000000000 ffff8800d850d7f0
 Call Trace:
  [<ffffffff81a136f2>] dump_stack+0x7a/0xa4
  [<ffffffff8105cac6>] warn_slowpath_common+0x86/0xa0
  [<ffffffff8105cb2c>] warn_slowpath_fmt+0x4c/0x50
  [<ffffffff81a2f401>] ? preempt_schedule+0x41/0x50
  [<ffffffff81001058>] ? ___preempt_schedule+0x12/0x14
  [<ffffffff81a32085>] ? schedule_timeout_interruptible+0x5/0x30
  [<ffffffff81a32085>] ? schedule_timeout_interruptible+0x5/0x30
  [<ffffffff81087be7>] __might_sleep+0x77/0x80
  [<ffffffff81a30340>] wait_for_completion+0x30/0xf0
  [<ffffffff811075cd>] stop_one_cpu+0x5d/0x80
  [<ffffffff8108f060>] ? sched_ttwu_pending+0x80/0x80
  [<ffffffff8108be1a>] ? migrate_enable+0xda/0x390
  [<ffffffff8105d416>] ? unpin_current_cpu+0x16/0x70
  [<ffffffff8108c06f>] migrate_enable+0x32f/0x390
  [<ffffffff81a30d24>] rt_spin_lock_slowlock+0x1a4/0x380
  [<ffffffffa00112f0>] ? lock_torture_reader+0x100/0x100 [locktorture]
  [<ffffffff81a33716>] rt_spin_lock+0x36/0x60
  [<ffffffffa0011045>] torture_spin_lock_write_lock+0x15/0x20 [locktorture]
  [<ffffffffa0011349>] lock_torture_writer+0x59/0x170 [locktorture]
  [<ffffffff81081a4a>] kthread+0xea/0x100
  [<ffffffff81081960>] ? kthread_create_on_node+0x250/0x250
  [<ffffffff81a3450f>] ret_from_fork+0x3f/0x80
  [<ffffffff81081960>] ? kthread_create_on_node+0x250/0x250

I decided to release this version with these known bugs, because
someone else might spot the problem right away.

Interesting enough, with this update the cyclicdeadline test passes
for the first time on v4.4-rt. Also the cyclictest latency numbers are
better. After 12 hours I saw max lattency of 16us, usually it was
around 25us on my x86_64 box.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: ac4368e8782290a48051791c7d866e118461e286

Or to build 4.4.261-rt218 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.261.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.261-rt218.patch.xz

Enjoy!
Daniel
