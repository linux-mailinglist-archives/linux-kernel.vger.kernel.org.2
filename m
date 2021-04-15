Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC33605FC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhDOJij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:38:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40244 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhDOJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:38:37 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWyRy-0005z6-2x
        for linux-kernel@vger.kernel.org; Thu, 15 Apr 2021 09:38:14 +0000
Received: by mail-ed1-f69.google.com with SMTP id i5-20020aa7dd050000b02903830cafa575so3446062edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7z2ouZqcZvLyEOcdE7FnfhcpFO/282ITnfmb7UR/10=;
        b=RhC3hUjr46WIEsE55j0hitFlWJ4NcN6/teZpqJ3q1WgAeHKJL8fvDPu+gla4Ol/s03
         KXULHhwhwQCAoeM+ZT27g+RB1DbEbKhbVFtO+7cJoREFm6MY9RoHKNRzfMUSQ9ySGIeM
         XPYiKWEX9s2wk9O0UJmExdAz0TUIPLRS2/BEZGwxWhGcr+p7+zTyupSlL3uC0pEJdr6X
         I8BCL8nshlrhldKdOG8+6OZXsV0e64R3Q/FsgHo33KNNADUTwt6/3+V9VFqTA0gE8OQC
         S/Nd7W/XcGDoJQyehtwcvw+LM+Ss2h+cQZmXV210MPc7J8haarvBkbD9gEIr+/wGJHpz
         OeTw==
X-Gm-Message-State: AOAM530D2qU1LWZ+O20B3qaeYCtrgNGasptOMmGjAzwtR+UvRlH5hC35
        5KPlfVNTVV1LBNYykNe9gWE/Q2+hKYLpfCOPDPRbj0c2rOgPYrzKt0uG79H941go8/Zwe720iWS
        hEGBToP5q7NfrxQ6llPNjUER4rdtrQMumHkhwyBJQqA==
X-Received: by 2002:a05:6402:441:: with SMTP id p1mr3050354edw.298.1618479493843;
        Thu, 15 Apr 2021 02:38:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjTWhXTydv5lD8MaRLQ1f9/d9f9dV/fzvHNm6rGHF/jEEPA7jl/HaK9McUQpiTlM0C77cbrw==
X-Received: by 2002:a05:6402:441:: with SMTP id p1mr3050341edw.298.1618479493689;
        Thu, 15 Apr 2021 02:38:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id cq26sm1954088edb.60.2021.04.15.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:38:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 1/2] i2c: s3c2410: simplify getting of_device_id match data
Date:   Thu, 15 Apr 2021 11:38:02 +0200
Message-Id: <20210415093803.162673-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 62a903fbe912..ab928613afba 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/mfd/syscon.h>
@@ -156,12 +157,8 @@ MODULE_DEVICE_TABLE(of, s3c24xx_i2c_match);
  */
 static inline kernel_ulong_t s3c24xx_get_device_quirks(struct platform_device *pdev)
 {
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-
-		match = of_match_node(s3c24xx_i2c_match, pdev->dev.of_node);
-		return (kernel_ulong_t)match->data;
-	}
+	if (pdev->dev.of_node)
+		return (kernel_ulong_t)of_device_get_match_data(&pdev->dev);
 
 	return platform_get_device_id(pdev)->driver_data;
 }
-- 
2.25.1

