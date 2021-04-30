Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65C536FC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhD3OkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhD3OkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:40:22 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:39:31 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q136so49883525qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BiN60F6dTP6DmE3gx9WBdjNyi1KofY1mmNmP2XjnsSI=;
        b=XJVRHsHATzPcYtsl0wE6zJxEeHqIE27DR7APxA2Dfb/kUbSBHYtPvMWTzmnuzsJQZQ
         abLGc20y+gAvMovdVTX6SpBOYdyDIWu0vdnkl+wzI1Yw8g2xNMlNzqthSLm22uYoB9E9
         POiJSUdRMWOX24nVAz7yQ4aNlpcbJXRX10oodTVmJ5/Qd6Hk10zloE/ypas65b+xIvC2
         8DxDa48toFnzgiV3vsA0oWmcxED+LQAHLpOi09wLT+vzCU00J552ZKkVxsckxUygrBMV
         Kh3H8I+ERLVuYY3Sf9x2KS+cUNxzZUuH//yvsgUu4ZzKzNgNoqY+erzj3PelT+8G1MQV
         9xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BiN60F6dTP6DmE3gx9WBdjNyi1KofY1mmNmP2XjnsSI=;
        b=Z7i6PDWnP9K4tc5WxNtt2y5aa5I9qp0BZ4Wphi36rUFkyTjUq6Sapn2HDYcjUXX+AF
         k8RUZbXmmpd32zbWVD6F3BrZyzDHKGD5LyMYvs9ZTNF/QeX68wL5qCzBh5bB29tgoipP
         Ij87dGwQtQ2bYp9I9ZqlQhS1PSu4J/GAjMNt01q7Lgou04X0j043yyuhg6VOndK2+rzu
         Ak+6fStJoKL+rbZ24TGSqUpu71fYZFRtNN+mEYVFhvhz4mk8NsbF2w0EFOD3tfWeZZgG
         uZaU5it/KTOq/GHFS08Pd2UBJpbUAJYCTZUKGHaYyAFWH/82PRb3VKOBWazm5pu8ZdI9
         mmXw==
X-Gm-Message-State: AOAM533quW2yh+01zVVaGTOR3GdP93uQFFVUqnUmgakz2EbHIROqKDQX
        m9DPSYxRR4dVsvXT+z4PFYo=
X-Google-Smtp-Source: ABdhPJyjEAHdHUvmPLb2vBERPaJ3wO/pxq0gjZtDsTxNtsItKay7/tLp17gqmYaVUs8rEgSDzF5cBg==
X-Received: by 2002:a05:620a:12ae:: with SMTP id x14mr5743022qki.471.1619793571085;
        Fri, 30 Apr 2021 07:39:31 -0700 (PDT)
Received: from ubuntu-mate-laptop.hsd1.fl.comcast.net ([2601:703:380:74f0:3016:5d78:eea0:48af])
        by smtp.gmail.com with ESMTPSA id n16sm2329419qtl.48.2021.04.30.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:39:30 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: [PATCH] sound: soc: amd: fix missing dependencies on GPIOLIB
Date:   Fri, 30 Apr 2021 10:39:19 -0400
Message-Id: <20210430143919.43362-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.27.0
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
index a6ce000fac3f..b7d41438d830 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -34,7 +34,7 @@ config SND_SOC_AMD_RV_RT5682_MACH
 	select SND_SOC_CROS_EC_CODEC
 	select I2C_CROS_EC_TUNNEL
 	select SND_SOC_RT1015
-	depends on SND_SOC_AMD_ACP3x && I2C && CROS_EC
+	depends on SND_SOC_AMD_ACP3x && I2C && CROS_EC && GPIOLIB
 	help
 	 This option enables machine driver for RT5682 and MAX9835.
 
@@ -47,6 +47,6 @@ config SND_SOC_AMD_RENOIR
 config SND_SOC_AMD_RENOIR_MACH
 	tristate "AMD Renoir support for DMIC"
 	select SND_SOC_DMIC
-	depends on SND_SOC_AMD_RENOIR
+	depends on SND_SOC_AMD_RENOIR && GPIOLIB
 	help
 	 This option enables machine driver for DMIC
-- 
2.27.0

