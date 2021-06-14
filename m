Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE23A6ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhFNTYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:24:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35069 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhFNTYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:24:37 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lssAL-0007tn-LS
        for linux-kernel@vger.kernel.org; Mon, 14 Jun 2021 19:22:33 +0000
Received: by mail-ed1-f72.google.com with SMTP id v12-20020aa7dbcc0000b029038fc8e57037so2632691edt.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rFGGgn0LeG2Atp7rG87b+h6mzwgKd/t0DiWuNT+ZsKs=;
        b=R7jRZrVKsxDsFI/5a1yf+3Cy4KhNcj3VwDWATaj111fg0Xjs0E9w8Acn6BxNJmBqeu
         fJfjnxj47Pz1ENkE7G8PmGmdnbj05Fxr+SGCJIiatRxSICLGLV6udT0kh+pr6hT9MK3z
         eMIKC6Nj/LWaubpV0pQlcdd0n/Q0Zs//haZb96yTTsKSW/ULv1DoOY8/5wAjwkQGa/oT
         lGZGoJCs2Rx1cEM1lHphY3+Kk2SYLm+R4jA7JXXzjiSimbPl+6Hsc5PWHDIRY+KhyQUy
         D3OL/t81M0OG1U80QvGqM2db9QcTB5icjx/U49FCYD4eanh5jk/En7mLBEb1UJjBHv3a
         WfCA==
X-Gm-Message-State: AOAM532vQ1UeiZdvYry2bPrm6/UeIIFx2A7gcvE/uChbAHyunRcNQV58
        b7vFvw9WOQDVsMgBQwnL22ExAQwpJKeyWiArmbbNFOmxLDo0PxSwpU9YUUIeiIjmftvYKqyMj9n
        MMa9itoKQzlyDaU8ewgJCaKkAofZhfdzC8g4WyfLyYQ==
X-Received: by 2002:a05:6402:1d0c:: with SMTP id dg12mr18717262edb.155.1623698553422;
        Mon, 14 Jun 2021 12:22:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMsv3DkP07aHqMhlbxy+wuR9SIRdpNR3T1Bs7YyzWUWFtxizGr+EqxJyt9kJ0TE/aqW6tjsg==
X-Received: by 2002:a05:6402:1d0c:: with SMTP id dg12mr18717250edb.155.1623698553308;
        Mon, 14 Jun 2021 12:22:33 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id n23sm9071365edr.46.2021.06.14.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:22:32 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH v2 1/2] thermal: imx_sc: add missing of_node_put for loop iteration
Date:   Mon, 14 Jun 2021 21:22:29 +0200
Message-Id: <20210614192230.19248-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early exits from for_each_available_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/thermal/imx_sc_thermal.c:93:1-33: WARNING:
    Function "for_each_available_child_of_node" should have of_node_put() before return around line 97.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>

---

Changes since v1:
1. None.
---
 drivers/thermal/imx_sc_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index b01d28eca7ee..8d76dbfde6a9 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -93,6 +93,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(np, child) {
 		sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
 		if (!sensor) {
+			of_node_put(child);
 			of_node_put(sensor_np);
 			return -ENOMEM;
 		}
@@ -104,6 +105,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to get valid sensor resource id: %d\n",
 				ret);
+			of_node_put(child);
 			break;
 		}
 
@@ -114,6 +116,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(sensor->tzd)) {
 			dev_err(&pdev->dev, "failed to register thermal zone\n");
 			ret = PTR_ERR(sensor->tzd);
+			of_node_put(child);
 			break;
 		}
 
-- 
2.27.0

