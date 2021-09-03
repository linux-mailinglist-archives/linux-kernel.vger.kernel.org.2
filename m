Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956BB3FFB2F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348045AbhICHi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbhICHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:38:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F173AC061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 00:37:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id me10so10171555ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRGvZSsdRmFgCiMKoqUCm1KoczOaDBpTmvjrEAznFXk=;
        b=ZtgOuaGg9ld2PfKJa7EJwdFc7RVXoiDiH4rxAz6tIZ73a+uaFviS/V80qkBU5imk3q
         wfilCq4Oq9oFaDubG8CpWMdr8qqeFRJO0h4pjB/t569WKttrJLkfB3IUhYkR3Gi6PzfA
         oy9bkVNDrXB+M5Ckctjm/vwjMruXA7eiSVe6iscse9QUAizwboRHIACFoeG2x31vTbSi
         gj9Iuj+Hm0dHKk2P3bFNQJhDYhrHcOq/PlZeViaSP8FAqqx/JCOcjK3aqA6D7waaVQds
         uwVIKCVafTtFJGVYB/jmMrV42reAeYxRpen0BrcBnAdULJSAbR2sIzTr+8q1j0e/P0ap
         R9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRGvZSsdRmFgCiMKoqUCm1KoczOaDBpTmvjrEAznFXk=;
        b=Aw8e3tVUJoWUYmyc4z9yKe/JCGqF0picb0H4qsdZOlk+DU4ppIOi6k64ZJTJl7j24u
         4y/NVL3jh+3FbjbsYlUhKQfhT2SicnnwvbH71/de1iR4WtmTZAYoKdixYx1+fFDv9z/P
         ti/bmpgBAefwbhupcibwjqhnr2dYq27ISWJbSnolNqLdLjqGaYVuzaKrtUlPcPZ641L0
         2VYFQLqn92th8orbSk13ITXfPeJSFxuoSdoEc3B6V11PRPd4FhOE3PAI6Mysk4qdI1ny
         W0PkzDBHU5lHgeywc5vd8ewElo36e25tDJ22/2NLMj0UjPotUcw6msXg7vWufeEj17of
         Ecvw==
X-Gm-Message-State: AOAM53190e0aqpZ6CMhcVkn1vxOusMTPGOjR8Zyk3HB7Filncg/mbTEK
        /Qa/pF4CgWBWNBA4jmUm7CcRQcUVXyCsmA==
X-Google-Smtp-Source: ABdhPJyotfem2L+UTIbP3rA/k0FEc8E9GhMu6BgmV48BRHsNgcPZN/WaC8+4YmMcuKABb5NZon7uMA==
X-Received: by 2002:a17:906:7fc4:: with SMTP id r4mr2660637ejs.75.1630654644357;
        Fri, 03 Sep 2021 00:37:24 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id c19sm2211627ejs.116.2021.09.03.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:37:24 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: adc: ti-ads8344: convert probe to device-managed
Date:   Fri,  3 Sep 2021 10:37:07 +0300
Message-Id: <20210903073707.46892-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the driver to register via devm_iio_device_register().
The regulator disable is moved on a devm_add_action_or_reset() hook.

And the spi_set_drvdata() isn't required anymore.
And finally, the ads8344_remove() can be removed as well.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ti-ads8344.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
index a345a30d74fa..c96d2a9ba924 100644
--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -133,6 +133,11 @@ static const struct iio_info ads8344_info = {
 	.read_raw = ads8344_read_raw,
 };
 
+static void ads8344_reg_disable(void *data)
+{
+	regulator_disable(data);
+}
+
 static int ads8344_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -161,26 +166,11 @@ static int ads8344_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	spi_set_drvdata(spi, indio_dev);
-
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		regulator_disable(adc->reg);
+	ret = devm_add_action_or_reset(&spi->dev, ads8344_reg_disable, adc->reg);
+	if (ret)
 		return ret;
-	}
-
-	return 0;
-}
-
-static int ads8344_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ads8344 *adc = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	regulator_disable(adc->reg);
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ads8344_of_match[] = {
@@ -195,7 +185,6 @@ static struct spi_driver ads8344_driver = {
 		.of_match_table = ads8344_of_match,
 	},
 	.probe = ads8344_probe,
-	.remove = ads8344_remove,
 };
 module_spi_driver(ads8344_driver);
 
-- 
2.31.1

