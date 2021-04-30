Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEC136FD8E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhD3PTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhD3PTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:19:09 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:18:21 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id o21so23731394qtp.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8qhoZjnAOoRGSspXxTVaK8T+itmNjOz7rF9WJiHL+Y=;
        b=DbJ4ZO/so/jEi8PJ3cwjqsfrARU63Q46CsvWFvSJP1T6Vr5PmBMBAfVb/4WbZAHfQ5
         zYPdHAGfEhknDGB8kKQ/O2awTCC/N5lZHJ3NjC++plr5mxYKdYadXjZVQchrUP397Zx0
         KVnr4EwZ0FzCCUOTPeO8bFTjtSFldbp38tvlPquzuhg9cGmr3PWa+88p7sOuRBeWNcWy
         EI+AQBMjwxwrAzgvmN+oVM8zbbY6Hz87Gk0DRgoBKDsjDgl/6O+8AxUatSi6hDHSlfex
         ohKZo9M/XuB2V1c2x8tdot/uKPol7172/oUaVspmHHZspI5Lko+fObs0f9U/tWI71uLA
         uqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=w8qhoZjnAOoRGSspXxTVaK8T+itmNjOz7rF9WJiHL+Y=;
        b=fC/2D9+4O1bCJXfqFNI1z9JLPFeWLa275hVw7tYxbZkxOMvLkPeCrskwQ+FS5Py4IG
         /HLX1QfoXqLmk2CgamcSgqCeoPftV+hwqdrcBABm9dreT36JhDKrEKied7ZlB7D0SbyZ
         O+k7KP3xyTWJZs7F4AACODwkqqutXl3TXn2+DywQxfsI3VSMthWliP8R4jX5KV1/R6oX
         M0qvIwRVZIKMPuHUcbqtMKhA70+FEcX798ZsS1CVaIQFm+ydTmeh+K0k7bEDynlKKBV1
         zxTJAJAxOkqnQv2y2TJ8RPHvGcuInX/uuZHlVBKsKUNVDZLu11IKSR4cS6TqdQkXLqrf
         eX+g==
X-Gm-Message-State: AOAM530pQZnt5bxYy9cNkRu472jGftQAUBrwkWAWLiH6x/1YJTnGxm/2
        OkiEiep80N/mLp1XZ3vQppocRRmLa6exQQ==
X-Google-Smtp-Source: ABdhPJyTJsTvLRanIbdxcoNKlBYr1At8qNb65WG/tfhK3T0iL3RdbG/9axmMsS9caI9gHfR5gmuiBQ==
X-Received: by 2002:ac8:515a:: with SMTP id h26mr5052875qtn.109.1619795900108;
        Fri, 30 Apr 2021 08:18:20 -0700 (PDT)
Received: from ubuntu-mate-laptop.hsd1.fl.comcast.net ([2601:703:380:74f0:3016:5d78:eea0:48af])
        by smtp.gmail.com with ESMTPSA id x85sm1614348qkb.44.2021.04.30.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:18:19 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: [PATCH] sound: soc: intel: boards: fix missing dependencies on GPIOLIB
Date:   Fri, 30 Apr 2021 11:18:14 -0400
Message-Id: <20210430151814.50112-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.27.0
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
index d1d28129a32b..6c6c8e55a3cb 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -363,7 +363,7 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
 
 config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
 	tristate "KBL with DA7219 and MAX98357A in I2S Mode"
-	depends on I2C && ACPI
+	depends on I2C && ACPI && GPIOLIB
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
 	select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
 	help
-- 
2.27.0

