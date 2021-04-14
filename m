Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82135F9D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350838AbhDNRaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350393AbhDNR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:29:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C79C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:29:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso11192426pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plmO0AdMl820K1E1EewPUIFFIYm0UYQ8GWMNCMfiNMs=;
        b=LWWkG7tf2pAAxOYa62M6wF4DR6wuiuWheoc5zSNFuwA0w62Prt2SPX7h0tg3QF4d2V
         44nkwDeNFfIzGlhxsD0/euzgJwjZy8/voyo4Fri/H5W/ug6v0hmlUPQH+WHtMo0TjM9m
         zGTvuXagrcNpxaxXK+HoZoVJQf5Z62gbvDiKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plmO0AdMl820K1E1EewPUIFFIYm0UYQ8GWMNCMfiNMs=;
        b=X07hx3+DCXBa+aQHPea2Ydzj+35IC9ySyckz9kxKXfchN99Yh01icjBl38vTqSTUVw
         aXnHtnGQn+66Asem+gwrdNTAgziqFjX5JwDMLE7UrImRxZ7B2rulNutZ0QGnLhsOEP3P
         kkDFyazSP2E/fzfSRgdw1UMU0Y0wZz+pykdyew7g0BJzSJZpEDBmFJD56h/VoPF8Y80h
         ye3lvZ17SXsd4l1n5tJqywuSr8s03Tdm53nfgnpiPQBVxm4zapGan0Xw3OkO3qjLEy/w
         aigfqDmpYlmkkZo0wCn9RkhUfELauosIH5SHrOpjWG0cagwtKCMhC/+ryn8sSr18rqC6
         3a3w==
X-Gm-Message-State: AOAM532jZ1q4pcWdGwBmPjebDd8Q577k50GQbB9CMFdQhr8CgMFq78tp
        1yFeRBTcmrj3RpIwotz1g07uwA==
X-Google-Smtp-Source: ABdhPJzqi2vvW8j/Szl8iVKwjP6K0nUzELS0dvdFZgmCztvcUb4kX2kyyJdsJNS5/ctFp046mYN23w==
X-Received: by 2002:a17:902:fe91:b029:eb:ad8:c5f with SMTP id x17-20020a170902fe91b02900eb0ad80c5fmr15248007plm.63.1618421371078;
        Wed, 14 Apr 2021 10:29:31 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:bae3:4af0:9792:1539])
        by smtp.gmail.com with ESMTPSA id e31sm63460pjk.4.2021.04.14.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 10:29:30 -0700 (PDT)
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
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v19 3/6] i2c: mediatek: mt65xx: add optional vbus-supply
Date:   Thu, 15 Apr 2021 01:29:13 +0800
Message-Id: <20210414172916.2689361-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414172916.2689361-1-hsinyi@chromium.org>
References: <20210414172916.2689361-1-hsinyi@chromium.org>
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
2.31.1.295.g9ea45b61b8-goog

