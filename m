Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA036BEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 07:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhD0Fh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 01:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhD0FhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:37:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5405CC06138B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:36:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m12so837384pgr.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOSiNAIFbF5oM0OgD4JWcfn+rkikH5kg1ZaUYL3whtQ=;
        b=VOWdUtYAgwq1bQG3/NsqLEKs/W1eKLs6RW9BQiWCYyD/Rfqvg890AjJ+GEoGMq5OrA
         AJ5KHj4U1HvetQeuUVJVOIRQXy84KxIekLczgZ69sB4zUtPWSuutk3TpnMuHMTjWm4+8
         h8G+8PZFnH5Rm1K+s/a+i9Kx1KocC5TA7BsS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOSiNAIFbF5oM0OgD4JWcfn+rkikH5kg1ZaUYL3whtQ=;
        b=MqTkifUx3ElJ8CVVE9kkF3rSr4WrxkTRsIMK6ha6bS7xuBd0/G/hEtEhvDmhSjljcr
         UOEf4eacoW5CDnojXlebf7HKaKE+uFptbKKB9kYmPSVHgvwyxyWZrh1+4cLAu0LEg4ev
         1LSS/xqeTqCej8NBngT+b30Zre/qZI/TjyKRc9Mdga59p5bq1hvRW91VxGo7F4afpovn
         l30TdUg8eHdxmmj9VHOhAIqwU8RrmaNRsNle4aBZqYyWaIGQIPXUTnDpq8vXF0NCWnOb
         lrW/Y1ge3HWdc9yNzz8MRlH1/YMeyLcWlWzakQFHH2kgh1hvjLn+kZ7+wTmSn6q8uXNf
         /2qQ==
X-Gm-Message-State: AOAM533z/+9FKRHOLwFE+mKe122VEoisV04W2ZujXUvxr8+UFB4SB8ma
        8ujYI+nTyAxjxGyvFLDja7YIWg==
X-Google-Smtp-Source: ABdhPJyrLflzW+OohhHuQBd5kScDJnTZGVrPGqJeEKaquqlC5N0ZXttwfYEPggjDOml6EKMuunb2XA==
X-Received: by 2002:aa7:82ce:0:b029:242:deb4:9442 with SMTP id f14-20020aa782ce0000b0290242deb49442mr21579555pfn.73.1619501790821;
        Mon, 26 Apr 2021 22:36:30 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3984:c4f5:8612:6b3e])
        by smtp.gmail.com with ESMTPSA id gc15sm993529pjb.2.2021.04.26.22.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 22:36:30 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-i2c@vger.kernel.org, Qii Wang <qii.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v20 3/5] i2c: mediatek: mt65xx: add optional vbus-supply
Date:   Tue, 27 Apr 2021 13:36:15 +0800
Message-Id: <20210427053617.27972-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427053617.27972-1-hsinyi@chromium.org>
References: <20210427053617.27972-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vbus-supply which provides power to SCL/SDA. Pass this regulator
into core so it can be turned on/off for low power mode support.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/i2c/busses/i2c-mt65xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 2ffd2f354d0a..82f2b6716005 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -1215,6 +1215,13 @@ static int mtk_i2c_probe(struct platform_device *pdev)
 	i2c->adap.quirks = i2c->dev_comp->quirks;
 	i2c->adap.timeout = 2 * HZ;
 	i2c->adap.retries = 1;
+	i2c->adap.bus_regulator = devm_regulator_get_optional(&pdev->dev, "vbus");
+	if (IS_ERR(i2c->adap.bus_regulator)) {
+		if (PTR_ERR(i2c->adap.bus_regulator) == -ENODEV)
+			i2c->adap.bus_regulator = NULL;
+		else
+			return PTR_ERR(i2c->adap.bus_regulator);
+	}
 
 	ret = mtk_i2c_parse_dt(pdev->dev.of_node, i2c);
 	if (ret)
-- 
2.31.1.498.g6c1eba8ee3d-goog

