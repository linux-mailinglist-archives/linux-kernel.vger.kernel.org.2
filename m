Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8303A1E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 22:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhFIUXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 16:23:19 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:40658 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhFIUXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:23:18 -0400
Received: by mail-ej1-f53.google.com with SMTP id my49so23634886ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1GjlLUDtM2mEAEvdu2FMZEVrykbRH7EpEHQNoxkDU4=;
        b=niZu8GLvw1ayIHdeNNDj6brBfFOpWsKB3p1cyzLN9Jq5nuciCUMYN1nwj0n16gtAfZ
         0vvSwPQRNEhEXTLkwsfH92bR5I0qMebE00KEDCdOezV/q0xXI3+u03aS3PVsWsmfJbad
         2xAbeKyA8nCuyXC/cpKA5QwasrWMdkqJhE8x1vDr0oowPr6vStNZjz3NauwJVkVXR7uW
         S6+kmLOsx3+Nslxgc2lGCuv5AFbgaL/q/fiFwL7UNCfnQFxA/JvmqM8zir9rGLOeaaUd
         MQwkQZDE9derH7iIOIEXQvL1JNNr2jozF3TpVoURl4hvLuG1Q1Swnfa4BxNRm0HR4mWw
         aGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1GjlLUDtM2mEAEvdu2FMZEVrykbRH7EpEHQNoxkDU4=;
        b=SEurlAuLjpwM6v0f/9ETmgSliiA7FtWcpHz3bqxTpibluH2CfxrTnw5UvBPK5t1uGB
         fcnnwB/baTqKB0MUmM0je8x9bvZ4Dd4hCgabEKCHFBH9UwdLABWdRtKFDo7SmTp6Ts3k
         UHlodzv+oBlAabkGh7kQK4kOvAlD+NtDPAlOu2/qFPqj7vNP389tqfQA/E/c15gK+n9/
         xpGCuzjUAtTCIwGvkZjMrpjy4DOmPNeshngmUz5ztFBzlVLi/Mwh2f2KjUpajgcJ1fy1
         nowrMxMot2U23apjyuqXqc/Z/eNiTCdf388E73TQmyeq7Oryjqt3l8EfL+sLLpwheuu4
         JKGA==
X-Gm-Message-State: AOAM531t7ZtWuHQhKV9Z9vLnu6y2YYMjZcbMjpkIu+H6G91IxjVdgoNS
        q8+Aiag7wLFc5Bwy8TXLSIbYlW1vEiEeow==
X-Google-Smtp-Source: ABdhPJyE2We8oSGaqvQe0DO/z+AqXv4xQ+RUCvWYLtVth4uml/OhWI+D1bK/0hDRlO4uR5ZM27ZHYA==
X-Received: by 2002:a17:906:520f:: with SMTP id g15mr1510005ejm.126.1623270023173;
        Wed, 09 Jun 2021 13:20:23 -0700 (PDT)
Received: from jackdaw.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id u19sm249358ejt.74.2021.06.09.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 13:20:22 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] arm64: meson: remove COMMON_CLK
Date:   Wed,  9 Jun 2021 22:20:09 +0200
Message-Id: <20210609202009.1424879-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit aea7a80ad5effd48f44a7a08c3903168be038a43.
Selecting COMMON_CLK is not necessary, it is already selected by
CONFIG_ARM64

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7336c1fd0dda..6409b47b73e4 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -165,7 +165,6 @@ config ARCH_MEDIATEK
 
 config ARCH_MESON
 	bool "Amlogic Platforms"
-	select COMMON_CLK
 	select MESON_IRQ_GPIO
 	help
 	  This enables support for the arm64 based Amlogic SoCs
-- 
2.32.0

