Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD63F8237
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbhHZGFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:05:10 -0400
Received: from out0.migadu.com ([94.23.1.103]:28175 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233351AbhHZGFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:05:09 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629957861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CWubK53gOwcaOqvTOzGSGWnzZP5IN4poCC+nkyqLR2k=;
        b=Yqfa1Nui+BoYsgi0zZQJuX46Rfze4yj/MUWmEJ+h7D4YtoWzUvvYTiv/wiWZOJDujXavJR
        z08JebmxPIotHPS1T4htxMM84vUKmCEytTkQQMHzu7niVPYTOUKA0aO8kKlLMvoMTXFaFn
        Rwqr+1l1LMNlHQwIGt8QWmc1i8R09sY=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     catalin.marinas@arm.com, will@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH linux-next v2] arm64: PCI: Introduce pcibios_free_irq() helper function
Date:   Thu, 26 Aug 2021 14:04:06 +0800
Message-Id: <20210826060406.12571-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcibios_alloc_irq() will be called in pci_device_probe(), but there
hasn't pcibios_free_irq() in arm64 architecture correspond it.
pcibios_free_irq() is an empty weak function in drivers/pci/pci-driver.c.
So add pcibios_free_irq() for correspond it. This will be called
in pci_device_remove().

====================
v2: remove the change in pcibios_alloc_irq(), and modify the commit log.
====================

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 arch/arm64/kernel/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 2276689b5411..6ffd92126f65 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -29,6 +29,13 @@ int pcibios_alloc_irq(struct pci_dev *dev)
 
 	return 0;
 }
+
+void pcibios_free_irq(struct pci_dev *dev)
+{
+	if (!acpi_disabled)
+		acpi_pci_irq_disable(dev);
+}
+
 #endif
 
 /*
-- 
2.32.0

