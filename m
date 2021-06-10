Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D703A2C01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhFJMy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:54:28 -0400
Received: from m12-13.163.com ([220.181.12.13]:38468 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhFJMy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=R7rRZ
        DJWfcFuQCiHnx+KSuleoUfxvvGlDesqMsLVoLQ=; b=mPtdElz8voi3VV6tjW0cr
        xSM9eN0YI4LYD3DsWayu4y6NVB/T24OaHkSLWU7xNRA7ZEAuKN4DY/7Na3PgCcu8
        efNMTLlRFmgcVPllGYQ5wsdSvuMAN8x3cVZI5CLZ2VUWnv+CJxC6JCl8MzKYIWNP
        Nxil4eobj7HL6OBThyy3yc=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowAB3ebW_CsJgoBppFg--.24300S2;
        Thu, 10 Jun 2021 20:51:12 +0800 (CST)
From:   =?UTF-8?q?=C2=A0Zhongjun=20Tan?= <hbut_tan@163.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, shengjiu.wang@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tan Zhongjun <tanzhongjun@yulong.com>
Subject: [PATCH] ASoC:fsl_easrc:Remove superfluous error message around platform_get_irq()
Date:   Thu, 10 Jun 2021 20:50:52 +0800
Message-Id: <20210610125052.1280-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAB3ebW_CsJgoBppFg--.24300S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1xCr1fKF45ur48AFWUJwb_yoWfJFX_J3
        4UC393XFWrAFWj9ay0va12vr47WFs7CF4jvF4qkFnFv345tw45uayDJrn7uF4F9w4I93yx
        Wa4rurWFyr15ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU50tC7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/xtbBqBetxl75dLHjvgAEsv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Zhongjun <tanzhongjun@yulong.com>

Clean up the check for irq.dev_err is superfluous as platform_get_irq()
already prints an error.Remove curly braces to confirm to styling
requirements.

Signed-off-by: Tan Zhongjun <tanzhongjun@yulong.com>
---
 sound/soc/fsl/fsl_easrc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index b1765c7d3bcd..25747433916e 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1901,10 +1901,8 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq for node %pOF\n", np);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_easrc_isr, 0,
 			       dev_name(dev), easrc);
-- 
2.17.1


