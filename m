Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE60D37F791
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhEMMMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhEMMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:09:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C020C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so6660308edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hy3IcRDvRV5+tK+ZRLaGDhqpXCfFka7PQKuph7JiP4Y=;
        b=Y2Qg773FvUVyXUSZo0qA0Ufrbs2J17MmauND0QOgH96B1yBC5SPhl2XgSASxQtaC/x
         USkdibM6EdiFNEOwsXEFFc+F838k8y40MTBQQJ7QnN/ysrUQJhMSeqKGG/dBKISBvkzn
         hTmjJ04JHpLmOWU8YEk1SJJg1fZeLx47oddDMlkTkoaTaAf8hUDhBXczFwYTix23wJPP
         hvKg8kBt/VzwOO0yyJ4jO8Qv33CStQWervRwa7WAjT5rLFtQesRxNzKEtnTfR+R4mi6P
         Ew8AilIUcoIDiqlMn3REaLvz431U4Kzqn48Hy8qr3i/sEleVhNVTBVmPC2NSnvfwsQvm
         aiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hy3IcRDvRV5+tK+ZRLaGDhqpXCfFka7PQKuph7JiP4Y=;
        b=aTwLEMJ8Y1MxQBrOlhj01YeAlXIBBvJN3iEj333KJicfn2XUdLTuuf/8oT0whMwnpC
         Qp6SnnD6R8+F3rI7Zl+1QOR6rf4TwqAQZfwqoED1zvnexJl4rq8TWXfiY/9pzuna9Shz
         uDopqUMoHDO+p1Qq39wyUgNNwCHd/gc+r55c7hgEjXlr8W/CisK3Sh/uO7x7Uhvtb9no
         5B3da3K88QzpyEQAjXgubFvEkk46qII52PXAdTtitIme0fBpZrF+ohv9Wq/nOD7l4yiw
         yED69V9SdE36MJLKbIjxgPdP4TsgmdPDGeeC3Bkvjz+C2bozlE8XBcyXsmCiKEvYMg4u
         rz0g==
X-Gm-Message-State: AOAM533z6Hw6uPkCEpALqeE3Os36ddQIBRyldbHlND47O3slsdk8TYpX
        SXSWVd5NDRpdlard2ka28bhbmw==
X-Google-Smtp-Source: ABdhPJzgUPJMDuolRPi8aBMo2dNDP6Rq3oicyRvMxnIN5hd/q4y6rnZR8nVCND4j3vBEIXWyWbAoAw==
X-Received: by 2002:aa7:cd46:: with SMTP id v6mr48645873edw.16.1620907688231;
        Thu, 13 May 2021 05:08:08 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:07 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 09/12] iio: adc: ad7192: use devm_clk_get_optional() for mclk
Date:   Thu, 13 May 2021 15:07:49 +0300
Message-Id: <20210513120752.90074-10-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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
little quirky).

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 1141cc13a124..523cf3bc955b 100644
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
@@ -978,8 +978,8 @@ static int ad7192_probe(struct spi_device *spi)
 
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

