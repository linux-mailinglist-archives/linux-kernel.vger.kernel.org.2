Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ADF3A0AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhFIDj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbhFIDjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:39:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450A4C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 20:37:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x19so4685729pln.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 20:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6zXMN5ll7TqYL0aplhePUX2gZ+E/gbqQqmdmCua20NM=;
        b=UZyWz51Rvms6N+ygB3kUxZtGt095CvNlartmipzWktYJkX6mhk2UUYkFSIt3/zA/54
         rBtSPHOfB3zEgZpzeHHFpHUwQ6ymdsyMzMlXyDv9xJzwa4yTID9WTr1bj8wFcc9p2ujO
         MoCIEC28IQg1q/tLpq2rfmJTSBAhoka7P+hEEfLb0F00cegQaoxPsr2DWXE+YWYvs2R/
         xNFZME+bxCcb3psEc3YuUpt12MNhcFxHOE0r2PG03NTBb0OA3QkcI7wgR/Ig8PeEaSJo
         Q7u7nNhSeWXckY3D8p/emX5k0sNEaGinWv+7i2bC3rkK2rc38wMCWbHQPZxFqEvSj7BX
         xopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6zXMN5ll7TqYL0aplhePUX2gZ+E/gbqQqmdmCua20NM=;
        b=b/UvWDlhksWusZRMU1diYr/mtQrWt3UMmLmG9yZwcj2nyZidcaufsJ6vfDN5/1ydd+
         vUrNYsyQuDv++IxGoyXOP+rv3qVtP/nCvx/NHmTCJUHvxLpQeM4+hKYfT2hZmq1drzNB
         ePcpWH8N6eFhRSC0KLAV8vyCm7Sg3wN5QaqxYy5EUxCRtWfDaK0XL7DUOFO5Mal1ykKE
         z7aPSbqa+RNG+q/4w/KiD/7YBLg0E1IbXEqWl7zgZs8TWwbZbvkOiTV4T+UfmhLaoag8
         H/3yll1EL2tE6m8rqIanLfEIl7B41N1OABCkNFq00Kd+coIfh9urJx9Duy69bNx//bIr
         EGOQ==
X-Gm-Message-State: AOAM532XVL/gUWu6nFZnxv7HsAoJmxLPGTD1elOTw3x+ewO51u4RZ5fm
        vOjzzxGsgSf9YIt3zbfcI1CS5g==
X-Google-Smtp-Source: ABdhPJxBIQALUt+JU3tbbDF+75RfxEJQGypdU7Til5HLLfgC9LGuKID8h9Yzu36B9UQoUZd+dNbHFw==
X-Received: by 2002:a17:902:9042:b029:10f:c864:6090 with SMTP id w2-20020a1709029042b029010fc8646090mr3393800plz.39.1623209836798;
        Tue, 08 Jun 2021 20:37:16 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.135])
        by smtp.gmail.com with ESMTPSA id t24sm3473904pji.56.2021.06.08.20.37.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 20:37:16 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 3/3] PCI: Set dma-can-stall for HiSilicon chips
Date:   Wed,  9 Jun 2021 11:36:41 +0800
Message-Id: <1623209801-1709-4-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
References: <1623209801-1709-1-git-send-email-zhangfei.gao@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSilicon KunPeng920 and KunPeng930 have devices appear as PCI but are
actually on the AMBA bus. These fake PCI devices can support SVA via
SMMU stall feature, by setting dma-can-stall for ACPI platforms.

Property dma-can-stall depends on patchset
https://lore.kernel.org/linux-iommu/162314710744.3707892.6632600736379822229.b4-ty@kernel.org/

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 9331113..c1643ce 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1822,10 +1822,23 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI
 
 static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
 {
+	struct property_entry properties[] = {
+		PROPERTY_ENTRY_BOOL("dma-can-stall"),
+		{},
+	};
+
 	if (pdev->revision != 0x21 && pdev->revision != 0x30)
 		return;
 
 	pdev->pasid_no_tlp = 1;
+
+	/*
+	 * Set the dma-can-stall property on ACPI platforms. Device tree
+	 * can set it directly.
+	 */
+	if (!pdev->dev.of_node &&
+	    device_add_properties(&pdev->dev, properties))
+		pci_warn(pdev, "could not add stall property");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
-- 
2.7.4

