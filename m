Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153EE438CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 03:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJYBIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 21:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJYBIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 21:08:44 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330BEC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:06:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id kd16so788065qvb.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUgFMuFWMqRkPlVa3Bg3L3JdMeXkE1iDKFTnUjQ3Sz0=;
        b=DAYeIL98GmFt5w1sG/kbhRK/o+yMnFp307KdZpZ35rFhYjdlYSnWi4YX8btq9/iUQJ
         zqoqL1zXnKhcctXDQpScuBpWYddJhbF1FQFIu6O1aOryCw9dhBnysh4t9wcdieP/ZxEl
         3c9wjVaLqwJvjeUqI8HN6dPfa8BgbIccwvbPAXiKvmv1GYXod0+KTLQKsg+gk2cbEfL2
         ivDDDV/BNgIQ5kT+LFhBWvuRC6kdUD/T6zq9arQ4Edir8Hi2XzwDV0NAjvMKDgZ3JhEy
         1FCCAJiTMtHR+5DQFJByX4TlfULgewad0wixB4sMSPkLoeDMn16Bkw8Skj51Kc7fsRt7
         Y8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pUgFMuFWMqRkPlVa3Bg3L3JdMeXkE1iDKFTnUjQ3Sz0=;
        b=4j7fXli6d8DsKDeI2z3kiSBuHZ7+hjrvaceRq2AyAaB8Msh0lM+hKBs3dpSjYGAF/i
         EiymtyC88Tlwf8PDzwoSWAKfjjhe/4UvV7TrwBNsq1kLEN6TRq4rERtgFeNZ59hngEql
         PcTnNALe18ers7ckEiQdRDtKUOaz6wxLQADq1YEdYrNc+iITQTZmInsbY/vBjT2JNcnG
         tWdUndQ0yk97t/ZCZau/9zspPny/MbVZBn6n1/MJ48F+Yp022qSQ3WIDXev4OCL69LRm
         EQh9GMe0O1MGs9R548i4PIIqdYfAKRf+R5tgA8ASjtDOwpRCg1xRngzMHfje3OmTGDdx
         p1Ww==
X-Gm-Message-State: AOAM531M2KbdDkus66PGqDRgpf7wLI68xc+Csii+3F+1P9QAxLTB97wF
        9O7uOGpjsuaGeVk2iGz6RPkRC8pj6/gvE4ol
X-Google-Smtp-Source: ABdhPJxnekBfNlKAQb4vwX0YsEcIUCoHwtP2LefYDFVm5wOt86f//qHwU2lw4nZR2VEPKC29FCl08Q==
X-Received: by 2002:a0c:fe8c:: with SMTP id d12mr8201265qvs.19.1635123982259;
        Sun, 24 Oct 2021 18:06:22 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:1bd1:606f:798c:522:4ec4:cb93])
        by smtp.gmail.com with ESMTPSA id q22sm7906035qkj.64.2021.10.24.18.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:06:21 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        cezary.rojewski@intel.com, perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fix unmet dependency on GPIOLIB for SND_SOC_MAX98357A
Date:   Sun, 24 Oct 2021 21:06:15 -0400
Message-Id: <20211025010615.10070-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is selected,
and GPIOLIB is not selected, Kbuild gives the
following warnings:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_INTEL_DA7219_MAX98357A_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y]

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_INTEL_DA7219_MAX98357A_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y]

WARNING: unmet direct dependencies detected for SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && SND_SOC_INTEL_KBL [=y] && I2C [=y] && ACPI [=y] && (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=n])

This is because SND_SOC_DMIC and SND_SOC_MAX98357A are
selected by SND_SOC_INTEL_DA7219_MAX98357A_GENERIC, which
is also selected by SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH.
However, the selectors do not depend on or select GPIOLIB,
despite SND_SOC_DMIC and SND_SOC_MAX98357A depending on GPIOLIB.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise if this
is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/intel/boards/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 61b71d6c44cf..87db6a80876a 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -371,7 +371,7 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
 
 config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
 	tristate "KBL with DA7219 and MAX98357A in I2S Mode"
-	depends on I2C && ACPI
+	depends on I2C && ACPI && GPIOLIB
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
 	select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
 	help
-- 
2.30.2

