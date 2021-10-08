Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D114269F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbhJHLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:44:54 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33728
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241431AbhJHLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:42:06 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E61EF4001C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633693085;
        bh=dPbx/8KTnDIjXlUljsgyPIndd3ltzWoSPxnPkixkLcA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nzWk1tkyuctkocE4GnQ4WKi1srWENcRMtVzdLNBvzwUZ+1AEG8whtJRW5rA9Ldwgx
         37cY4EWD8T71RJKOXcEf0tFaSxzHX+kMsgtzCHSxfJBmJCRs8tIjZJQ9P5azY97wX4
         FJvp7Dnd3sYxAFwDfYpohbTKVwATjlb2rioBcbFKhFfRV/9JffZDePaoO8KLJxatp2
         IeKDofp/tmQocepuF2UFlThCOOzY5OBKtILnE6D37VWdf0JDho1mmmm7CvH9Kdft9c
         0KairdhcyjbiFR909AqbuhyV6PIxjtGaS8GiW3cbgfDai6/dDzGmk1afOFkHmPCy5z
         fbH+mWxnjKzpA==
Received: by mail-ed1-f70.google.com with SMTP id t28-20020a508d5c000000b003dad7fc5caeso8901081edt.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 04:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPbx/8KTnDIjXlUljsgyPIndd3ltzWoSPxnPkixkLcA=;
        b=iMylHK25ci3Ievpk7KMRyTQ+dPB97+XesZFQh+0dKlJU8pYG6v649xVbAussF7268o
         Sq0d6qwunboRxzUrJiAgG5bgaljgDcb7PNRcVsQkePJqkrlQ1ceUVfTzjdsXg9N+e/Dv
         LRBpKKav2ubY13ghahHoFAj8Lmo0GVBeiplBUH2JgqAHa41TBWucYSSTctZOmXrR0Un2
         eGkUP9wxQ7bPRY+PZlOTcHf370xDaiGeKkPmMjnoPO+uXEovudChBpEKnVGpHm951GkT
         XohSuwOPLs2AO0Ge35H/y+i06vJ3i7iPyjI7DY+htZdvyM1OI1sj8c7swF+SKnofPTL5
         nDNA==
X-Gm-Message-State: AOAM531tGFl6cv+ew6ZRJVcQAn2f2bbiDHSEVVDqc0jzOFCgRjWMiwRc
        rNSydNxhQ+btLGbjXfrKgf6432TS+3mMOeJAcwriqmsNoQ8OD/TNv85y2HEBwjNPh6nhc3ikd2r
        Xe5lD4z/hBgkcJCLrTb3bG5nKCrA0InWf0+HagYRyLw==
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr2338829edw.292.1633693085381;
        Fri, 08 Oct 2021 04:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOlAJw7zauZzWriZ0crHhFAPxfzn+yNlPi5vhsqurYP6ugB3/qYjw/x2eqYNLssDiZdRHb3g==
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr2338797edw.292.1633693085071;
        Fri, 08 Oct 2021 04:38:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id la1sm819948ejc.48.2021.10.08.04.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 04:38:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>, stable@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 01/10] regulator: s5m8767: do not use reset value as DVS voltage if GPIO DVS is disabled
Date:   Fri,  8 Oct 2021 13:37:13 +0200
Message-Id: <20211008113723.134648-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
References: <20211008113723.134648-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver and its bindings, before commit 04f9f068a619 ("regulator:
s5m8767: Modify parsing method of the voltage table of buck2/3/4") were
requiring to provide at least one safe/default voltage for DVS registers
if DVS GPIO is not being enabled.

IOW, if s5m8767,pmic-buck2-uses-gpio-dvs is missing, the
s5m8767,pmic-buck2-dvs-voltage should still be present and contain one
voltage.

This requirement was coming from driver behavior matching this condition
(none of DVS GPIO is enabled): it was always initializing the DVS
selector pins to 0 and keeping the DVS enable setting at reset value
(enabled).  Therefore if none of DVS GPIO is enabled in devicetree,
driver was configuring the first DVS voltage for buck[234].

Mentioned commit 04f9f068a619 ("regulator: s5m8767: Modify parsing
method of the voltage table of buck2/3/4") broke it because DVS voltage
won't be parsed from devicetree if DVS GPIO is not enabled.  After the
change, driver will configure bucks to use the register reset value as
voltage which might have unpleasant effects.

Fix this by relaxing the bindings constrain: if DVS GPIO is not enabled
in devicetree (therefore DVS voltage is also not parsed), explicitly
disable it.

Cc: <stable@vger.kernel.org>
Fixes: 04f9f068a619 ("regulator: s5m8767: Modify parsing method of the voltage table of buck2/3/4")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/regulator/samsung,s5m8767.txt    | 21 +++++++------------
 drivers/regulator/s5m8767.c                   | 21 ++++++++-----------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
index 093edda0c8df..d9cff1614f7a 100644
--- a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
+++ b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.txt
@@ -13,6 +13,14 @@ common regulator binding documented in:
 
 
 Required properties of the main device node (the parent!):
+ - s5m8767,pmic-buck-ds-gpios: GPIO specifiers for three host gpio's used
+   for selecting GPIO DVS lines. It is one-to-one mapped to dvs gpio lines.
+
+ [1] If either of the 's5m8767,pmic-buck[2/3/4]-uses-gpio-dvs' optional
+     property is specified, then all the eight voltage values for the
+     's5m8767,pmic-buck[2/3/4]-dvs-voltage' should be specified.
+
+Optional properties of the main device node (the parent!):
  - s5m8767,pmic-buck2-dvs-voltage: A set of 8 voltage values in micro-volt (uV)
    units for buck2 when changing voltage using gpio dvs. Refer to [1] below
    for additional information.
@@ -25,19 +33,6 @@ Required properties of the main device node (the parent!):
    units for buck4 when changing voltage using gpio dvs. Refer to [1] below
    for additional information.
 
- - s5m8767,pmic-buck-ds-gpios: GPIO specifiers for three host gpio's used
-   for selecting GPIO DVS lines. It is one-to-one mapped to dvs gpio lines.
-
- [1] If none of the 's5m8767,pmic-buck[2/3/4]-uses-gpio-dvs' optional
-     property is specified, the 's5m8767,pmic-buck[2/3/4]-dvs-voltage'
-     property should specify atleast one voltage level (which would be a
-     safe operating voltage).
-
-     If either of the 's5m8767,pmic-buck[2/3/4]-uses-gpio-dvs' optional
-     property is specified, then all the eight voltage values for the
-     's5m8767,pmic-buck[2/3/4]-dvs-voltage' should be specified.
-
-Optional properties of the main device node (the parent!):
  - s5m8767,pmic-buck2-uses-gpio-dvs: 'buck2' can be controlled by gpio dvs.
  - s5m8767,pmic-buck3-uses-gpio-dvs: 'buck3' can be controlled by gpio dvs.
  - s5m8767,pmic-buck4-uses-gpio-dvs: 'buck4' can be controlled by gpio dvs.
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 7c111bbdc2af..35269f998210 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -850,18 +850,15 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 	/* DS4 GPIO */
 	gpio_direction_output(pdata->buck_ds[2], 0x0);
 
-	if (pdata->buck2_gpiodvs || pdata->buck3_gpiodvs ||
-	   pdata->buck4_gpiodvs) {
-		regmap_update_bits(s5m8767->iodev->regmap_pmic,
-				S5M8767_REG_BUCK2CTRL, 1 << 1,
-				(pdata->buck2_gpiodvs) ? (1 << 1) : (0 << 1));
-		regmap_update_bits(s5m8767->iodev->regmap_pmic,
-				S5M8767_REG_BUCK3CTRL, 1 << 1,
-				(pdata->buck3_gpiodvs) ? (1 << 1) : (0 << 1));
-		regmap_update_bits(s5m8767->iodev->regmap_pmic,
-				S5M8767_REG_BUCK4CTRL, 1 << 1,
-				(pdata->buck4_gpiodvs) ? (1 << 1) : (0 << 1));
-	}
+	regmap_update_bits(s5m8767->iodev->regmap_pmic,
+			   S5M8767_REG_BUCK2CTRL, 1 << 1,
+			   (pdata->buck2_gpiodvs) ? (1 << 1) : (0 << 1));
+	regmap_update_bits(s5m8767->iodev->regmap_pmic,
+			   S5M8767_REG_BUCK3CTRL, 1 << 1,
+			   (pdata->buck3_gpiodvs) ? (1 << 1) : (0 << 1));
+	regmap_update_bits(s5m8767->iodev->regmap_pmic,
+			   S5M8767_REG_BUCK4CTRL, 1 << 1,
+			   (pdata->buck4_gpiodvs) ? (1 << 1) : (0 << 1));
 
 	/* Initialize GPIO DVS registers */
 	for (i = 0; i < 8; i++) {
-- 
2.30.2

