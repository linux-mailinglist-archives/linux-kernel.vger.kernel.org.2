Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51403657C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhDTLkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:40:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39120 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhDTLkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:40:09 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYojB-0005V1-F6
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 11:39:37 +0000
Received: by mail-ed1-f72.google.com with SMTP id cz7-20020a0564021ca7b02903853d41d8adso3658104edb.17
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 04:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z90S5N2Vf8o3affpqAJ/qKsRULU7kNCm7WTR7sGPJFI=;
        b=gYf+24PKIxLmi4rwi+1fkU9bZaG8hbkxJimRkxXpt1/2m+MvwYQDxKUFdIJzwYxMJD
         X4yJKwPy/IqnVMCtX8tWjoadqHKf7zGXenX4BMTyXC592pRvzxJBR15IQDCxDctGGV2k
         Tis0MB+gJOtCKm0A/O1vHHt82YEIxqKccW1q8OEZCb571mrgVs5oskSiD7kNCqs5kqla
         1+BBzIc7OHeHD2Q1+XmMcLPokMtyUHm7whaePPFx2Z6UFQR7q3EsLyy8gpptgpcrUBMt
         HbZD+BW7b7Hi9MAv4FSYAN75V87TNKYa5WYx7reFyPDzUJFPKxrcRvg7C+AYkNSUR4Yo
         fDQQ==
X-Gm-Message-State: AOAM532lnnfaML2LXGRiAnAj90KSA943HsjV2fiFhGl1OGlb/aDpHUCy
        OWJ5B20J/F6G0la54qBWknueCHwBENZ8N3pStLIyjOC0MnpAkzXKepmWwjbJ1sWcb6QPdzS6yB8
        0SCPoN9xJLunok3rYsxuNkLz+MIZNso96rR8u2vjNxA==
X-Received: by 2002:aa7:da15:: with SMTP id r21mr31299683eds.253.1618918777054;
        Tue, 20 Apr 2021 04:39:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDLe7voWiCNzz20rbTRMwYK/knYegMngT8XRwqFQSN5JSDPctogln3VwQ/zsXtlLbeBhoQVg==
X-Received: by 2002:aa7:da15:: with SMTP id r21mr31299662eds.253.1618918776947;
        Tue, 20 Apr 2021 04:39:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id bw26sm10109007ejb.119.2021.04.20.04.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 04:39:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 4/7] mfd: da9062: Simplify getting of_device_id match data
Date:   Tue, 20 Apr 2021 13:39:26 +0200
Message-Id: <20210420113929.278082-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
References: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

---

Changes since v1:
1. Add Ack
2. Correct subject prefix
---
 drivers/mfd/da9062-core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 8d913375152d..01f8e10dfa55 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/irq.h>
 #include <linux/mfd/core.h>
@@ -622,7 +623,6 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
 	struct da9062 *chip;
-	const struct of_device_id *match;
 	unsigned int irq_base;
 	const struct mfd_cell *cell;
 	const struct regmap_irq_chip *irq_chip;
@@ -635,15 +635,10 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	if (!chip)
 		return -ENOMEM;
 
-	if (i2c->dev.of_node) {
-		match = of_match_node(da9062_dt_ids, i2c->dev.of_node);
-		if (!match)
-			return -EINVAL;
-
-		chip->chip_type = (uintptr_t)match->data;
-	} else {
+	if (i2c->dev.of_node)
+		chip->chip_type = (uintptr_t)of_device_get_match_data(&i2c->dev);
+	else
 		chip->chip_type = id->driver_data;
-	}
 
 	i2c_set_clientdata(i2c, chip);
 	chip->dev = &i2c->dev;
-- 
2.25.1

