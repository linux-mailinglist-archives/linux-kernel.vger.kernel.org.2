Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823D83D4257
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhGWVAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:00:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17043 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhGWVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627076436; x=1658612436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TtAadJ6hGLCmc033TEnWfjUBgRsF/DZxBUrEEIez1Fo=;
  b=f+nu0/CdxWwarErcZi4FgffE9SA7p80eptXiZ/Z1mdzqrCrwKsmi7HMS
   8Yw8Xrwz/h/bHq82XXP9hUxjjl0JLozLp/WcXMGcL5eDtGCUyoyP4uTAq
   2pMzWvVKt00TQ7UF6AlcvUHfkUeMvjzZKavIUXr5MVCH9RpNG2gsWCsaY
   /tCDYDc27fjwCuPPglupMUAoNu0J4HAmd2GXcbQNMPM7vJfOqu2ftix+B
   wgFgadYzCD8r1EFR1tqZHf0AK5OkNVc/vsuDv8VE+9Ck8wf6WH4SgLWjU
   L8zGks/8yHE2bqk5SlyhYD7TQByNmQlsoftAgh118OA6G/0YMUxWMi04b
   A==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; 
   d="scan'208";a="279198458"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:36 +0800
IronPort-SDR: ddhhEcIvoGPO4VaUU0cTZQXUYD8FK7J0wFPo9vUFjf02QTtidh63bJO29exNZhHApz6VPe44Fo
 tUM+Hb4cj7KuCLNsgloWJsrWJ7NKoAMhGj48OojznNTbz/vPkhB2ni6NjTFg5JvoLfgbYlz3A4
 Vxd2zZKX/xGhstN+LOQUaj1V8LQdrEeYJToTmrH1MGiuXYvN8eckDuMg6FO4kI2d96JMy/kkbp
 OjdFz+OkmCEdKq+iIH/PTAzby5hatZ4Xkj31us1c3u7XVoG83aTd+NhJTyzdKmkxsgl36EPSLm
 m2FO6+5N9uJ63vm6VcULDsgN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 14:16:45 -0700
IronPort-SDR: iht1k14TXaRgYuHcExQMxXDvBJ3lM+d2qFu0HNLMP/m1Lxt3+sb+N39um9cWnSgGv+xK+oULw8
 GD+comDzjiA03Yi/yzbvF1tLI9LK7/uFKDc61+UxJ+unNE4NlgItR+mWHeop/k1FW+LDY1iGkv
 bIRs/GghVxg/KlDKAwSOAE56h8UurPmyEwvBnYOlWDOK8rQ6pIUqNcTdfmUWYQvtbTUB8AstNj
 ybmzgG1fG/v3JWXcN82OQ0gkWAp2DRz2Ef6vAOkDxAxJMNcx1b1yxxQEbRI/2TozKavkbY18h1
 UWw=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:36 -0700
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
Subject: [RFC 2/5] of: Move of_dma_get_range to of_address.h
Date:   Fri, 23 Jul 2021 14:40:28 -0700
Message-Id: <20210723214031.3251801-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
References: <20210723214031.3251801-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, of_dma_get_range is kept in of_private.h as it is used by only
OF support code.

Move it to of_address.h so that it can be used by the code outside OF
support code.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/of/of_private.h    | 10 ----------
 include/linux/of_address.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 631489f7f8c0..f65f801e3aae 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -160,16 +160,6 @@ extern int of_bus_n_addr_cells(struct device_node *np);
 extern int of_bus_n_size_cells(struct device_node *np);
 
 struct bus_dma_region;
-#if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
-int of_dma_get_range(struct device_node *np,
-		const struct bus_dma_region **map);
-#else
-static inline int of_dma_get_range(struct device_node *np,
-		const struct bus_dma_region **map)
-{
-	return -ENODEV;
-}
-#endif
 
 void fdt_init_reserved_mem(void);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 45598dbec269..0e20f85850fc 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -154,4 +154,16 @@ static inline const __be32 *of_get_pci_address(struct device_node *dev, int bar_
 	return __of_get_address(dev, -1, bar_no, size, flags);
 }
 
+struct bus_dma_region;
+#if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
+int of_dma_get_range(struct device_node *np,
+		const struct bus_dma_region **map);
+#else
+static inline int of_dma_get_range(struct device_node *np,
+		const struct bus_dma_region **map)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif /* __OF_ADDRESS_H */
-- 
2.31.1

