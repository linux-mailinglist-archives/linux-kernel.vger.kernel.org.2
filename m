Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56CD419851
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhI0QAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhI0QAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:00:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBABCC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:58:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y28so79173671lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnBui/bq2DenTO0RzI30XkLpJ5ryphhFyB3vBxgNy3g=;
        b=MsFXo0I6wLJKPx9iHv/XEWK/6o62hxZrp8RYlozF8o5/qDU2Sr+mmfPRC4E9+BtfNe
         3XxksAjOsoaT8pEmG1VsgwpavT3Qq4U8UlXLbuV32Iwqzpr5SC4j19Z6Gr0segzjXZOF
         5W6k0scXl1AQD6OqNw95LU4S1nwqANsVt6BNAGUMqMU7tGPdJlHO7dDC9z0iNoo9eDK+
         +r/AVboWdImwi5XhOgsD5jL3Joj1pzLPwjckKukzZsH7CJZ5tgiLV/+F+8715SR/uOrY
         vgJbh9o2zfrJQ1R6r2/IQtJPQ8nJWBjnp0yRt940xbA/89ic+6sCAcTg9QSIROXOhhc+
         L6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnBui/bq2DenTO0RzI30XkLpJ5ryphhFyB3vBxgNy3g=;
        b=u0+5I6l3gLv9phCQ/6ss+AIfiu4+u8bRUkFKgI09kCPbu5Pbh5AmJZgiGugnnZw43N
         0MhhyCnSHQIR6+hVTQQRyw3/79X3iBgnbKKQL+VJehwCg5q/GvmpExSVkztsPoYf43sd
         0WLNU/Q23IaqwbOpmSHxIXiB1Uqihxf9w/6lEZVz7aax/2YSpEhNdzDIqzLtxkpYxKxL
         7gTDQDOZfodiOneo+SX+p26lCP6fagH904tJCQSTa/3JuvCyk0AKoIYUJeU0/j6LIQrg
         0ya8mrqTyto1UZpItN3kcn+plKxcP2zaG2rQ7UPHpCJmeDp53mbX7ZnUmF+EopJLlLWi
         F3uw==
X-Gm-Message-State: AOAM530gZu6xLvwMk+ap+Gkw1VgDtG/BFYFqKPvH18cogS/tj0NuNyvy
        C+SBM7mMmAduqu45hBJy5Vh32A==
X-Google-Smtp-Source: ABdhPJztNIfPvBJVgd+M5+SywC/TUunjVE+8HODRyIAx29XlY0BgFRxjT+6k/dTOxw4MmVYuY40TOA==
X-Received: by 2002:a05:651c:1505:: with SMTP id e5mr597864ljf.9.1632758313119;
        Mon, 27 Sep 2021 08:58:33 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id c17sm1795730lfp.290.2021.09.27.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 08:58:32 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH v2] staging: most: dim2: force fcnt=3 on Renesas GEN3
Date:   Mon, 27 Sep 2021 18:58:05 +0300
Message-Id: <20210927155804.27877-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YVHoXyULqXsWktMN@kroah.com>
References: <YVHoXyULqXsWktMN@kroah.com>
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
Changes from v1:
- set dev_fcnt via if statement, not conditional expression

 drivers/staging/most/dim2/dim2.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 093ef9a2b291..9300040ec84c 100644
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
@@ -770,8 +771,14 @@ static int dim2_probe(struct platform_device *pdev)
 
 	dev->disable_platform = pdata ? pdata->disable : NULL;
 
-	dev_info(&pdev->dev, "sync: num of frames per sub-buffer: %u\n", fcnt);
-	hal_ret = dim_startup(dev->io_base, dev->clk_speed, fcnt);
+	if (pdata && pdata->fcnt)
+		dev_fcnt = pdata->fcnt;
+	else
+		dev_fcnt = fcnt;
+
+	dev_info(&pdev->dev, "sync: num of frames per sub-buffer: %u\n",
+		 dev_fcnt);
+	hal_ret = dim_startup(dev->io_base, dev->clk_speed, dev_fcnt);
 	if (hal_ret != DIM_NO_ERROR) {
 		dev_err(&pdev->dev, "dim_startup failed: %d\n", hal_ret);
 		ret = -ENODEV;
@@ -1047,9 +1054,19 @@ static void rcar_m3_disable(struct platform_device *pdev)
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
2.30.2

