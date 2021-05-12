Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930E537C9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhELQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbhELPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:37:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C363C03546C
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:16:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z130so1020461wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=63QQCc6cTan1btl2te+SCsjBWU0FH3iC+vQeIXSq1iY=;
        b=V9R2XWR/saz6XB8NRctn/cGN1pRjTqiEDub+PuWKysZpA8EcL4PA+58xSrmgeB0du5
         Bv41I/jd6D/4Tif0aS/r1KPKknFBgvQ0DOqezpAF7EHP+xLskYV9C6YxDMmIwPnt78Gu
         UjvQ2c6VGMv0oIwds2bqw31zezgXow/oq+REYMVZyGoQ5fjX64W2axB6QRE3elQt3Yrb
         BYaCJWef7OxPOs+WqHrzq2b4DEvybfNEIV3UcgcQfs2SoI9M8ryJD8mztruRKRx9nwy9
         Zcqr2jR4+eVBb0ikee0QNVVFIT4OQItpdd1eFKYHCz/Tuk4GVZ7xwHCztgO9nOscQeN5
         9UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63QQCc6cTan1btl2te+SCsjBWU0FH3iC+vQeIXSq1iY=;
        b=l8O3M3GjVroFH5c9/RnnkWV25RKBIlFBeSJlinb4B71AVeEc3hampIYp5LI9vcYYyT
         YkeGVaQaUaeQnOWuO0GekIon5xsWdaJkatCpwbfZJggUN3KWk5fLZlJpb34kR+3hSyGn
         1H3Pjtuqr3kMs6b8DsSdNe+qxunlWBKYLhFpWKg9C6Epcns7Q9tjA7jeZMyBkVQwtTUh
         3jzxVYoM78sG8KO+t/QTsIvgpViIPUdZz3PUZbBlqZBrwKyDYyuH1Z0zX4schBbKTQMr
         9t3+17R8luLhlXOjV0hGSFWkYEy68T8A2KgkSuaNeJdeDaVblvIXzRkA5DTDKZyQ6fYv
         u2xQ==
X-Gm-Message-State: AOAM5334Y0zRz7X2o/YywrBWOz6USq7ck8sg9eaWtmQU6s3+UqDb7xV7
        n5zBZbWMXeFsX9CxL5Tdfrqfiw==
X-Google-Smtp-Source: ABdhPJy33NvSem24eI2h1X+78s6h8Fyljd3qZ3KpToCeaJt1bQMLx99FHMfDjjXFE0vPCV8Wp+5oKA==
X-Received: by 2002:a05:600c:3592:: with SMTP id p18mr20474678wmq.44.1620832589473;
        Wed, 12 May 2021 08:16:29 -0700 (PDT)
Received: from mkorpershoek-XPS-13-9370.home (lfbn-tou-1-1465-169.w90-89.abo.wanadoo.fr. [90.89.34.169])
        by smtp.gmail.com with ESMTPSA id c15sm30095011wrr.3.2021.05.12.08.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:16:29 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 3/3] mfd: mt6397: add PMIC keys for MT6358
Date:   Wed, 12 May 2021 17:16:14 +0200
Message-Id: <20210512151614.36996-4-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210512151614.36996-1-mkorpershoek@baylibre.com>
References: <20210512151614.36996-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings and interrupts for pmic keys
which serves as child device of MFD.

MT6358 has two interrupts per key: one for press, another one for
release (_R)

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/mfd/mt6397-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 8738b5524783..5b79975dc13c 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -45,6 +45,13 @@ static const struct resource mt6397_rtc_resources[] = {
 	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
 };
 
+static const struct resource mt6358_keys_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_HOMEKEY, "homekey"),
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_PWRKEY_R, "powerkey_r"),
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_HOMEKEY_R, "homekey_r"),
+};
+
 static const struct resource mt6323_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_PWRKEY, "powerkey"),
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
@@ -96,6 +103,11 @@ static const struct mfd_cell mt6358_devs[] = {
 	}, {
 		.name = "mt6358-sound",
 		.of_compatible = "mediatek,mt6358-sound"
+	}, {
+		.name = "mt6358-keys",
+		.num_resources = ARRAY_SIZE(mt6358_keys_resources),
+		.resources = mt6358_keys_resources,
+		.of_compatible = "mediatek,mt6358-keys"
 	},
 };
 
-- 
2.27.0

