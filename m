Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9333D3E11
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhGWQVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhGWQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC348C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so4518934pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7V+TW4j/dTKdTkh3n8BXLdQOwARDBdQfixL2tFdi55Y=;
        b=H/V5/yWkynYmSW8o0j4NWtH05Et3lvod20vgWvq1x9CeXtoj6iceIn4C8BEjEWEPzP
         hr30+khZ/66DovGzi2qzsaqQlbKPVJK30FaKMYUCTIQ2hSFGTSnbdJNQFcwPdNIQCtBP
         ZB8qRez/W8v9EYmntRr+wL3LF4MPkcVQ+1SZNA/54I4n3H02E0VnksJMltwYWAadx2OY
         qj2xEVAQ0VFRWKwPnMT6apHfuQ6BaWddwTzrEzszMMOZjhlUO0kMIHYBbItQXFT0bogQ
         NfJIZjclGHSjF57KSqPZsvopFyzSgT0MQMeagVZ3mqhBeAHi5CyBXoGJId0jYo6/OOiZ
         ybXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7V+TW4j/dTKdTkh3n8BXLdQOwARDBdQfixL2tFdi55Y=;
        b=k+BK7aU0QwdO4Mn6tvJ+M/byjX2/3K0wQfmHMMoq1PDpBGQX+DKZdTstn0r6ZUc8Lg
         d9k3vav8BCXgyqzd4qj9/EmGYxYOhiuH3GXTfPMqAebB2cXB4Qj6QWlU26RsjWkMDbeN
         mPlU9C+e/T4ON5h7ZzfNuocZLdX1Mzex8uyU8OxNC5yH6R2axJc70Mz7fd8XM4v+ggHe
         8YJr9JobbURfRPZVm8yykw5aXMsxNw5l0qW4B6/beeXdPeIBBK+Rr11sDmC3R6nORlSg
         rtit4yEwM16VejSJya7PJ2uSfUmFuegm1FETlmfBcPm1OtDVIOl2HhCBwvZA2pqhqEF2
         trkQ==
X-Gm-Message-State: AOAM530ddAbXLwymLJ9bcjmLushpTyINcZNMGH3U9LBnlLLkViggvLUQ
        QT/GFTtQnTlG0AZJqJuq068=
X-Google-Smtp-Source: ABdhPJyTddjeUVT07xUgh/lw1kS9bu8a3qI5oK7vLKlmSpFpNzOCvASJ5Y0ej1rDgh88K9hNb4rOQA==
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr5735888pgf.65.1627059721160;
        Fri, 23 Jul 2021 10:02:01 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:02:00 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/7] iommu/amd: Do not use flush-queue when NpCache is on
Date:   Fri, 23 Jul 2021 02:32:04 -0700
Message-Id: <20210723093209.714328-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
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
index 46280e6e1535..1c7ae7d3c55d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,8 +1850,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
-	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
+	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
+		if (!amd_iommu_unmap_flush)
+			pr_info("IOMMU batching is disabled due to virtualization\n");
+
 		amd_iommu_np_cache = true;
+		amd_iommu_unmap_flush = true;
+	}
 
 	init_iommu_perf_ctr(iommu);
 
-- 
2.25.1

