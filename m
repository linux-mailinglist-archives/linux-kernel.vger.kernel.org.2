Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B240043E35D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhJ1OW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJ1OWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F685C061570;
        Thu, 28 Oct 2021 07:19:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d13so10486440wrf.11;
        Thu, 28 Oct 2021 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyvzNad0Xx5R9v5YeX/jyfVB5cjv8pWIdrWsMdtOKeU=;
        b=pnI+cDc9pgmeUAnEprJ7/g4BWiQOQtOOfpQNHyw3VF2sBk/yxpLfYNtbnA4fAvsbzv
         +DdHd6ejGKxE3mz93ID2DTOqwhVuISJvg+EYrF122ReobcnkAtX3JdQaMCfYD5aOdqxt
         tn+DosTSrlI2W7nHzvKH80PUuO8b+5SkBOGl5wnksLRPsgqEabF4Av2vkPbXeq3JMdeG
         eIQOPCkjUT8qbpJfBNSVZy8OPEftyNcMBoyeTW0qUaTDRVCuKcfC6PmVliubGi7YiuEn
         oLehjjga+IdY0b9Zznh0Zne8SGdgDPw49DXo88qGqGf8udnQqu/8tCdT/tybaYzf9BDb
         +Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyvzNad0Xx5R9v5YeX/jyfVB5cjv8pWIdrWsMdtOKeU=;
        b=uKmE56sBLmCbPanrcI28ZdzCR1wLSWs6N66Lyefu5dyxhtgXdFzUQIJd9/W+KMai7G
         FASloih4ChOpd7V5rJ0RlScQTIUHVZDzuqBGT5hSLWTXOf3qUe755xKp9LmVMVyxGDgs
         BKEAZRxuFbJUScoO+6VmNem+1+06xPdru7mBHj8EHwOVp5HMjnL8KnmbAT58w19D+zAH
         oKHxKo+m2f5OwMWrnBIvNSIIoZijM9AsV+wyp93f+PiT9kXEZdj1XruArjQrKF4z+zwn
         vBQVHEzJUIPjC2xTz9q/r6t0MRNccZYVrf9J1WEu5zhkIl+Zi/P8qOkwXjwt2VD+LM+O
         E7Ow==
X-Gm-Message-State: AOAM5302zck/O9zVSnCgOG5bhCbQUhWHg0x46p33J4OfiIQour2zMXM8
        YHbFIEVuDeIF3HT4yxtDNwg=
X-Google-Smtp-Source: ABdhPJyezFwmqtsLn5aBEOCfGdfBxksRSaz4BYGyosYiXwUImog8O0a6Qn+fFMD6OKMmrx4b80PO/Q==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr1609524wrj.274.1635430796683;
        Thu, 28 Oct 2021 07:19:56 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:19:56 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 02/13] arm: debug: reuse the config DEBUG_OMAP2UART{1,2} for OMAP{3,4,5}
Date:   Thu, 28 Oct 2021 16:19:27 +0200
Message-Id: <20211028141938.3530-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d2b310b0234c ("ARM: debug: Use generic 8250 debug_ll for omap2 and
omap3/4/5 common uarts") adds address definitions of DEBUG_UART_PHYS for
OMAP2, OMAP3, OMAP4 and OMAP5 in ./arch/arm/Kconfig.debug.

These definitions depend on DEBUG_OMAP{2,3,4,5}UART{1,2}; however, only
DEBUG_OMAP2UART{1,2} are defined in ./arch/arm/Kconfig.debug, and
DEBUG_OMAP{3,4,5}UART{1,2} are not defined. Hence, the script
./scripts/checkkconfigsymbols.py warns here on non-existing symbols.
Simply reuse the config DEBUG_OMAP2UART{1,2}; there is no need to define
separate config symbols for OMAP{3,4,5}. So, just delete the dead
references to DEBUG_OMAP{3,4,5}UART{1,2}.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/Kconfig.debug | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 98436702e0c7..83484564b1d9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1643,10 +1643,8 @@ config DEBUG_UART_PHYS
 	default 0x48020000 if DEBUG_OMAP4UART3 || DEBUG_TI81XXUART1
 	default 0x48022000 if DEBUG_TI81XXUART2
 	default 0x48024000 if DEBUG_TI81XXUART3
-	default 0x4806a000 if DEBUG_OMAP2UART1 || DEBUG_OMAP3UART1 || \
-				DEBUG_OMAP4UART1 || DEBUG_OMAP5UART1
-	default 0x4806c000 if DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || \
-				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
+	default 0x4806a000 if DEBUG_OMAP2UART1
+	default 0x4806c000 if DEBUG_OMAP2UART2
 	default 0x4806e000 if DEBUG_OMAP2UART3 || DEBUG_OMAP4UART4
 	default 0x49020000 if DEBUG_OMAP3UART3
 	default 0x49042000 if DEBUG_OMAP3UART4
@@ -1782,10 +1780,8 @@ config DEBUG_UART_VIRT
 	default 0xfa020000 if DEBUG_OMAP4UART3 || DEBUG_TI81XXUART1
 	default 0xfa022000 if DEBUG_TI81XXUART2
 	default 0xfa024000 if DEBUG_TI81XXUART3
-	default 0xfa06a000 if DEBUG_OMAP2UART1 || DEBUG_OMAP3UART1 || \
-				DEBUG_OMAP4UART1 || DEBUG_OMAP5UART1
-	default 0xfa06c000 if DEBUG_OMAP2UART2 || DEBUG_OMAP3UART2 || \
-				DEBUG_OMAP4UART2 || DEBUG_OMAP5UART2
+	default 0xfa06a000 if DEBUG_OMAP2UART1
+	default 0xfa06c000 if DEBUG_OMAP2UART2
 	default 0xfa06e000 if DEBUG_OMAP2UART3 || DEBUG_OMAP4UART4
 	default 0xfa71e000 if DEBUG_QCOM_UARTDM
 	default 0xfb002000 if DEBUG_CNS3XXX
-- 
2.26.2

