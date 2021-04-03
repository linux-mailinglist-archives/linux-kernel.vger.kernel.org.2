Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA63532B0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 07:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhDCFNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 01:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhDCFNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 01:13:40 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224AEC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 22:13:38 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m11so5993468qtx.19
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 22:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5e19wUdjdODQtGD2+GvA+Yzt0Qe0WeByd74Ygcf0qpo=;
        b=RSLGuy7Kh37CaGR59OvN4TwyzsJg7oifTMmm9Nxlu2Ybw6NQiYdi+9tHOptypt1958
         j2fehMNyvamzGtEfEKt+mFLdy/eQ9ekiTaTVZ9XbAaXNpjUYBslWwogJlOz1Ie+sJ6J6
         LG7JiHDC1Ko7EKqax9gNaStHYCMS2hMagAVPX5bli60EN4ycotVrfugd2bbo7AIRddR1
         11ntZ+a+0I4nGoHiIzAV3dA9vFD9lypn6ncRdNP/d3SxBmDBPer9Nwa/MhqmuJHWo4uH
         VrX7GxFpP4xjPIhy38IwB1h4B2Xj6ZVl9FIWFwIYFpe4MYLQKEeZ/NUL12bEfZ2/S9oh
         bu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5e19wUdjdODQtGD2+GvA+Yzt0Qe0WeByd74Ygcf0qpo=;
        b=NdlIbJytzve5q/gEbFXUDMezjyhVf0FpCHFQkA+Z4hxJuIvwiDvGxNIV0+sUSbjeGP
         eJMUx3ApMX57OuQ00qAjE962t0eSWXxqEM5lb9e/Z7CbxRDpXZMvdT7/CTFodC1S8CX/
         vYKL62SsQF1RVHdoGj4AE8P6d0ZI53P4fOnotDZIVELRwxhP3tQJg/kI9oNBLOTuo+I1
         9m7AYycpSWgwNLYcQtLYjeglJVoV6WQGwL3znKs0cJTapePd2esISiYr/uQ2451BeHRL
         fvhWeEnJCGXZJkBU1ei+rywsrL1XUGCB26+2066z5+uSFYV96LU24SVcmb+EilpHKQNQ
         IeIg==
X-Gm-Message-State: AOAM531+yRTjXjNoTjL5eeS0xb+aV8FITWU0+jnCp9o++a/B7Wjw+Xb5
        wuAp4/v+Ts8lh1I1Gqg69of/xfo=
X-Google-Smtp-Source: ABdhPJx9AF7tORTLtgPQIRGaLKtq7413l8Z76aS59E00uak73td2NPgBTs1wu4w51hdbRBwQ2QC89RE=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7898:24e2:b0bc:77e6])
 (user=pcc job=sendgmr) by 2002:a0c:f805:: with SMTP id r5mr15630966qvn.45.1617426816378;
 Fri, 02 Apr 2021 22:13:36 -0700 (PDT)
Date:   Fri,  2 Apr 2021 22:13:25 -0700
Message-Id: <20210403051325.683071-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH] kfence: unpoison pool region before use
From:   Peter Collingbourne <pcc@google.com>
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory region allocated by KFENCE had previously been poisoned,
any validity checks done using kasan_byte_accessible() will fail. Fix
it by unpoisoning the memory before using it as the pool region.

Link: https://linux-review.googlesource.com/id/I0af99e9f1c25eaf7e1ec295836b5d148d76940c5
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 mm/kfence/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index d53c91f881a4..bb22b0cf77aa 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -633,13 +633,19 @@ static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
 
 void __init kfence_alloc_pool(void)
 {
+	void *pool;
+
 	if (!kfence_sample_interval)
 		return;
 
-	__kfence_pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
-
-	if (!__kfence_pool)
+	pool = memblock_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
+	if (!pool) {
 		pr_err("failed to allocate pool\n");
+		return;
+	}
+
+	kasan_unpoison_range(pool, KFENCE_POOL_SIZE);
+	__kfence_pool = pool;
 }
 
 void __init kfence_init(void)
-- 
2.31.0.208.g409f899ff0-goog

