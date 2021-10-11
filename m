Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DDC42939C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbhJKPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238222AbhJKPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:42:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A23C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 08:40:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AFEF51F42259
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
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] arm64: defconfig: Enable SC7180 interconnect driver
Date:   Mon, 11 Oct 2021 17:40:03 +0200
Message-Id: <20211011154003.904355-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SC7180 device trees, almost all of the nodes are declaring
interconnect properties, including the QUP nodes: at least on
some machines, leaving this configuration option disabled, or
as a module, the kernel appears to hang while initializing the
QUP node containing the UART device.

To solve this issue, enable the interconnect driver for this
SoC as built-in.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fc40ae9e9bdb..171848ace3ac 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1172,6 +1172,7 @@ CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
+CONFIG_INTERCONNECT_QCOM_SC7180=y
 CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
-- 
2.33.0

