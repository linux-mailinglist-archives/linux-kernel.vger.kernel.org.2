Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB77415E52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbhIWM2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbhIWM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:28:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D084C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:27:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n2so3868353plk.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EG/jIsXsinDHEREmGQKFYzsvt6qH7E+P5K9bH6Rw3k8=;
        b=q5UmY5hkt8KCJWcDURo1rVUITu5vDqRjhzC2FLP1HxC286Ha0Desx0hRoXfA4lO04k
         8VvhbkS1w8vAUH1kNaIahccythth+fllOS4kgzzkFl0cxTiW5cz56sOirLwo600qnn1y
         4qivyYm31m5W8QPS0MY2YEwpAohzDOI6u2KNbmLOzZbmPuU+9tsTrf9C5/WAhcL7i4EK
         L5fpEOhom/HOp5jKj+Zm1l0vfZO6oo/rDdUMXS/rZ4+x0eJok8fRkfJTPu5ShVy6FxVh
         8qfw5riRS7825a7f1rANAWs63FWzTnTE0fyPz+iet7b61SAVUWrld98ygtD5sampl5f9
         EFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EG/jIsXsinDHEREmGQKFYzsvt6qH7E+P5K9bH6Rw3k8=;
        b=kbyDzpyx9/a7pfMVVL/dqkw0AoHIRzBDd3l8EC1bBgFsilcWZkSUT3bTpk/vDU6XXO
         BmJdj2wt7BHnmDCw5K/YF1hxHN4DARQJLLUtM22n2X5+sg/Meuz2XZG3O78BOsTvuk1h
         GUJ0Fxcu4DKjWw0ommlVKK/P74clDkTC3HsGj90hIDGGi0vW7IAanlVbJljeTzSXLBxC
         Kyc/LIUke0bd9IRBA2WcZf4Jxkm7+Q9i0y7FXlJqKNjbkWQc9xfiN+wDcom0Xn1DJFii
         cJ7SQHm6u5L/OW/x/+V90lgUw8dgI167Q9yyy86a4kJSKyM1Z9kk/peMftnxzwFE76D7
         iL3Q==
X-Gm-Message-State: AOAM5333YMKAs3iElfKSHuZVP0qXDO2U/Hi6RWEdhnuqrexh/ojYdEIi
        Z28KTP6C9cAKbk+Ai6Atw0/R3Q==
X-Google-Smtp-Source: ABdhPJzJumf/vq3brjK1T9CHdxiVtqzRbHdGtmE9hicDTx8of0VoCMMYIv4czr5pNaYXuHBtnyEL8Q==
X-Received: by 2002:a17:90b:1e09:: with SMTP id pg9mr17562608pjb.73.1632400027804;
        Thu, 23 Sep 2021 05:27:07 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id y5sm5561401pfb.207.2021.09.23.05.27.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Sep 2021 05:27:07 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     naoya.horiguchi@nec.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm/memory_failure: Fix the missing pte_unmap() call
Date:   Thu, 23 Sep 2021 20:26:42 +0800
Message-Id: <20210923122642.4999-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paired pte_unmap() call is missing before the
dev_pagemap_mapping_shift() returns. So fix it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory-failure.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e2984c123e7e..4e5419f16fd4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -306,6 +306,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
 		struct vm_area_struct *vma)
 {
 	unsigned long address = vma_address(page, vma);
+	unsigned long ret = 0;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -330,10 +331,12 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
 		return PMD_SHIFT;
 	pte = pte_offset_map(pmd, address);
 	if (!pte_present(*pte))
-		return 0;
+		goto unmap;
 	if (pte_devmap(*pte))
-		return PAGE_SHIFT;
-	return 0;
+		ret = PAGE_SHIFT;
+unmap:
+	pte_unmap(pte);
+	return ret;
 }
 
 /*
-- 
2.11.0

