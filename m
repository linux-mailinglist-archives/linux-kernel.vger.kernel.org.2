Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A844D421FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhJEH5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhJEH5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:57:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CDC06174E;
        Tue,  5 Oct 2021 00:55:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r18so8418711wrg.6;
        Tue, 05 Oct 2021 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWHTo+XRSGYiCKOh5BlWAncj+C5oL18K4OJn3wqBUvc=;
        b=RUaEq41QPmQWfIHjCKWg49PUmhqCDf5hxGVMgyL4NOZrhjIr2WhT2yYKzOEO86bCG8
         /Mwt255trIDzltwQJBPxf0IZxK5GgA1dJKiy7bxBeL6hyYq/VSg76ksmDgNY4yRQ4SkU
         e0HF3tlje7R7qKjMpacOdX1QqPLpp9Rx9ih/ypmwwIubewqbI1j1cKepIlwhAoxFvkNM
         1uybbCRV8OFY1MbKkjrPnvgKcs1J/6T3YDMwZwRswjpfYEYnOu1CreM5/OHtRWVzV6vV
         XVWVZsNkOWEqN2tQceKD5uGpFdehDRx272aCr9UPTF3fcBN5C59fAkP5wIWtjZOpquN1
         x2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWHTo+XRSGYiCKOh5BlWAncj+C5oL18K4OJn3wqBUvc=;
        b=U2UUKA3CZtOSn8OlkF90zoCGtyFZY0OSlY4769ALbyYr9rJ5XspbBbcf0zRfJtQeIu
         glHlHJJ1UhTDiPbr0bCxUE6wusHJBnWE4wio/SjB1AELcqYtN11e0waEUWiS6m0e1DQu
         JJJ2YaCd+eO3EKC7IA7OiP34maThA/tu/Ejgl9hTgukmxiSwekuOcYYSaf73fFkXvR5j
         VY9IcT2TrfKu7n/NshdIB+H2/PsT+af08m6fzS/QqdgdES3A5aA58p17/LWt1NK/sJmg
         IqWh3corw+4Uy2t8pJqvxH/YahMNTutx6A4C9etQkWoADZAFPLrRk8Dv1wk6jB0dkfz/
         dhZA==
X-Gm-Message-State: AOAM530kJBxyThRNp4+l5byaMYEpZP7YuHl4mxqFG4+lRId93+6jY587
        kTkUW95dbh1nH04+D/Krzgo=
X-Google-Smtp-Source: ABdhPJwHNge0HaFDWk+ufwEQCKuNYqjSnSSlZlTguVCiy4ZUE+hadlr1LwtRBAxvoDcij4G3nVFy3Q==
X-Received: by 2002:adf:a2c8:: with SMTP id t8mr19954663wra.215.1633420514015;
        Tue, 05 Oct 2021 00:55:14 -0700 (PDT)
Received: from localhost.localdomain (i59F67A83.versanet.de. [89.246.122.131])
        by smtp.gmail.com with ESMTPSA id o1sm1176984wmq.26.2021.10.05.00.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:55:13 -0700 (PDT)
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
Subject: [PATCH v4 02/11] MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
Date:   Tue,  5 Oct 2021 09:54:42 +0200
Message-Id: <20211005075451.29691-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
References: <20211005075451.29691-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB
gpio hub on Hikey960") refers to the non-existing file
./Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml, but this
commit's patch series does not add any related devicetree binding in misc.

So, just drop this file reference in HIKEY960 ONBOARD USB GPIO HUB DRIVER.

Fixes: 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB gpio hub on Hikey960")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2543b6344949..3eb7154df430 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8512,7 +8512,6 @@ M:	John Stultz <john.stultz@linaro.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
-F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
 
 HISILICON PMU DRIVER
 M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
-- 
2.26.2

