Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2374E394230
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhE1LxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:53:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41036 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbhE1LxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:53:00 -0400
Received: from mail-ua1-f71.google.com ([209.85.222.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmb1R-00041J-C3
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 11:51:25 +0000
Received: by mail-ua1-f71.google.com with SMTP id f2-20020ab006020000b02902124881cdf4so1798613uaf.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 04:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+A7NmETeNVsWXQhhgLVcq4I2U3ly5GO/4a+00+Ltec0=;
        b=ms63Drl9UMhn2vdZBtRMND8JPXeK5fHzH6j1evGWNCBMDnp70AOpCQXkVOkIIIJ6yK
         JBBNclm+TdGttjwh99w3qnb5KQBkfwS8mVespn/UIHzDVTdcUs0fpxINjzSPvEOb2JPH
         3h+dXcjjhljCi7bwab3vqDwCxdjINxi/yvP6GjvPmQ+IFd+1FEII90gfRYhE/l0wA7M1
         G0/6byNE7ozKQMDbRd7w3Z0MTf+YS78bBXEpQzReLTxbmR4u/Jqf6d2qU6hmhoOJ6Y5t
         ns5HkPMwlT7tLy319t/2zxxc0/Rf+NDqeTLDnb8TC0utk7IcysZrOQ3hBTmJEq9D2LvN
         sDAQ==
X-Gm-Message-State: AOAM530V1mwk0hmqtqncq2cxN46/0XsGE0M1SDw05ngHHVY91F7GYuuj
        U8Lvm9ZPguO0I2RzOKGazRmi3DmCJYlh0PkWwbStBxs2wfo0bEONCCYAxXu+Tc6vxD8gYnMyYJ6
        Km5Xm+VSTWF74Ugw9KvyA6C+Ob6eme+E1ftCleGMkbw==
X-Received: by 2002:a67:6a02:: with SMTP id f2mr6264730vsc.49.1622202680526;
        Fri, 28 May 2021 04:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8wp965ZXdOS/URJI0BlvrioKqZR1rbzc1/KfnNkSONQtzH+C+OVVa8fj46i7Np0GVLTF3wQ==
X-Received: by 2002:a67:6a02:: with SMTP id f2mr6264723vsc.49.1622202680342;
        Fri, 28 May 2021 04:51:20 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id 189sm669831vkz.51.2021.05.28.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 04:51:19 -0700 (PDT)
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
Subject: [RESEND PATCH 2/2] thermal: sprd: add missing of_node_put for loop iteration
Date:   Fri, 28 May 2021 07:50:36 -0400
Message-Id: <20210528115036.18222-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528115036.18222-1-krzysztof.kozlowski@canonical.com>
References: <20210528115036.18222-1-krzysztof.kozlowski@canonical.com>
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
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
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
2.27.0

