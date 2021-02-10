Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1EA315CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhBJCBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:01:36 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:57300 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhBJAk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1612917658; x=1644453658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=nankUMrNk1jmGMTceQpek9gK36swyK5+qE/O39IiF20=;
  b=mBlp92p4UWqZlCPuVz9aROaea/vf2LAXfJ5VqGN5uIpr2nU4afMZRrb4
   yshlGJNTL+5H1ga9vryKL0yJW9Vto+b9nn8Ig84BqI9rKyHcLKW94QgYA
   LT+8w2hHIc+0VxLJRdjlYOPpzN2oJ37QRp6q2NaED8PoOWZKtsQge/h8I
   A=;
X-IronPort-AV: E=Sophos;i="5.81,166,1610409600"; 
   d="scan'208";a="81114973"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Feb 2021 00:40:06 +0000
Received: from EX13D02EUC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 86061A1DA9;
        Wed, 10 Feb 2021 00:40:04 +0000 (UTC)
Received: from u2196cf9297dc59.ant.amazon.com (10.43.161.87) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Feb 2021 00:39:59 +0000
From:   Filippo Sironi <sironi@amazon.de>
To:     <serebrin@amazon.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Filippo Sironi <sironi@amazon.de>
Subject: [PATCH v2] nvme: Add 48-bit DMA address quirk for Amazon NVMe controllers
Date:   Wed, 10 Feb 2021 01:39:42 +0100
Message-ID: <20210210003942.25700-1-sironi@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203094338.19473-1-sironi@amazon.de>
References: <20210203094338.19473-1-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.87]
X-ClientProxiedBy: EX13D43UWA001.ant.amazon.com (10.43.160.44) To
 EX13D02EUC001.ant.amazon.com (10.43.164.92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amazon NVMe controllers do not support 64-bit DMA addresses; they are
limited to 48-bit DMA addresses.  Let's add a quirk to ensure that we
make use of 48-bit DMA addresses to avoid misbehavior.

This affects all Amazon NVMe controllers that expose EBS volumes
(0x0061, 0x0065, 0x8061) and local instance storage (0xcd00, 0xcd01,
0xcd02).

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 88a6b97247f5..dae747b4ac35 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -144,6 +144,11 @@ enum nvme_quirks {
 	 * NVMe 1.3 compliance.
 	 */
 	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
+
+	/*
+	 * The controller supports up to 48-bit DMA address.
+	 */
+	NVME_QUIRK_DMA_ADDRESS_BITS_48		= (1 << 16),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bad4d4dcdf0..e7001f5ed6e4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2362,13 +2362,16 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int dma_address_bits = 64;
 
 	if (pci_enable_device_mem(pdev))
 		return result;
 
 	pci_set_master(pdev);
 
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)))
+	if (dev->ctrl.quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
+		dma_address_bits = 48;
+	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(dma_address_bits)))
 		goto disable;
 
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
@@ -3263,6 +3266,18 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x8061),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd00),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd01),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd02),
+		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



