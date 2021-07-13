Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5502A3C75B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhGMR1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhGMR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:27:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74988C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:51 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y4so19727051pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7V+TW4j/dTKdTkh3n8BXLdQOwARDBdQfixL2tFdi55Y=;
        b=EUXrjWHqkH0BxXsmRSm3dqAmFXWbJKeF1oaVvbleGkXtZij1hf305qas49Tv1KT/aP
         UP9cfopwzY1fE7Ex+HV3eVpmNWMG721o+alH+pe90tCuHsyBDEEcYfS1XhrMlfO5c3fp
         Nreb+1fGLP6eTV/xo3r2qnnM3P6SDZoLlNKri0SmLmXp4pJD/GRMg2MQ5YDYjvGmpPuG
         A9gyZ+MWba3cH3dR0hjIepcm98PdRc7rddJrFBG2yEGr6UMioUl3PjflHMkLzcD1VwZ2
         nfmxJKqMSV5Gj4TouvrDF+C5+xoXEp69BpNa9mGVG8AlHgWM5cL0XB7PTYD6WxRJTrSZ
         CEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7V+TW4j/dTKdTkh3n8BXLdQOwARDBdQfixL2tFdi55Y=;
        b=J0NF7krh9LvPCsmqB0Sb1J+ZbR8r8UpPoMA9wth/TTbgwik0gj5ikJhRQbvFwbDMG1
         AuwAysY5caKecYzN1+56yMkh/DO44F7TceMOeZffvbwSBT/A6cw7uTC1PBqpdPpG5y85
         mUod1d0vKheD+zgMZxVNUeyMWEPFXtV7BZFC5yK0amyTojp+TAekJ5tiq7ZyjX1PQCnG
         jjOmcBaDTA+XEAO46zaOkVZkXkucVWAcpV+8z3jpcLl/e5I5oluo2M6YCZLNKRCiU9F5
         n4CLyqUlQa2RqA0e1eitLKL704cwRZ1Z+1KYXwl5Z+atjmJ2FD5aiLn0LZ/HxoQvUhM8
         wHPw==
X-Gm-Message-State: AOAM530y95XXboKKjWHwwewjbVarO43AiDFD/9sPG+51w7/lfxgFK0La
        ZAuoljYYk/H+Xf73tRNePJA=
X-Google-Smtp-Source: ABdhPJwvy73Brnre+MjqvuOUmw+yRf0jy/k9L3a5HcjCN33acOxQ1z3HwooFLIJXNhp/iE9o7Su3QA==
X-Received: by 2002:a63:d54b:: with SMTP id v11mr5251964pgi.450.1626197090907;
        Tue, 13 Jul 2021 10:24:50 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:24:50 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/7] iommu/amd: Do not use flush-queue when NpCache is on
Date:   Tue, 13 Jul 2021 02:41:46 -0700
Message-Id: <20210713094151.652597-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
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

