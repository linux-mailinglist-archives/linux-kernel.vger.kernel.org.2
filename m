Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B056367FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhDVMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235957AbhDVMCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:02:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E03D861164;
        Thu, 22 Apr 2021 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619092925;
        bh=rkCq6YOyLHab1KE6vI7NiCXSOcxoEXY9r+QmW7Dd6DE=;
        h=From:To:Cc:Subject:Date:From;
        b=XpIdIxw0hzCja5ovJ6LOCRuVYlPr9Bzbsk1Fz6YCfMyFMk1hJNSY/ls3vhmcVpstc
         U1iVTyg5FBOXsfNayGUx4ssoaNiASgxQUW1zmb0+Yofan5d3N7VF9kx4jO9cGCv0Cu
         pD9rv43vWfQr+Vjtqvy37ebs023Bl3FehjVals2cpf9E5T18ZEOvVDOOW/13RKYFT0
         PvVcIBvcIAfNk5Kf/Qrs05F+a9Tunmn4kG3rkvq5fE9g5shY6Y7/yaRaoGOtI4wDze
         STc1mNvzRMhzaJJFr7u5Zv6Z5AC7I0/fuZ3YF/GKlpdwQFjB/+U0bFaIje9XInq4y3
         KlBCP6DI+0cVw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 0/8] tick/nohz updates v2
Date:   Thu, 22 Apr 2021 14:01:50 +0200
Message-Id: <20210422120158.33629-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set brings various interrupts reducing while running in nohz_full:

* Remove one tick interrupt while waking up from idle to a user task
  running in nohz_full mode. (thanks Yunfeng Ye).

* Reduce IPIs when running posix cpu timers, only relevant tasks should
  be interrupted now instead of all tick nohz CPUs (thanks Marcelo)

And a few other cleanups and improvement.

Changes since last take:

- Remove "tick/nohz: Prevent tick_nohz_get_sleep_length() from returning negative value"
  since the issue has been solve on the cpuidle side.

- Remove "timer: Report ignored local enqueue in nohz mode"
  and hope that objtool will spot the future offenders.

- Changed "tick/nohz: Add tick_nohz_full_this_cpu()" and provide with
  "tick/nohz: Evaluate the CPU expression after the static key" (please
  add your SOB on this one).

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/nohz-v2

HEAD: 4546d43a9938f6c7eec024f005cb240b8b73637b

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      tick/nohz: Remove superflous check for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
      tick/nohz: Update nohz_full Kconfig help
      tick/nohz: Only wakeup a single target cpu when kicking a task

Marcelo Tosatti (2):
      tick/nohz: Change signal tick dependency to wakeup CPUs of member tasks
      tick/nohz: Kick only _queued_ task whose tick dependency is updated

Yunfeng Ye (2):
      tick/nohz: Conditionally restart tick on idle exit
      tick/nohz: Update idle_exittime on actual idle exit

Peter Zijlstra (1):
      tick/nohz: Evaluate the CPU expression after the static key


 include/linux/sched.h          |   2 +
 include/linux/tick.h           |  26 +++++----
 kernel/sched/core.c            |   5 ++
 kernel/time/Kconfig            |  11 ++--
 kernel/time/posix-cpu-timers.c |   4 +-
 kernel/time/tick-sched.c       | 122 +++++++++++++++++++++++++++++------------
 6 files changed, 117 insertions(+), 53 deletions(-)
