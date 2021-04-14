Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A2F35EFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbhDNIaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350064AbhDNI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:29:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E5DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:29:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so428071wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epXw3irDvsvZFL4o434NpborWULmmHYE5K7OMVRyRAI=;
        b=p7Sxm7w9vNyyhaZiiyz/88cew7fUg3K8H2EC02WrUDTOxJ+2hC/CbH8VY3rrYvX7eO
         uXMzbiDRMr6+nUahA7p0JZigYAC26pMFHDdVxyyTBvUtSCN17kVwhxyOtanZ2m1yrU0a
         PIzpBpDOKr+9R/QEzcW2792Htj+Sp/VfoWh6o0mux4Fa8voOp7Fv7ufJr7RHhlXRQmhP
         oaymv49jrNB2zFc/5CRVufR87V5BwOu1+7EZ1mEtQP/dNOzv+xaz6A5TPrLkgu2nffad
         Frd3gdc3Xk7xN5YU2hiw2L6CdAZFkZkbMw4G9LTDk8d3atgG7ZlqgojFSKM36b+gAg9q
         25XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epXw3irDvsvZFL4o434NpborWULmmHYE5K7OMVRyRAI=;
        b=VfK45o42K4AOGQBXzAQ3Zjnd9LpPB4/TMQtMteIFACbjY5I2PEg0Rs6OnNPZiDUyMM
         Z4cSzbUIsMHnom0Uzn5oPKb1lcua25J+sdTnJu+dSz8CgwXM7V8g/jeqqyRv6pMf0xmE
         l0vLDRqwGYM+MrA9PeXESlmLUhsFfKNVCMH8LfMWIvjNoZ+GcWvuWrIF2ghmCNfNqTDp
         pL5snxwFvfUZGXoFns30k/SIApDGW/VBre4ddBCeZc7BdiIBH/B4MaonQlYlbi9k82nc
         wV5bn+TQjfsupmbM6g3MnvOXcQOK2RAXtu6msaIMYnX3RlD9jVVKSHWfzSuqMKaDb2OQ
         OrNA==
X-Gm-Message-State: AOAM532MDAz7/4Kkd74gxgSYXY1P2gR8UdHv+zg62YFPQPKyDUHI/jNY
        slfYkvC3QUstPW+/aDuTIGXG6g==
X-Google-Smtp-Source: ABdhPJwM8rnaaPmIEmSVIcO5Ix/lhhztBwn1RzthnOJVzNgGDiuXonPn4QdXuKllPtda2dypc+NOZQ==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr1765553wml.113.1618388952091;
        Wed, 14 Apr 2021 01:29:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c12sm23850730wro.6.2021.04.14.01.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:29:11 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, hch@lst.de,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] x86/dma: Tear down DMA ops on driver unbind
Date:   Wed, 14 Apr 2021 10:26:34 +0200
Message-Id: <20210414082633.877461-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 08a27c1c3ecf ("iommu: Add support to change default domain
of an iommu group") a user can switch a device between IOMMU and direct
DMA through sysfs. This doesn't work for AMD IOMMU at the moment because
dev->dma_ops is not cleared when switching from a DMA to an identity
IOMMU domain. The DMA layer thus attempts to use the dma-iommu ops on an
identity domain, causing an oops:

  # echo 0000:00:05.0 > /sys/sys/bus/pci/drivers/e1000e/unbind
  # echo identity > /sys/bus/pci/devices/0000:00:05.0/iommu_group/type
  # echo 0000:00:05.0 > /sys/sys/bus/pci/drivers/e1000e/bind
   ...
  [  190.017587] BUG: kernel NULL pointer dereference, address: 0000000000000028
   ...
  [  190.027375] Call Trace:
  [  190.027561]  iommu_dma_alloc+0xd0/0x100
  [  190.027840]  e1000e_setup_tx_resources+0x56/0x90
  [  190.028173]  e1000e_open+0x75/0x5b0

Implement arch_teardown_dma_ops() on x86 to clear the device's dma_ops
pointer during driver unbind.

Fixes: 08a27c1c3ecf ("iommu: Add support to change default domain of an iommu group")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/x86/Kconfig          | 1 +
 arch/x86/kernel/pci-dma.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..2c90f8de3e20 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,7 @@ config X86
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select ARCH_HAS_TEARDOWN_DMA_OPS	if IOMMU_DMA
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index de234e7a8962..60a4ec22d849 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -154,3 +154,10 @@ static void via_no_dac(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_BRIDGE_PCI, 8, via_no_dac);
 #endif
+
+#ifdef CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS
+void arch_teardown_dma_ops(struct device *dev)
+{
+	set_dma_ops(dev, NULL);
+}
+#endif
-- 
2.31.1

