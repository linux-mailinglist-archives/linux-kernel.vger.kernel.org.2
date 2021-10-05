Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00E7421FE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhJEH51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhJEH5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD7DC061745;
        Tue,  5 Oct 2021 00:55:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m14-20020a05600c3b0e00b0030d4dffd04fso2160658wms.3;
        Tue, 05 Oct 2021 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pf84AIn9FjQpSRJFnQBCMelTEoJaH75pJ7KofEhQL+I=;
        b=RBQ+DO8IIzYP29+JTDV6BMZLBPaJ9csggF5Nvt7fpWdxrMhhRXQJ2uy5TEmtEXWH8I
         hHFVUdECpMlD7W0KvV0CW29VSimDd8BNVtjJqTKe/beHeSedfTEEY+lyTVZOP3EsSQcW
         o2i303wmL892TorCIHVL8kUCnHSq16PonmadhH08yIYeRQKzy+umpKnfDvX/upxpHNZc
         ZY7QCJPpmS8ruunnbn7UCpEpQrQQYIqiuo/UBoyIMo9tNiSrsFnJcypbQxYh7DS/mWOi
         0SdAp094L0g9bV94ULmGbq1nOQf4w4zCIoH/RFy0fAjrEHhLq5nEPgmgeUtBm473SHnK
         FXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pf84AIn9FjQpSRJFnQBCMelTEoJaH75pJ7KofEhQL+I=;
        b=mFf84F4tyzL3eLnyaed74PYf1nERcssy2Ntr0WxXa+VMJBSfNcbBAd0lbO5CmqcgR2
         XkYU6FyRRLvT9gRB+/4QhpdwirTPs5rl+ExHgZ634zO9fyFL8/UsFR8v8eZ5w6Oq1WO+
         kIXgMrS0SC1G/FZIKLtTse/EEuuHsKsvfC1rKAUTyGysHmNFDcH1ZLXKj0oYhOiEWsup
         8+l/UBR97/TB9sjndlxyLRG8PKZAFvHhnOm0cf2RXr6h/Z0OnuIpdP9QNhBN3DDqZkj3
         NYB6q4OFeLqr9Ow7x0Eq6wIUJJLEZVevTmK3zaqh4k1B9geLsluHDaWNsBNFrr97ZMAC
         fEaA==
X-Gm-Message-State: AOAM532BX+GK4C6gHYw+6xBT4uZZULUlg3mbAr1KyHTNtrprtximQ+Tr
        PZeaEl5bNi81oSMy4EQWYwY=
X-Google-Smtp-Source: ABdhPJz89isDx4oMXTdQdMlV5ArVR2wcf4Qv7dTcE9vaJz9g+8jAqeKHuBEfK3ErKjA4F/EYcDc3iQ==
X-Received: by 2002:a1c:158:: with SMTP id 85mr1787004wmb.187.1633420522106;
        Tue, 05 Oct 2021 00:55:22 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:21 -0700 (PDT)
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
Subject: [PATCH v4 06/11] MAINTAINERS: rectify entries to mtd-physmap.yaml
Date:   Tue,  5 Oct 2021 09:54:46 +0200
Message-Id: <20211005075451.29691-7-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
aggregated, amongst others, arm-versatile.txt and cypress,hyperflash.txt,
into mtd-physmap.yaml in ./Documentation/devicetree/bindings/mtd/.

The two .txt files are however mentioned in MAINTAINERS; hence,
./scripts/get_maintainer.pl --self-test=patterns complains about broken
references.

Refer to mtd-physmap.yaml, so that the maintainers and reviewers of
ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT and HYPERBUS SUPPORT are
informed on any changes in the yaml file.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9db2012ebae4..0650954f1570 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1427,7 +1427,7 @@ F:	Documentation/devicetree/bindings/auxdisplay/arm,versatile-lcd.yaml
 F:	Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-versatile.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
-F:	Documentation/devicetree/bindings/mtd/arm-versatile.txt
+F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 F:	arch/arm/boot/dts/arm-realview-*
 F:	arch/arm/boot/dts/integrator*
 F:	arch/arm/boot/dts/versatile*
@@ -8768,7 +8768,7 @@ S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
 C:	irc://irc.oftc.net/mtd
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next
-F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
+F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.yaml
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
-- 
2.26.2

