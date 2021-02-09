Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91AD314B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhBIJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:15:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46536 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhBIJMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:12:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 59EAB1F44D07
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Anson Huang <Anson.Huang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64: defconfig: Enable options to support panel display for Mediatek Chromebooks
Date:   Tue,  9 Feb 2021 10:11:12 +0100
Message-Id: <20210209091112.2075478-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209091112.2075478-1-enric.balletbo@collabora.com>
References: <20210209091112.2075478-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some Mediatek based Chromebooks supported in the kernel. Enable the
required config options to have the panel display working on both devices.
This was tested on the ACER Chromebook R13 (MT8173) and the Lenovo
Ideapad Duet (MT8183), but should also enable display support for similar
devices.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30db9b50efaa..7f4d70d24bb5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -676,6 +676,7 @@ CONFIG_DRM_MSM=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
+CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
@@ -683,6 +684,7 @@ CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_NWL_MIPI_DSI=m
 CONFIG_DRM_LONTIUM_LT9611=m
+CONFIG_DRM_PARADE_PS8640=m
 CONFIG_DRM_SII902X=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_THINE_THC63LVD1024=m
@@ -696,6 +698,8 @@ CONFIG_DRM_VC4=m
 CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_HISI_HIBMC=m
 CONFIG_DRM_HISI_KIRIN=m
+CONFIG_DRM_MEDIATEK=m
+CONFIG_DRM_MEDIATEK_HDMI=m
 CONFIG_DRM_MXSFB=m
 CONFIG_DRM_MESON=m
 CONFIG_DRM_PL111=m
@@ -949,6 +953,7 @@ CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
+CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=y
 CONFIG_QCOM_Q6V5_MSS=m
@@ -1019,6 +1024,8 @@ CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
 CONFIG_PWM_CROS_EC=m
 CONFIG_PWM_MESON=m
+CONFIG_PWM_MTK_DISP=m
+CONFIG_PWM_MEDIATEK=m
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=y
@@ -1063,6 +1070,7 @@ CONFIG_QCOM_L3_PMU=y
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_IMX_OCOTP_SCU=y
 CONFIG_QCOM_QFPROM=y
+CONFIG_MTK_EFUSE=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_UNIPHIER_EFUSE=y
-- 
2.30.0

