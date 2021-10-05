Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA03C421FEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhJEH5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhJEH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F019DC061745;
        Tue,  5 Oct 2021 00:55:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b136-20020a1c808e000000b0030d60716239so2117679wmd.4;
        Tue, 05 Oct 2021 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brZh1+Y4mHA/auO2EBCD5YPji97xxxj6RW4xNGX8ors=;
        b=mHx5qfHOatJkPOCvAdiuUIX1yNyMWnYxBBEsHai7TBt1glMEyd+3b4gUUvkccC3n+U
         QwfxDUQTWlId/CBwK46L+oRHCTxd9pHXARVsxC8YoHnKGK4l3Y1B99Rtfd9uf6jBTxpi
         sUjAJhKdF0VOrVCOUvq2S5t2LKHChQLNGJpWXhIqh45n64zEQ4u/Bz5XAADhMgOzyvRe
         Zgcvv1tI6+paPWAYnLA0KCKBg2kES2OnlCdt8AW5LBthfNuYbtO0/loRCHBbFpvBgtv2
         7bSYnIuKnky9A1AfOF3niEIPTeeVBdRTFpzQZM+I8zwkLTz9Bxi0LndLIHx+zbZtn/mB
         Ygaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brZh1+Y4mHA/auO2EBCD5YPji97xxxj6RW4xNGX8ors=;
        b=fZBOBUm6mEdQ/I2x3S1bY7aXh5B6RAt83WkHbTOcsoOAe3KQmxwNu2AhN09MCvALiM
         WW3yzyiQC3UzGiXXlPCU1KiP9RxIzcUB6spZYgbV3Plo4k8a9cz/mHwkkTLg7oLFj95o
         Ey19q0MZRBT75wuvpXogdGqyzoXW7X2yVHLNU04EqdTmRCQ4ut+sXTMSGQzps6jMQHR7
         TZISJjOJuaprEynwo48/HDl2ns6m/TJG6n/ojihr8lrq6FhkeiQZeVBI/riqz4opuCBT
         ljRttuA3UviZlpHbG43G3HPX3JHMTIXSr6/5WHECfdDeqIhhf6vLWtisilnykIVMAJUl
         m9kw==
X-Gm-Message-State: AOAM533Ey8qhVQLhOMiI6M0xGlVboFLb6crLjMK6Ti6NkYc9qgPhTYQC
        NoAvyJqIO0Rh7NdquN+7eBI=
X-Google-Smtp-Source: ABdhPJwIv0XwXYQoKg4et/C8qG54noBHCTk4D91AKyiqBvwcooJpdbo1NTDJtrjAgBgB6qnQG+DyfQ==
X-Received: by 2002:a05:600c:aca:: with SMTP id c10mr1821856wmr.174.1633420523465;
        Tue, 05 Oct 2021 00:55:23 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:23 -0700 (PDT)
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
Subject: [PATCH v4 07/11] MAINTAINERS: rectify entry for ARM/ASPEED I2C DRIVER
Date:   Tue,  5 Oct 2021 09:54:47 +0200
Message-Id: <20211005075451.29691-8-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 810e4441946c ("dt-bindings: aspeed-i2c: Convert txt to yaml format")
converts i2c-aspeed.txt to aspeed,i2c.yaml, but missed to adjust its
reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
a broken reference.

Rectify this file reference in ARM/ASPEED I2C DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0650954f1570..1337ba843f26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1762,7 +1762,7 @@ R:	Joel Stanley <joel@jms.id.au>
 L:	linux-i2c@vger.kernel.org
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+F:	Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
 F:	drivers/i2c/busses/i2c-aspeed.c
 F:	drivers/irqchip/irq-aspeed-i2c-ic.c
-- 
2.26.2

