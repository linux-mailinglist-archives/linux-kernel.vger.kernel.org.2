Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43D42BE38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhJMK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:59:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35392 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhJMK6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:58:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CCD9A1F44160
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
Subject: [PATCH 1/2] arm64: defconfig: Add SC7180 GPUCC and DISPCC as module
Date:   Wed, 13 Oct 2021 12:56:12 +0200
Message-Id: <20211013105613.250450-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013105613.250450-1-angelogioacchino.delregno@collabora.com>
References: <20211013105613.250450-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC_DISPCC_7180 and SC_GPUCC_7180 are not boot-critical clock
controller drivers, but these are required in order to get
DPU1/display support (so, to allow probing DRM_MSM) and Adreno
GPU support, which are modules as well.

This is being done as there are SC7180 device trees enabling
support for this hardware, but not being probed due to these
drivers not being built.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 171848ace3ac..bb97baa5f1d8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -992,7 +992,9 @@ CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
+CONFIG_SC_DISPCC_7180=m
 CONFIG_SC_GCC_7180=y
+CONFIG_SC_GPUCC_7180=m
 CONFIG_SDM_CAMCC_845=m
 CONFIG_SDM_GCC_845=y
 CONFIG_SDM_GPUCC_845=y
-- 
2.33.0

