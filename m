Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644BF3D18B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhGUU1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhGUU1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:27:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0849613FD;
        Wed, 21 Jul 2021 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901694;
        bh=nZu80pSi991/jep8dyfRtBhXzoNqP+PLM2pJMkKPv9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mv0cjSVM31CnNCv0QWoyELwMq0mSRYZKfhrqO31Ybs4qroG3Go9lmiX5LXoXN8CF3
         NTLnWC4t80EakFua+4/8DgDROgOLRe7zCm4kEJYmnWgIYFnf0Y9fQYGSyOzzYChzzX
         UBENRa6E2RI1ZH7EFdreGfpJdhX4RZcn76MefwEQAhS03u9K2IaySBN1IPgXSWqYzb
         XLy0VlrOGmN222o+lhDzTImLmHBHJ3XkY5U2JaSDiG/c4cemnSQ6lwWkV80J2fr7Sa
         DWB2ZGrJ799R0HT8458o9ysifHZwxW49bE9C//a2Ey0lIrJW1ZIdOrXCcAKz9Y3oIa
         t7rC0Z75CGc7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 51EC25C09A4; Wed, 21 Jul 2021 14:08:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 1/8] kcsan: Improve some Kconfig comments
Date:   Wed, 21 Jul 2021 14:08:05 -0700
Message-Id: <20210721210812.844740-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Improve comment for CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE. Also shorten
the comment above the "strictness" configuration options.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Kconfig.kcsan | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 0440f373248eb..6152fbd5cbb43 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -40,10 +40,14 @@ menuconfig KCSAN
 
 if KCSAN
 
-# Compiler capabilities that should not fail the test if they are unavailable.
 config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
 	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
 		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param tsan-compound-read-before-write=1))
+	help
+	  The compiler instruments plain compound read-write operations
+	  differently (++, --, +=, -=, |=, &=, etc.), which allows KCSAN to
+	  distinguish them from other plain accesses. This is currently
+	  supported by Clang 12 or later.
 
 config KCSAN_VERBOSE
 	bool "Show verbose reports with more information about system state"
@@ -169,13 +173,9 @@ config KCSAN_REPORT_ONCE_IN_MS
 	  reporting to avoid flooding the console with reports.  Setting this
 	  to 0 disables rate limiting.
 
-# The main purpose of the below options is to control reported data races (e.g.
-# in fuzzer configs), and are not expected to be switched frequently by other
-# users. We could turn some of them into boot parameters, but given they should
-# not be switched normally, let's keep them here to simplify configuration.
-#
-# The defaults below are chosen to be very conservative, and may miss certain
-# bugs.
+# The main purpose of the below options is to control reported data races, and
+# are not expected to be switched frequently by non-testers or at runtime.
+# The defaults are chosen to be conservative, and can miss certain bugs.
 
 config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	bool "Report races of unknown origin"
-- 
2.31.1.189.g2e36527f23

