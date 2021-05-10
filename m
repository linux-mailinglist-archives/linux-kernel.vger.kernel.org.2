Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4043E378E28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351324AbhEJNGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351143AbhEJNDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:03:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFDBC061358
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:55:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x5so16504270wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CiE+DRXkOw8bMfDOSqysGFYepMljSM6PNYuMxJPfrmU=;
        b=XecbULtBOeyGf4Bxa5VCo5LMZqF3LVtq4rHnbXFTCyIjfm01Vj82BE+TIOjJjDSWCq
         FS+PUOyMtrSvIAEw80KWs6lCMFZ4akV2WfrLhPF9QH1ltKGPtGAilNPBf0DbrN9lKLYC
         y+uoq0TZ2nRmHuDMbCvTQGPQ+aKPVpSIghEDSV1zKxsfzRZbX0yaU2DNQ7M2O6VeumQ7
         qF4JOc9t6DqgBg0NV/ry4TbeNyHV98txsDTMkzr3w0K6janzYGmo9/1gmtITuOpO1PsP
         m8WTEfbxEFQ5cRTj7Krpj8o1+Fb/SOs6ztekIu4wkok42DeW1+MdfIt9i83FSI8X7jfx
         W0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CiE+DRXkOw8bMfDOSqysGFYepMljSM6PNYuMxJPfrmU=;
        b=R7yH7iZEqwQSlxGFUXVxRz5Og+mZ1my3Ms7sr91EeT9wl40HQTRhznKxSLQ0XctSd5
         5qssawxq4OkO5J1LbYYQJA4Vu0dePW6ul2b0i33tNXRL+9phBTb4lsoWj9eFCTbWXum0
         vnkktl4pFU/P3+G++1+dIzWpRJCCsN30GgxMuLypiWrlVh8pKoie64/hY8s9Rgkf/I18
         qLExzo/WoDFPgKk3YXRnMBzEtClcqPdhi25RSYoKmLN6Em0v/ZCXOaEkvfUXeWT6cT2I
         KXNwlJn0/2tF44OPxTUi6qup1LCc/GbdhWHJi2FxTTM3bhZI7TnY74MgVxvW0KaA8chB
         KpeQ==
X-Gm-Message-State: AOAM533jHR+xZHVtEUaxWC0DvZKTS4Scazr7+yD7OOv1h+Jzd6xP8nA7
        BtuGAx/hClr0in2A7NhkpDf40nDiyrYaGg==
X-Google-Smtp-Source: ABdhPJxZwHHpdwJTsdJNi4ly4pYnB3ns9TT2G4VeDKNRgG01eSCaFkMT3psZf7vIM/AOsAiS9D0B/w==
X-Received: by 2002:a5d:64c7:: with SMTP id f7mr30026754wri.257.1620651355719;
        Mon, 10 May 2021 05:55:55 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:55 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 05/11] iio: adc: ad7192: use devm_clk_get_optional() for mclk
Date:   Mon, 10 May 2021 15:55:17 +0300
Message-Id: <20210510125523.1271237-6-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_optional() helper returns NULL when devm_clk_get() returns
-ENOENT.
This makes things slightly cleaner. The added benefit is mostly cosmetic.

Also, a minor detail with this call, is that the reference for the parent
device is taken as `spi->dev` instead of `&st->sd.spi->dev` (which looks a
little crazy).

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 2ed580521d81..2671581d761f 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -326,7 +326,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 	clock_sel = AD7192_CLK_INT;
 
 	/* use internal clock */
-	if (PTR_ERR(st->mclk) == -ENOENT) {
+	if (st->mclk) {
 		if (of_property_read_bool(np, "adi,int-clock-output-enable"))
 			clock_sel = AD7192_CLK_INT_CO;
 	} else {
@@ -981,8 +981,8 @@ static int ad7192_probe(struct spi_device *spi)
 
 	st->fclk = AD7192_INT_FREQ_MHZ;
 
-	st->mclk = devm_clk_get(&st->sd.spi->dev, "mclk");
-	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
+	st->mclk = devm_clk_get_optional(&spi->dev, "mclk");
+	if (IS_ERR(st->mclk)) {
 		ret = PTR_ERR(st->mclk);
 		goto error_remove_trigger;
 	}
-- 
2.31.1

