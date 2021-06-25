Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075E33B42F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFYMPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:15:46 -0400
Received: from m12-16.163.com ([220.181.12.16]:46281 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhFYMPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nnXPQ
        EEagZ9bRbPniD+fpcr7i2CjXp63TKYIyfs2KEo=; b=jG50EBM+9w+lRebnqzM5C
        fTADl8SbOU4X3hotTjBZS7u0ETG9xRUY3hLB1wfclfiFq3GHM+c5eZ09C6MrTC7S
        iSuo6i08ugon6QZF49BRpT1eR8FuiygWyc4sTustumaNyXnh60ncK++mHFosAxl+
        iY437RHG24QHYyHCqHH6LM=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowADHFTEoyNVgsUmszA--.56053S2;
        Fri, 25 Jun 2021 20:12:25 +0800 (CST)
From:   13145886936@163.com
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: fsl_spdif: remove unnecessary print function dev_err()
Date:   Fri, 25 Jun 2021 05:12:22 -0700
Message-Id: <20210625121222.434746-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADHFTEoyNVgsUmszA--.56053S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUCF45ur1kKr4UGF13CFg_yoWfXrc_Kw
        1kC39Yq3yxJryIvas8Aw4avr17Ww4DGF4UXF4DKF1Sq345Jrs5Z3yUJr4kuFs5Zr48K34r
        W3yY9rZ3Ar1SyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5JMa5UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiGgm8g1aD+PLeIAAAsN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/soc/fsl/fsl_spdif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index c631de325a6e..02b750fc32d8 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1302,10 +1302,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 	for (i = 0; i < spdif_priv->soc->interrupts; i++) {
 		irq = platform_get_irq(pdev, i);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+		if (irq < 0)
 			return irq;
-		}
 
 		ret = devm_request_irq(&pdev->dev, irq, spdif_isr, 0,
 				       dev_name(&pdev->dev), spdif_priv);
-- 
2.25.1


