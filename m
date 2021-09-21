Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEAC4137D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhIUQxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhIUQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:53:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D80C061767
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:51:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i4so184393lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnVNJWxdJp/O3yNbbRJ7mIEi/fwxJdU+PF6KUrC9rVE=;
        b=1OTLWhIAZbw98TXwD1Gw/0gnV9IeA5sInhq86eCw9rH28Kbkiby2P26MPUY9DRxksS
         zlbL/p3GesEAjDdOaksgIZQAA0WwGATzjmt/mXlTfbFHjmPmFeX1uwfsbRy2K3N7Wkxy
         gV/xFk+5MOFhhvqS254pfPNL+/wxlTmx9pf/fen67K0zC2XO1kVbBHW+MhyK3WYVfL1X
         UakBHRuKYs5bXOQlr2sHsxnNQBp7PUfH0guzUQoDW78HpcPcHgCOTRjZ4CJmrKJfTZws
         LvK6Qo6dIdQcCf68YaB7EPCuGpsw5sauXQTAqmS5LIjCS2opMw7dg2rH/7VNrwXZZt5A
         ywfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnVNJWxdJp/O3yNbbRJ7mIEi/fwxJdU+PF6KUrC9rVE=;
        b=LlyWQwgK67N611Frj1+zg1as6AqJiYyvMTbMhnmeJUq39nmTKi4Nqt3zQ09GrsEjEl
         RYFyPzd3kz1o7GDTOny0dLx6DCyeKIUD1k0Li5PRje6mA5Dvoz2YdXDUICMyrE/TT7Qq
         qvgy0QPkQsHsMhH0Lp/i64ttHrPo4qIFD9zKey0A7dbWpUImFdEPnfWalDHBYX7e69/1
         zm/QfNDU5u7+2dI7FQ4bQ/56crgS4ZSSRQzwKOdNOr898YaFUDXgWNkZ0a7WgYWTcl6f
         xv/fK+bWJdV93tmcCqktVRXbYMHok8wohpnqXVzTVklH/G/mik4uiBkQ8ISBAbC2u+SQ
         Jc3g==
X-Gm-Message-State: AOAM5336T/pIEFVZWGvP438kb1TVvk6YCNkq7Mok0vcmrZ0gAFOpYqRC
        05UxwzBt3w80IgPC7zWbZXoYnA==
X-Google-Smtp-Source: ABdhPJwnhhw2d4dOMygsgFPi1GNVXIA1X4Ce9E8R+xk6bsFj+gkQwNLHwXyhfzOHXlWrbz/ZBuXqEg==
X-Received: by 2002:a2e:5049:: with SMTP id v9mr23584503ljd.128.1632243099506;
        Tue, 21 Sep 2021 09:51:39 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id bt38sm1559955lfb.269.2021.09.21.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:51:39 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] staging: most: dim2: force fcnt=3 on Renesas GEN3
Date:   Tue, 21 Sep 2021 19:51:30 +0300
Message-Id: <20210921165130.24178-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Renesas datasheet, MLBC0 register's fcnt field in the embedded
dim2 module must be never set to value different from 3.

Enforce that, via an optional field in struct dim2_platform_data.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/staging/most/dim2/dim2.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 093ef9a2b291..d90284d79621 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -108,6 +108,7 @@ struct dim2_hdm {
 struct dim2_platform_data {
 	int (*enable)(struct platform_device *pdev);
 	void (*disable)(struct platform_device *pdev);
+	u8 fcnt;
 };
 
 #define iface_to_hdm(iface) container_of(iface, struct dim2_hdm, most_iface)
@@ -731,7 +732,7 @@ static int dim2_probe(struct platform_device *pdev)
 	struct dim2_hdm *dev;
 	struct resource *res;
 	int ret, i;
-	u8 hal_ret;
+	u8 dev_fcnt, hal_ret;
 	int irq;
 
 	enum { MLB_INT_IDX, AHB0_INT_IDX };
@@ -770,8 +771,10 @@ static int dim2_probe(struct platform_device *pdev)
 
 	dev->disable_platform = pdata ? pdata->disable : NULL;
 
-	dev_info(&pdev->dev, "sync: num of frames per sub-buffer: %u\n", fcnt);
-	hal_ret = dim_startup(dev->io_base, dev->clk_speed, fcnt);
+	dev_fcnt = pdata && pdata->fcnt ? pdata->fcnt : fcnt;
+	dev_info(&pdev->dev, "sync: num of frames per sub-buffer: %u\n",
+		 dev_fcnt);
+	hal_ret = dim_startup(dev->io_base, dev->clk_speed, dev_fcnt);
 	if (hal_ret != DIM_NO_ERROR) {
 		dev_err(&pdev->dev, "dim_startup failed: %d\n", hal_ret);
 		ret = -ENODEV;
@@ -1047,9 +1050,19 @@ static void rcar_m3_disable(struct platform_device *pdev)
 enum dim2_platforms { FSL_MX6, RCAR_H2, RCAR_M3 };
 
 static struct dim2_platform_data plat_data[] = {
-	[FSL_MX6] = { .enable = fsl_mx6_enable, .disable = fsl_mx6_disable },
-	[RCAR_H2] = { .enable = rcar_h2_enable, .disable = rcar_h2_disable },
-	[RCAR_M3] = { .enable = rcar_m3_enable, .disable = rcar_m3_disable },
+	[FSL_MX6] = {
+		.enable = fsl_mx6_enable,
+		.disable = fsl_mx6_disable,
+	},
+	[RCAR_H2] = {
+		.enable = rcar_h2_enable,
+		.disable = rcar_h2_disable,
+	},
+	[RCAR_M3] = {
+		.enable = rcar_m3_enable,
+		.disable = rcar_m3_disable,
+		.fcnt = 3,
+	},
 };
 
 static const struct of_device_id dim2_of_match[] = {
-- 
2.20.1

