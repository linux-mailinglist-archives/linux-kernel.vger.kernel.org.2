Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA103D18BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhGUU1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhGUU1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:27:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E65EB6141C;
        Wed, 21 Jul 2021 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901695;
        bh=EnVzEtFnkzNN4ZcGmW5TGlEOLlti+MulOzrZxzhzTCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUvN784FG4vQt/vkDJa13hhH4In8/bUhvid2mt5m8RgGcLqN/vvTcT2/IKhjEOeqt
         jqyikp/W1HhipUxfFQCmbxdokr62X3rsrnJ8VeZ1TTVJ1iY0pAJA2m+Ffj2swgSpJQ
         Ne2PdZ4FJGuO+UhEzZol1g4UGM8gr9S6swRpy/+ZzXQntQZ7xPWvZXLXTMyqyodhRt
         vkBQXYCKNoUpy3/ocnKWv7cto1fvxl6kRA2UQx8rMSCbQvG5yeuG+4wn2BWeRpIwFl
         3SImQPxX5JYCGFvvJtTiLkns6nz2BnytZaTyFdPO2aQjIA+2qYYfMSv0zscwxrYjwB
         bvhQ/KkaPVqyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C88C5C0C70; Wed, 21 Jul 2021 14:08:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 6/8] kcsan: Print if strict or non-strict during init
Date:   Wed, 21 Jul 2021 14:08:10 -0700
Message-Id: <20210721210812.844740-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Show a brief message if KCSAN is strict or non-strict, and if non-strict
also say that CONFIG_KCSAN_STRICT=y can be used to see all data races.

This is to hint to users of KCSAN who blindly use the default config
that their configuration might miss data races of interest.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 439edb9dcbb13..76e67d1e02d48 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -656,6 +656,15 @@ void __init kcsan_init(void)
 		pr_info("enabled early\n");
 		WRITE_ONCE(kcsan_enabled, true);
 	}
+
+	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) ||
+	    IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) ||
+	    IS_ENABLED(CONFIG_KCSAN_PERMISSIVE) ||
+	    IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {
+		pr_warn("non-strict mode configured - use CONFIG_KCSAN_STRICT=y to see all data races\n");
+	} else {
+		pr_info("strict mode configured\n");
+	}
 }
 
 /* === Exported interface =================================================== */
-- 
2.31.1.189.g2e36527f23

