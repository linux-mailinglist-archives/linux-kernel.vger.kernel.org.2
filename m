Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2197543D10C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhJ0SvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbhJ0SvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:51:03 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD43C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:48:37 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id v2so2404868qve.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1FJiBpCKtlOpMH0mW30VRaesYawySjY66iCeXFJ7SYM=;
        b=cDWn67pDYQ4ozbi60h6BD3NfdckXrfUip7IWC34IVy1/rYlnmBOzphnxc6Pi3yAjyA
         Pv8kQIIssiYDyvqEQSOKXlr8cs/4/lihrt+BrBvnQl2cimAK5iwaCmpMjpMzRz/56dL8
         5cq/u2Ku3/4elbpVQTji55mG0USBSrrkxeKMtRD7gUNfP7z+lcy/ij8Jz3lKfLd9k1xg
         Zmoc+W2MdRmXJo3KTMLkG74L46hszFgScQkmC6jpJieNjtABCsh2+iXdwOXDSpkB/gLb
         SikHEhpSwCaS62wHtTn+gCyLzVI4/0zQB3uPdJcvOFzHleH1XHMbKVeFqJhxa4+jLJDR
         71MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1FJiBpCKtlOpMH0mW30VRaesYawySjY66iCeXFJ7SYM=;
        b=pGlsb/S3kPV2QiHVzaF/O6HrntbJVT1oR1VP9XPjyuUlbpFW5xS40c7UFHCCtmeCRW
         hAcZ5kLHF9j5HQpbQqM6NCxPItxpPZ/jEdW9eefT4BXHwlcx6g0iwsa7jZdhOqTS7F6D
         KmF83I0VfjmyjoMWiayH47qdYVUD5/EWM+U7hkJSiJHc75Kc/xxK3t1gtWY3FsimeBqo
         b3kxU2xN/YeAKmf+45n8Wbkokg2+Kdy7mJjvb9ULfpMSkIBOPyEHGfr1Ws2qYzYLEigw
         GIkWZyW3sEO/ui5t90KAA+1bI+8mTGvvYq4OmFZBVPhmAuLkGUizPeH95OIek5vPLPlv
         dSeg==
X-Gm-Message-State: AOAM533TsZI16apOCjIynwSqZHFGmqASu5fPzHnbE/IIy0Nycx+DFQKg
        2ltnQ37LQilk7t4m3Kax3D8=
X-Google-Smtp-Source: ABdhPJzW4teN0Shtei3LjruOVmsoXFBmBZv8vnnzvzVAQ8/cAUbcALlfr9AxoR8Y4j8KD3WG/clZVA==
X-Received: by 2002:ad4:5423:: with SMTP id g3mr27947804qvt.45.1635360516980;
        Wed, 27 Oct 2021 11:48:36 -0700 (PDT)
Received: from ubuntu-mate-laptop.therobinsoncafe.local (097-068-131-026.biz.spectrum.com. [97.68.131.26])
        by smtp.gmail.com with ESMTPSA id o6sm503131qta.2.2021.10.27.11.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:48:36 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     broonie@kernel.org, Vijendar.Mukunda@amd.com, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        fazilyildiran@gmail.com
Subject: [PATCH RESEND] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_DMIC
Date:   Wed, 27 Oct 2021 14:48:35 -0400
Message-Id: <20211027184835.112916-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_AMD_RENOIR_MACH or SND_SOC_AMD_RV_RT5682_MACH
are selected, and GPIOLIB is not selected, Kbuild gives
the following warnings, respectively:

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_AMD_RENOIR_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_RENOIR [=y]

and

WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_AMD_RV_RT5682_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_ACP3x [=y] && I2C [=y] && CROS_EC [=y]

This is because SND_SOC_DMIC and SND_SOC_MAX98357A are
selected by SND_SOC_AMD_RV_RT5682_MACH and SND_SOC_AMD_RENOIR_MACH,
respectively. However, neither of the selectors depend on or select GPIOLIB,
despite their selectees depending on GPIOLIB.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise if this
is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/amd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 56e7c079deac..2c6af3f8f296 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -38,7 +38,7 @@ config SND_SOC_AMD_RV_RT5682_MACH
 	select I2C_CROS_EC_TUNNEL
 	select SND_SOC_RT1015
 	select SND_SOC_RT1015P
-	depends on SND_SOC_AMD_ACP3x && I2C && CROS_EC
+	depends on SND_SOC_AMD_ACP3x && I2C && CROS_EC && GPIOLIB
 	help
 	 This option enables machine driver for RT5682 and MAX9835.

@@ -51,7 +51,7 @@ config SND_SOC_AMD_RENOIR
 config SND_SOC_AMD_RENOIR_MACH
 	tristate "AMD Renoir support for DMIC"
 	select SND_SOC_DMIC
-	depends on SND_SOC_AMD_RENOIR
+	depends on SND_SOC_AMD_RENOIR && GPIOLIB
 	help
 	 This option enables machine driver for DMIC

--
2.30.2
