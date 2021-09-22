Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33019414FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhIVS1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhIVS1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:27:31 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A907CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:26:00 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso4165782edp.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hROscUrgx82P/DRIV1g6rbQ4KwPphWmoM+tTMU2qK8E=;
        b=tT1s4L2x6/uDOqLYSEh3Cmnj+ZHPMdfbAxewhCnCi7iihLKnXqzVTxuJICz31WdiO4
         CdpeOB1ExJfMITOZW+iEJZbkMbCHW5pwhHM1gu8pb3c3YAWVfIbWvD4Py0P1+wAykada
         NhKdgQHNGCk2ptgfOfgqFKOdDNE12fY8Cc+LRyOvL/nnb9MEnqI1HjqYMbagGowokSND
         veZavqCog8HDfcRtxdEFAiDHcsY6AKF4WJCx+yz8ub9gnl3VsTL8v01NRVYBokYMidC8
         RiSH1FuNAoQFULz/cYNIHqj0a8JEyN3Vd8aVF4v4MPXbobsm84Z3v4yVvTAkiLxdVyaL
         gzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hROscUrgx82P/DRIV1g6rbQ4KwPphWmoM+tTMU2qK8E=;
        b=makUDVTU6r5pKx7PZw0ToIOz4i7UAS0hod/iJ4X7fL3d1w12aWOzsL4AsOpObBWw8R
         rnIyWLtFJYbiZV8JOCBisgmnwRlzafoDPO/lYDtfcN08zTn3+r/dEQL8/oQNQXOelBPX
         MoQVWZso4qhKRE7hBcFk8I4Cu0C+jVa88stZlnOOi2NdHvuNMwlEnGm1sEOm8AVAwv13
         nroRQ2gfnOu8dCN2rgS2vqSclWOZdbJrWi3U9gdZVrPe5vDtZl4Ni5bQH45qRhvSlXPC
         XIEI6x9+C1Rx6r/uruPNOhWKDwl5oiLZg5wZ1CJUuRSIN5TVxx0qLHpPC+oHxdpCqPiH
         71fg==
X-Gm-Message-State: AOAM533T0jwYHGtwhewImRJaRJDt+4kVuSsEeIqIaEwAXGo5f7xVeD8A
        2nTp+1a9Ig3hwLGQmMqA/gqlw8mTGw==
X-Google-Smtp-Source: ABdhPJy953tfY9ijLr1x+Rwh6kZsYSkYidCYFHPT0Ea43m43CeZ5zIGy0NE+O0TI7KqGRAQSDbBMtY29Og==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:d1cb:58a8:28e2:c853])
 (user=elver job=sendgmr) by 2002:a17:906:6c94:: with SMTP id
 s20mr722795ejr.152.1632335159064; Wed, 22 Sep 2021 11:25:59 -0700 (PDT)
Date:   Wed, 22 Sep 2021 20:25:41 +0200
Message-Id: <20210922182541.1372400-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH] kfence: test: use kunit_skip() to skip tests
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new kunit_skip() to skip tests if requirements were not met. It
makes it easier to see in KUnit's summary if there were skipped tests.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/kfence_test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index f1690cf54199..695030c1fff8 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -32,6 +32,11 @@
 #define arch_kfence_test_address(addr) (addr)
 #endif
 
+#define KFENCE_TEST_REQUIRES(test, cond) do {			\
+	if (!(cond))						\
+		kunit_skip((test), "Test requires: " #cond);	\
+} while (0)
+
 /* Report as observed from console. */
 static struct {
 	spinlock_t lock;
@@ -555,8 +560,7 @@ static void test_init_on_free(struct kunit *test)
 	};
 	int i;
 
-	if (!IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON))
-		return;
+	KFENCE_TEST_REQUIRES(test, IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON));
 	/* Assume it hasn't been disabled on command line. */
 
 	setup_test_cache(test, size, 0, NULL);
@@ -603,10 +607,8 @@ static void test_gfpzero(struct kunit *test)
 	char *buf1, *buf2;
 	int i;
 
-	if (CONFIG_KFENCE_SAMPLE_INTERVAL > 100) {
-		kunit_warn(test, "skipping ... would take too long\n");
-		return;
-	}
+	/* Skip if we think it'd take too long. */
+	KFENCE_TEST_REQUIRES(test, CONFIG_KFENCE_SAMPLE_INTERVAL <= 100);
 
 	setup_test_cache(test, size, 0, NULL);
 	buf1 = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
-- 
2.33.0.464.g1972c5931b-goog

