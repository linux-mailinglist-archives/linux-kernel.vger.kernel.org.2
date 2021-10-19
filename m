Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F95432B07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhJSAKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJSAKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:10:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D43466128B;
        Tue, 19 Oct 2021 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602102;
        bh=uoH2gy/ftzCVfTJH9UzXcA54bjNgLAZAlCMtqwKEehE=;
        h=From:To:Cc:Subject:Date:From;
        b=ZhKQ2PCU0Cst+uV8W3/bO3iHRXA3YWpWq23Q0O87RUjaGaiUAgG3UQiQCWblSzbVL
         SlzA667undXRoW5J7ZXjfvfxERa3B5JSNEJUL9cZ/wZ7xKuQ55+rZlXc5Z4dXHWwVA
         Db/1KFL73Bic81C5mDOuAO1F/O9t0v0jRJX0Rg9C+kimc2sTYH5HouNMDjqVyX9UQ8
         6l0axNYRwPRqNUuIXrOX3i4N2HHoITdSRNB5SO1wiCzRBvRpdvL1ne/1mPUyo9N/p+
         CRuxbfE0bWmukNlyp4UVSxR7qYlsSu1SbiBy/YeWGTPw18/9ibBKrg++F3NK7hO55V
         d4J4UeCMEidpQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 00/10] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB + a few other fixes v3
Date:   Tue, 19 Oct 2021 02:08:06 +0200
Message-Id: <20211019000816.455375-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:

_ Drop first patch (got applied by Paul)

_ Fix unwanted rcu_core() hanging around after setting a CPU as nocb
  on boot. This resulted in terrible rcu_barrier() misordering.
  I simply forgot to clear SEGCBLIST_RCU_CORE on nocb CPUs on boot.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/rt-v3

HEAD: 7610a2ba5eaca8caf977ed45bad251ac693feefa

Thanks,
	Frederic
---

Frederic Weisbecker (9):
      rcu/nocb: Prepare state machine for a new step
      rcu/nocb: Invoke rcu_core() at the start of deoffloading
      rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
      rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
      rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
      rcu/nocb: Limit number of softirq callbacks only on softirq
      rcu: Fix callbacks processing time limit retaining cond_resched()
      rcu: Apply callbacks processing time limit only on softirq
      rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread

Thomas Gleixner (1):
      rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe


 include/linux/rcu_segcblist.h | 51 ++++++++++++++++++-------
 kernel/rcu/rcu_segcblist.c    | 10 ++---
 kernel/rcu/rcu_segcblist.h    | 12 +++---
 kernel/rcu/tree.c             | 87 +++++++++++++++++++++++++++++--------------
 kernel/rcu/tree_nocb.h        | 33 ++++++++++++----
 5 files changed, 133 insertions(+), 60 deletions(-)
