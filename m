Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4A363D47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhDSISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:18:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50438 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhDSISF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:18:05 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYP66-0007uS-Nm
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 08:17:34 +0000
Received: by mail-ed1-f71.google.com with SMTP id i25-20020a50fc190000b0290384fe0dab00so5198644edr.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLN0PMvVAHq0LojAhsPhZSWrezfhIp/EDYrzGUmyMJA=;
        b=pOSrFGp0Ur1ML4SH1eUc7HHk/4CHeY19wxhkiPL7DzgKaQolGWL3BMQS437NGZtN7q
         7zIXvAauidCnehLFFYWMuwiT/ZYR+MXU/Nqq+/xMD2AU5xVJp4Pu4yI4gsWm7laApd8x
         RgEjK8N+AkmlH1WF+WKt+4DuUX2/FuT5msbbxpp5Ck3EufEJAT+V3PYsdb1lAZ3npuVU
         XwT4wVzDXPSdUQIsQzm/TxZ9jtGQbiAs9f9VfvBaklRnkLY4sMD3taU4eecHb2+aiRf4
         6om+u2miSyvMPC4wQwl//1IUDISlFR5iigUfBSYnLrATDjxoDBFCovLgYnu+Ev6DlK0E
         o4dQ==
X-Gm-Message-State: AOAM532axEKHqT5v6ddM1OCmgvdseq8AJHa1HIXwqDHcwEqct6P82LP6
        7pZt7gXT2Gkku7EWV5QO5wOyZ62CwkZpB6VzCfv3ZyG8qpjyfUedsqpCr4HmaCcaA0DFjOtfsoG
        GmoIRsXwU221lnGveor+tD4BrDSdhB5FVofLm4cf8HA==
X-Received: by 2002:aa7:d7d1:: with SMTP id e17mr24637985eds.84.1618820254499;
        Mon, 19 Apr 2021 01:17:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbgbYVj51767PEhDP7VAodeawbzJhcMg0iaGYdt1vBRijmX7LpaevyW3LVDSs2NNzeY/besg==
X-Received: by 2002:aa7:d7d1:: with SMTP id e17mr24637973eds.84.1618820254403;
        Mon, 19 Apr 2021 01:17:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id da13sm12384781edb.6.2021.04.19.01.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 01:17:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 4/7] mfd: da9052: Simplify getting of_device_id match data
Date:   Mon, 19 Apr 2021 10:17:23 +0200
Message-Id: <20210419081726.67867-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419081726.67867-1-krzysztof.kozlowski@canonical.com>
References: <20210419081726.67867-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

