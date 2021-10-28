Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F6643E367
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhJ1OWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhJ1OWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F6C061348;
        Thu, 28 Oct 2021 07:20:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v17so10479842wrv.9;
        Thu, 28 Oct 2021 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=le2hzZSknGbN32j+WyPBSUphMiDhY48ycCDRlUrmOR4=;
        b=fZyet1jpHTyp6VrkESIendSjAXNfzPrPLAR6SiYMpsO2hpA1CHmWoU4oL0LwcRnXaH
         R6LUm9v8niok9TSIHUNh6JKXcTCj2RLkkEAlV2TL7wcssA9Q7j9qRrZdCIeLgYUEYjOl
         S9jEpoC1YR8Q33EwmWarOFgCoqhl8PxSPSs690us4j5VsBHH8dfhNW07cmVQJcM8V5Ve
         DUh4QZoHipLRXYsSzL/CJzs7Uo3GIwjHoRsLHiCCcDkAB2GIF3S7sqnJAmGMRrF3RlqI
         8sh/9yJkUy7/hvu0m92m9++TNNzrmhRvDPC1wSk9WHNJIgLEFdKXxdKB/PyKf9tt0Y9E
         Dl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=le2hzZSknGbN32j+WyPBSUphMiDhY48ycCDRlUrmOR4=;
        b=A4gqJ/7EZRclzjFteP4+Kq+gsbyGxw9tToKLAWCKUSJE22fVUcd3fOjJcD+x2hB6Cw
         zAc77yhYWieYdpsjvmCMS/FQtLhVkV/qOhDqEMsfTUCNp+QB2jjD8trvQU4kcr1Dvu02
         b8FHivV8BpqY0WpwzV6ytNu1jw7t5AL2NumFGzSC/0RcyEACWlLc+Bg1+6xyQNTiuVkm
         FrL7ivZdhDM4/gIdEI+3iOfF/K0AQz18YW96xr/FwMZrre/EMH/1h6GtBqKQr4RfAJKI
         e9ty7a7v3GPX2+Lzvxm/pRJYw7CgriKjrxBnoWQTXP50JSAQYsrV8eTcC6GQutteNiwc
         9cDg==
X-Gm-Message-State: AOAM532nxAxWDbj1Esq6V6efIv9tFxPx0rjvj5RAkqqeWhMwNbo2JTVZ
        ffR1iRiiCfnR5HcGE/rYLlE=
X-Google-Smtp-Source: ABdhPJy4C/+R0zhTRyO5Ty3sYcOvSI81tuUGNdaGW1vIgobW8JDjdh2Y3LAk2e7WtMKDJ59YhVDa2A==
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr6100112wrb.336.1635430808034;
        Thu, 28 Oct 2021 07:20:08 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:07 -0700 (PDT)
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
Subject: [PATCH 07/13] arm: imx: remove dead left-over from i.MX{27,31,35} removal
Date:   Thu, 28 Oct 2021 16:19:32 +0200
Message-Id: <20211028141938.3530-8-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commits:

  commit 879c0e5e0ac7 ("ARM: imx: Remove i.MX27 board files")
  commit c93197b0041d ("ARM: imx: Remove i.MX31 board files")
  commit e1324ece2af4 ("ARM: imx: Remove i.MX35 board files")

remove the config MACH_MX27_3DS, MACH_MX31_3DS and MACH_MX35_3DS.
Commit a542fc18168c ("ARM: imx31: Remove remaining i.MX31 board code")
further removes arch/arm/mach-imx/3ds_debugboard.{c,h}. So, only some
dead left-over in Kconfig and Makefile remains.

Remove this remaining left-over.

This issue was identified with ./scripts/checkkconfigsymbols.py,
which warns on references to the non-existing configs
MACH_MX{27,31,35}_3DS in ./arch/arm/mach-imx/Kconfig.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-imx/Kconfig  | 12 ------------
 arch/arm/mach-imx/Makefile |  2 --
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b407b024dde3..f296bac467c8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -21,18 +21,6 @@ config MXC_TZIC
 config MXC_AVIC
 	bool
 
-config MXC_DEBUG_BOARD
-	bool "Enable MXC debug board(for 3-stack)"
-	depends on MACH_MX27_3DS || MACH_MX31_3DS || MACH_MX35_3DS
-	help
-	  The debug board is an integral part of the MXC 3-stack(PDK)
-	  platforms, it can be attached or removed from the peripheral
-	  board. On debug board, several debug devices(ethernet, UART,
-	  buttons, LEDs and JTAG) are implemented. Between the MCU and
-	  these devices, a CPLD is added as a bridge which performs
-	  data/address de-multiplexing and decode, signal level shift,
-	  interrupt control and various board functions.
-
 config HAVE_IMX_ANATOP
 	bool
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index d1506ef7a537..d5291ed9186a 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -14,8 +14,6 @@ obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o $(imx5-pm-y)
 obj-$(CONFIG_MXC_TZIC) += tzic.o
 obj-$(CONFIG_MXC_AVIC) += avic.o
 
-obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
-
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
-- 
2.26.2

