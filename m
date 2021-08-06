Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86B3E2D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244621AbhHFPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbhHFPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:22:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052A3C06179F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 08:21:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m18so1127851ljo.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7149QsY3bxKHTBqGFladXmfU1OHnqAYwWvtju/kpgDw=;
        b=mU3tb0VOjIyfm2Q/1wxVB5IQeJY6SOfiPtxtSTAQSM7URQzOPL3Aj6JlwK9ogcH3sU
         SMRfbF3EFe3/V4/9h71BBGirdS9wb8TFJYrsXsbbkuV8Uiol9nOthlQtIBB3C+u0xHri
         2Z917j9Wby2pjv5vyCqcjnIkOzxPZDgdZpHMDnwUTRYVWg8ENCrBT2mnatKNXyLzDTIs
         MTWCN8MC66Q6+dNxDk4R74/+PBJttkSfuGBh52UEQgGHiIgd+2GsCAO/TZjeJ9sXrw5w
         0FBuR3pF8HVMuy85s7WKXXTLaKqIrxc9JsVbxi4yBObBekrmgOHh6gv0vNu76QiLGXOp
         A/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7149QsY3bxKHTBqGFladXmfU1OHnqAYwWvtju/kpgDw=;
        b=tYg+ujOAF8236eTXcLVLuwC6SvOShcqrO0Vf0U+GlZ491sjosILuXAVHJTQ8uKjmip
         T0OmvkNTLE9xCJr+DwwGKmd33ZUM3H29NqZPhvT6gjwdh6ypYtbQqLFGr6DM/v+vNhdl
         QbUTQ94NkWefIUgJ8uBj+2JOdjfoKHW8/mVhWmLS/8OnN/EoT0/NhUFLDRd9FZdjg1K4
         k9TvJddSwWpi/EgOxUmFh5ImNUAnlw16+Gi84o1JpztlX317AQlonC/BZkTDL0fnpmm3
         kCrkbl9cd4hJOcxVTOgbXvHUVUg34gljs5a9Db7+5ItKr2yj3jPGG7UtgaZpEuF/C+BL
         HX7w==
X-Gm-Message-State: AOAM533jsfCLEZCHqq+HAjheyJ3y8Y7Pz8OGKWTd26hP9lWzlcfOlIby
        FsJdouUwuu9/y4ZQeu9Fm4uNIg==
X-Google-Smtp-Source: ABdhPJz/nCSkupmdZvO+O/nPY21YE/Jn23nLsw919q8+GtfFLWrOy8Lwwb/7fmeR6+l9D649lgfGfQ==
X-Received: by 2002:a2e:a887:: with SMTP id m7mr7083249ljq.236.1628263314373;
        Fri, 06 Aug 2021 08:21:54 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id u18sm87339ljj.2.2021.08.06.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 08:21:53 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 4/8] tty: serial: samsung: Init USI to keep clocks running
Date:   Fri,  6 Aug 2021 18:21:42 +0300
Message-Id: <20210806152146.16107-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210806152146.16107-1-semen.protsenko@linaro.org>
References: <20210806152146.16107-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART block is a part of USI (Universal Serial Interface) IP-core in
Samsung SoCs since Exynos9810 (e.g. in Exynos850). USI allows one to
enable one of three types of serial interface: UART, SPI or I2C. That's
possible because USI shares almost all internal circuits within each
protocol. USI also provides some additional registers so it's possible
to configure it.

One USI register called USI_OPTION has reset value of 0x0. Because of
this the clock gating behavior is controlled by hardware (HWACG =
Hardware Auto Clock Gating), which simply means the serial won't work
after reset as is. In order to make it work, USI_OPTION[2:1] bits must
be set to 0b01, so that HWACG is controlled manually (by software).
Bits meaning:
  - CLKREQ_ON = 1: clock is continuously provided to IP
  - CLKSTOP_ON = 0: drive IP_CLKREQ to High (needs to be set along with
                    CLKREQ_ON = 1)

USI is not present on older chips, like s3c2410, s3c2412, s3c2440,
s3c6400, s5pv210, exynos5433, exynos4210. So the new boolean field
'.has_usi' was added to struct s3c24xx_uart_info. USI registers will be
only actually accessed when '.has_usi' field is set to "1".

This feature is needed for further serial enablement on Exynos850, but
some other new Exynos chips (like Exynos9810) may benefit from this
feature as well.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Non-intrusive modification of USI registers
  - Improved comments
  - Rearranged USI register definitions to conform with existing style

 drivers/tty/serial/samsung_tty.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/serial_s3c.h       |  9 +++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 9fbc61151c2e..b8034c1168e0 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -65,6 +65,7 @@ enum s3c24xx_port_type {
 struct s3c24xx_uart_info {
 	char			*name;
 	enum s3c24xx_port_type	type;
+	unsigned int		has_usi;
 	unsigned int		port_type;
 	unsigned int		fifosize;
 	unsigned long		rx_fifomask;
@@ -1352,6 +1353,28 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	return ret;
 }
 
+static void exynos_usi_init(struct uart_port *port)
+{
+	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	struct s3c24xx_uart_info *info = ourport->info;
+	unsigned int val;
+
+	if (!info->has_usi)
+		return;
+
+	/* Clear the software reset of USI block (it's set at startup) */
+	val = rd_regl(port, USI_CON);
+	val &= ~USI_CON_RESET_MASK;
+	wr_regl(port, USI_CON, val);
+	udelay(1);
+
+	/* Continuously provide the clock to USI IP w/o gating (for Rx mode) */
+	val = rd_regl(port, USI_OPTION);
+	val &= ~USI_OPTION_HWACG_MASK;
+	val |= USI_OPTION_HWACG_CLKREQ_ON;
+	wr_regl(port, USI_OPTION, val);
+}
+
 /* power power management control */
 
 static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
@@ -1379,6 +1402,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 		if (!IS_ERR(ourport->baudclk))
 			clk_prepare_enable(ourport->baudclk);
 
+		exynos_usi_init(port);
 		break;
 	default:
 		dev_err(port->dev, "s3c24xx_serial: unknown pm %d\n", level);
@@ -2102,6 +2126,8 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	if (ret)
 		pr_warn("uart: failed to enable baudclk\n");
 
+	exynos_usi_init(port);
+
 	/* Keep all interrupts masked and cleared */
 	switch (ourport->info->type) {
 	case TYPE_S3C6400:
@@ -2750,10 +2776,11 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 #endif
 
 #if defined(CONFIG_ARCH_EXYNOS)
-#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
+#define EXYNOS_COMMON_SERIAL_DRV_DATA_USI(_has_usi)		\
 	.info = &(struct s3c24xx_uart_info) {			\
 		.name		= "Samsung Exynos UART",	\
 		.type		= TYPE_S3C6400,			\
+		.has_usi	= _has_usi,			\
 		.port_type	= PORT_S3C6400,			\
 		.has_divslot	= 1,				\
 		.rx_fifomask	= S5PV210_UFSTAT_RXMASK,	\
@@ -2773,6 +2800,9 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
 		.has_fracval	= 1,				\
 	}							\
 
+#define EXYNOS_COMMON_SERIAL_DRV_DATA				\
+	EXYNOS_COMMON_SERIAL_DRV_DATA_USI(0)
+
 static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
 	EXYNOS_COMMON_SERIAL_DRV_DATA,
 	.fifosize = { 256, 64, 16, 16 },
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index f6c3323fc4c5..cf0de4a86640 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -27,6 +27,15 @@
 #define S3C2410_UERSTAT	  (0x14)
 #define S3C2410_UFSTAT	  (0x18)
 #define S3C2410_UMSTAT	  (0x1C)
+#define USI_CON		  (0xC4)
+#define USI_OPTION	  (0xC8)
+
+#define USI_CON_RESET			(1<<0)
+#define USI_CON_RESET_MASK		(1<<0)
+
+#define USI_OPTION_HWACG_CLKREQ_ON	(1<<1)
+#define USI_OPTION_HWACG_CLKSTOP_ON	(1<<2)
+#define USI_OPTION_HWACG_MASK		(3<<1)
 
 #define S3C2410_LCON_CFGMASK	  ((0xF<<3)|(0x3))
 
-- 
2.30.2

