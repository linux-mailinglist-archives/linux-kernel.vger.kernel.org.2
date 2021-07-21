Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCB3D18B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhGUU1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhGUU1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:27:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E2BC613F8;
        Wed, 21 Jul 2021 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901694;
        bh=/m4Am1C2OyApZU0OlXF9iJUerqbUWjkTj5tkxKgDhRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLV8wcCDLCLQqe5C82YvvRpeK32iOMb3mzWCpNPOJeHaVPGJK8kDVRynnmuNF4Ig2
         SyCX+JQPuGrhc5NkQBMoaTebd+61bQg4LRqUoVpWu16IS2AIsNVCIUoSOHzg3qmVIU
         1TWWWdr8j2KsxZfNmwK0M6UViHbaPXAwhGWLeDTrh7mPIqVs++nM8+Ymjqy204pDji
         lA4kOXs7qd857fuWEY4RC/kNx0a0jdFJSiarWC4wW/h3Klyn1bjtd0zgx4r1sexCqc
         0tgYDJuStLXpw1JIJ/xRDo05PQEuXfc/hCzRWXtHnoTmpifSCRSUI6gUWUTOX/IFGu
         4sanRkqonWzGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 570D85C0A03; Wed, 21 Jul 2021 14:08:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 2/8] kcsan: Remove CONFIG_KCSAN_DEBUG
Date:   Wed, 21 Jul 2021 14:08:06 -0700
Message-Id: <20210721210812.844740-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

By this point CONFIG_KCSAN_DEBUG is pretty useless, as the system just
isn't usable with it due to spamming console (I imagine a randconfig
test robot will run into this sooner or later). Remove it.

Back in 2019 I used it occasionally to record traces of watchpoints and
verify the encoding is correct, but these days we have proper tests. If
something similar is needed in future, just add it back ad-hoc.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 9 ---------
 lib/Kconfig.kcsan   | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 26709ea65c715..d92977ede7e17 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -479,15 +479,6 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		break; /* ignore; we do not diff the values */
 	}
 
-	if (IS_ENABLED(CONFIG_KCSAN_DEBUG)) {
-		kcsan_disable_current();
-		pr_err("watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
-		       is_write ? "write" : "read", size, ptr,
-		       watchpoint_slot((unsigned long)ptr),
-		       encode_watchpoint((unsigned long)ptr, size, is_write));
-		kcsan_enable_current();
-	}
-
 	/*
 	 * Delay this thread, to increase probability of observing a racy
 	 * conflicting access.
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 6152fbd5cbb43..5304f211f81f1 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -62,9 +62,6 @@ config KCSAN_VERBOSE
 	  generated from any one of them, system stability may suffer due to
 	  deadlocks or recursion.  If in doubt, say N.
 
-config KCSAN_DEBUG
-	bool "Debugging of KCSAN internals"
-
 config KCSAN_SELFTEST
 	bool "Perform short selftests on boot"
 	default y
-- 
2.31.1.189.g2e36527f23

