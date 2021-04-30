Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC78736FE64
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhD3QUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhD3QUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:20:36 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F962C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:19:48 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 8so37486638qkv.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XkqXq8o8NvX8O05anTrL4L6PWuFtEQ5E3tJy9DQStH4=;
        b=oTie7fqQ3/ImsOGyAlUEovsRvZu/FCp7gn4/jV6Uj26t2Whpks5KiNf4oZ5nTpNYgG
         IfxznNfKHdZFG8ytQ6DE70BgkQzpM2laxtniK2rbS4491CtC8we1SJQEYsNB6UJp8o+I
         uVqQSO5RAT/QBHVD3aMrQr1qJLChMzCx5HQdisyJBmyZqXg/fyPXxMz7+t0BqC31dnnE
         B+ouXmu+9zJnE+dAE5dOKKuUSkw6fyPg7tr4RYlo8w8EESqSz1E4CYwAQ+JTo4B9HR9n
         akL9uRrcmOjsBBSiTNddH4fofK68bcFpCFxQv5zWt8Tk05NtiV6kM7nQbtPiw+HnjlTK
         h8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XkqXq8o8NvX8O05anTrL4L6PWuFtEQ5E3tJy9DQStH4=;
        b=SS0QmgpEdbMs6pYIfA/HV1zYEEQzGHCGPmvRzJCjuMK2wowia3wGeoZoV7I9FMxz/M
         H+8/sAQuXLdFheE2N2Ggn96/LL7rGr9XK5fJNPezDuNR2pNZ/7uVtCmf639TK3H1C/yU
         UV5tU06Svxq+acJawP+Je0sPnfeX+9ePBBiMwNo1QhLxNdX4NKkYUA5G8XFblQS+5Mb9
         +mXW+e7s6cZ1ghDvmi4Owlff5UQ5HSkbbdCDQrMJNNuG5IONCTh94Uqo+VjOX8+VszfU
         KA/NlQxYD1JQcYIijL/2Ej3HxCVXqMiqO3/ckhBrSzl6EE3BbV9yFCaQHm4U9v2rPw99
         eWPQ==
X-Gm-Message-State: AOAM530CoRH4jDZMYADYxwtNnbw8XWntm2YTK0PFM9FKKaHx+MOc4xKo
        4k8CD85Lm75k41dmSH73AegvR2CxQBx3gw==
X-Google-Smtp-Source: ABdhPJxXFYZl2Um7B+dKw3MD+fdPvkDVKon+SIvJWPWYwVnKNBAc9YRcAxM3/1AvrzFaMl1gervrPA==
X-Received: by 2002:a05:620a:714:: with SMTP id 20mr6306084qkc.260.1619799587384;
        Fri, 30 Apr 2021 09:19:47 -0700 (PDT)
Received: from ubuntu-mate-laptop.hsd1.fl.comcast.net ([2601:703:380:74f0:7a3d:d5fb:bf68:b214])
        by smtp.gmail.com with ESMTPSA id g4sm2561225qtg.86.2021.04.30.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 09:19:47 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: [PATCH] sound: soc: qcom: fix unmet dependencies on GPIOLIB
Date:   Fri, 30 Apr 2021 12:19:40 -0400
Message-Id: <20210430161940.55268-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.27.0
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
index cc7c1de2f1d9..0e1366ca3275 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -38,6 +38,7 @@ config SND_SOC_LPASS_SC7180
 
 config SND_SOC_STORM
 	tristate "ASoC I2S support for Storm boards"
+  depends on GPIOLIB
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
2.27.0

