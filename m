Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2A386FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbhERCJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:09:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4724 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhERCJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:09:22 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkfSz5nxVzmhqb;
        Tue, 18 May 2021 10:04:35 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 10:08:04 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 10:08:03 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>
CC:     <john.wanghui@huawei.com>, <yangyingliang@huawei.com>,
        <dingtianhong@huawei.com>, <cuibixuan@huawei.com>,
        <wangxiongfeng2@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] genirq/msi: Fix unpaired calls in msi
Date:   Tue, 18 May 2021 11:31:17 +0800
Message-ID: <20210518033117.78104-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are unpaired calls in the msi:

msi_domain_alloc_irqs() {
        ...
        __irq_domain_alloc_irqs()
        ...
        irq_domain_activate_irq()
}

msi_domain_free_irqs() {
        ...
        irq_domain_free_irqs()
}

When msi_domain_alloc_irqs() and msi_domain_free_irqs() are called in
pairs, the irq_domain_deactivate_irq() is missing calls.

This problem occurs during PCI initialization.After pci_msi_setup_msi_irqs
is executed (invoke irq_domain_activate_irq to initialize the MSI irq),
error_cleanup_irqs() of pcie_port_device_register() is executed.
As follows:

pcie_port_device_register() {
	...

	error_cleanup_irqs:
		pci_free_irq_vectors(dev);
}

Invoking Procedure:
	pcie_port_device_register
	-> goto error_cleanup_irqs
	-> pci_free_irq_vectors(dev);
	    pci_disable_msi
	        free_msi_irqs
		    pci_msi_teardown_msi_irqs
		        msi_domain_free_irqs // no deactivate before free
			    irq_domain_free_irqs

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 kernel/irq/msi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c41965e348b5..8828d4863c5d 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -476,11 +476,6 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	return 0;
 
 cleanup:
-	for_each_msi_vector(desc, i, dev) {
-		irq_data = irq_domain_get_irq_data(domain, i);
-		if (irqd_is_activated(irq_data))
-			irq_domain_deactivate_irq(irq_data);
-	}
 	msi_domain_free_irqs(domain, dev);
 	return ret;
 }
@@ -506,6 +501,14 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
 	struct msi_desc *desc;
+	struct irq_data *irq_data;
+	int i;
+
+	for_each_msi_vector(desc, i, dev) {
+		irq_data = irq_domain_get_irq_data(domain, i);
+		if (irqd_is_activated(irq_data))
+			irq_domain_deactivate_irq(irq_data);
+	}
 
 	for_each_msi_entry(desc, dev) {
 		/*
-- 
2.17.1

