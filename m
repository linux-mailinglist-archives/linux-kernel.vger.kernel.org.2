Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4763472AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhCXHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:31:24 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36826 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhCXHa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:30:57 -0400
Received: by mail-lf1-f42.google.com with SMTP id n138so30479151lfa.3;
        Wed, 24 Mar 2021 00:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jl5sxaMxshBxOQhJcLRE6/WC1n/x+UyQBmzvk4vkGn8=;
        b=bS3jmY0K/HExWFVveQiZJxAp3XblHEG1084u2dltRZLR06B/yTfcBuvkF8L/or3Q26
         xBkSvV6QxYukAikrYr3MSPNM/KziVEy0K3qVETtxMsb9e3R0zlIqa5MHqNnUUuQfqXgg
         8x5v+W/Fy/laFhqFJ1GTyOziqnQWSuDcfuM2aq54hzAMmNJsCkpN9lokx1OCjl9KLSwj
         rh8ioPAqxG1uD5W8pdJLFv1gFxUudNECUKtb+xKY1XDp19aMNQDwtmKCcUH6Qu4YtJ53
         lLR6N3IF3CFe2LKrCUie1SzgslN4+81S3zMhHbcbk/PC/ToyQvbhgCeNmJHoVz7SnV56
         cTIA==
X-Gm-Message-State: AOAM530d10ND6bfR241r+hfCx+/j41nA1QdnNikp9Z6Nwm8MmrqAGAUe
        9yjsw7rebLREnmG5gR+MwYk=
X-Google-Smtp-Source: ABdhPJw3RXiDBBbtHavHzFrMiBa9VvBrPNvb/Fmg7wsK/2SgwZy5lIVPF/Z1lkneyWNkzDssvfXVNA==
X-Received: by 2002:ac2:41c4:: with SMTP id d4mr1145654lfi.334.1616571056205;
        Wed, 24 Mar 2021 00:30:56 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id c2sm43817lfc.221.2021.03.24.00.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:30:55 -0700 (PDT)
Date:   Wed, 24 Mar 2021 09:30:50 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-clk@vger.kernel.org
Subject: [PATCH v4 14/16] clk: bd718x7: Add support for clk gate on ROHM
 BD71815 PMIC
Message-ID: <c12cb5025529650ae79244e3c16fb4ae5a347d63.1616566395.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616566395.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616566395.git.matti.vaittinen@fi.rohmeurope.com>
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
