Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885234315B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhJRKSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhJRKQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:16:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8A6C061772
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:13:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3A1E71F42B3B
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        geert+renesas@glider.be, vkoul@kernel.org,
        jagan@amarulasolutions.com, agx@sigxcpu.org,
        biju.das.jz@bp.renesas.com, enric.balletbo@collabora.com,
        aford173@gmail.com, nm@ti.com,
        andrey.zhizhikin@leica-geosystems.com, saravanak@google.com,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] arm64: defconfig: Enable RTC_DRV_MT6397 as module
Date:   Mon, 18 Oct 2021 12:13:29 +0200
Message-Id: <20211018101329.360892-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable this driver to let RTC probe on various MediaTek SoCs, including
mt6358, mt6795 and mt8173: these all have a DT node to probe the RTC.

Also, having a RTC in place is necessary for certain KernelCI suspend
tests to run.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 86224aa3a74b..be132058a1ed 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -922,6 +922,7 @@ CONFIG_RTC_DRV_PM8XXX=m
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_SNVS=m
 CONFIG_RTC_DRV_IMX_SC=m
+CONFIG_RTC_DRV_MT6397=m
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
-- 
2.33.0

