Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8864E3372CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhCKMhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:37:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233179AbhCKMhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C69C64F8E;
        Thu, 11 Mar 2021 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466234;
        bh=9RAEUsRaMheb+lyyBoNwvH8fiZ28fFkswXX/YYJj/Qc=;
        h=From:To:Cc:Subject:Date:From;
        b=SHsyKJ46coJNLN5KyTY3Av83EsbXqVCh0lxUoxFO+7a1PRE8WkvDK3wH/7kd+sElO
         zOBqWWBSZqWEO55Ah6wTpNBmi9HQUdMijF/oWkzJNUC8fdK0H7qdMZ6CpWIQdq9NWe
         NRh49p7iRJJqGXUDzSYPCN0GVSmt9or5pzPbPgqQzUK1YITprfFlpSmF0TUEbHivXa
         Oxigz38Hl/mILrm+aREvW7+CI6As1yTQ2ACJYGMtvLYzCPpUZKovNYsN1UfEJ+8eVq
         ANyA3eGPcJTgoxmQDRPTx1X0UNjFszjv/aK/fzpO0LkeZBbNXV2hm4JqK2zXL9/PKp
         Jb4BfgcTUB5pg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 00/10] tick/nohz updates
Date:   Thu, 11 Mar 2021 13:36:58 +0100
Message-Id: <20210311123708.23501-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various updates for the timer/nohz side.

* Two fixes (maybe 01/10 deserves a stable tag, I should check)

* A Kconfig help change

* A debug check while enqueuing timers when the tick is stopped in idle.

* The rest is noise reduction for full nohz ("tick/nohz: Kick only 
  _queued_ task whose tick dependency is updated").
  It relies on the fact that p->on_rq is never set to anything else than
  TASK_ON_RQ_QUEUED while the task is running on a CPU, the only relevant
  exception being the task dequeuing itself on schedule().
  I haven't found issues in my modest reviews of deactivate_task() callers
  but I lost my headlamp while visiting fair's sched entity dequeuing
  and throttling (had to find my way back in the dark again).

So please double check the last patch.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/nohz

HEAD: e469edfa00f97e5ec5d31fe31d3aef0a5c9bd607

Thanks,
	Frederic
---

Frederic Weisbecker (5):
      tick/nohz: Add tick_nohz_full_this_cpu()
      tick/nohz: Remove superflous check for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
      timer: Report ignored local enqueue in nohz mode
      tick/nohz: Update nohz_full Kconfig help
      tick/nohz: Only wakeup a single target cpu when kicking a task

Marcelo Tosatti (2):
      tick/nohz: Change signal tick dependency to wakeup CPUs of member tasks
      tick/nohz: Kick only _queued_ task whose tick dependency is updated

Yunfeng Ye (2):
      tick/nohz: Conditionally restart tick on idle exit
      tick/nohz: Update idle_exittime on actual idle exit

Zhou Ti (x2019cwm) (1):
      tick/nohz: Prevent tick_nohz_get_sleep_length() from returning negative value


 include/linux/sched.h          |   2 +
 include/linux/tick.h           |  19 ++++--
 kernel/sched/core.c            |  25 +++++++-
 kernel/time/Kconfig            |  11 ++--
 kernel/time/posix-cpu-timers.c |   4 +-
 kernel/time/tick-sched.c       | 134 +++++++++++++++++++++++++++++------------
 6 files changed, 142 insertions(+), 53 deletions(-)
