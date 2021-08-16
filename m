Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4B3ED993
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhHPPMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHPPMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:12:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE3C061764;
        Mon, 16 Aug 2021 08:11:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so5180160wrn.3;
        Mon, 16 Aug 2021 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i91Xnqm0s2YZ0wkXrlBd/CQ8uFNBQwcWmTXkV70rIO8=;
        b=mXdRnI5akKj/2CuINhEgUlHbpAoHAZSDRJnbwmVbtvgPXfvFUxvuDBqWx1tpiytRHU
         5aD9IqSBD0sZRqy47eQrp92oOibMRpkkBVnR9rdT3AACT9S7b6dlRRsyNK8EF9+hLjjO
         X4KaLVLHWjj1ADCuP6J1uh4k/I6OdK51pGNMQqgQFnr7whdYILGYdgtqVToIXihW/rML
         e0FQ834UrzX1Hp06QfMTAmpFB7qg6jRaaB1j4jJKK1Iu/zikRKZiHT2dKor66bSMzh0f
         JReTYPq/Zx4PBaK5VhBXkp/sEM8M1C0lQfFnlG7MSoiJERbhfSLrvosnhG3yuPUKHqMz
         XDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i91Xnqm0s2YZ0wkXrlBd/CQ8uFNBQwcWmTXkV70rIO8=;
        b=hCfh0wJ+NbDYioU6iTB71Qt8UN5U2b4UyQOSJ9haCov9K5U0yCamUw5gUiaXG7ab29
         rw7rb8mgNNwCWyNX30jgYs0fJcIVRfPB6OUhlasAajgI1w3CwyCbYFSNCEm0hTRsPQn0
         DcghdXULcmF9fILyffzsH/6De0qOM6ts/cphpG31KsBhFRDbakrQDrMAgjG+kn9KzQiy
         22DXTDFpQ/1ClHDO3ife0NHLc2QKdrZS6Un7HehjVnmSEZjQWpHYNRX9aLWlEIDIcQ2Q
         CsC5fCdMRqRUKYMqeNetLbTUiOyeHklBQQ/8bztF7+bDI63+5BdeAQcqZQ0hxClRzEVm
         isYA==
X-Gm-Message-State: AOAM533ob1JdZL4t9f2LVrXqWPhtOc8LhuHvzo0mn7H8IepTPnZDC5bx
        icNbm0vE4mu4H1MhydSQhols0SThfxI=
X-Google-Smtp-Source: ABdhPJyrIFmc2g7RMEQbjesHou0XyfLg8Uy6JrHQ6MaqqmM5XtDs8yBL0ugBNJRt7ZgZ/GO0FZCpGA==
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr18905085wrq.355.1629126695647;
        Mon, 16 Aug 2021 08:11:35 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id w14sm11795011wrt.23.2021.08.16.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:11:35 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] pcmcia: clean up dead drivers for CompuLab CM-X255/CM-X270 boards
Date:   Mon, 16 Aug 2021 17:01:15 +0200
Message-Id: <20210816150115.12889-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9d3239147d6d ("ARM: pxa: remove Compulab pxa2xx boards") removes
the config MACH_ARMCORE in ./arch/arm/mach-pxa/Kconfig.

Hence, ./scripts/checkkconfigsymbols.py warns on non-existing configs:

MACH_ARMCORE
Referencing files: drivers/pcmcia/Kconfig, drivers/pcmcia/Makefile

Clean up the dead remains of pcmcia drivers for Compulab pxa2xx boards.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/pcmcia/Kconfig          |   2 +-
 drivers/pcmcia/Makefile         |   2 -
 drivers/pcmcia/pxa2xx_cm_x255.c | 124 --------------------------------
 drivers/pcmcia/pxa2xx_cm_x270.c | 103 --------------------------
 drivers/pcmcia/pxa2xx_cm_x2xx.c |  44 ------------
 5 files changed, 1 insertion(+), 274 deletions(-)
 delete mode 100644 drivers/pcmcia/pxa2xx_cm_x255.c
 delete mode 100644 drivers/pcmcia/pxa2xx_cm_x270.c
 delete mode 100644 drivers/pcmcia/pxa2xx_cm_x2xx.c

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index d13b8d1a780a..ab53eab635f6 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -209,7 +209,7 @@ config PCMCIA_PXA2XX
 	tristate "PXA2xx support"
 	depends on ARM && ARCH_PXA && PCMCIA
 	depends on (ARCH_LUBBOCK || MACH_MAINSTONE || PXA_SHARPSL \
-		    || MACH_ARMCORE || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
+		    || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
 		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2 \
 		    || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI \
 		    || MACH_COLIBRI320 || MACH_H4700)
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index d82c07c4806b..2d5657cfc49c 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -48,10 +48,8 @@ sa1100_cs-$(CONFIG_SA1100_H3100)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_SIMPAD)		+= sa1100_simpad.o
 
-pxa2xx_cm_x2xx_cs-y				+= pxa2xx_cm_x2xx.o pxa2xx_cm_x255.o pxa2xx_cm_x270.o
 pxa2xx-obj-$(CONFIG_MACH_MAINSTONE)		+= pxa2xx_mainstone.o
 pxa2xx-obj-$(CONFIG_PXA_SHARPSL)		+= pxa2xx_sharpsl.o
-pxa2xx-obj-$(CONFIG_MACH_ARMCORE)		+= pxa2xx_cm_x2xx_cs.o
 pxa2xx-obj-$(CONFIG_ARCOM_PCMCIA)		+= pxa2xx_viper.o
 pxa2xx-obj-$(CONFIG_TRIZEPS_PCMCIA)		+= pxa2xx_trizeps4.o
 pxa2xx-obj-$(CONFIG_MACH_PALMTX)		+= pxa2xx_palmtx.o
diff --git a/drivers/pcmcia/pxa2xx_cm_x255.c b/drivers/pcmcia/pxa2xx_cm_x255.c
deleted file mode 100644
index c0b6b846fbaa..000000000000
--- a/drivers/pcmcia/pxa2xx_cm_x255.c
+++ /dev/null
@@ -1,124 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/drivers/pcmcia/pxa/pxa_cm_x255.c
- *
- * Compulab Ltd., 2003, 2007, 2008
- * Mike Rapoport <mike@compulab.co.il>
- */
-
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/export.h>
-
-#include "soc_common.h"
-
-#define GPIO_PCMCIA_SKTSEL	(54)
-#define GPIO_PCMCIA_S0_CD_VALID	(16)
-#define GPIO_PCMCIA_S1_CD_VALID	(17)
-#define GPIO_PCMCIA_S0_RDYINT	(6)
-#define GPIO_PCMCIA_S1_RDYINT	(8)
-#define GPIO_PCMCIA_RESET	(9)
-
-static int cmx255_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
-{
-	int ret = gpio_request(GPIO_PCMCIA_RESET, "PCCard reset");
-	if (ret)
-		return ret;
-	gpio_direction_output(GPIO_PCMCIA_RESET, 0);
-
-	if (skt->nr == 0) {
-		skt->stat[SOC_STAT_CD].gpio = GPIO_PCMCIA_S0_CD_VALID;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA0 CD";
-		skt->stat[SOC_STAT_RDY].gpio = GPIO_PCMCIA_S0_RDYINT;
-		skt->stat[SOC_STAT_RDY].name = "PCMCIA0 RDY";
-	} else {
-		skt->stat[SOC_STAT_CD].gpio = GPIO_PCMCIA_S1_CD_VALID;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA1 CD";
-		skt->stat[SOC_STAT_RDY].gpio = GPIO_PCMCIA_S1_RDYINT;
-		skt->stat[SOC_STAT_RDY].name = "PCMCIA1 RDY";
-	}
-
-	return 0;
-}
-
-static void cmx255_pcmcia_shutdown(struct soc_pcmcia_socket *skt)
-{
-	gpio_free(GPIO_PCMCIA_RESET);
-}
-
-
-static void cmx255_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
-				       struct pcmcia_state *state)
-{
-	state->vs_3v  = 0;
-	state->vs_Xv  = 0;
-}
-
-
-static int cmx255_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
-					  const socket_state_t *state)
-{
-	switch (skt->nr) {
-	case 0:
-		if (state->flags & SS_RESET) {
-			gpio_set_value(GPIO_PCMCIA_SKTSEL, 0);
-			udelay(1);
-			gpio_set_value(GPIO_PCMCIA_RESET, 1);
-			udelay(10);
-			gpio_set_value(GPIO_PCMCIA_RESET, 0);
-		}
-		break;
-	case 1:
-		if (state->flags & SS_RESET) {
-			gpio_set_value(GPIO_PCMCIA_SKTSEL, 1);
-			udelay(1);
-			gpio_set_value(GPIO_PCMCIA_RESET, 1);
-			udelay(10);
-			gpio_set_value(GPIO_PCMCIA_RESET, 0);
-		}
-		break;
-	}
-
-	return 0;
-}
-
-static struct pcmcia_low_level cmx255_pcmcia_ops __initdata = {
-	.owner			= THIS_MODULE,
-	.hw_init		= cmx255_pcmcia_hw_init,
-	.hw_shutdown		= cmx255_pcmcia_shutdown,
-	.socket_state		= cmx255_pcmcia_socket_state,
-	.configure_socket	= cmx255_pcmcia_configure_socket,
-	.nr			= 1,
-};
-
-static struct platform_device *cmx255_pcmcia_device;
-
-int __init cmx255_pcmcia_init(void)
-{
-	int ret;
-
-	cmx255_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia", -1);
-
-	if (!cmx255_pcmcia_device)
-		return -ENOMEM;
-
-	ret = platform_device_add_data(cmx255_pcmcia_device, &cmx255_pcmcia_ops,
-				       sizeof(cmx255_pcmcia_ops));
-
-	if (ret == 0) {
-		printk(KERN_INFO "Registering cm-x255 PCMCIA interface.\n");
-		ret = platform_device_add(cmx255_pcmcia_device);
-	}
-
-	if (ret)
-		platform_device_put(cmx255_pcmcia_device);
-
-	return ret;
-}
-
-void __exit cmx255_pcmcia_exit(void)
-{
-	platform_device_unregister(cmx255_pcmcia_device);
-}
diff --git a/drivers/pcmcia/pxa2xx_cm_x270.c b/drivers/pcmcia/pxa2xx_cm_x270.c
deleted file mode 100644
index 36e35da5f887..000000000000
--- a/drivers/pcmcia/pxa2xx_cm_x270.c
+++ /dev/null
@@ -1,103 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/drivers/pcmcia/pxa/pxa_cm_x270.c
- *
- * Compulab Ltd., 2003, 2007, 2008
- * Mike Rapoport <mike@compulab.co.il>
- */
-
-#include <linux/platform_device.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/export.h>
-
-#include "soc_common.h"
-
-#define GPIO_PCMCIA_S0_CD_VALID	(84)
-#define GPIO_PCMCIA_S0_RDYINT	(82)
-#define GPIO_PCMCIA_RESET	(53)
-
-static int cmx270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
-{
-	int ret = gpio_request(GPIO_PCMCIA_RESET, "PCCard reset");
-	if (ret)
-		return ret;
-	gpio_direction_output(GPIO_PCMCIA_RESET, 0);
-
-	skt->stat[SOC_STAT_CD].gpio = GPIO_PCMCIA_S0_CD_VALID;
-	skt->stat[SOC_STAT_CD].name = "PCMCIA0 CD";
-	skt->stat[SOC_STAT_RDY].gpio = GPIO_PCMCIA_S0_RDYINT;
-	skt->stat[SOC_STAT_RDY].name = "PCMCIA0 RDY";
-
-	return ret;
-}
-
-static void cmx270_pcmcia_shutdown(struct soc_pcmcia_socket *skt)
-{
-	gpio_free(GPIO_PCMCIA_RESET);
-}
-
-
-static void cmx270_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
-				       struct pcmcia_state *state)
-{
-	state->vs_3v  = 0;
-	state->vs_Xv  = 0;
-}
-
-
-static int cmx270_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
-					  const socket_state_t *state)
-{
-	switch (skt->nr) {
-	case 0:
-		if (state->flags & SS_RESET) {
-			gpio_set_value(GPIO_PCMCIA_RESET, 1);
-			udelay(10);
-			gpio_set_value(GPIO_PCMCIA_RESET, 0);
-		}
-		break;
-	}
-
-	return 0;
-}
-
-static struct pcmcia_low_level cmx270_pcmcia_ops __initdata = {
-	.owner			= THIS_MODULE,
-	.hw_init		= cmx270_pcmcia_hw_init,
-	.hw_shutdown		= cmx270_pcmcia_shutdown,
-	.socket_state		= cmx270_pcmcia_socket_state,
-	.configure_socket	= cmx270_pcmcia_configure_socket,
-	.nr			= 1,
-};
-
-static struct platform_device *cmx270_pcmcia_device;
-
-int __init cmx270_pcmcia_init(void)
-{
-	int ret;
-
-	cmx270_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia", -1);
-
-	if (!cmx270_pcmcia_device)
-		return -ENOMEM;
-
-	ret = platform_device_add_data(cmx270_pcmcia_device, &cmx270_pcmcia_ops,
-				       sizeof(cmx270_pcmcia_ops));
-
-	if (ret == 0) {
-		printk(KERN_INFO "Registering cm-x270 PCMCIA interface.\n");
-		ret = platform_device_add(cmx270_pcmcia_device);
-	}
-
-	if (ret)
-		platform_device_put(cmx270_pcmcia_device);
-
-	return ret;
-}
-
-void __exit cmx270_pcmcia_exit(void)
-{
-	platform_device_unregister(cmx270_pcmcia_device);
-}
diff --git a/drivers/pcmcia/pxa2xx_cm_x2xx.c b/drivers/pcmcia/pxa2xx_cm_x2xx.c
deleted file mode 100644
index 14eae238131d..000000000000
--- a/drivers/pcmcia/pxa2xx_cm_x2xx.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/drivers/pcmcia/pxa/pxa_cm_x2xx.c
- *
- * Compulab Ltd., 2003, 2007, 2008
- * Mike Rapoport <mike@compulab.co.il>
- */
-
-#include <linux/module.h>
-
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
-
-int cmx255_pcmcia_init(void);
-int cmx270_pcmcia_init(void);
-void cmx255_pcmcia_exit(void);
-void cmx270_pcmcia_exit(void);
-
-static int __init cmx2xx_pcmcia_init(void)
-{
-	int ret = -ENODEV;
-
-	if (machine_is_armcore() && cpu_is_pxa25x())
-		ret = cmx255_pcmcia_init();
-	else if (machine_is_armcore() && cpu_is_pxa27x())
-		ret = cmx270_pcmcia_init();
-
-	return ret;
-}
-
-static void __exit cmx2xx_pcmcia_exit(void)
-{
-	if (machine_is_armcore() && cpu_is_pxa25x())
-		cmx255_pcmcia_exit();
-	else if (machine_is_armcore() && cpu_is_pxa27x())
-		cmx270_pcmcia_exit();
-}
-
-module_init(cmx2xx_pcmcia_init);
-module_exit(cmx2xx_pcmcia_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_DESCRIPTION("CM-x2xx PCMCIA driver");
-- 
2.26.2

