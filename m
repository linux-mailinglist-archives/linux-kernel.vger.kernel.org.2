Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34794402FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2TRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2TRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:17:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6982C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:15:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x5so969585pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYyJRgic56kuU+9zRd7dChHV4NJ2SP79fJa3nRF/dI8=;
        b=DA/CLldpd7M5JojD7qSQsAYcnylSrCiWWHivOEAFG03crdUX5WW348S4wgU8DwJcc2
         U7juNKsdqr4ojrLqsh7tn7UAuCkY2NDR+NxFE81+2kAUP2YxewVv/+SfTgKulmHtEPqe
         WnSQzJ2ZvN5rcv73paKLZm7dCUf01xpRyk/oG9B7fUiRxwKa44yC/uPCQws7iLkKAaT4
         51PCqB1TyEy4DUytK3U+Def18dH/RPG5J05SciE574kbBnyK8BiyGpQzTsHeRkzL4Dup
         mXskUBN0JE3ug7M6SHBJJ2BEDeRQJAXHiLS36pUuiMw/BeNwVrmAKs1EyvjSCr9gmZCk
         xutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYyJRgic56kuU+9zRd7dChHV4NJ2SP79fJa3nRF/dI8=;
        b=sggc0c6k/tGAbtpb1cuNF8wDlH3ULT+5Hlf8rX8BpSYEwKW66U8/rLsjspe6ZnHo/a
         2V/TJfcSyGyfEo7geeALyAzBddt3rZkSFYoOu6cacyh+rQs2+qVGlwdnfboddh2AiJGO
         8HEYQRmih3/+F3XEqH/FtFRfw5mnQJI+bCAmISlvOYLjnQs5xfE0dm2ZLyIYiRlzPmFb
         MPFyOFNX6RozQqv1dTsXWcjEnTVHoyAda5msNcuGuCinT7aKQdCrh8G/q9jmBHSjWUt0
         dC9JonlQ7zI8gfMR/mBHNN+RmjxhHnRzXPKDlMQIkvOfv4oqSkHfzAhaMz/9zlk8VhgF
         vgbw==
X-Gm-Message-State: AOAM5339D0HYjJii5vBNLq03W1fjsSh6rb4o2+3t3eTtj3fD3WUC0IRP
        0KTyKLKPDhdsG0zD1GmY4IA=
X-Google-Smtp-Source: ABdhPJz+vQhJXi/iY/iclwzbywKDsTsoILmgT7UwtKaazW/na3k5O8Mnn88unPk+QrVlsQi1KMW4JA==
X-Received: by 2002:a63:ed13:: with SMTP id d19mr9577493pgi.430.1635534909303;
        Fri, 29 Oct 2021 12:15:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id lb5sm7103121pjb.11.2021.10.29.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:15:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford <aford173@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nishanth Menon <nm@ti.com>, Fabio Estevam <festevam@gmail.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: defconfig: Enable additional Broadcom STB drivers
Date:   Fri, 29 Oct 2021 12:15:03 -0700
Message-Id: <20211029191505.22593-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the following drivers as modular:

- NAND controller with CONFIG_MTD_NAND_BRCMNAND
- AHCI/SATA controller driver with CONFIG_AHCI_BRCM
- Starfighter 2 Ethernet switch driver with CONFIG_NET_DSA_BCM_SF2
- USB drivers (OHCI, EHCI, XHCI) with CONFIG_USB_BRCMSTB
- Watchdog with CONFIG_BCM7038_WDT
- PWM with CONFIG_PWM_BRCMSTB
- SYSTEMPORT Ethernet controller with CONFIG_SYSTEMPORT

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 156d96afbbfc..76d6bc37d74d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -262,6 +262,7 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_DATAFLASH=y
 CONFIG_MTD_SST25L=y
 CONFIG_MTD_RAW_NAND=y
+CONFIG_MTD_NAND_BRCMNAND=m
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_NAND_MARVELL=y
 CONFIG_MTD_NAND_FSL_IFC=y
@@ -293,6 +294,7 @@ CONFIG_SCSI_UFS_EXYNOS=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_BRCM=m
 CONFIG_AHCI_CEVA=y
 CONFIG_AHCI_MVEBU=y
 CONFIG_AHCI_XGENE=y
@@ -312,11 +314,13 @@ CONFIG_MACVTAP=m
 CONFIG_TUN=y
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=y
+CONFIG_NET_DSA_BCM_SF2=m
 CONFIG_NET_DSA_MSCC_FELIX=m
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m
 CONFIG_BCMGENET=m
+CONFIG_SYSTEMPORT=m
 CONFIG_BNX2X=m
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
@@ -367,6 +371,7 @@ CONFIG_AT803X_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_VITESSE_PHY=y
+CONFIG_USB_BRCMSTB=m
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
@@ -587,6 +592,7 @@ CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_ARM_SBSA_WATCHDOG=y
 CONFIG_ARM_SMC_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
+CONFIG_BCM7038_WDT=m
 CONFIG_DW_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=m
 CONFIG_IMX2_WDT=y
@@ -1085,6 +1091,7 @@ CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_MPL3115=m
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
+CONFIG_PWM_BRCMSTB=m
 CONFIG_PWM_CROS_EC=m
 CONFIG_PWM_IMX27=m
 CONFIG_PWM_MESON=m
-- 
2.25.1

