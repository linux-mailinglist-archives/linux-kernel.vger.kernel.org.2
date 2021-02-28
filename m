Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CAB327245
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 13:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhB1Moh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 07:44:37 -0500
Received: from relay02.th.seeweb.it ([5.144.164.163]:33323 "EHLO
        relay02.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhB1Moe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 07:44:34 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id B46401F49E;
        Sun, 28 Feb 2021 13:43:34 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dsi: Uncomment core_mmss clock for MSM8996
Date:   Sun, 28 Feb 2021 13:43:26 +0100
Message-Id: <20210228124328.136397-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

The MSM8996 core_mmss clock was commented out due to some
strange issues that others were experiencing.

At least SONY Tone family is working perfectly fine with this clock
declared and gets it up and running without any error.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index b2ff68a15791..f3f1c03c7db9 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -106,12 +106,8 @@ static const struct msm_dsi_config msm8994_dsi_cfg = {
 	.num_dsi = 2,
 };
 
-/*
- * TODO: core_mmss_clk fails to enable for some reason, but things work fine
- * without it too. Figure out why it doesn't enable and uncomment below
- */
 static const char * const dsi_8996_bus_clk_names[] = {
-	"mdp_core", "iface", "bus", /* "core_mmss", */
+	"mdp_core", "iface", "bus", "core_mmss",
 };
 
 static const struct msm_dsi_config msm8996_dsi_cfg = {
-- 
2.30.1

