Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570D33212FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBVJWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:22:47 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40132 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhBVJWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:22:45 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F5781A020C;
        Mon, 22 Feb 2021 10:21:58 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB1F51A0050;
        Mon, 22 Feb 2021 10:21:52 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2C98240291;
        Mon, 22 Feb 2021 10:21:46 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_xcvr: move reset assert into runtime_resume
Date:   Mon, 22 Feb 2021 17:09:50 +0800
Message-Id: <1613984990-5534-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Move reset assert into runtime_resume since we
cannot rely on reset assert state when the device
is put out from suspend.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index dd228b421e2c..4857e0df8681 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1243,10 +1243,6 @@ static __maybe_unused int fsl_xcvr_runtime_suspend(struct device *dev)
 	if (ret < 0)
 		dev_err(dev, "Failed to assert M0+ core: %d\n", ret);
 
-	ret = reset_control_assert(xcvr->reset);
-	if (ret < 0)
-		dev_err(dev, "Failed to assert M0+ reset: %d\n", ret);
-
 	regcache_cache_only(xcvr->regmap, true);
 
 	clk_disable_unprepare(xcvr->spba_clk);
@@ -1262,6 +1258,12 @@ static __maybe_unused int fsl_xcvr_runtime_resume(struct device *dev)
 	struct fsl_xcvr *xcvr = dev_get_drvdata(dev);
 	int ret;
 
+	ret = reset_control_assert(xcvr->reset);
+	if (ret < 0) {
+		dev_err(dev, "Failed to assert M0+ reset: %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(xcvr->ipg_clk);
 	if (ret) {
 		dev_err(dev, "failed to start IPG clock.\n");
-- 
2.27.0

