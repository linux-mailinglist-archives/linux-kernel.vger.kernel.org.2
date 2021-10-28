Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6143E88D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhJ1Soc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhJ1So2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:44:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D558C061570;
        Thu, 28 Oct 2021 11:42:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 131-20020a1c0489000000b0032cca9883b5so8974802wme.0;
        Thu, 28 Oct 2021 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5ctcYr+hiRkqGH5aJ/1429sRX/gX5KpK78UC99anpA=;
        b=GsaYcu//7WfLsSO0p3vsuakFnTdmPrmuJn7bwpARosaOL3uQdAyzMLJqzVBNy+EY9a
         B0RKADY9y4IJ8t6TfTpYP52ToIu9dOw+GN2NQG4Jc1Qn6Vn4geS7I5HE7DYiSXlgjP2N
         Zd/sERL7enGQ4uuJFWJfgCUcGR8NYZe6hfk+Gfe7j7dzV/7852DpfP7FnAyO5cb9A5F+
         A/A8FrM6yBwdjWX6PJHDLx5Fswwm7chfwIK+Fn9cxQy5Hx9xe3Sz9O1DdQ00kh7DKB0f
         XtH6O3NUhRhiIDofjhVxfWGmNF0xJ32uA0Sj8/yKyHjTwRv4cJKA1h9yGrqk0K6GQpLq
         BEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5ctcYr+hiRkqGH5aJ/1429sRX/gX5KpK78UC99anpA=;
        b=yFjW1UnTxopHrxcladA3p68mPVxU//ytFa4KFh/xRyCU3OVVjQwpgGnCSOnWtouYn2
         PueTzB0yVaL5id5kY1rqqWrJNE7kSAgGGSDbnxr/JhTzrmIC4Z7xiDpq8mqPpRHa6x/x
         kn6Ye7JCdMCDw8HDWg56yXVuKlXqhly/FvKmZGSGUyAsN35kRfvifQXspuN+E8EG8Zdb
         D6ofq5ijl2SMwbePaieYooSAv3uTe10VqnBBcFxj79bUoJhlayb+8cXMV8kve4g8JYuk
         MLH6IYGS6Cxf6ayMlBL9KYx13Q/voJ+JqxOnuUwDz4/lXhxKkKo+JC+bGNsxQ/fWiFkQ
         F49w==
X-Gm-Message-State: AOAM533QJGmjQzPpIYD4Jc6fbAwS/B/FDe13TYGkEs01+lfwIKMv69tZ
        IFGbLDSFXigg0g==
X-Google-Smtp-Source: ABdhPJwesjygk2ycSujhbxXF4bdnFA+xOA89kyY+JuiKUM66Mn2+iR5BRpTnhRXx7H14VvOoO8KWYA==
X-Received: by 2002:a7b:cd03:: with SMTP id f3mr6442432wmj.89.1635446520121;
        Thu, 28 Oct 2021 11:42:00 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s13sm7102120wmc.47.2021.10.28.11.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:41:59 -0700 (PDT)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm/damon: Fix a few spelling mistakes in comments and a pr_debug message
Date:   Thu, 28 Oct 2021 19:41:57 +0100
Message-Id: <20211028184157.614544-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few spelling mistakes in the code. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 mm/damon/core.c       | 2 +-
 mm/damon/dbgfs-test.h | 2 +-
 mm/damon/vaddr-test.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f37c17b53814..c381b3c525d0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -959,7 +959,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 	/* higher than high watermark or lower than low watermark */
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
 		if (scheme->wmarks.activated)
-			pr_debug("inactivate a scheme (%d) for %s wmark\n",
+			pr_debug("deactivate a scheme (%d) for %s wmark\n",
 					scheme->action,
 					metric > scheme->wmarks.high ?
 					"high" : "low");
diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 104b22957616..86b9f9528231 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -145,7 +145,7 @@ static void damon_dbgfs_test_set_init_regions(struct kunit *test)
 
 		KUNIT_EXPECT_STREQ(test, (char *)buf, expect);
 	}
-	/* Put invlid inputs and check the return error code */
+	/* Put invalid inputs and check the return error code */
 	for (i = 0; i < ARRAY_SIZE(invalid_inputs); i++) {
 		input = invalid_inputs[i];
 		pr_info("input: %s\n", input);
diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 1f5c13257dba..ecfd0b2ed222 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -233,7 +233,7 @@ static void damon_test_apply_three_regions3(struct kunit *test)
  * and 70-100) has totally freed and mapped to different area (30-32 and
  * 65-68).  The target regions which were in the old second and third big
  * regions should now be removed and new target regions covering the new second
- * and third big regions should be crated.
+ * and third big regions should be created.
  */
 static void damon_test_apply_three_regions4(struct kunit *test)
 {
-- 
2.32.0

