Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1303263BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBZOFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:05:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:53628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhBZOEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:04:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3E23AD73;
        Fri, 26 Feb 2021 14:03:17 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 03/13] of: device: Introduce of_mmio_configure()
Date:   Fri, 26 Feb 2021 15:02:55 +0100
Message-Id: <20210226140305.26356-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function will traverse a device's bus hierarchy looking for MMIO
limited buses. If found it'll populate the relevant struct device
quirks.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/of/device.c       | 19 +++++++++++++++++++
 include/linux/of_device.h |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 6cb86de404f1..b80367a2764b 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -169,6 +169,25 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
 
+int of_mmio_configure(struct device *dev, struct device_node *np)
+{
+#if defined(CONFIG_ARCH_HAS_64BIT_MMIO_BROKEN)
+	struct device_node *node = of_node_get(np);
+
+	do {
+		if (of_property_read_bool(node, "64bit-mmio-broken")) {
+			dev->mmio_64bit_broken = true;
+			dev_dbg(dev, "device behind 64bit mmio broken bus\n");
+			break;
+		}
+	} while ((node = of_get_next_parent(node)));
+
+	of_node_put(node);
+#endif
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_mmio_configure);
+
 int of_device_register(struct platform_device *pdev)
 {
 	device_initialize(&pdev->dev);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 1d7992a02e36..c465edd509c7 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -56,6 +56,9 @@ static inline int of_dma_configure(struct device *dev,
 {
 	return of_dma_configure_id(dev, np, force_dma, NULL);
 }
+
+int of_mmio_configure(struct device *dev, struct device_node *np);
+
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -112,6 +115,11 @@ static inline int of_dma_configure(struct device *dev,
 {
 	return 0;
 }
+
+static inline int of_mmio_configure(struct device *dev, struct device_node *np);
+{
+	return 0;
+}
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
2.30.1

