Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17C632679A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBZTzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBZTzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:55:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB05C061786
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:54:34 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y7so10975794ybh.20
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=93DnUl3mPCv0PBljL10S9KBQS9GPo3qds17qRDPIGwo=;
        b=VgZ7YllnWRdQlhW5UVXGqx4b3G72yCpzjPbSy4EknlflMm9yV5fAGN9KPRG4C2sFWJ
         Ol1VOI3JIuTqc9bmRYrPNu1TRREdeePlR2QlcXG1VqGfWtCT8AFaEjxEF347mbtLB/OV
         EDlctfFLDfAR912iIMSVNBuagumYNUzoS7JcWpOUSQFJrNyHyE4j1trav1TAMAUuYj46
         Ze/fH54Gw6lw/iR0PcpPniGu3J/qTsUK3sWCjPPzi/A8SHeeadKfdO27hF1LsmP3Hs6A
         sXRwULEdIo1tGA/DdWVx9nJiTPHtml9TMXJbnkY8UbMK7T7PGnnu0qfOCT0rTtBBipfL
         L9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=93DnUl3mPCv0PBljL10S9KBQS9GPo3qds17qRDPIGwo=;
        b=MZp+XnAQil2gXneu2+n2th0Kq3970xdxIJGJLWaYVHvDS+kZgIcyx/cia33FCRuVNs
         oyov0IgnL6rNhIs4nisUF2RQDtazQQsP9v5FpAF9f/1rKvdeZWjO1d0Wh8GkXA94L808
         /7PYs876ekCTRb4nAMr/7qeRfQ5TthFGHf/XJHpU8NAnpIx2daNMHq7REuQ6p8K4xkAY
         KzWsgjBrnp0GaxrJXsNjcV6DT5JI1Y1c3x2UXhpHHHdUv3Vyomp1b5AWSvZGa/F/Zjy0
         lQCjzgsFLeqCc7gMSzHzpmpNk2D/stffuCZfM/Re8EjEXemuwTMZ96vjueSCbwAxTD/D
         4WYA==
X-Gm-Message-State: AOAM530jMBHvLbC72Pwo9QD9bfgiLyj+ZDYMMIVFN/6gRTrtNr7Xul9S
        o5blOCHwvqr5xI14BSJ/+bwpXjUG5rXX
X-Google-Smtp-Source: ABdhPJwrQrbDsm/9ZeV4I0S72cQGd/tDoznkiJjGpTywkwUtpj+It4YMY3QYBTD3uRiDBhSVxw+kmfZ1Z1cB
Sender: "joshdon via sendgmr" <joshdon@joshdon.svl.corp.google.com>
X-Received: from joshdon.svl.corp.google.com ([100.116.76.254]) (user=joshdon
 job=sendgmr) by 2002:a25:1d88:: with SMTP id d130mr6463133ybd.446.1614369273382;
 Fri, 26 Feb 2021 11:54:33 -0800 (PST)
Date:   Fri, 26 Feb 2021 11:52:39 -0800
Message-Id: <20210226195239.3905966-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] sched: Optimize __calc_delta.
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clement Courbet <courbet@google.com>

A significant portion of __calc_delta time is spent in the loop
shifting a u64 by 32 bits. Use a __builtin_clz instead of iterating.

This is ~7x faster on benchmarks.

Signed-off-by: Clement Courbet <courbet@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b13634..dbd1ae203f7c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -214,6 +214,16 @@ static void __update_inv_weight(struct load_weight *lw)
 		lw->inv_weight = WMULT_CONST / w;
 }
 
+/*
+ * A __builtin_clz that handles a u32 value on architectures
+ * where `sizeof(unsigned int) < 32`.
+ */
+#if (__SIZEOF_INT__ < 32)
+# define BUILTIN_CLZ32(v) __builtin_clzl(v)
+#else
+# define BUILTIN_CLZ32(v) __builtin_clz(v)
+#endif
+
 /*
  * delta_exec * weight / lw.weight
  *   OR
@@ -229,27 +239,31 @@ static void __update_inv_weight(struct load_weight *lw)
 static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight *lw)
 {
 	u64 fact = scale_load_down(weight);
+	u32 fact_hi = (u32)(fact >> 32);
 	int shift = WMULT_SHIFT;
+	int fs;
 
 	__update_inv_weight(lw);
 
-	if (unlikely(fact >> 32)) {
-		while (fact >> 32) {
-			fact >>= 1;
-			shift--;
-		}
+	if (unlikely(fact_hi)) {
+		fs = 32 - BUILTIN_CLZ32(fact_hi);
+		shift -= fs;
+		fact >>= fs;
 	}
 
 	fact = mul_u32_u32(fact, lw->inv_weight);
 
-	while (fact >> 32) {
-		fact >>= 1;
-		shift--;
+	fact_hi = (u32)(fact >> 32);
+	if (fact_hi) {
+		fs = 32 - BUILTIN_CLZ32(fact_hi);
+		shift -= fs;
+		fact >>= fs;
 	}
 
 	return mul_u64_u32_shr(delta_exec, fact, shift);
 }
 
+#undef BUILTIN_CLZ32
 
 const struct sched_class fair_sched_class;
 
-- 
2.30.1.766.gb4fecdf3b7-goog

