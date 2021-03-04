Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE03732CF49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbhCDJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:09:18 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46799 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237385AbhCDJIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:08:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UQMz88a_1614848882;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQMz88a_1614848882)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Mar 2021 17:08:03 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     timur@kernel.org
Cc:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2] ASoC: imx-hdmi: fix platform_no_drv_owner.cocci warnings
Date:   Thu,  4 Mar 2021 17:08:01 +0800
Message-Id: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./sound/soc/fsl/imx-hdmi.c:226:3-8: No need to set .owner here. The core
will do it.

Remove .owner field if calls are used which set it automatically

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

Change in v2:
-use imx-hdmi instead of hdmi-codec for Subject

 sound/soc/fsl/imx-hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index dbbb761..cd0235a 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -223,7 +223,6 @@ static int imx_hdmi_probe(struct platform_device *pdev)
 static struct platform_driver imx_hdmi_driver = {
 	.driver = {
 		.name = "imx-hdmi",
-		.owner = THIS_MODULE,
 		.pm = &snd_soc_pm_ops,
 		.of_match_table = imx_hdmi_dt_ids,
 	},
-- 
1.8.3.1

