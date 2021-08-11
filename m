Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508703E8FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhHKLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:55:26 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:44179 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhHKLzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:55:25 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16113ba8532d-64212; Wed, 11 Aug 2021 19:54:47 +0800 (CST)
X-RM-TRANSID: 2ee16113ba8532d-64212
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66113ba81a7c-3dfcf;
        Wed, 11 Aug 2021 19:54:47 +0800 (CST)
X-RM-TRANSID: 2ee66113ba81a7c-3dfcf
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, olivier.moysan@foss.st.com,
        arnaud.pouliquen@foss.st.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: stm32: spdifrx: Delete unnecessary check in the probe function
Date:   Wed, 11 Aug 2021 19:55:23 +0800
Message-Id: <20210811115523.17232-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function stm32_spdifrx_parse_of() is only called by the function
stm32_spdifrx_probe(), and the probe function is only called with
an openfirmware platform device. Therefore there is no need to check
the device_node in probe function.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/stm/stm32_spdifrx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 48145f553..8fe822903 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -908,13 +908,9 @@ static const struct of_device_id stm32_spdifrx_ids[] = {
 static int stm32_spdifrx_parse_of(struct platform_device *pdev,
 				  struct stm32_spdifrx_data *spdifrx)
 {
-	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id;
 	struct resource *res;
 
-	if (!np)
-		return -ENODEV;
-
 	of_id = of_match_device(stm32_spdifrx_ids, &pdev->dev);
 	if (of_id)
 		spdifrx->regmap_conf =
-- 
2.20.1.windows.1



