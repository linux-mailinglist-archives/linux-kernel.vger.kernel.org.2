Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A232A32C51F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383074AbhCDATO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352628AbhCDAHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:07:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7778C64F51;
        Wed,  3 Mar 2021 23:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815781;
        bh=105HF8Ek1s04oyI8/eyyq7JPO81DBPjepxDvZTkTflk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUuQhYGENQGF149t23vrqjhl0u2NqTSY0j8j4Gu7VnAKcptjC3Je9Agpe7w5yCLM2
         qlosY8BWNNMbKkeq3rI8+G0qt0QNpZkuZC+9A3wE6b5D8wlYUw0zLoTlwE2F3larOQ
         WlrZuLO0kJXP3wntbJl4y6WXIaj2ZJFQdioRw26KdlclDyeFm3MzNAkvgS8KAglBUg
         FSDtpOv5t6psaLAuQmz6qt15Olbpiok8lPGwTlSWtK7aQzNrhP3VWlWvl2IzIAwlcH
         9vRZazcfJMUH0HayhZi3lh4mcmYnIx66RtZDy4tCp/MCyeArZ+9y/eOWqmXXAAFon7
         RIrh6qJWx5IQw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        paul.gortmaker@windriver.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH lib/bitmap 9/9] rcutorture: Use "all" and "N" in "nohz_full" and "rcu_nocbs"
Date:   Wed,  3 Mar 2021 15:56:16 -0800
Message-Id: <20210303235616.22093-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235526.GA21868@paulmck-ThinkPad-P72>
References: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit uses the shiny new "all" and "N" cpumask options to decouple
the "nohz_full" and "rcu_nocbs" kernel boot parameters in the TREE04.boot
and TREE08.boot files from the CONFIG_NR_CPUS options in the TREE04 and
TREE08 files.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot | 2 +-
 tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
index 5adc675..a8d94ca 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
@@ -1 +1 @@
-rcutree.rcu_fanout_leaf=4 nohz_full=1-7
+rcutree.rcu_fanout_leaf=4 nohz_full=1-N
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
index 22478fd..94d3844 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
@@ -1,3 +1,3 @@
 rcupdate.rcu_self_test=1
 rcutree.rcu_fanout_exact=1
-rcu_nocbs=0-7
+rcu_nocbs=all
-- 
2.9.5

