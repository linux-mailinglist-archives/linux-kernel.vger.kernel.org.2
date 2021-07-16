Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA03CB1FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 07:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhGPFoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 01:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbhGPFoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:44:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2E6C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 22:41:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id o201so7966463pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4myuWkA9xB+cjc0XD5MczNyScf1c1ZlV8jj86wi9jI0=;
        b=Cc+oIpxiJq7lvKQ9o7sx7yagPWlMIilCxXgJd8Tfhj8hVMEdbOtsRW7iocFBmrbAcH
         tENgsXAfC3+uzB1p9mu4EKmU+sWiNeFrFozzzMiK2dq9rJx5BjEpx+I/DDzq9N0V4F9Y
         lvpczMYU9kmxQdtAJcw73T/LmUMexjNIGaLwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4myuWkA9xB+cjc0XD5MczNyScf1c1ZlV8jj86wi9jI0=;
        b=qL8fCixzLJ39irTPc3+CCqQIUqWH3i92Jgm7nBjswvm9lCQUidIQkEvt0IPS5t0Br4
         ZhNXKuRiI1kOmlczdbKnOC5dJ2wezWI6n4lTKYpzbX4LZSguowIbJhUBmpYsUzcTx3oB
         pUiMQ78N5CZX64pLvHWyCiM3nCSD006yHUXnPSr6zGlLMFTudxgm/BItsktgNdkMNqKq
         EPCsKg44L73Xe+QuUITEl6C6P8BKXhw6vM/qXOrP/7F00R++Hj3FFDHuOAPDmAsEmWUg
         0NahmltVNbY31qvihJUiK+iTPn6KQ2jpS/1/lG0lgpDVUenm6JsItanaX4Cn/TsTGZyB
         bCqg==
X-Gm-Message-State: AOAM531prWrU+vs47nx7T2vaMJraxEGRgwCKGjvxLP4icxWIGEHZ0U8b
        uHo7a431GJtPmH6uQeubXnBnKA==
X-Google-Smtp-Source: ABdhPJxUByLMN1y1QO9dDiTq4b2c5IDX5aUojwQ0pcUb0FGmZU5XQKCcL6+wGtnezmgPbtz6oSPBHg==
X-Received: by 2002:a63:d014:: with SMTP id z20mr8179873pgf.203.1626414087462;
        Thu, 15 Jul 2021 22:41:27 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:d1af:356e:50a6:75e8])
        by smtp.gmail.com with ESMTPSA id o25sm9664412pgd.21.2021.07.15.22.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:41:26 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH] rcu: call kvm_check_and_clear_guest_paused unconditionally
Date:   Fri, 16 Jul 2021 14:41:13 +0900
Message-Id: <20210716054113.1244529-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not call kvm_check_and_clear_guest_paused() only from the
stall branch (which requires an active grace period in the
first place), but instead handle PVCLOCK_GUEST_STOPPED as
early as possible.

pvclock_touch_watchdogs() touches various watchdogs, which
have different timeouts, so the earlier we handle stopped
VCPU the better (lockup watchdog does the same).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 677ee3d8671b..5dd6ea2ead0c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -657,6 +657,13 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	unsigned long js;
 	struct rcu_node *rnp;
 
+	/*
+	 * If a virtual machine is stopped by the host it can look to
+	 * the watchdog like an RCU stall. Check to see if the host
+	 * stopped the vm.
+	 */
+	kvm_check_and_clear_guest_paused();
+
 	lockdep_assert_irqs_disabled();
 	if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
 	    !rcu_gp_in_progress())
@@ -699,14 +706,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
-		/*
-		 * If a virtual machine is stopped by the host it can look to
-		 * the watchdog like an RCU stall. Check to see if the host
-		 * stopped the vm.
-		 */
-		if (kvm_check_and_clear_guest_paused())
-			return;
-
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
@@ -717,14 +716,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
 		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
-		/*
-		 * If a virtual machine is stopped by the host it can look to
-		 * the watchdog like an RCU stall. Check to see if the host
-		 * stopped the vm.
-		 */
-		if (kvm_check_and_clear_guest_paused())
-			return;
-
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(gs2, gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
-- 
2.32.0.402.g57bb445576-goog

