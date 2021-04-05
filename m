Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CA83541C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbhDELor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:44:47 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40601 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbhDELoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:44:46 -0400
Received: by mail-lj1-f181.google.com with SMTP id u10so12397713lju.7;
        Mon, 05 Apr 2021 04:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jl5sxaMxshBxOQhJcLRE6/WC1n/x+UyQBmzvk4vkGn8=;
        b=hh0dRZiWnJ+RXMFTLKMSN8aaeAe6Gov2iAEwNOs/qcDa4d1dx3tU7F86pqmTMoPrZ3
         rArVxksh6rMKPCwM8kGZ38GDqdBP7qcwRXebxaRcm+A7E99yG35E1c4+OYGjdTxGNPtk
         bGDBaVEp2pjrR2fBL94K1J37+2pjgt66ztl9YoYF9jnljoB2ScfWC35Qi1s7+SS1sRhQ
         uxLekul9E/PJa25shtdHqimwa1V1c3wTMih2oN1ZH2hKn8u6+QJxlPcGjmh9mklX277R
         DAEQoFBs7NMnUqGHQd1xIgopNPaqmAf2IxYZgBg/nvwmgk3G8nT84GM38O3PXSv6CJOj
         6MxQ==
X-Gm-Message-State: AOAM532xiqM55Ur12VJOp/jTPnCKSZZjywMA4wH8c+8a90Cd+YcvcCXk
        hJsOkMnY5MGp5cZ2yI//ab/VT8E0fhh3Og==
X-Google-Smtp-Source: ABdhPJyCLzvCNMCsAh12Lt+ZzywN+lZmNC3F5ZMwHiQ1mevY8l6sb/EdjyAyCmSR4AhynHkiBgzrYw==
X-Received: by 2002:a2e:8709:: with SMTP id m9mr15350651lji.483.1617623078755;
        Mon, 05 Apr 2021 04:44:38 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id x6sm1760899lfn.11.2021.04.05.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 04:44:38 -0700 (PDT)
Date:   Mon, 5 Apr 2021 14:44:32 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-clk@vger.kernel.org
Subject: [PATCH v6 14/16] clk: bd718x7: Add support for clk gate on ROHM
 BD71815 PMIC
Message-ID: <aa5f86959b7d1cad9a8132b252e7143673d352ba.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROHM BD71815 also provide clk signal for RTC. Add control
for gating this clock.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
Changes since v3:
 - No changes
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
