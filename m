Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F690408A87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbhIMLwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbhIMLws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:52:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB21C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:51:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c22so12534704edn.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXAvyIFlCypwleJumirPLWNzM4FoVetFpvyDJQxWSRw=;
        b=bo7S/wLUwCS0ubAEOARY9BfI/QA6oeUrPPqXzfmsg54xFUThB4vaYyDbcaVAoQrIY4
         bt6XlAbz6KVrzY8sELxF7g/nUVpxGifIXrjA5f5eXnqi+gK6OkMZt69HFfMZwgSIvF5q
         MdP9oEvXuGz8uaorzm+Z8DbEa3vEIeaIUvqgmZzw1Gf/cd41T/Zcq0SKsx4DfZ39kOTr
         a/goci4pQtjeLRNYIGiV6jcEkW8Pg76qid7dB2vC5eSCVwCaDOjs7JIxhvAyV++dZYgs
         j1w3JQv1uTrpE9iduRMRYnwha9YCL6q1B4hT4v7xnpLBkM/kg2YffipXkixyGHSuIsNd
         dhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXAvyIFlCypwleJumirPLWNzM4FoVetFpvyDJQxWSRw=;
        b=PdVRZoEC2OqFVtJLrihrnJiKJNXkdRseStlVj7PNNzzigjiTD2H0y5ImM2KzflW26Q
         i/6TllNy8kLiN5thNWZye6ZsDNWoIltW4pnTSQ8lvirkb0w9/NglH3kpIRLA6Hc/VTr1
         MzQLm23eiUiNwp7YyiYO6vpZzmApEGz+Lce5Flrt2srM7Eewsr738YZ8JFgFAVb3N8t0
         94NPszGl7jajY+TqwuVZes2t4/HNY39WwetKx8WCIxvj16dLZHEn+irGsLVP+422SFOl
         JTY/NKNjdHjXBPp0UJhljYZFTOU3urVLB4zbNlZsAx2eqsFQo1LIDBoblnNiw7vB3ujB
         wfhg==
X-Gm-Message-State: AOAM532Qc1tz/K4v1Zxibak97ZeavR8XfeptLV6SfYqGpBdr8HGJF4jB
        vhC94/mCS4ezvFpBP2kUd8nzh+RjZ85qQQ==
X-Google-Smtp-Source: ABdhPJwJsg5ZuYrAdO/HueT6Wh7Neq+S5QGheVIjgFq9g64Y8SR6wvXY+yFynPuXwCNQOuhkdmbQ3Q==
X-Received: by 2002:aa7:d6c7:: with SMTP id x7mr9081537edr.180.1631533890625;
        Mon, 13 Sep 2021 04:51:30 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id br21sm3070225ejb.112.2021.09.13.04.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:51:30 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: dac: ad7303: convert probe to full device-managed
Date:   Mon, 13 Sep 2021 14:51:21 +0300
Message-Id: <20210913115121.300082-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For this conversion, the regulators need to have some cleanup hooks
registered with devm_add_action_or_reset() and then the
devm_io_device_register() call can be used.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/dac/ad7303.c | 47 +++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index e1b6a92df12f..91eaaf793b3e 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -198,6 +198,11 @@ static const struct iio_chan_spec ad7303_channels[] = {
 	AD7303_CHANNEL(1),
 };
 
+static void ad7303_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7303_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -210,7 +215,6 @@ static int ad7303_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
 
 	st->spi = spi;
 
@@ -224,18 +228,27 @@ static int ad7303_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7303_reg_disable, st->vdd_reg);
+	if (ret)
+		return ret;
+
 	st->vref_reg = devm_regulator_get_optional(&spi->dev, "REF");
 	if (IS_ERR(st->vref_reg)) {
 		ret = PTR_ERR(st->vref_reg);
 		if (ret != -ENODEV)
-			goto err_disable_vdd_reg;
+			return ret;
 		st->vref_reg = NULL;
 	}
 
 	if (st->vref_reg) {
 		ret = regulator_enable(st->vref_reg);
 		if (ret)
-			goto err_disable_vdd_reg;
+			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7303_reg_disable,
+					       st->vref_reg);
+		if (ret)
+			return ret;
 
 		st->config |= AD7303_CFG_EXTERNAL_VREF;
 	}
@@ -246,32 +259,7 @@ static int ad7303_probe(struct spi_device *spi)
 	indio_dev->channels = ad7303_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7303_channels);
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto err_disable_vref_reg;
-
-	return 0;
-
-err_disable_vref_reg:
-	if (st->vref_reg)
-		regulator_disable(st->vref_reg);
-err_disable_vdd_reg:
-	regulator_disable(st->vdd_reg);
-	return ret;
-}
-
-static int ad7303_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7303_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	if (st->vref_reg)
-		regulator_disable(st->vref_reg);
-	regulator_disable(st->vdd_reg);
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad7303_spi_of_match[] = {
@@ -292,7 +280,6 @@ static struct spi_driver ad7303_driver = {
 		.of_match_table = ad7303_spi_of_match,
 	},
 	.probe = ad7303_probe,
-	.remove = ad7303_remove,
 	.id_table = ad7303_spi_ids,
 };
 module_spi_driver(ad7303_driver);
-- 
2.31.1

