Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8EE3657C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhDTLkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:40:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39132 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhDTLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:40:10 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYojC-0005Vt-CP
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 11:39:38 +0000
Received: by mail-ej1-f71.google.com with SMTP id re9-20020a170906d8c9b029037ca22d6744so4645397ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 04:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uA4zMXERcZERRFVtvNG5BrrsNQ88clv/v46eOD0pR5M=;
        b=JdBYJvy5EXIScsYh3cuqasjR/2eAj/biQNp+o0jM+2wPgC75hMbuOESqvMjhLsGXC3
         uaC84koCkbuRlttl9gkzgvHmEgxMliA1O1Qead0DA07s0a5x5tq5bl9tU4ZiuIyl658S
         9bfQ816WzfdUFIkY54voXbRGynPtYJInLj4pFoWGYZ5YZLZyyMQw9RcgJXXLiDnKPeyI
         YWU51eT7jFNxURW1K+WJwsLnEANIf8Scbb59ZUXNcqyjL0+P+RY+CNdNty6KAdh7lG7S
         ao/NQl5MDSP2/2GAISF1u8cqkOC2/P+ivDB3Y+on3iKRinyhuGhvJ+w6O7ZAb63PfO2c
         5kbg==
X-Gm-Message-State: AOAM530I4skQapm3HyzaH74rKpfKOi16nv4sn/Io8bBvGgFQw82wyV8C
        B1hTa753S6gUliaiPZac/mdmyCZSqcPynWaVq3/3LWid2K3AaJFqUKHcW4GyvRIwPMnjiZMN9iA
        VAijFf3YLYKnIlKDkkv6pxup+XPd2CBsqugMITk9lug==
X-Received: by 2002:a05:6402:3ce:: with SMTP id t14mr15486431edw.142.1618918778135;
        Tue, 20 Apr 2021 04:39:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAd4zKG30DBWanjfBjytY6/YSWvfxCxt0tF6VGi/LLUDA2FbF6zidPnO/1qnhDujdnL0Nc+A==
X-Received: by 2002:a05:6402:3ce:: with SMTP id t14mr15486421edw.142.1618918778034;
        Tue, 20 Apr 2021 04:39:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id bw26sm10109007ejb.119.2021.04.20.04.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 04:39:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v2 5/7] mfd: sec: Simplify getting of_device_id match data
Date:   Tue, 20 Apr 2021 13:39:27 +0200
Message-Id: <20210420113929.278082-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
References: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to make the code slightly smaller.  There
is also no need to wrap it in a check for CONFIG_OF, because dev.of_node
will be set only with OF support.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Remove check for CONFIG_OF as suggested by Marek
---
 drivers/mfd/sec-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 8d55992da19e..15dd4c579937 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
@@ -323,14 +324,9 @@ sec_pmic_i2c_parse_dt_pdata(struct device *dev)
 static inline unsigned long sec_i2c_get_driver_data(struct i2c_client *i2c,
 						const struct i2c_device_id *id)
 {
-#ifdef CONFIG_OF
-	if (i2c->dev.of_node) {
-		const struct of_device_id *match;
+	if (i2c->dev.of_node)
+		return (unsigned long)of_device_get_match_data(&i2c->dev);
 
-		match = of_match_node(sec_dt_match, i2c->dev.of_node);
-		return (unsigned long)match->data;
-	}
-#endif
 	return id->driver_data;
 }
 
-- 
2.25.1

