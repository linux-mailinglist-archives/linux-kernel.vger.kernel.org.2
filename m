Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461CC3D0E59
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhGULT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:19:59 -0400
Received: from foss.arm.com ([217.140.110.172]:52750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237424AbhGULKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:10:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38A336D;
        Wed, 21 Jul 2021 04:51:29 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB4C63F694;
        Wed, 21 Jul 2021 04:51:26 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/3] sched: migrate_disable() vs per-CPU access safety checks
Date:   Wed, 21 Jul 2021 12:51:15 +0100
Message-Id: <20210721115118.729943-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've hit a few warnings when taking v5.13-rt1 out for a spin on my arm64
Juno. Those are due to regions that become preemptible under PREEMPT_RT, but
remain safe wrt per-CPU accesses due to migrate_disable() + a sleepable lock.

This adds a helper that looks at not just preemptability but also affinity and
migrate disable, and plasters the warning sites.

Cheers,
Valentin

Valentin Schneider (3):
  sched: Introduce is_pcpu_safe()
  rcu/nocb: Check for migratability rather than pure preemptability
  arm64: mm: Make arch_faults_on_old_pte() check for migratability

 arch/arm64/include/asm/pgtable.h |  2 +-
 include/linux/sched.h            | 10 ++++++++++
 kernel/rcu/tree_plugin.h         |  3 +--
 3 files changed, 12 insertions(+), 3 deletions(-)

--
2.25.1

