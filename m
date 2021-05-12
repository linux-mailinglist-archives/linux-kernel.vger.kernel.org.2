Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6037EBA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381609AbhELTer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350508AbhELRvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:51:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2567C061763
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:49:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id s20so30731333ejr.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URnNCU/Gt3uzfVjqFnT5ZArbKyWbTbXjKVLfJMYugCE=;
        b=qg7B+p/EdpaiT5gvz8IazDMbbMPiWk9AJUJJLOX5vNYzliT7X3pyFCTYphE+eWpyFT
         pnzyX3hL1IquBRjvIKYFWfDQErVLkvyNwtHGDP+R7WDY1LMzeJEj+2ngyLkN9Ei1QkR6
         P8Wp/EABTMd4H97FmKQ7DGN6Y4GTrP6cmbyWCjJkE1qs1x6APee0qKsGJDPWBwXjZ4Uh
         wA5iPLULgRq1vosVtyEaXwnWyL6kxoC+ANXj3lF3BUAMCfjeViP3tJrVfEQ6d2PPn+qK
         WYPsLEICOvDN+XcdTDWeRTV7GG1opmSMRv5NcVu+bTeKvUdlKCs5fBCxxvzsDi+n5gEZ
         GwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URnNCU/Gt3uzfVjqFnT5ZArbKyWbTbXjKVLfJMYugCE=;
        b=TN1axEbdH2zweSY4rV+qCQDgcN7bn7ypoeyEOv5MA7ABZEGwbblRLH7rsbbGV7WRT7
         YT9//iJqfqmKpDiUPi9LA+SKlQdeI4tBrE1DjLngDnxEpQ16pC8kORPrIORW+PPDQimc
         gXEqCIJ8ps2a7EOKIXJMr1+5rBQ+psIAR/d0l5+pl6KHeIK3sdiB1qTHZ9orpE+A3rZ5
         /bYkZue9rEZPnQfSY2MJc5tCd7VZJOqgIH6LWao4XGoUuiJ5IjwkZadnQqTFNDPT15KE
         yyVro2YkVsiZ0H4q0y3AFqFOxeVh9HR2sBQjLIYKi9R796i6DoYUYpNws1qBTGY677Hq
         8tlg==
X-Gm-Message-State: AOAM531AGGhgvbl/HrOIZJ3GqiRDpHpxrSg5h04aB3cyv/LhhkhdlkkW
        t7Rp2hl73rlvIW6zGctXnyD3JQ==
X-Google-Smtp-Source: ABdhPJwRM2YdDAwUgqdu+As6vFNfWcxNjZJd+2LpncXGnTaKBSs/Qj0AxhzAn8V71kWgDJbc4EfQng==
X-Received: by 2002:a17:906:7c45:: with SMTP id g5mr37981556ejp.368.1620841796574;
        Wed, 12 May 2021 10:49:56 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:49:56 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 01/12] iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
Date:   Wed, 12 May 2021 20:49:03 +0300
Message-Id: <20210512174914.10549-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If the devm_regulator_get() call succeeded but not the regulator_enable()
then regulator_disable() would be called on a regulator that was not
enabled.

Fix this by moving regulator enabling / disabling over to
devm_ management via devm_add_action_or_reset.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7124.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9d3952b4674f..437116a07cf1 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -850,6 +850,11 @@ static int ad7124_setup(struct ad7124_state *st)
 	return ret;
 }
 
+static void ad7124_reg_disable(void *r)
+{
+	regulator_disable(r);
+}
+
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
@@ -895,17 +900,20 @@ static int ad7124_probe(struct spi_device *spi)
 		ret = regulator_enable(st->vref[i]);
 		if (ret)
 			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7124_reg_disable,
+					       st->vref[i]);
+		if (ret)
+			return ret;
 	}
 
 	st->mclk = devm_clk_get(&spi->dev, "mclk");
-	if (IS_ERR(st->mclk)) {
-		ret = PTR_ERR(st->mclk);
-		goto error_regulator_disable;
-	}
+	if (IS_ERR(st->mclk))
+		return PTR_ERR(st->mclk);
 
 	ret = clk_prepare_enable(st->mclk);
 	if (ret < 0)
-		goto error_regulator_disable;
+		return ret;
 
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
@@ -935,11 +943,6 @@ static int ad7124_probe(struct spi_device *spi)
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_clk_disable_unprepare:
 	clk_disable_unprepare(st->mclk);
-error_regulator_disable:
-	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
-		if (!IS_ERR_OR_NULL(st->vref[i]))
-			regulator_disable(st->vref[i]);
-	}
 
 	return ret;
 }
@@ -948,17 +951,11 @@ static int ad7124_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7124_state *st = iio_priv(indio_dev);
-	int i;
 
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 	clk_disable_unprepare(st->mclk);
 
-	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
-		if (!IS_ERR_OR_NULL(st->vref[i]))
-			regulator_disable(st->vref[i]);
-	}
-
 	return 0;
 }
 
-- 
2.31.1

