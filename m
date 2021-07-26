Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79973D5BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhGZNtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhGZNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:49:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A599C0613CF;
        Mon, 26 Jul 2021 07:30:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b9so10492440wrx.12;
        Mon, 26 Jul 2021 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IL3Vn4zyfal3Jr+fqL7Fse86t3HrXoz8NQl9ywFZul8=;
        b=kPa8+8Wrtqw93n08n3FFVq85b0LSA9t2gVnBw52u9hleVRy8ctYQBZ0DuYgaNjmHRH
         8jz6BojeVO6F1iLK2psF4Mfihu84rykJpbYXiN403gS9KFNeFK9NtlbeqbQFSLqRzWli
         yf0cT+pc82+km586KPFj/Ll3G7jt5Ne2fHNxgIVlpeEB9S67HUalTOMmPOSL/9ts/uRW
         FUag3p5/Bipics4CnVMEs/CslKVjzw6KNLrNWCMcU+smAgSaw0lkjfL393og5oF9sjGI
         uWRLM+fDjCxptiaIb6suoUuSwEMCykkWlkaFiv1ByYgPvELA2Mo6bEJrbnloXOrJm92O
         JJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IL3Vn4zyfal3Jr+fqL7Fse86t3HrXoz8NQl9ywFZul8=;
        b=lWMDbRKwxp071dC5Gw9HcnVspodvI2mpG/LR/A19MDo1ZznK6sGU7oOICXLot36G73
         AY95OIkk3C17R6VJhEyZkBbizvBL3biSXPtFpqWdVsFBioK3jHSYeENrQfHuSc7+3G0/
         rPrf85jlH29fYMnlqpH0m29Ng1EdOqUy19A37etwD5j6BNjHK1PrDz7TM8lI5CdSZkoe
         KL/wLXuq7Vfr61AGyHKDEn+6VBBhBHPtt0D7PM9H4lINj1c4PrLYEOiXqSpn1TypV7+w
         kE86DjOdlemfSuTpbKp42gQPWngQ9EQrryW2dBV68FweOX14EU5okQKhKNgv13QS1PL/
         0hMg==
X-Gm-Message-State: AOAM530ORJVnTrAqx7+T+QV0U7ZjEr4eGTd51TyvcstCRbBc7wueHknN
        jmFYXX9fAaXJC7crjjTJHps=
X-Google-Smtp-Source: ABdhPJz/xEgTuELpxAUkHv6uEMz+nRsvgUK0m00w/9Y6GEGYkbY5UNPnabmcCN4/3TRwbQOLEeJqGA==
X-Received: by 2002:adf:b30a:: with SMTP id j10mr2304438wrd.43.1627309813665;
        Mon, 26 Jul 2021 07:30:13 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id o17sm9176609wmp.31.2021.07.26.07.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:30:13 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Deepak Saxena <dsaxena@plexity.net>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v3 4/8] MAINTAINERS: rectify entries with documentation-file-ref check
Date:   Mon, 26 Jul 2021 16:29:39 +0200
Message-Id: <20210726142943.27008-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
References: <20210726142943.27008-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of file entries can be automatically repaired with
./scripts/documentation-file-ref-check --fix.

The changes from this script were manually cross-checked for sanity.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd943be7375c..c5a407015e2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1488,7 +1488,7 @@ M:	Miquel Raynal <miquel.raynal@bootlin.com@bootlin.com>
 M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/mtd/arm,pl353-smc.yaml
+F:	Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
 F:	drivers/memory/pl353-smc.c
 
 ARM PRIMECELL CLCD PL110 DRIVER
@@ -1525,7 +1525,7 @@ ARM PRIMECELL VIC PL190/PL192 DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
 F:	drivers/irqchip/irq-vic.c
 
 ARM SMC WATCHDOG DRIVER
@@ -1850,7 +1850,7 @@ T:	git git://github.com/ulli-kroll/linux.git
 F:	Documentation/devicetree/bindings/arm/gemini.txt
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
-F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
+F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
 F:	arch/arm/boot/dts/gemini*
 F:	arch/arm/mach-gemini/
 F:	drivers/crypto/gemini/
@@ -8633,7 +8633,7 @@ Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next
 F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
-F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
+F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 
@@ -9410,7 +9410,7 @@ F:	include/linux/soc/ixp4xx/qmgr.h
 INTEL IXP4XX RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,ixp46x-rng.yaml
+F:	Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
 F:	drivers/char/hw_random/ixp4xx-rng.c
 
 INTEL KEEM BAY DRM DRIVER
@@ -13428,7 +13428,7 @@ M:	Mirela Rabulea <mirela.rabulea@nxp.com>
 R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/imx8-jpeg.yaml
+F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/imx-jpeg
 
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
@@ -18354,7 +18354,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
-F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
@@ -20381,7 +20381,7 @@ R:	Srinivas Neeli <srinivas.neeli@xilinx.com>
 R:	Michal Simek <michal.simek@xilinx.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
-F:	Documentation/devicetree/bindings/gpio/gpio-zynq.txt
+F:	Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
 F:	drivers/gpio/gpio-xilinx.c
 F:	drivers/gpio/gpio-zynq.c
 
-- 
2.17.1

