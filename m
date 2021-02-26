Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07A73263C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBZOGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:06:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:54870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhBZOEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:04:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24D19AF4F;
        Fri, 26 Feb 2021 14:03:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 05/13] pci: Introduce pci_mmio_configure()
Date:   Fri, 26 Feb 2021 15:02:57 +0100
Message-Id: <20210226140305.26356-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function will traverse the pci device's bus hierarchy and set
the relevant MMIO access flags.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/pci/pci-driver.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ec44a79e951a..554d91e7ec52 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1596,6 +1596,31 @@ static int pci_dma_configure(struct device *dev)
 	return ret;
 }
 
+/**
+ * pci_mmio_configure - Setup MMIO configuration
+ * @dev: ptr to dev structure
+ *
+ * Function to update PCI devices's MMIO configuration using the same
+ * info from the OF node of host bridge's parent (if any).
+ */
+static int pci_mmio_configure(struct device *dev)
+{
+	struct device *bridge;
+	int ret = 0;
+
+	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
+
+	dev_info(dev, "MMIO CONFIGURATION\n");
+	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
+	    bridge->parent->of_node) {
+		dev_info(dev, "MMIO CONFIGURATION, %pOF\n", bridge->parent->of_node);
+		ret = of_mmio_configure(dev, bridge->parent->of_node);
+	}
+
+	pci_put_host_bridge_device(bridge);
+	return ret;
+}
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
@@ -1609,6 +1634,7 @@ struct bus_type pci_bus_type = {
 	.pm		= PCI_PM_OPS_PTR,
 	.num_vf		= pci_bus_num_vf,
 	.dma_configure	= pci_dma_configure,
+	.mmio_configure = pci_mmio_configure,
 };
 EXPORT_SYMBOL(pci_bus_type);
 
-- 
2.30.1

