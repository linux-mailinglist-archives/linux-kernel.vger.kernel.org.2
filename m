Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576B5363D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhDSISG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:18:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50409 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhDSISD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:18:03 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYP63-0007sg-LC
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 08:17:31 +0000
Received: by mail-ed1-f71.google.com with SMTP id n18-20020a0564020612b02903853320059eso1732554edv.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3LUGEJmp+br9C+4Vo+YUNsyCt/PXk3aFn54roSqdS8=;
        b=fohaNoB+Ob/SstC0bUq+WbCiBP4JoW7ZYB86+NgVBFF4Egf8B8baGpF9noBqlRFWse
         QTqGxf75/DcaSgmUb0cY/2TYUA/1PnGqcnZ+S0KazvWkoBYm7179omrcjKG/n7sn/toh
         Pkh4GHi5pE1VAMlachz5AM21KpIsW1OotqJhzeCiDRTDXiomiEWVNFJDzVjlWbBlFEBv
         qiVFJdg2GPQfA75qDmsifhQMejMDhD0dV89YXmzn8YMFQEWXeY2dIpAFXRFLCiWPAthr
         6Xdep/NEUE3Kz+w+0zO2HOXlExhk7ZBLzW00mwlpCqWheButjE4V2gNCQ3NtRBX1UMdv
         yIlg==
X-Gm-Message-State: AOAM533oAoUSUJhzeerM2iwQvXWLGdd+Hi6hzifD0/ggCJJuIeP0n1di
        y/Z79g0Yf+gjULK4+SwWk6c0RtuDmfeOpWIJMDeSILxYWV76PyYVKD2A3t/SXWXiDShgpBHl6s5
        ZKQfz7z8DqKvSM21goDQVeLU4OjUIAoZ9viitzVQC6w==
X-Received: by 2002:a17:906:7d82:: with SMTP id v2mr21176587ejo.524.1618820251388;
        Mon, 19 Apr 2021 01:17:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy4EtMQXnut0wnOGkwOw0Mdy3TCBQQu/E5EuD6rk7PBrCTRVZtUjf3OIo0bVwGNEkZ4dAKsw==
X-Received: by 2002:a17:906:7d82:: with SMTP id v2mr21176578ejo.524.1618820251260;
        Mon, 19 Apr 2021 01:17:31 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id da13sm12384781edb.6.2021.04.19.01.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 01:17:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 1/7] mfd: max8997: Simplify getting of_device_id match data
Date:   Mon, 19 Apr 2021 10:17:20 +0200
Message-Id: <20210419081726.67867-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/max8997.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 68d8f2b95287..f89b1eb121c9 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
@@ -145,11 +146,9 @@ static struct max8997_platform_data *max8997_i2c_parse_dt_pdata(
 static inline unsigned long max8997_i2c_get_driver_data(struct i2c_client *i2c,
 						const struct i2c_device_id *id)
 {
-	if (IS_ENABLED(CONFIG_OF) && i2c->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(max8997_pmic_dt_match, i2c->dev.of_node);
-		return (unsigned long)match->data;
-	}
+	if (IS_ENABLED(CONFIG_OF) && i2c->dev.of_node)
+		return (unsigned long)of_device_get_match_data(&i2c->dev);
+
 	return id->driver_data;
 }
 
-- 
2.25.1

