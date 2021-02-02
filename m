Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1F30B469
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhBBBHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhBBBHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:07:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDAFC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 17:06:30 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id m6so13235479pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 17:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tWP56wGAsq5M1/6L0Nhx+Nff7Wx1AXO7jr86wZj1aM=;
        b=IVgPwKBKfNJ9jpRYoicL6hpd2wmOuRx6xSG+oELVY/zQuuhBTyLcF9eM/iOrSQK9XY
         hfa3wCKjPC5kjiiqsTwFOuMHg4lf3GQopkekSXhZFImOdjiGe5f1ugKUzKNiTJc/u+M4
         sNfMdGZLsEIgokugJxQ6Icjgzh4DJo2HFoVoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tWP56wGAsq5M1/6L0Nhx+Nff7Wx1AXO7jr86wZj1aM=;
        b=TRmLoofUvoibTqTsL0ZD2YwzoZQR2/RicQ7VNay0Qs0u0VqNYFLn14BixTFrrR/RJ8
         2DhhlnfiBBU6TE90ZFLFavA11fKItHxmdG4d3vTy+C1LbXX8NatMXjMOXO78pwclZwJS
         wsNTYmQVCokd5xXe6wuVY6n2kBDlgnGElA5ptD3FvDlxrLlbu3vybFiAGqgYmVz9vikq
         wHtiEN1L+LArGbapcB0AfokOCtcDf7JoRskIxcOU8ArZbYKAIx9olMIMhvfd26Lsv32P
         x2eVCWnLcvgAoVSBukCIG2ypNe7ANGlvZxR2Hrp+/cUfqV3LVSVtFwJchTKVEt73dcuH
         xA+A==
X-Gm-Message-State: AOAM533+Unw7vcJBwJdn59FPjLRnEqvmWz74XYf+qkpGKtKfCk9HV4O+
        zIRG30eQDFLAkhFfukj/kz4UQc1ND/BS1Ndr
X-Google-Smtp-Source: ABdhPJwntOGwfW+QmkbBNMIa6+zYGCYzPyotiBWqhxHLBlUE+EHriVmMrDbRJc6c1OtSykVwqcKgdw==
X-Received: by 2002:aa7:8b0f:0:b029:1c0:e782:ba29 with SMTP id f15-20020aa78b0f0000b02901c0e782ba29mr18490270pfd.37.1612227990480;
        Mon, 01 Feb 2021 17:06:30 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:d1cd:7a42:64fe:9bae])
        by smtp.gmail.com with ESMTPSA id b17sm20003282pfp.167.2021.02.01.17.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 17:06:29 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        joro@8bytes.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Properly pass gfp_t in _iommu_map() to avoid atomic sleeping
Date:   Mon,  1 Feb 2021 17:06:23 -0800
Message-Id: <20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sleeping while atomic = bad.  Let's fix an obvious typo to try to avoid it.

The warning that was seen (on a downstream kernel with the problematic
patch backported):

 BUG: sleeping function called from invalid context at mm/page_alloc.c:4726
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9, name: ksoftirqd/0
 CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.4.93-12508-gc10c93e28e39 #1
 Call trace:
  dump_backtrace+0x0/0x154
  show_stack+0x20/0x2c
  dump_stack+0xa0/0xfc
  ___might_sleep+0x11c/0x12c
  __might_sleep+0x50/0x84
  __alloc_pages_nodemask+0xf8/0x2bc
  __arm_lpae_alloc_pages+0x48/0x1b4
  __arm_lpae_map+0x124/0x274
  __arm_lpae_map+0x1cc/0x274
  arm_lpae_map+0x140/0x170
  arm_smmu_map+0x78/0xbc
  __iommu_map+0xd4/0x210
  _iommu_map+0x4c/0x84
  iommu_map_atomic+0x44/0x58
  __iommu_dma_map+0x8c/0xc4
  iommu_dma_map_page+0xac/0xf0

Fixes: d8c1df02ac7f ("iommu: Move iotlb_sync_map out from __iommu_map")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I haven't done any serious testing on this.  I saw a report of the
warning and the fix seemed obvious so I'm shooting it out.

 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3d099a31ddca..2b06b01850d5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2441,7 +2441,7 @@ static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
 	const struct iommu_ops *ops = domain->ops;
 	int ret;
 
-	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
+	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
 	if (ret == 0 && ops->iotlb_sync_map)
 		ops->iotlb_sync_map(domain, iova, size);
 
-- 
2.30.0.365.g02bc693789-goog

