Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F6330B92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhCHKpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:45:34 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33200 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhCHKpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:45:12 -0500
Received: by mail-lf1-f45.google.com with SMTP id u4so20300913lfs.0;
        Mon, 08 Mar 2021 02:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QWSR6RBA7gvmEp5M9awnuof1OSKvGDBreH4WWr4K40I=;
        b=lHWqhnV3kiwp/15q/D5bus2uY4Q+GHevP2iBBWrfy9F88O4XU/qbO10Rn9Znktb307
         G0tEGGAX4bJFrh5QRfWAGsV/QLRAONgJyvQK9HVGj0ihq70iVhkQEH2sHIqOYwqp0zYr
         D3gs1Jk87jmas17hy3q2xIh1qVkpWkb3KWuP4F+7dlMnEyUK06LNYSSor6jKodqSyjXJ
         bNoycVfy95DLZoyw+I4d+R9D7+iz4gkLpj8Qyr1a1mthY+I9oATqCGrEFUrd6SOJDDfn
         L1X4QhrCUroEaPViid6nZyXTH7HMRj0xVfURdzjAYxg9HH+0j1OVNXepI38SoauncFdY
         zS5A==
X-Gm-Message-State: AOAM533cozm43UYbG9r3s34WaBmUuWgQt16VQIl5H0TkyeS06Ysn98Z1
        rJAyDif7VT0Zbmur5n2hl24=
X-Google-Smtp-Source: ABdhPJxCUKoN6YM1+awNw8Cejd7GpbJmtF+n5Rf1NizdTGSUO3PmrAQ+h5JT/4QE0hAkaLLLmWUojA==
X-Received: by 2002:ac2:4859:: with SMTP id 25mr13882802lfy.243.1615200311160;
        Mon, 08 Mar 2021 02:45:11 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id i8sm814996lfc.115.2021.03.08.02.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:45:10 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:45:04 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-clk@vger.kernel.org
Subject: [PATCH v3 13/15] clk: bd718x7: Add support for clk gate on ROHM
 BD71815 PMIC
Message-ID: <bbe0f311cc1b84be9a1684ff30931801420de73b.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD71815 also provide clk signal for RTC. Add control
for gating this clock.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-bd718x7.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index 17d90e09f1c0..d9e70e506d18 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -13,6 +13,8 @@
 #include <linux/regmap.h>
 
 /* clk control registers */
+/* BD71815 */
+#define BD71815_REG_OUT32K	0x1d
 /* BD70528 */
 #define BD70528_REG_OUT32K	0x2c
 /* BD71828 */
@@ -118,6 +120,10 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 		c->reg = BD70528_REG_OUT32K;
 		c->mask = CLK_OUT_EN_MASK;
 		break;
+	case ROHM_CHIP_TYPE_BD71815:
+		c->reg = BD71815_REG_OUT32K;
+		c->mask = CLK_OUT_EN_MASK;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown clk chip\n");
 		return -EINVAL;
@@ -146,6 +152,7 @@ static const struct platform_device_id bd718x7_clk_id[] = {
 	{ "bd71847-clk", ROHM_CHIP_TYPE_BD71847 },
 	{ "bd70528-clk", ROHM_CHIP_TYPE_BD70528 },
 	{ "bd71828-clk", ROHM_CHIP_TYPE_BD71828 },
+	{ "bd71815-clk", ROHM_CHIP_TYPE_BD71815 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd718x7_clk_id);
@@ -161,6 +168,6 @@ static struct platform_driver bd71837_clk = {
 module_platform_driver(bd71837_clk);
 
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD71837/BD71847/BD70528 chip clk driver");
+MODULE_DESCRIPTION("BD718(15/18/28/37/47/50) and BD70528 chip clk driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:bd718xx-clk");
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
