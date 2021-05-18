Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD8387BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245305AbhERO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244591AbhERO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:58:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30949C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:57:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q5so10585459wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vurGL64Q3SxR/3rC1VvdPqxLLlL5m2GaEVxxxuUXcnk=;
        b=ADC6wtP2Uy28k6oVzgFz3m7h+EKlhA/HZv6l3f85y9KwFUpxLWRtNp4Z2S1XCyYiNn
         /MtYGElEOf3XT15Zb16RvoCYb26HsPmfLLWh0ioZPt1KUHckECCiqmzk3uCRt6XRpNOL
         x+ijhif8boPjZQkpGhW85RTvrPjyd/NgsEB2C7CrCLiLdBmiQS2iGl6oaUFyjgUcZ5hF
         0dK4ktiJL6shb6c//mDf6Q6i3UyXvqP8cuBzioqFIcRxw80SzzbWKFpnS8QAmkNhhSGl
         P/qYAbILrnu6yKoQWTDtAS1WXwp7/uoalDTBj6Y3wDaSnygUAZIcHQfr5/+eEbFnZejv
         BVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vurGL64Q3SxR/3rC1VvdPqxLLlL5m2GaEVxxxuUXcnk=;
        b=IOaNKYKrlI2Sz6kPQXGfV9rYaWVyMNTU56sZiI2yYS7VsaliWrJxYtkKz2Li7tuQvN
         yEfesMX3yhNejtte1IH+VeszMy04fZ2NCitoo9rtNGXFsYQvhPwL81cyuvlvvT4lCJv8
         O0sMdGGvJEVSd61Z+vws/PDIr1kWGcNF7FWo/DgZXoYodqXAFon0m4IsWC1sbzurqOJZ
         mgslCpZ7zIiwtjfY05BCzSJD9dtBBLmNZHH62fjdMcwD2jZU63Yu8qt0gf3nDUsjp+Ud
         BHrIVV/7Cawk6huSDp1pdetrNZdVVfW+BezlwNIXbxkMEL9goKuH6kwxwjKMCgUsujIp
         xJAg==
X-Gm-Message-State: AOAM530v26evYLI8goz9hyJns2sQ41TGt7khHyqLAeP1JtChEbLK9fQI
        cKZbKYBogb0Mr5gusWN9fB4u/A==
X-Google-Smtp-Source: ABdhPJzudJFc0nj4LYsR4FvoPi7DZDUoXDJbEP/PWcHdFQceggrOdrlOub2/IYm5mnnfPtyt8yv/Ig==
X-Received: by 2002:a5d:5249:: with SMTP id k9mr3866068wrc.301.1621349843897;
        Tue, 18 May 2021 07:57:23 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id a18sm2928386wmb.13.2021.05.18.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:57:23 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Qii Wang <qii.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] i2c: i2c-mt65xx: add MT8365 SoC support
Date:   Tue, 18 May 2021 16:55:22 +0200
Message-Id: <20210518145522.2420135-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518145522.2420135-1-fparent@baylibre.com>
References: <20210518145522.2420135-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for I2C on MT8365 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 5ddfa4e56ee2..0e6ad84e0e47 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -404,6 +404,19 @@ static const struct mtk_i2c_compatible mt8192_compat = {
 	.max_dma_support = 36,
 };
 
+static const struct mtk_i2c_compatible mt8365_compat = {
+	.regs = mt_i2c_regs_v1,
+	.pmic_i2c = 0,
+	.dcm = 1,
+	.auto_restart = 1,
+	.aux_len_reg = 1,
+	.timing_adjust = 1,
+	.dma_sync = 1,
+	.ltiming_adjust = 0,
+	.apdma_sync = 0,
+	.max_dma_support = 33,
+};
+
 static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt2712-i2c", .data = &mt2712_compat },
 	{ .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
@@ -412,6 +425,7 @@ static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
 	{ .compatible = "mediatek,mt8183-i2c", .data = &mt8183_compat },
 	{ .compatible = "mediatek,mt8192-i2c", .data = &mt8192_compat },
+	{ .compatible = "mediatek,mt8365-i2c", .data = &mt8365_compat },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
-- 
2.31.1

