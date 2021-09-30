Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A941D1FE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 05:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348002AbhI3Dww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 23:52:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33270 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347975AbhI3Dww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 23:52:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E22B20030E;
        Thu, 30 Sep 2021 05:51:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DA6F420028A;
        Thu, 30 Sep 2021 05:51:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6D943183AC94;
        Thu, 30 Sep 2021 11:51:07 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_rpmsg: Add rpmsg audio support for i.MX8ULP
Date:   Thu, 30 Sep 2021 11:26:53 +0800
Message-Id: <1632972413-22130-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8ULP the audio interface and codec are controlled
by Cortex-M domain, Cortex-M core provides audio service
over rpmsg.

The rpmsg audio function is almost same as i.MX7ULP
platform, so share same configuration.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_rpmsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_rpmsg.c b/sound/soc/fsl/fsl_rpmsg.c
index 07abad7fe372..8508bc7f239d 100644
--- a/sound/soc/fsl/fsl_rpmsg.c
+++ b/sound/soc/fsl/fsl_rpmsg.c
@@ -174,6 +174,7 @@ static const struct of_device_id fsl_rpmsg_ids[] = {
 	{ .compatible = "fsl,imx8mm-rpmsg-audio", .data = &imx8mm_data},
 	{ .compatible = "fsl,imx8mn-rpmsg-audio", .data = &imx8mn_data},
 	{ .compatible = "fsl,imx8mp-rpmsg-audio", .data = &imx8mp_data},
+	{ .compatible = "fsl,imx8ulp-rpmsg-audio", .data = &imx7ulp_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_rpmsg_ids);
-- 
2.17.1

