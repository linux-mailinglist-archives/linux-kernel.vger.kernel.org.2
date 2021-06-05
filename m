Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15BF39CA2E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFERVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 13:21:55 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:38529 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFERVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:21:54 -0400
Received: by mail-ej1-f51.google.com with SMTP id og14so14102628ejc.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G68YSORxe8rZrlz+rz117NbYUn0YGxl6wX6qgQenpUw=;
        b=hdD/YdrotRvnc1FN/L/7lBNYZ2RqeztUrS3XH58c4O94CyDXf9su2MZauf63DjojhQ
         p3i0raKHvSiZPJ9tnoFlnQzZ/Efai2sW3g+Wxl9ZH7v4qouQdOoBkUdtF730EFSi42ZN
         PRFtHqeCMhH+Jj+A1TMjGlN4wtAFjo8b3TkvBXnB1M0cW+ml7fhHYIROwGDKrxfe1wus
         z1UIhSwMCgiszGGKh6kwnBEJPN0YJn8dCJ9di+KJSBlDofKk5yMlZkGqol51qTQNYzUb
         0QLkds4VrCtyR3B2xvDyrKjD18e/+r+C2zhMHw4rZBQ7GDeEO2bqVENMneKeN7ULWi59
         wQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G68YSORxe8rZrlz+rz117NbYUn0YGxl6wX6qgQenpUw=;
        b=UGonMV61PMXWV6Gj0SBUKhfAe9RQewp/o8KivVnJGHjbWnEuTI2iBi/v75jLXU5o1+
         ouwblsjCnkXykl4nb92/VwlyVOCZkATAEu5JfB71pkp/Vgsx7K9Aklkjk9aFUtipADCz
         CVDSdqCANrXExdNlXHH1kf/Joq7rF8LkkuMGIXRTK1ckC9joNGJLfhpgl4ZC7Uxe5s4O
         uS4BnEASWNcTvtBqTVRFPPkirOkGK05cYvJcq4G/6FIe1at15DQR98jFe1hb75j6ny14
         TN96wWj7XeoZC2vQ+qVYbHuT1LoNgxXm2L1GFggMTYbB0u85RxBkK77cQvzlZzCLy4eR
         WrEw==
X-Gm-Message-State: AOAM530NtnyKv1+tBGy2H0ggMU/mbjs6CD7up2qbP9X1PGDqT+1gglqV
        Yfglqsx4uISmUO2U3DLvCDE=
X-Google-Smtp-Source: ABdhPJw36PZ7c9+6qoRGtbFfIVf0She+h0Hf2UQlr/dvG+tp1UHI5OgGEc5rB4Rv9EesqsfJGtpwYg==
X-Received: by 2002:a17:906:b24a:: with SMTP id ce10mr10060406ejb.83.1622913545503;
        Sat, 05 Jun 2021 10:19:05 -0700 (PDT)
Received: from snuff.lan (178-164-181-11.pool.digikabel.hu. [178.164.181.11])
        by smtp.gmail.com with ESMTPSA id r21sm5207360edy.78.2021.06.05.10.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 10:19:05 -0700 (PDT)
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ray Jui <ray.jui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: iproc: restrict multi-MSI to single core CPUs
Date:   Sat,  5 Jun 2021 19:17:36 +0200
Message-Id: <20210605171736.15755-1-sbodomerle@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
introduced multi-MSI support with a broken allocation mechanism (it failed to
reserve the proper number of bits from the inner domain).  Natural alignment of
the base vector number was also not guaranteed.

The interrupt affinity scheme used by this driver is incompatible with
multi-MSI as implies moving the doorbell address to that of another MSI group.
This isn't possible for Multi-MSI, as all the MSIs must have the same doorbell
address. As such it is restricted to systems with single CPU core.

Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
Reported-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
---
 drivers/pci/controller/pcie-iproc-msi.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git drivers/pci/controller/pcie-iproc-msi.c drivers/pci/controller/pcie-iproc-msi.c
index eede4e8f3f75..2e42c460b626 100644
--- drivers/pci/controller/pcie-iproc-msi.c
+++ drivers/pci/controller/pcie-iproc-msi.c
@@ -171,7 +171,7 @@ static struct irq_chip iproc_msi_irq_chip = {
 
 static struct msi_domain_info iproc_msi_domain_info = {
 	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+		MSI_FLAG_PCI_MSIX,
 	.chip = &iproc_msi_irq_chip,
 };
 
@@ -252,18 +252,15 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
 
 	mutex_lock(&msi->bitmap_lock);
 
-	/* Allocate 'nr_cpus' number of MSI vectors each time */
-	hwirq = bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi_vecs, 0,
-					   msi->nr_cpus, 0);
-	if (hwirq < msi->nr_msi_vecs) {
-		bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
-	} else {
-		mutex_unlock(&msi->bitmap_lock);
-		return -ENOSPC;
-	}
+	/* Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI vectors each time */
+	hwirq = bitmap_find_free_region(msi->bitmap, msi->nr_msi_vecs,
+					order_base_2(msi->nr_cpus * nr_irqs));
 
 	mutex_unlock(&msi->bitmap_lock);
 
+	if (hwirq < 0)
+		return -ENOSPC;
+
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i,
 				    &iproc_msi_bottom_irq_chip,
@@ -284,7 +281,8 @@ static void iproc_msi_irq_domain_free(struct irq_domain *domain,
 	mutex_lock(&msi->bitmap_lock);
 
 	hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq);
-	bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
+	bitmap_release_region(msi->bitmap, hwirq,
+			      order_base_2(msi->nr_cpus * nr_irqs));
 
 	mutex_unlock(&msi->bitmap_lock);
 
@@ -539,6 +537,9 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
 	mutex_init(&msi->bitmap_lock);
 	msi->nr_cpus = num_possible_cpus();
 
+	if (msi->nr_cpus == 1)
+		iproc_msi_domain_info.flags |=  MSI_FLAG_MULTI_PCI_MSI;
+
 	msi->nr_irqs = of_irq_count(node);
 	if (!msi->nr_irqs) {
 		dev_err(pcie->dev, "found no MSI GIC interrupt\n");
-- 
2.31.0

