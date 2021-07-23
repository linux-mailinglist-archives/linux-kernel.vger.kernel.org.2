Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385003D4259
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhGWVAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:00:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53127 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhGWVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627076438; x=1658612438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FZmD5JDut8+hqQnxscDF4nA471lKHOPpWVdLU/AZ18o=;
  b=NzEP6GJ+vTrZoRsYL1+hVW6/+YPNJDfc5n3/6RZW4PS2/rXhDcO+YApS
   AL5bqTuhZkv7/MMOw0copSp7mjUWFZJ8w/T7we6iCxzJkQudfmG6Izyhb
   cf0jQzXnpCazii7TWqbIfQGAmjt4wLw2InJmRZ/enzeyzBUqesFqcwLQ1
   mwu7dcSkXfxAhNGRd9zhgav+wjILac8t66aTwcxW3wYPWqh7FhC2kccl5
   XVPg7r8LKd+mVRVpoPdshgfaxvTLMT55QzbIR/Vf7B780gprIQD/QrG81
   Bn2DCWaDvNU5qMMqbxMQz4f7v2DZPMaY7bKvsjTtVQWapRwQeNzE5LNvn
   A==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; 
   d="scan'208";a="279198469"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:37 +0800
IronPort-SDR: GgCkjKQ4iqVvVxjYx5RuhbEcge46hNARB3+SjKedpBGGjlxs9Cq+5VPWCpc2OM7sIktONEtJxy
 UTVW8GdAeM/us/9/TE9Zw2XHUgaJpmxL3IGW/ZKZUb0avXb/KX4/kOEQOdtIYDP2OqP2D5QabK
 BV2aPbnztX4pmbLE4AAUE572bXANpv1UT0rh9FJk6ajYLKn8ZZbBZIxWqbOogvtGPTsvJ09vML
 79SnAxCWYDkio/ucKlJagq0iSXEKKOjUJj2aKRQRHqEV4AxzSw6gJoFTGqgyXi0AFaAym9Ln6Q
 LatYEJ/vlYlM91ZzAtaVcBGI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:16:46 -0700
IronPort-SDR: LjlOnqwO6a/04wGjvbug293m/8qn7cznMgBruMkmo6Tel5ZJMkE6+M7OvZdwEvPubcxMheZERt
 lQ+sNikSqbrehg8ASur9Vjq9mL3Z4lqGj5A946yoMS6Ts92f/InosBlv1k2y7BMcnZXeI9zPvx
 mJQEjGWo0n4PPJ7AA4mRZXBBF3gLp53/vEUqb9aWh7AAOyzSZkDvpyEMe1gzV0DokMofyshPSa
 GwceP5V147VgMQfr8U+sGdKkY+aTpBTNx89lHFjrE172mP1ushHKqjMVO+Y4cL8vURhvNaPxhK
 Jzc=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:38 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, devicetree@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [RFC 4/5] dma-direct: Allocate dma pages directly if global pool allocation fails
Date:   Fri, 23 Jul 2021 14:40:30 -0700
Message-Id: <20210723214031.3251801-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
References: <20210723214031.3251801-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA_GLOBAL_POOL config may be enabled for platforms where global pool is
not supported because a generic defconfig is expected to boot on different
platforms. Specifically, some RISC-V platforms may use global pool for
non-coherent devices while some other platforms are completely coherent.
However, it is expected that single kernel image must boot on all the
platforms.

Continue the dma direct allocation if a allocation from global pool failed.
This indicates that the platform is relying on some other method (direct
remap) or just have coherent devices.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 kernel/dma/direct.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d1d0258ed6d0..984ea776f099 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -161,8 +161,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 
 	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
-	    !dev_is_dma_coherent(dev))
-		return dma_alloc_from_global_coherent(dev, size, dma_handle);
+	    !dev_is_dma_coherent(dev)) {
+		ret = dma_alloc_from_global_coherent(dev, size, dma_handle);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Remapping or decrypting memory may block. If either is required and
-- 
2.31.1

