Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676F13D18B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhGUU1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhGUU1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:27:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98E1D613CF;
        Wed, 21 Jul 2021 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901694;
        bh=Z0tp86t9IU4025ITmJpRQ2NPiQ4EzlkqCAQOh5lB8Og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPjcYR+wmOoxGPUAFoVFLIOZEbKKGSjidNOOqok17xKrhs04HAR87kolTn0f2lxz0
         ROj2hRGMLIELzBVa4w4bWhvcicIlFrMlsM/95BnZSFhtWS9UHv1uAfoPWfUkSp+YIl
         dxTRa6kp5hCEfyuPSOFqAO6NXzaxKkN3xKENeaimKIisNgUQlLZHSraW8abQDRFbYP
         5vXN4Vu2eD/vClCRB3sK0iAbDlcDI3d5JnRdDEqYgIT8nbz0IOZizIj2ATKBS2NIYh
         HNVTbXkuQiUHFzs1qsyqgxqO/bPFMnC81c20IBtIGjaC7eqUjs4PyLSncUHsWVKlZe
         NnWXMUunVWkFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5C04D5C0A11; Wed, 21 Jul 2021 14:08:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 3/8] kcsan: Introduce CONFIG_KCSAN_STRICT
Date:   Wed, 21 Jul 2021 14:08:07 -0700
Message-Id: <20210721210812.844740-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Add a simpler Kconfig variable to configure KCSAN's "strict" mode. This
makes it simpler in documentation or messages to suggest just a single
configuration option to select the strictest checking mode (vs.
currently having to list several options).

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst |  4 ++++
 lib/Kconfig.kcsan                 | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 6a600cf8430b1..69dc9c502ccc5 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -127,6 +127,10 @@ Kconfig options:
   causes KCSAN to not report data races due to conflicts where the only plain
   accesses are aligned writes up to word size.
 
+To use the strictest possible rules, select ``CONFIG_KCSAN_STRICT=y``, which
+configures KCSAN to follow the Linux-kernel memory consistency model (LKMM) as
+closely as possible.
+
 DebugFS interface
 ~~~~~~~~~~~~~~~~~
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 5304f211f81f1..c76fbb3ee09ec 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -183,9 +183,17 @@ config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	  reported if it was only possible to infer a race due to a data value
 	  change while an access is being delayed on a watchpoint.
 
+config KCSAN_STRICT
+	bool "Strict data-race checking"
+	help
+	  KCSAN will report data races with the strictest possible rules, which
+	  closely aligns with the rules defined by the Linux-kernel memory
+	  consistency model (LKMM).
+
 config KCSAN_REPORT_VALUE_CHANGE_ONLY
 	bool "Only report races where watcher observed a data value change"
 	default y
+	depends on !KCSAN_STRICT
 	help
 	  If enabled and a conflicting write is observed via a watchpoint, but
 	  the data value of the memory location was observed to remain
@@ -194,6 +202,7 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
 config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 	bool "Assume that plain aligned writes up to word size are atomic"
 	default y
+	depends on !KCSAN_STRICT
 	help
 	  Assume that plain aligned writes up to word size are atomic by
 	  default, and also not subject to other unsafe compiler optimizations
@@ -206,6 +215,7 @@ config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
+	depends on !KCSAN_STRICT
 	help
 	  Never instrument marked atomic accesses. This option can be used for
 	  additional filtering. Conflicting marked atomic reads and plain
-- 
2.31.1.189.g2e36527f23

