Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74769379229
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhEJPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:12:50 -0400
Received: from foss.arm.com ([217.140.110.172]:60710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234259AbhEJPMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:12:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1DA21688;
        Mon, 10 May 2021 08:11:17 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D691F3F719;
        Mon, 10 May 2021 08:11:16 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        bristot@redhat.com, yejune.deng@gmail.com
Subject: [PATCH 0/2] sched: Address idle task vs pcpu kthread checks
Date:   Mon, 10 May 2021 16:10:22 +0100
Message-Id: <20210510151024.2448573-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit

  5ba2ffba13a1 ("sched: Fix CPU hotplug / tighten is_per_cpu_kthread()")

had to special-case the idle task when checking for per-CPU kthreads. This is
due to the idle task not having its own struct kthread, which is where we'd
store KTHREAD_IS_PER_CPU.

From staring at Yejune's recent patch [1], it turns out the idle task is also
missing PF_NO_SETAFFINITY.

Patch 1 cleans this up, patch 2 is Yejune's v1 which depends on it.


Note: I remember seeing some patch(es) from Peter tackling this exact
problem, but I couldn't find them again.

[1]: http://lore.kernel.org/r/1620458722-13026-1-git-send-email-yejunedeng@gmail.com

Cheers,
Valentin

Valentin Schneider (1):
  sched: Make the idle task quack like a per-CPU kthread

Yejune Deng (1):
  lib/smp_processor_id: Use is_percpu_thread() instead of
    nr_cpus_allowed

 include/linux/kthread.h |  2 ++
 kernel/kthread.c        | 30 ++++++++++++++++++------------
 kernel/sched/core.c     | 21 +++++++++++++++------
 lib/smp_processor_id.c  |  6 +-----
 4 files changed, 36 insertions(+), 23 deletions(-)

--
2.25.1

