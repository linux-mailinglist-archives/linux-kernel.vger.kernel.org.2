Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CEF3A2303
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 06:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFJEEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 00:04:45 -0400
Received: from m12-11.163.com ([220.181.12.11]:59854 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhFJEES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 00:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5+CyZ
        obPKR0nHlvAJFBUdKCJc3XZdSIYzi6QIkkecus=; b=UiwYBJ+2v9yeqwmhb+jXQ
        lxD/hPTkJYIsXPnyKZNowU/abEUi533IQ2z8lHlu2v8uBaKWEHqznkoYUpbwLkbF
        KPDXsmKRXCfR5MV69V6b//hMoQrAxprWYOzyQOs+ZhnHr7dnrantnco5iht9XSam
        UjipjAIv5AN9Yvx2NeVLzU=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowAB3YYl3jsFgVPzJhA--.907S2;
        Thu, 10 Jun 2021 12:00:57 +0800 (CST)
From:   =?UTF-8?q?=C2=A0Zhongjun=20Tan?= <hbut_tan@163.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tan Zhongjun <tanzhongjun@yulong.com>
Subject: [PATCH] ASoC:fsl_spdif:Remove superfluous error message around platform_get_irq()
Date:   Thu, 10 Jun 2021 12:00:37 +0800
Message-Id: <20210610040037.1064-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAB3YYl3jsFgVPzJhA--.907S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrykKFy7tryDZw1fKF4kJFb_yoWfCrb_G3
        4kCws5uFWxXrWjqF98Zw42yw1xXrsrGr4UXF42qF12v345Jrs5Wa18Jrn5uFsYvw48K34r
        W3WrWrWSyrn3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5e89tUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/xtbBqBitxl75dK+TcgAAsG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Zhongjun <tanzhongjun@yulong.com>

The platform_get_irq() prints error message telling that interrupt is
missing, hence there is no need to duplicated that message.

Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>
---
 sound/soc/fsl/fsl_spdif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 2a76714eb8e6..29cefd459241 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1368,10 +1368,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
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
2.17.1

