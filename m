Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C484283EC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhJJV6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhJJV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:58:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC32C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 14:56:34 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r16so14713948qtw.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJbVzM7l1D7JuwqpAtI5nI7LnVZbvtzYKA+zk7EWtHU=;
        b=VtRSwv+TAjnM/7UgaXIXwuA4sdNX3Yyrgv0NaB8ScyZrroWaYPWsvfZfwY2yLQN7pE
         E0SJCYR5fOR5SulTnrIb417GrpSYo0DcyPvvLMCLdkdEJ7y6DT4w+0Acl4q+e21gW1t6
         AIh/YSakbWaNy+is/VTAFywLZHqjLupRNA4RKD3fN2vim+PARDioldLQHZiaqZDNSVK1
         UoivOuewKg9BcZjWmcOje5CLAjrY7fTEVSSABQ1z4H28S7nkx1ul+I3nS3+5BUR422MH
         8lXFbYCpJGjtPHsb8tvI+kYFdWqRLy81G3r0vQX9ATQhiSGa6ALOo3TniCpPP7GdyORq
         4Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jJbVzM7l1D7JuwqpAtI5nI7LnVZbvtzYKA+zk7EWtHU=;
        b=5xVG1RYWIP9jUh66stuiMabsCkJ6M3Ry9nBGVPXwY7xf1xe9FTgTTDU5d6+tk1sfb0
         EeB5Ql8TT7tvTFnSEFZchNrWY35JmpZcKvyuwMDh3RwPfgp1Fp5GARVbZpE+43BBnzzU
         P/1zrnoRx8X3G3judcV7ecJn/9PguXesiNifHUpIyCNJWTXg8czzC54MZ6LoXHdN/C9F
         29239j+DJfqgJsz8i3eo33AUUF1L2zj2qf4qb+h+560eHoJVHK+7Jzx3KwkUI4xXEcM2
         iAOMRvh1dACI2LgacIviTPoZ7K43TdjdApzu8s6yYnlK/VqHLbet3HVVg0P8yzUBamt9
         ze2Q==
X-Gm-Message-State: AOAM5335Qsvn3QFeiLmh0ybSbHZ7ttCD0QdfHr8ECresbrqL62/Kq5DW
        BoEVVWN1Hy5OgMarPLWphsmEiNsH5Gmb9Q==
X-Google-Smtp-Source: ABdhPJy2Uxes532xgkBffYFXTLfI44OGqyQwMouf2EzqAGyGgrgAVWINChSTbrTrXuZd2/8FBsc9FA==
X-Received: by 2002:a05:622a:11c9:: with SMTP id n9mr11536236qtk.295.1633902993496;
        Sun, 10 Oct 2021 14:56:33 -0700 (PDT)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id t11sm1851951qkm.92.2021.10.10.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 14:56:33 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ajitp@codeaurora.org
Subject: [PATCH] ASoC: fix unmet dependency on GPIOLIB
Date:   Sun, 10 Oct 2021 17:56:27 -0400
Message-Id: <20211010215627.17869-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_SC7180 or SND_SOC_STORM is selected,
and GPIOLIB is not selected, Kbuild gives the following
warning:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_STORM [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y]
  - SND_SOC_SC7180 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && I2C [=y]

This is because SND_SOC_MAX98357A is selected
by SND_SOC_STORM and SND_SOC_SC7180, but
these config options do not select or depend on
GPIOLIB, despite SND_SOC_MAX98357A depending on
GPIOLIB.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise if this
is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/qcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index cc7c1de2f1d9..8c5c1ed54bc7 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -38,6 +38,7 @@ config SND_SOC_LPASS_SC7180
 
 config SND_SOC_STORM
 	tristate "ASoC I2S support for Storm boards"
+	depends on GPIOLIB
 	select SND_SOC_LPASS_IPQ806X
 	select SND_SOC_MAX98357A
 	help
@@ -141,7 +142,7 @@ config SND_SOC_SM8250
 
 config SND_SOC_SC7180
 	tristate "SoC Machine driver for SC7180 boards"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_LPASS_SC7180
 	select SND_SOC_MAX98357A
-- 
2.25.1

