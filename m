Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF7339CE5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 09:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhCMIYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 03:24:09 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:50798 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhCMIXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 03:23:47 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id BFC00400155;
        Sat, 13 Mar 2021 16:23:44 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] sound: soc: fsl: Remove unnecessary THIS_MODULE
Date:   Sat, 13 Mar 2021 16:23:40 +0800
Message-Id: <1615623820-16592-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSxgaSExPSUhJQkoYVkpNSk5NSUhDSU5IQklVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQg6Nxw*AT8LD1EdPQwyKCse
        LC0wFCFVSlVKTUpOTUlIQ0lOTENLVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSUhIQjcG
X-HM-Tid: 0a782aaf27a4d991kuwsbfc00400155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As THIS_MODULE has been set in module_platform_driver(), so remove it.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 sound/soc/fsl/imx-hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index dbbb761..cd0235a
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -223,7 +223,6 @@ MODULE_DEVICE_TABLE(of, imx_hdmi_dt_ids);
 static struct platform_driver imx_hdmi_driver = {
 	.driver = {
 		.name = "imx-hdmi",
-		.owner = THIS_MODULE,
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = imx_hdmi_dt_ids,
 	},
-- 
2.7.4

