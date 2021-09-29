Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFDF41CF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347055AbhI2WMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345332AbhI2WL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80E8460FC2;
        Wed, 29 Sep 2021 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632953418;
        bh=18N3NHo//mXzDyvusQFEFTrLFCZXw6uOQdZJYYX/pkA=;
        h=From:To:Cc:Subject:Date:From;
        b=Sv8W5WNgdzYwctrr03XHSlLsBTFfjjUVuMGPTJr9GMnL/W2+zchMYBJJUJhFHRV3a
         GtHlUUFYN8d2a/fv1tLydODTi2Kp/28x6DRtUcRheA54AWtz7Xxav7JkwguMfigPl9
         j9GY9wRV31LrYYcbyONXI8c9k/TvzVZ6hy6x+5A4cyC5X4JEF23etMIrr/OPHGxoq/
         leypFPYvAVKZxhG9RKm+fqvU3PSNBuX5pIxnr2pJGxW6usC4ewanvQ6saSzxnLHkhV
         XQzDR/ZX3vVW0ja2AFcM54AJldF2tWsXipM+9YHG8V6Kv5Zb670mk8vN5FrYtcGqTq
         hmX+K/tqlbZtw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 00/11] rcu: Make rcu_core() safe in PREEMPT_RT with NOCB + a few other fixes
Date:   Thu, 30 Sep 2021 00:10:01 +0200
Message-Id: <20210929221012.228270-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PREEMPT_RT has made rcu_core() preemptible, making it unsafe against
concurrent NOCB (de-)offloading.

Thomas suggested to drop the local_lock() based solution and simply
check the offloaded state while context looks safe but that's not
enough. Here is a bit of rework.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/rt

HEAD: aac1c58961446c731f2e989bd822ca1fd2659bad

Thanks,
	Frederic
---

Frederic Weisbecker (10):
      rcu/nocb: Make local rcu_nocb_lock_irqsave() safe against concurrent deoffloading
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


 include/linux/rcu_segcblist.h | 51 +++++++++++++++++++-------
 kernel/rcu/rcu_segcblist.c    | 10 ++---
 kernel/rcu/rcu_segcblist.h    |  7 ++--
 kernel/rcu/tree.c             | 85 ++++++++++++++++++++++++++++++-------------
 kernel/rcu/tree.h             | 16 +++++---
 kernel/rcu/tree_nocb.h        | 29 ++++++++++++---
 6 files changed, 136 insertions(+), 62 deletions(-)
