Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDACC378E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351435AbhEJNGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351158AbhEJNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:03:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD50AC06135E
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:55:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l13so16497674wru.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5I8AlEC8dBHxWFP7B4nHqLuYclQwxngKCwv+MqH04xk=;
        b=sQfd4NvTRV4ixQQ86oG2ZoHxdXUfEauJV7TV36o6f3OfhJ39gNJvExCMosqH9kYn5T
         aFhsp0Ro31OhwJgSLHagc26/AxQk3KbawtB+3P27yoR6Dzccrtjhu0ErpDvgtKfOFz0h
         HiKISzMcmbpd96L7vR2Vqs1kig5TzCONiS0Uxka50YEGVLpImwy8kGEKIOF+CPHz3Zdh
         /mrRi4/UhP3qmVOnxFdx9TPITxEm0uu+oxQqqcvcEIFrstCAj/MQWR742OjVDrfa56oq
         mR4rHyLersV5LpCDWyR+QWpA2CQfeLW78k9O8EXZdDHmnlAdzB4qijY3zFNY0345NcCx
         R6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5I8AlEC8dBHxWFP7B4nHqLuYclQwxngKCwv+MqH04xk=;
        b=YkqQiH2l69sK/GnsknmWnig9X4ilND8KTPFbdev84FoZ2I6ARZb8DJpcWjsJUpgBLT
         WWo9aWI+xkT3Mk6J1Ex+m+rf5cwoXDa+RwiUI7c8VlUhIb7tkaqFX6Tr3LBrbZ4KlV88
         bSO1Tw/MmK7QwLJ7qJLRyZkODt5wa5O6pFxfkfdY/DEXNPW+GGik1p0GUkWlQUhHnPMC
         juxouo5hIGgC72zfVYZWsCLbMNG3b0QhsdKl6YjhwUuoKYwhE2/z67V2bg312LQ+iM70
         U+A7oeu6Z7aMbJwNWwY44w/MM2X0swVUy4hWpXmJGMabCvssdvlVL+VukRwC0OPbcix3
         QCgw==
X-Gm-Message-State: AOAM530OR6/UOldEMFv0THlS88EzvUTSo0RKma30f0p/xwu3BK+vgo1P
        nJnjZVXFnU8xLWUZ13TlRECiiQ==
X-Google-Smtp-Source: ABdhPJxOWtpr8Do6Tf/iovboR54hvTwbW1Gisv2RZXs4FQEfB48TuZVMAOrU8aX33X8DYta11pNbRw==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr30419014wrm.93.1620651358650;
        Mon, 10 May 2021 05:55:58 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:58 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH 08/11] iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
Date:   Mon, 10 May 2021 15:55:20 +0300
Message-Id: <20210510125523.1271237-9-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
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
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

