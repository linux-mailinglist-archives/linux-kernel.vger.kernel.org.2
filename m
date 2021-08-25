Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA36B3F7033
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbhHYHRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:17:15 -0400
Received: from out1.migadu.com ([91.121.223.63]:50786 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238606AbhHYHRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:17:14 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629875787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qZDfge9JkGpMNd2PzfnbUn2iPJxkyxvkteeaxzl9liY=;
        b=wUBKVMzKbWsBvVeKNeV9rNn1HZJiRAbQwALHx0mYcGZqwg+PtP7vJYmHlD2xzN2VM/gNDS
        yBlJprBT82rSi2HZDkbpQPhvsloZslacMy+PrV71rTnDMj7dKDKp0AWH4g0JTF/b6OpD7d
        6t5wewA94U1B9wkiqqRMERR04+y+5Jg=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH linux-next] arm64: PCI: Introduce pcibios_free_irq() helper function
Date:   Wed, 25 Aug 2021 15:16:12 +0800
Message-Id: <20210825071612.21543-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce pcibios_free_irq() to free irq in pci_device_probe() and
pci_device_remove() that in drivers/pci/pci-driver.c.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 arch/arm64/kernel/pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1006ed2d7c60..40da5aff4548 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -25,10 +25,18 @@
 int pcibios_alloc_irq(struct pci_dev *dev)
 {
 	if (!acpi_disabled)
-		acpi_pci_irq_enable(dev);
+		return acpi_pci_irq_enable(dev);
 
 	return 0;
 }
+
+void pcibios_free_irq(struct pci_dev *dev)
+{
+	if (!acpi_disabled)
+		acpi_pci_irq_disable(dev);
+
+}
+
 #endif
 
 /*
-- 
2.32.0

