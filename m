Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C550637F001
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbhELXmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243600AbhELXar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:30:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC7BE613F6;
        Wed, 12 May 2021 23:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862178;
        bh=BvLgFFP2FaOwOn41naJu3wceL9pcWdau3pAGZc8yBA0=;
        h=From:To:Cc:Subject:Date:From;
        b=CB+XVxyKRy7YNFjUS47rhUVinyCWl7MqPgyJlPacni3Kt2yOeZDqejBU2GiH5R2MU
         Y3Q2+GP0wp/Dq2mtjHMSHNBnIv3m1jF2q5iRS9QWb7qc+Gti00BVfQ0qfai/1mrVGD
         AVd7RRgsueU7rgY6Ggx/2tH8zE4aRW9c2dALtAqpwB3sKH9PpW4AnL8Ff0wlFBcTOZ
         jzpOvXDkRbkfHPEGmY1goNFkMXhgX3Crpv9QFtvcJQS3ZUWCYidq1DCrCMXZMl+PwB
         dmNjxxjDlEIzwhq1+fjMtvkV5u0zUjQ0L7wNl6ZSef7+Sr54IK3XT44WEN5dinX2Z2
         Yma6BYopivVpw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [GIT PULL] tick/nohz updates v3
Date:   Thu, 13 May 2021 01:29:14 +0200
Message-Id: <20210512232924.150322-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, Thomas,

Please pull the timers/nohz-v3 branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/nohz-v3

Changes since v2:

* Add Acks from Peter Zijlstra

* Only bother to fetch task's CPU if the task is queued in
	"tick/nohz: Kick only _queued_ task whose tick dependency is updated"
  (reported by Peter Zijlstra)

* Correctly indent comment in
  "tick/nohz: Kick only _queued_ task whose tick dependency is updated"
  (reported by Peter Zijlstra)

* Add Peter's SoB in "tick/nohz: Evaluate the CPU expression after the static key"

* Add "tick/nohz: Call tick_nohz_task_switch() with interrupts disabled"
  (from Peter Zijlstra)

* Add "MAINTAINERS: Add myself as context tracking maintainer"

---
Summary:

* Further reduce ticks and IPIs in full dynticks mode.

* Optimize static key based test for a CPU's nohz_full mode
  and also tick nohz probe on context switch.

* A few cleanups, Kconfig documentation and maintainership clarification.

HEAD: 380b68819eed62264ad8e54467481ca7003248c3

Thanks,
	Frederic
---

Frederic Weisbecker (4):
      tick/nohz: Remove superflous check for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
      tick/nohz: Update nohz_full Kconfig help
      tick/nohz: Only wakeup a single target cpu when kicking a task
      MAINTAINERS: Add myself as context tracking maintainer

Marcelo Tosatti (2):
      tick/nohz: Change signal tick dependency to wakeup CPUs of member tasks
      tick/nohz: Kick only _queued_ task whose tick dependency is updated

Peter Zijlstra (2):
      tick/nohz: Evaluate the CPU expression after the static key
      tick/nohz: Call tick_nohz_task_switch() with interrupts disabled

Yunfeng Ye (2):
      tick/nohz: Conditionally restart tick on idle exit
      tick/nohz: Update idle_exittime on actual idle exit


 MAINTAINERS                    |   6 ++
 include/linux/sched.h          |   2 +
 include/linux/tick.h           |  26 +++++----
 kernel/sched/core.c            |   7 ++-
 kernel/time/Kconfig            |  11 ++--
 kernel/time/posix-cpu-timers.c |   4 +-
 kernel/time/tick-sched.c       | 129 ++++++++++++++++++++++++++++-------------
 7 files changed, 125 insertions(+), 60 deletions(-)
