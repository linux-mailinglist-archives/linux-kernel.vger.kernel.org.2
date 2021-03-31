Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C08834F753
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhCaDRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbhCaDRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:17:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:17:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x126so13505054pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YH7VyiloQmk21ZwkKDneMtghe+woErBUyGKt9DFQjxs=;
        b=M1Tx1fUmT1JZxICY8e/FPzijoytFN1mZY9tk4CIinK2+uwuX2m0XQgS+Z9e8taB8R5
         2ITcVOgv+upLlraexefx1xv9llhTWV0WONT+op8/4RDPgvRbs0B14UWgFDgvzhwfB/79
         vOw0HQV4torLVutoe9riI8nsuCs79yx0iH9jXbqNQUtKE7Ck0QaIs5jFHVMfVLG1MmWM
         lvVwY2l/oANDY3DPgh6snCF/OHggdnKWZbe/oxdT63nploswOVK2UG5buUFn3/mSXJfZ
         /6gP85L2fR5by6Cw5wmfi2S6SzgbDyVS+UfRis4mfgAcBPzfeR7Vel9jqjNa1ywxewGK
         xPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YH7VyiloQmk21ZwkKDneMtghe+woErBUyGKt9DFQjxs=;
        b=O4pOQCK2GjnOanP4FXwOfzcl+XU2Dlm6S0H8qXYRXAHX1R2P5aVziE1a2Nohhp+CI5
         8x+DfhEqmA5WtTDP6Tj3R/hzn1xiPPZxPy3fOVRo4R4fDxKx6EghfVd5XaOlPGW9m3vf
         5RIzTVr6P8v/XoA4UhjdXZxDUgPDORSumJ3/njKzD5NmzMr/saRie8UTpOcegRUaiwvx
         U/E80LI42912J9ohZj1TNNwOH9zIn0QfzD7zbIiJQIqi7FkqZ+TsnV6PizqyluFlzPzU
         +K/xb6veWRIkZhBXkW8e2xPg/E/u82w0f7OUPEgpKheDa91Ue5Rp4HMs0DnFo+I8xnxJ
         QVfQ==
X-Gm-Message-State: AOAM530pGhXarufFQ4j2xxqkxI6HiZIepr3PHmLJAz4lCloyjCW15BFR
        iZsmHgJbzUwUnkbJTAlT8JcRgST2fBM=
X-Google-Smtp-Source: ABdhPJy8eCVIy9HA8af7r53Q+VB4Rdwh8r/F74zYBiwOL5AvZFNsag+DAvSF2ZRDijJ5mzKgEdVMew==
X-Received: by 2002:a62:6451:0:b029:20e:f351:f1e with SMTP id y78-20020a6264510000b029020ef3510f1emr1013447pfb.54.1617160620192;
        Tue, 30 Mar 2021 20:17:00 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j26sm390204pfn.47.2021.03.30.20.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:16:59 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] iommu: sprd: Fix parameter type warning
Date:   Wed, 31 Mar 2021 11:16:45 +0800
Message-Id: <20210331031645.1001913-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The second parameter of clk_get_optional() is "const char *", so use NULL
instead of integer 0 to fix a sparse warning like:

">> drivers/iommu/sprd-iommu.c:456:42: sparse: sparse: Using plain integer as NULL pointer"

Also this patch changes to use the resource-managed variant of
clk_get_optional(), then there's no need to add clk_put() which
is missed in the current driver.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iommu/sprd-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 7100ed17dcce..371d5715cbc9 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -453,7 +453,7 @@ static int sprd_iommu_clk_enable(struct sprd_iommu_device *sdev)
 {
 	struct clk *eb;
 
-	eb = clk_get_optional(sdev->dev, 0);
+	eb = devm_clk_get_optional(sdev->dev, NULL);
 	if (!eb)
 		return 0;
 
-- 
2.25.1

