Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C4235D90E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241760AbhDMHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbhDMHhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C78EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:37:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d8so7734713plh.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lY+BvEE2MyA/W5iizb1+I2X/2gi/Ot/SaAWBNm40SKc=;
        b=N0z3JMwCZbLees7ZXAFo7xVyRVS64HlYoJWOAsfnRZjmpbKbtYBJr4DI9Xzy7Wy+x6
         0yTXADLiq9TNzEGwB/mvbNzIDaWzhqI3x/905Czr9QFM+pvNCtK9ZhIpOamIgAhxuYF3
         OXeSRsDw3i82Nm2sjWMytuseaguv9FYhPQZsNSw8aMBVS7kwwg+qsULjzQVkeDDX8Fvt
         fQLNgIHMfhftQkQfvBcFYNaEriQjHBbT6JU5Nd1wv8B2wZ35wwHfPMr8YqUjv43MPhh/
         0T/AAUunGnEZ7ZWBQr25ekw1OySeo3X+UMKiFS2pyUs9tz/DIGk7/QPvRjEdP1R81wOD
         s6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lY+BvEE2MyA/W5iizb1+I2X/2gi/Ot/SaAWBNm40SKc=;
        b=bG/X3QSS1GUTPPBrNbPgLaTVXs/YKyYo/wpiLPNdIaBSVJG4Y3vPGR+8gK/LoKhdfN
         EsDq3xket/k5MSsNNrlsHjK5lXoNWgjJQwYigLXGrxX47EC+4311R/9rYDWg1hW0zNRF
         jhcrCK0cv61JFGEr2W88zupd8bxPQafd78yt9AUavuDSWutcTCizsx71/xdfMsgGlEwN
         i3/MXR4LzDEeYnOQbqZcmxBAXAB3Z+GEitLF/wKh6DKbU+/ytHJ/pkn34aL4k6wbB9mb
         3KSDhyluQwtx6RZGqSjOL7lKcf6TI5KMlCgwHxQ7JhuuwlwWZvmLCCiPRUhJattYyJ5Y
         Gh4A==
X-Gm-Message-State: AOAM5305psk+czrC1A3HGuZ+RZKDLzypFf7Ya/EfKn2limme/8yKFaEC
        Zu/t7en/saQDdJC9micwLF8=
X-Google-Smtp-Source: ABdhPJwHz8U4+7dZPA7iaT7pzX9Y8YSyn9ndZQmoXZmm0483t141RWtKUbsN1wyiP76VAP7foWd/EA==
X-Received: by 2002:a17:902:d104:b029:eb:6d3:1436 with SMTP id w4-20020a170902d104b02900eb06d31436mr7559974plw.1.1618299425013;
        Tue, 13 Apr 2021 00:37:05 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:71d7:d843:bfe8:bec7])
        by smtp.gmail.com with ESMTPSA id a3sm1349068pjq.36.2021.04.13.00.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:37:04 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH 1/3] rseq: optimize rseq_update_cpu_id()
Date:   Tue, 13 Apr 2021 00:36:55 -0700
Message-Id: <20210413073657.2308450-2-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413073657.2308450-1-eric.dumazet@gmail.com>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Two put_user() in rseq_update_cpu_id() are replaced
by a pair of unsafe_put_user() with appropriate surroundings.

This removes one stac/clac pair on x86 in fast path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Arjun Roy <arjunroy@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/rseq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index a4f86a9d6937cdfa2f13d1dcc9be863c1943d06f..d2689ccbb132c0fc8ec0924008771e5ee1ca855e 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -84,13 +84,20 @@
 static int rseq_update_cpu_id(struct task_struct *t)
 {
 	u32 cpu_id = raw_smp_processor_id();
+	struct rseq *r = t->rseq;
 
-	if (put_user(cpu_id, &t->rseq->cpu_id_start))
-		return -EFAULT;
-	if (put_user(cpu_id, &t->rseq->cpu_id))
-		return -EFAULT;
+	if (!user_write_access_begin(r, sizeof(*r)))
+		goto efault;
+	unsafe_put_user(cpu_id, &r->cpu_id_start, efault_end);
+	unsafe_put_user(cpu_id, &r->cpu_id, efault_end);
+	user_write_access_end();
 	trace_rseq_update(t);
 	return 0;
+
+efault_end:
+	user_write_access_end();
+efault:
+	return -EFAULT;
 }
 
 static int rseq_reset_rseq_cpu_id(struct task_struct *t)
-- 
2.31.1.295.g9ea45b61b8-goog

