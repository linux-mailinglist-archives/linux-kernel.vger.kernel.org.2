Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3B40D0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhIPAdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233582AbhIPAdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:33:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 110626120C;
        Thu, 16 Sep 2021 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752308;
        bh=Hii/WrluvBMkQ4cvmJy+DrFovV6WxYP/RUaZIIiauIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azZ4R+Quy2aBtaR2gN4c87YloazB3hcmwQiWRUGVTe+i2plfmYEIhIUManE22Z0Xv
         Q4Ai2fms1jQQzeT/TpWb7KLTjK1PjIzss2TTuxddNb/59uJ759QqTZlqGlJc0vV5WG
         0sX5iplZgM3bzOHhUHlCsGdcNpkwtD+DD/bCovPRiRDYENkGEpTpIgZOlz670mKWxI
         wDd0n2gyFrVLZFDZNUV89ahwBO8kNVCKmqwqsKPjF3iPkl6Y8czZCwGiK/HvwVF4Yj
         Z8NydZVSo8bN6AyflstFMon7E/upIkkrM/Ytlx2iSlbs+9uSo63iscMnJAZcLkz/fG
         va1fh7EFuG0Dg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B7FEE5C09F9; Wed, 15 Sep 2021 17:31:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 7/9] kcsan: Support reporting scoped read-write access type
Date:   Wed, 15 Sep 2021 17:31:44 -0700
Message-Id: <20210916003146.3910358-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
References: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Support generating the string representation of scoped read-write
accesses for completeness. They will become required in planned changes.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 8 +++++---
 kernel/kcsan/report.c     | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index a3b12429e1d3..660729238588 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -210,10 +210,12 @@ static bool report_matches(const struct expect_report *r)
 							"read-write" :
 							"write") :
 					       "read");
+		const bool is_atomic = (ty & KCSAN_ACCESS_ATOMIC);
+		const bool is_scoped = (ty & KCSAN_ACCESS_SCOPED);
 		const char *const access_type_aux =
-			(ty & KCSAN_ACCESS_ATOMIC) ?
-				      " (marked)" :
-				      ((ty & KCSAN_ACCESS_SCOPED) ? " (scoped)" : "");
+				(is_atomic && is_scoped)	? " (marked, scoped)"
+				: (is_atomic			? " (marked)"
+				   : (is_scoped			? " (scoped)" : ""));
 
 		if (i == 1) {
 			/* Access 2 */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index 4849cde9db9b..fc15077991c4 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -247,6 +247,10 @@ static const char *get_access_type(int type)
 		return "write (scoped)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
 		return "write (marked, scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE:
+		return "read-write (scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "read-write (marked, scoped)";
 	default:
 		BUG();
 	}
-- 
2.31.1.189.g2e36527f23

