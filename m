Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB737EBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381762AbhELTfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350909AbhELRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:52:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9509C06134D
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:50:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gx5so36209521ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBvo4n1b1lpFvoXyiJXHa/MxZkZ+cVEgHQDwczdnQoM=;
        b=KeUHS+sM1e7FnHAfkAJ7Aol2WcEZSwD8dAOWuCv5Qvd6OzIRoGIRKTn8gqDF0uDisi
         bPd0RIbn+h1yOn7ceieEkaop7mFgy478fbu6zPFO6KOFBa5d0RkUH6eTBb5BIyXWSGpz
         +7/g/2PvfIvNb6kH0/kv5ONgD5oS8UnYRoVOjIgas7m28TfoGkvwsQWi0oH0r9PBkgSh
         51WKUnD2amNa/ATxdUfAaZr1wP+nBbYOnxry6jKDGOXQJu4fCtDChSPKy4QFWxVi3INZ
         7fGtyvLH0aQd+2jabyC9ZfHcnpTYw/50fcvrrJZdCLx5ricC7WAnxZ50AJh2Ffsw6fZq
         8M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBvo4n1b1lpFvoXyiJXHa/MxZkZ+cVEgHQDwczdnQoM=;
        b=Jr0D+1ovys7HglvGtBUuzuS+6DzM/cfNTyOzaI8jF7bRK9gtr4JD8RazO8ygnPTq1G
         mm/UAib7gl9+9nhAcxL+N0C2OllNgR6mk+LYiriRL9WoGuv1Fe6wLD3cYj79vtnVZLLw
         NoafV/m2x2TbMz16j7UIv/nIz82v0n+BSmrCAOxoX0TpFamynwO3l1vUwkDb/YfKxp1B
         F0hGeF+/F5XzAt0il7ohFvXbsbeTOcTAwEreRjf6gETdpoCpmJj2akTZZVDPdOYaJGPk
         6Q3BzovqSGmpsYM/Ca2WzPCfnzvUys6No7i/cIJKdHbIBBUPtgy4ljIAp525imyB3HN1
         mPHQ==
X-Gm-Message-State: AOAM531mJEK9w2W4bzb3ujIpUw+z4LogbkXdpljYhWiAjjdqsM1A3wdJ
        AFPMJkKstSfbnhQX1zzLzp/XwPU8TB8MRw==
X-Google-Smtp-Source: ABdhPJydkg/jTMyUOet8s5ERY+J4yag6wbwgnKkuWVtiHkJnqAlKM5TCo+BFuBhkjoO7RE9j+lsnBQ==
X-Received: by 2002:a17:907:990f:: with SMTP id ka15mr31620660ejc.132.1620841805716;
        Wed, 12 May 2021 10:50:05 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:50:05 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 09/12] iio: adc: ad7192: use devm_clk_get_optional() for mclk
Date:   Wed, 12 May 2021 20:49:11 +0300
Message-Id: <20210512174914.10549-10-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
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
index 9da394ad3868..c3442e9aa9fd 100644
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

