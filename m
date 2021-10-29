Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF64F43F3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhJ2AO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 20:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2AOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 20:14:55 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE91C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:12:27 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k29so5247683qve.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zCdvHAMPb/U3XpOEmTJBvwKtKMr8OtCBU8SciZQYv0I=;
        b=Av48rDYAzVf/RSt+M91LSQcSgR2dMlUJhcAugutzpsobYfduotKLHEMV4fMB4NOqoQ
         igsM0xvRQUi9F+gcG9ys4/HsosHfBGwOl98gJV46c6r2eBGfHYJq3Qx30j0/GDPChDDH
         yPid3AaULXuqNR8PWnQcMUDcRbIfuMGGrKSWWsOAY2aaEdgfXJZ+N9F8NbyxJ+Y/k/iW
         jGZQwGDlIHk0a51qogNGras2lEkQgtyijMeaLvA2TtG0Nb5DHcopUknxgmhWmlAmfrRm
         b3xS5u569mFrUT3EEi7tQn2xj7dzlGqAv3g1sWoHVcBy2ENZArkKWaZUQpK4HpSHNeap
         KtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=zCdvHAMPb/U3XpOEmTJBvwKtKMr8OtCBU8SciZQYv0I=;
        b=dBU+dIe9RpIeRmsFcRsJffycFNqeFNXyf0Bmrkscsmxp8doIJ6NAxONdc8as/MKHLZ
         1S44ioIvLilHAqrsl8Cg6txFtX8vuxGIoifBAqKp4puYYYNKaEU58nF2RFebga3E5b2o
         1Gv9BlnGmcJyBCZsURIk0f2wDoRHBs0X8h6LYCCmeXShacqSNoFnDSaw5Ml1W8LogbVX
         6jm0703sMriaPRQgH5rPGG5X0VxNbHCeaHltey4Np5KIG7NOswgP8z7MxMlInwQAwvfj
         +Cp/YXEpuWK1RY2Gbas53Jh1kqKTqWO2ytRas/BDhTFxh4p9SkpK6w90NIJWvJsjfoYr
         JK/g==
X-Gm-Message-State: AOAM531H1aVBxs9p090NucZQR9nCBFp9UKH/5xb00fdiI8Z6tqqrc9YI
        kiy5+xHa+Z56r2RQLsPNSTw=
X-Google-Smtp-Source: ABdhPJy5ntN/HUll1913v6EiH0jp0EXjSai/uspe5ux/XvPebuhBFbYgC/ThsqZ+6FFFGA8m5zfjMw==
X-Received: by 2002:a05:6214:98d:: with SMTP id dt13mr7478426qvb.13.1635466346900;
        Thu, 28 Oct 2021 17:12:26 -0700 (PDT)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id f3sm514334qtf.55.2021.10.28.17.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 17:12:26 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        jiaxin.yu@mediatek.com, tzungbi@google.com, arnd@arndb.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fazilyildiran@gmail.com
Subject: [PATCH] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_RT1015P
Date:   Thu, 28 Oct 2021 20:12:25 -0400
Message-Id: <20211029001225.27218-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_MT8192_MT6359_RT1015_RT5682,
SND_SOC_MT8192_MT6359_RT1015_RT5682,
SND_SOC_MT8183_DA7219_MAX98357A, or
SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A is selected,
and GPIOLIB is not selected, Kbuild gives the following
warnings, respectively:

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_MT8192_MT6359_RT1015_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8192 [=y] && MTK_PMIC_WRAP [=y]

WARNING: unmet direct dependencies detected for SND_SOC_RT1015P
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_MT8192_MT6359_RT1015_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8192 [=y] && MTK_PMIC_WRAP [=y]

WARNING: unmet direct dependencies detected for SND_SOC_RT1015P
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_MT8183_DA7219_MAX98357A [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_MT8183 [=y] && I2C [=y]

WARNING: unmet direct dependencies detected for SND_SOC_RT1015P
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8183 [=y]

This is because these config options select SND_SOC_RT1015P
without selecting or depending on GPIOLIB, despite
SND_SOC_RT1015P depending on GPIOLIB.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise if this
is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/mediatek/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 81ad2dcee9eb..d10d6a3bf5eb 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -120,7 +120,7 @@ config SND_SOC_MT8183
 
 config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
 	tristate "ASoC Audio driver for MT8183 with MT6358 TS3A227E MAX98357A RT1015 codec"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	depends on SND_SOC_MT8183
 	select SND_SOC_MT6358
 	select SND_SOC_MAX98357A
@@ -138,7 +138,7 @@ config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
 
 config SND_SOC_MT8183_DA7219_MAX98357A
 	tristate "ASoC Audio driver for MT8183 with DA7219 MAX98357A RT1015 codec"
-	depends on SND_SOC_MT8183 && I2C
+	depends on SND_SOC_MT8183 && I2C && GPIOLIB
 	select SND_SOC_MT6358
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT1015
@@ -173,7 +173,7 @@ config SND_SOC_MT8192
 
 config SND_SOC_MT8192_MT6359_RT1015_RT5682
 	tristate "ASoC Audio driver for MT8192 with MT6359 RT1015 RT5682 codec"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	depends on SND_SOC_MT8192 && MTK_PMIC_WRAP
 	select SND_SOC_MT6359
 	select SND_SOC_RT1015
@@ -200,7 +200,7 @@ config SND_SOC_MT8195
 
 config SND_SOC_MT8195_MT6359_RT1019_RT5682
 	tristate "ASoC Audio driver for MT8195 with MT6359 RT1019 RT5682 codec"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	depends on SND_SOC_MT8195 && MTK_PMIC_WRAP
 	select SND_SOC_MT6359
 	select SND_SOC_RT1015P
-- 
2.30.2

