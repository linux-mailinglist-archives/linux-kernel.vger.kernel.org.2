Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F936A8A9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhDYRtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 13:49:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51445 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhDYRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 13:49:17 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lais0-0005D3-QS
        for linux-kernel@vger.kernel.org; Sun, 25 Apr 2021 17:48:36 +0000
Received: by mail-ed1-f71.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso21696253edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 10:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPLSoZ/tcqePUCSPTFPBT43x+MShOvw/eATV++A32uY=;
        b=LKQW63D6Ffah0JRqAPh8MoEqp8ypeNYudavZfLh+snJjfMUtwhcAOPr7jS0xoGlTs6
         /SsfkKkkYxSJ0mv71omDrn6qmHU3eW6LBL5sOqeUfOYU/UeYf0Y3StD/uBsjhV172vgw
         kZLAzUNtRflafGL0naVGbCGNSSfcBLOPl1bdP1vqNDIKaiCzq5HdpRie13UsXMppEtcJ
         W0blE+4x02kKz16DLdiYPTQHXpoYSTYwf88UR+MpQFazg7O3HPM4CJMaSTJVu4YekYH/
         OiS4ixoTGmhbKYp0kKlL0rO39AzuWaXaEUfgf1W9eivPGgwHmdiLk9lZtt1/Ziq9DQ3D
         HQPg==
X-Gm-Message-State: AOAM531pMEW58wL9juhsPEk9GLDKX46N1dBE75SkYYj+TW7nLQLjhmxN
        alDno+BusX+9E3kAAvoajBSt7/zxAEqUfC5OxtlJRnv/DJaYTYhnFjSJjSG0OQrWP+8CC4UkBnQ
        WcRogmfiqKyFZHSJMMNt60A4pBA2goIanXSOaYHX5Ew==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr14535247ejc.283.1619372915989;
        Sun, 25 Apr 2021 10:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwDYTMcE/A1dbagzjZUokQ/3sexJzDoZwW2rVwFta8ofhbvG82emcgOUJvU4/jj3FwCYRVQw==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr14535230ejc.283.1619372915860;
        Sun, 25 Apr 2021 10:48:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm10306849eja.12.2021.04.25.10.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 10:48:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] thermal: sprd: add missing of_node_put for loop iteration
Date:   Sun, 25 Apr 2021 19:48:31 +0200
Message-Id: <20210425174831.164332-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210425174831.164332-1-krzysztof.kozlowski@canonical.com>
References: <20210425174831.164332-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/thermal/sprd_thermal.c:387:1-23: WARNING:
    Function "for_each_child_of_node" should have of_node_put() before goto around lines 391.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/thermal/sprd_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index 3682edb2f466..2778971aaf03 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -388,6 +388,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
 		if (!sen) {
 			ret = -ENOMEM;
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
@@ -397,12 +398,14 @@ static int sprd_thm_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(sen_child, "reg", &sen->id);
 		if (ret) {
 			dev_err(&pdev->dev, "get sensor reg failed");
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
 		ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
 		if (ret) {
 			dev_err(&pdev->dev, "efuse cal analysis failed");
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
@@ -416,6 +419,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "register thermal zone failed %d\n",
 				sen->id);
 			ret = PTR_ERR(sen->tzd);
+			of_node_put(sen_child);
 			goto disable_clk;
 		}
 
-- 
2.25.1

