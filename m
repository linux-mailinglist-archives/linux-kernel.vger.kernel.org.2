Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802F84571A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbhKSPhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:37:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45198 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhKSPhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:37:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id A9EA01F47557
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637336044; bh=+WJq9p/OLtoII51RYDtOsRr+UMSRm2h49gRsaYg7JsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pb5qrBGKnYlPTaj8/1WNQLtWmVOGSRe0E8uRF/0L9bSDi86RKE62N8nlezDZ6KjZm
         8QGaChhOUs/3ViCWVCLMAuMLLd5VmxBQN3eeyKTKn3auz/MFrN7n2jTPCZLakLwYiQ
         IpFAhxk85OJlwcWKrgczYcAxo9+OFpN6qbJZ/ukT2sUHq5EpnunraBlPW+kifS3IxF
         pdXLFIvYDrbit6+9hEGbe4mFbyrMAWoU+iu3altB0Zg/5c9qs8z7sVeM7Jv/t1H8+5
         EWf633L0leIPvqFHsUetfQFCkLZaWafm1Lvje2uBDQMeCH0ent6607df+GR1IUmX7C
         K3jkd4ugUFYng==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bkylerussell@gmail.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com
Subject: [RFC patch 1/5] ASoC: tlv320aic31xx: Fix typo in BCLK clock name
Date:   Fri, 19 Nov 2021 12:32:44 -0300
Message-Id: <20211119153248.419802-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 sound/soc/codecs/tlv320aic31xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 2513922a0292..80d062578fb5 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -118,7 +118,7 @@ struct aic31xx_pdata {
 #define AIC31XX_PLL_CLKIN_MASK		GENMASK(3, 2)
 #define AIC31XX_PLL_CLKIN_SHIFT		(2)
 #define AIC31XX_PLL_CLKIN_MCLK		0x00
-#define AIC31XX_PLL_CLKIN_BCKL		0x01
+#define AIC31XX_PLL_CLKIN_BCLK		0x01
 #define AIC31XX_PLL_CLKIN_GPIO1		0x02
 #define AIC31XX_PLL_CLKIN_DIN		0x03
 #define AIC31XX_CODEC_CLKIN_MASK	GENMASK(1, 0)
-- 
2.30.2

