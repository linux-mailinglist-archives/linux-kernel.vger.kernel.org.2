Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD8A421FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhJEH5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhJEH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D6EC06174E;
        Tue,  5 Oct 2021 00:55:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j10-20020a1c230a000000b0030d523b6693so2155407wmj.2;
        Tue, 05 Oct 2021 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cs7yL1yesYeQIrYbGC+FwZ8CROeborq06P53sikC5fs=;
        b=gE9knev2IDasksSDYG6MpLzX9s+OcdLhHfmCJz80x2K14/oXXFl6RaAcE1WrigvhZ1
         SckG+zOgwO9zBhgISokBLd9pcj3yhZM/IJAnN+87nQDDxFraF85IumjKvRwpvqMkIvu8
         xkN0kVkF+XuDtmIJ7rNBAwEH0nP9OEDO5Qii1wcKyf/xPdm7BBWJMysP++OUZNMC13CB
         Aygmg+xgLE4qhyePaKT4E9mD771ZWzCw2XlJbqzReoP1A850hqIoFI9qGoWVh1DgIdfj
         6GX5C2vkzpK3J11WXBDEdGiAJQymze5cLf0HgQhgvlmxQc03eBJTbs12W2LZJXVf9eA7
         q+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cs7yL1yesYeQIrYbGC+FwZ8CROeborq06P53sikC5fs=;
        b=n4xkHfdHIc37JogiHQw7eVJPJGLUS1wLUqsEfXBl4KGQFZXSHeMdFUoDVGYk9kOJLr
         WrynSPrEvEqosk0vL7WRxVMew9d44TQxHnhta8l5qbA7jXnD35eHKGlY1vM9+Agy59Dg
         1Z2ocmMJeEq1QCRDthUIW3R8tkpGbkJszvgBam+foSXiqs7d8+C2cx/y2p45G9MscUMF
         hOGg2ZoiRo5VGwuPoLi6sLdYnO2Kx5shkXm1hckWq60ACWYRaugGkd5eSn3/VOyulvTi
         IHYxLSJtUMcLrp/wM8ZZyb5qRY9uY+hmbRKetWEv8z1nZpmjP0qJCLQSNBvD7D8q3jcC
         d0kA==
X-Gm-Message-State: AOAM5323hhhbYEJyQh461eQWMAvI7/ia67aJlHKM7NLSRnSTgfZnh4o7
        PztZnw2Il7awKCwRagNTdXQ=
X-Google-Smtp-Source: ABdhPJwg/ONyDw+lvreHNf3aoTXXadwZJA7I+YEfssPCZ3Td9bOO3v68PjbfVRu9R+08qR843xYSpQ==
X-Received: by 2002:a05:600c:210d:: with SMTP id u13mr1839931wml.146.1633420519584;
        Tue, 05 Oct 2021 00:55:19 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:19 -0700 (PDT)
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
        Maxime Ripard <maxime@cerno.tech>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v4 04/11] MAINTAINERS: rectify entries with documentation-file-ref check
Date:   Tue,  5 Oct 2021 09:54:44 +0200
Message-Id: <20211005075451.29691-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of file entries can be automatically repaired with
./scripts/documentation-file-ref-check --fix.

The changes from this script were manually cross-checked for sanity.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com> # for nxp,imx8-jpeg.yaml
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15cb81c935e3..09c166e2a239 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1566,7 +1566,7 @@ ARM PRIMECELL VIC PL190/PL192 DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
 F:	drivers/irqchip/irq-vic.c
 
 ARM SMC WATCHDOG DRIVER
@@ -1892,7 +1892,7 @@ T:	git git://github.com/ulli-kroll/linux.git
 F:	Documentation/devicetree/bindings/arm/gemini.txt
 F:	Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
 F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
-F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
+F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
 F:	arch/arm/boot/dts/gemini*
 F:	arch/arm/mach-gemini/
 F:	drivers/crypto/gemini/
@@ -8769,7 +8769,7 @@ Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next
 F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
-F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
+F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 
@@ -9559,7 +9559,7 @@ F:	include/linux/soc/ixp4xx/qmgr.h
 INTEL IXP4XX RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/intel,ixp46x-rng.yaml
+F:	Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml
 F:	drivers/char/hw_random/ixp4xx-rng.c
 
 INTEL KEEM BAY DRM DRIVER
@@ -13612,7 +13612,7 @@ M:	Mirela Rabulea <mirela.rabulea@nxp.com>
 R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/imx8-jpeg.yaml
+F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
 F:	drivers/media/platform/imx-jpeg
 
 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
@@ -18619,7 +18619,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
-F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
-- 
2.26.2

