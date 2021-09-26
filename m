Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB9D418A28
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhIZQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhIZQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 12:30:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CE6C061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 09:29:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ee50so58555854edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jucDxAZgXFO2xiPpoYJkT8xmT+xrk7gRKE4e9TEQU4=;
        b=jotAFICWXy4a5lhFBAfBjvv0/xOsSC3yFTelep4P8kVqsSiYZ34vpXylx7uc+MY+Kp
         oYeQgPOnJ9INL6J7YXyWbxTVSvMZo2SIBvPrqwW8Nn8Ux46Igqbk47Kj+vqgQYlU55aB
         CpBgq99QsmmkkcXuv2G/zMMNwZBTETpadnM7v6QWgOBVzXrz3WJW1fXkYk52nX+T7X1f
         xkciLhI9uhUrWMip5PlsSbDB0SbPU2ix2Nc+SrALDkFmeXLydJEuhHq7v4vFLaJBjXpD
         Tih4GZAq6FavS/Gnb0v23eICQtu4RxfhtF5pYuPACsKYmC+AP3BkyCGIh0z1SRqvdvcf
         JGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jucDxAZgXFO2xiPpoYJkT8xmT+xrk7gRKE4e9TEQU4=;
        b=U/mCXsz6ZMSE+XvtX5OFBcI7cwRoL0I/baq9mtwSf49LGOefzKMWhSmug4/4RlxVc2
         hZ+Duxoaxujy8CIeQZMgaosN+iF6SuLH5dqCDPaC6JrK5CT/NHMrV8JL4BiznjAtn48I
         xY9lE1TiMAttpefpHP+Ybo6626yCovFCAJeAvG3qgSoWBZLgVmh9FgvvSCLZ3chKRRkf
         5ubW3RcaMmOI5CV9RutWK2sZ/wfSvUnZKzbYCjQ1+ZNt3P8d25anss/LjR8fc8TuDHH8
         OkcCko81B2FAi5amBw5mmDSrHu9vj3VBiaqHEhv0XQQSjx8OCYQV7PsuEQq4F+PqxlU1
         aSpw==
X-Gm-Message-State: AOAM530HjTxvVK8E/Clv0gx4jrWVTN8hHxr8/Jry5V9dWvBtLNEI1RSS
        cGOphWsr6oaBnAsWMOhFSnJGD+T7tpzABg==
X-Google-Smtp-Source: ABdhPJwO+nWxZexfB5hgTBwJua7YyCdMBD3I/VDSQIOwjq+G9zhLU5af0yoKCSnhihWCWHTef4US8A==
X-Received: by 2002:a17:906:3054:: with SMTP id d20mr22181545ejd.294.1632673752679;
        Sun, 26 Sep 2021 09:29:12 -0700 (PDT)
Received: from neptune.. ([188.27.128.17])
        by smtp.gmail.com with ESMTPSA id d15sm7468956ejo.4.2021.09.26.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 09:29:12 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, andreas@kemnade.info,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: adc: rn5t618-adc: use devm_iio_map_array_register() function
Date:   Sun, 26 Sep 2021 19:28:59 +0300
Message-Id: <20210926162859.3567685-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver already hooks a similar unwind callback via
devm_add_action_or_reset().

They pretty much do the same thing, so this change converts it to the
devm_iio_map_array_register().

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/rn5t618-adc.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index c56fccb2c8e1..7d891b4ea461 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -197,13 +197,6 @@ static struct iio_map rn5t618_maps[] = {
 	{ /* sentinel */ }
 };
 
-static void unregister_map(void *data)
-{
-	struct iio_dev *iio_dev = (struct iio_dev *) data;
-
-	iio_map_array_unregister(iio_dev);
-}
-
 static int rn5t618_adc_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -254,11 +247,7 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = iio_map_array_register(iio_dev, rn5t618_maps);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(adc->dev, unregister_map, iio_dev);
+	ret = devm_iio_map_array_register(adc->dev, iio_dev, rn5t618_maps);
 	if (ret < 0)
 		return ret;
 
-- 
2.31.1

