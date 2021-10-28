Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391CC43E36A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhJ1OWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhJ1OWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A85C0613B9;
        Thu, 28 Oct 2021 07:20:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i5so2841146wrb.2;
        Thu, 28 Oct 2021 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jq2UWtG87dKtp2XZhwrbjMAgWZR6sHhFRmylDzZWc3U=;
        b=Ga9puom6MDb1nGZqJz4kzpiYpvKxyb9Nm4IeObhoEB/Vyllld2oBBGENQHR5M90VZp
         t6IYEj07WV+x9NavL9+WLfTcp9SPEMOZEYlWpMWtWNMOkt0CUEjSGJN0/NNSJOzoxG1r
         gPMborydG7PWwy4+8i/EnGGjnaw4j6akgpVanezrqm0D8Ty7h8UCUem3TsgZE3w4PjH5
         7r+4hlcJj22WKY5x9yJkkno2fzzvDwTTNr2pNgB6awOHHnQmxc3US9B9HdumUG0dHMyV
         pDWyXkldoEGup0spMTVH1ReipOAau4ZpTUImIBX0JqY58UCBKej5j0YT17ywMh9Ng9B/
         IDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jq2UWtG87dKtp2XZhwrbjMAgWZR6sHhFRmylDzZWc3U=;
        b=yBrdWgZJGaGOpyhXrQ11Xc6wmNW1k+yIS8hZFlc26FwoeNaE5CKkfsCCjSix3exe6o
         xpbUIlmHeAdoTFKOEuCrQQMPt3i5Y0xH7q/EWXc+Y5lAQW5ZgA3+iAYWuuCjxJhKIyxi
         YFyUf1mQt1kjb6aIYhxeLCWYfU1ESnvl6m5ahjc1PbberQU2QibleClnFyJGYJ46KShy
         0qEV5f1hIl8GE1HUgavWt90c0wcUg5GdUOhRKY5okp/1U4KIa2NT7gw/SPPpk3rN9ppV
         AM0nuRiNLM9mQ847CNa71yM0b3P1k2/ESHqEj0ttJ0VUC5ZcYQo2HR9TsmSYZFRGdKlV
         HxRA==
X-Gm-Message-State: AOAM533nBDA4V82VtSDww7Ag19R27E6UTJVYV6su+j4sis7EWgAoMVJW
        V3yJnN1wk//KrWCy288qulE=
X-Google-Smtp-Source: ABdhPJyTnHflOd35od7Nqe0uPf6eZ2Tsvdh6LTEeOfKT4xLNdiyUfBf9J8jHcbNZwK8CGER76iQugg==
X-Received: by 2002:a5d:6da7:: with SMTP id u7mr5906547wrs.322.1635430810538;
        Thu, 28 Oct 2021 07:20:10 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:10 -0700 (PDT)
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
Subject: [PATCH 08/13] arm: imx: rename DEBUG_IMX21_IMX27_UART to DEBUG_IMX27_UART
Date:   Thu, 28 Oct 2021 16:19:33 +0200
Message-Id: <20211028141938.3530-9-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4b563a066611 ("ARM: imx: Remove imx21 support"), the config
DEBUG_IMX21_IMX27_UART is really only debug support for IMX27.

So, rename this option to DEBUG_IMX27_UART and adjust dependencies in
Kconfig and rename the definitions to IMX27 as further clean-up.

This issue was discovered with ./scripts/checkkconfigsymbols.py, which
reported that DEBUG_IMX21_IMX27_UART depends on the non-existing config
SOC_IMX21.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/Kconfig.debug            | 14 +++++++-------
 arch/arm/include/debug/imx-uart.h | 18 +++++++++---------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 87aa6e92ee6e..7dad01729683 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -410,12 +410,12 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX25.
 
-	config DEBUG_IMX21_IMX27_UART
-		bool "i.MX21 and i.MX27 Debug UART"
-		depends on SOC_IMX21 || SOC_IMX27
+	config DEBUG_IMX27_UART
+		bool "i.MX27 Debug UART"
+		depends on SOC_IMX27
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on i.MX21 or i.MX27.
+		  on i.MX27.
 
 	config DEBUG_IMX28_UART
 		bool "i.MX28 Debug UART"
@@ -1481,7 +1481,7 @@ config DEBUG_IMX_UART_PORT
 	int "i.MX Debug UART Port Selection"
 	depends on DEBUG_IMX1_UART || \
 		   DEBUG_IMX25_UART || \
-		   DEBUG_IMX21_IMX27_UART || \
+		   DEBUG_IMX27_UART || \
 		   DEBUG_IMX31_UART || \
 		   DEBUG_IMX35_UART || \
 		   DEBUG_IMX50_UART || \
@@ -1540,12 +1540,12 @@ config DEBUG_LL_INCLUDE
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/imx.S" if DEBUG_IMX1_UART || \
 				 DEBUG_IMX25_UART || \
-				 DEBUG_IMX21_IMX27_UART || \
+				 DEBUG_IMX27_UART || \
 				 DEBUG_IMX31_UART || \
 				 DEBUG_IMX35_UART || \
 				 DEBUG_IMX50_UART || \
 				 DEBUG_IMX51_UART || \
-				 DEBUG_IMX53_UART ||\
+				 DEBUG_IMX53_UART || \
 				 DEBUG_IMX6Q_UART || \
 				 DEBUG_IMX6SL_UART || \
 				 DEBUG_IMX6SX_UART || \
diff --git a/arch/arm/include/debug/imx-uart.h b/arch/arm/include/debug/imx-uart.h
index c8eb83d4b896..3edbb3c5b42b 100644
--- a/arch/arm/include/debug/imx-uart.h
+++ b/arch/arm/include/debug/imx-uart.h
@@ -11,13 +11,6 @@
 #define IMX1_UART_BASE_ADDR(n)	IMX1_UART##n##_BASE_ADDR
 #define IMX1_UART_BASE(n)	IMX1_UART_BASE_ADDR(n)
 
-#define IMX21_UART1_BASE_ADDR	0x1000a000
-#define IMX21_UART2_BASE_ADDR	0x1000b000
-#define IMX21_UART3_BASE_ADDR	0x1000c000
-#define IMX21_UART4_BASE_ADDR	0x1000d000
-#define IMX21_UART_BASE_ADDR(n)	IMX21_UART##n##_BASE_ADDR
-#define IMX21_UART_BASE(n)	IMX21_UART_BASE_ADDR(n)
-
 #define IMX25_UART1_BASE_ADDR	0x43f90000
 #define IMX25_UART2_BASE_ADDR	0x43f94000
 #define IMX25_UART3_BASE_ADDR	0x5000c000
@@ -26,6 +19,13 @@
 #define IMX25_UART_BASE_ADDR(n)	IMX25_UART##n##_BASE_ADDR
 #define IMX25_UART_BASE(n)	IMX25_UART_BASE_ADDR(n)
 
+#define IMX27_UART1_BASE_ADDR	0x1000a000
+#define IMX27_UART2_BASE_ADDR	0x1000b000
+#define IMX27_UART3_BASE_ADDR	0x1000c000
+#define IMX27_UART4_BASE_ADDR	0x1000d000
+#define IMX27_UART_BASE_ADDR(n)	IMX27_UART##n##_BASE_ADDR
+#define IMX27_UART_BASE(n)	IMX27_UART_BASE_ADDR(n)
+
 #define IMX31_UART1_BASE_ADDR	0x43f90000
 #define IMX31_UART2_BASE_ADDR	0x43f94000
 #define IMX31_UART3_BASE_ADDR	0x5000c000
@@ -112,10 +112,10 @@
 
 #ifdef CONFIG_DEBUG_IMX1_UART
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX1)
-#elif defined(CONFIG_DEBUG_IMX21_IMX27_UART)
-#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX21)
 #elif defined(CONFIG_DEBUG_IMX25_UART)
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX25)
+#elif defined(CONFIG_DEBUG_IMX27_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX27)
 #elif defined(CONFIG_DEBUG_IMX31_UART)
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX31)
 #elif defined(CONFIG_DEBUG_IMX35_UART)
-- 
2.26.2

