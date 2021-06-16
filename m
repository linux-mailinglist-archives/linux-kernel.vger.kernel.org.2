Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A3C3AA277
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhFPRgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhFPRgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:36:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso4462704pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaCmke0KUr5hNz/V/U5Q1ipgm00ep8cVzDtmfH4etSo=;
        b=fGMSdy6veXpnegSm3FPvEItF+n/+ZvhKr/pjbKdx5R3XajlCitXAlcmbgv8GsDoYTu
         +mrfMWOciIb6YKYfgqN4UtR+cjXznHLfZRM7GPGiogS+IFK+ELqllqsCs9mbqpLFFOLQ
         1PPKHkjCzpqURZoLlDZrKKgHb/zgJMUGrstCHNVnmi11x+uceGyWquhSKgEqBHbBSOXr
         lfHqSdLGER8410SkkPVkmHDUzAmOUSjYIkVYSyh64Yf16pgafgMHgfjeKKvj4ikWU+vI
         blZvia5XAni7eUEF/FcRgo6IQ414viVemZaGNvqyE2xbPJUiFu7oKDRYKwclsuEe+6ct
         FJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaCmke0KUr5hNz/V/U5Q1ipgm00ep8cVzDtmfH4etSo=;
        b=N35EwTi01MqpzSOAH83/ZjhSGUi4GqX2n7RjTBYDXfuIbaneOrquP9i58sDFUrVZQH
         5RXwmjqI0Uyw+YdeC0f/DGKA7K1rGnDxtN2Pl1WRVvyZj+MBNk3iPS7Mf4+kYnfr4rde
         lXvlBQMskkYj9nHPY4onK7KCrj/seoEazjlr5fDbDU5ITpQ6t9DLJR3454fLWeC2XGxS
         2fLPjQB/JQLzighH42Y3JNlST1RD+jgXj3fbeknU6ss4KS/MIihNKBjzHTk5nfmZEI5H
         ZvjETtjzMBEfOScHxXO3bCfgJQepa38DL0yt5ysE8teQf8505GmSQl0U4xVYKf5nr/CH
         zOOg==
X-Gm-Message-State: AOAM532Ut2t0h6xASHURfpSbI0Buqtobm+Bp6Kc6n4hMZ6EBBRWMlQXI
        5acPmOgqaY5eT1F+kiWMngk=
X-Google-Smtp-Source: ABdhPJwcbD1NYoIUSr6+u8Onq2eIJ/+uWH2eVPZ7NLR9KqyitHvNcNfrt4hT5+Q6OBQFVWbff7XAZg==
X-Received: by 2002:a17:90a:4490:: with SMTP id t16mr7376370pjg.183.1623864866304;
        Wed, 16 Jun 2021 10:34:26 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:34:25 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] iommu/amd: Do not use flush-queue when NpCache is on
Date:   Wed, 16 Jun 2021 03:04:55 -0700
Message-Id: <20210616100500.174507-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Do not use flush-queue on virtualized environments, where the NpCache
capability of the IOMMU is set. This is required to reduce
virtualization overheads.

This change follows a similar change to Intel's VT-d and a detailed
explanation as for the rationale is described in commit 29b32839725f
("iommu/vt-d: Do not use flush-queue when caching-mode is on").

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..4a52d22d0d6f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,8 +1850,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
-	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
+	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
+		if (!amd_iommu_unmap_flush)
+			pr_warn("IOMMU batching is disabled due to virtualization");
+
 		amd_iommu_np_cache = true;
+		amd_iommu_unmap_flush = true;
+	}
 
 	init_iommu_perf_ctr(iommu);
 
-- 
2.25.1

