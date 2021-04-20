Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16E33657B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhDTLkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:40:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39090 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhDTLkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:40:07 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYoj8-0005TR-Np
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 11:39:34 +0000
Received: by mail-ej1-f70.google.com with SMTP id o25-20020a1709061d59b029037c94676df5so4669667ejh.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 04:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wuB2/tI9xcQwhhNMwxEVaEgHMJT+b83uq8pd/UhDHWg=;
        b=C4gBJR3kO2bsOunjjH1C2hMJsvZh+IAagdzs99OKkpCL4wEXyAKLWcVQIpM4PRNIEo
         j7BqGpgiqe2dcJHfrnme0ZVOyrtWeuQDHFHfkiBJyoRLO086aYAgWbxG+C4LU19Mutv2
         9Umqlwmc6PXwqBqv5e7mT08s9xMDMjU2CqtJfOwvVHJGjwxXHzc6Rnr040I7KA9o/KZR
         TVN4U3fRauM3ky6zfY2ElQoC7HXc5slZObakQxyPYSLT7r5+PKhOuxGHFrgRYQcKyjJi
         3P4SfPUlUPg2gcSCxKP3QTkiohbPj1aRyIAHe16lLZU8HI2MoreU2PJ6JBoeqbyuB0Pa
         mlNA==
X-Gm-Message-State: AOAM533r/O6HAf/me/WD4Sd1HvVM/JNTbbfiES3VMc96kTfTvT+i69Fl
        z+58NWgKD1XAaSR5NUwqW0Ahi5KWw9ntUOgpdpvSn29xpLy3nZA2FxuhI/DPsz4jlRoNlDLra56
        YCrDheOU+3lcjRZMW2PXKkDGZNF/O1/OJAQo/fMUwsA==
X-Received: by 2002:a50:fe01:: with SMTP id f1mr32499239edt.272.1618918774494;
        Tue, 20 Apr 2021 04:39:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7Xuk25grH3NsIgvMGGGwnXop0ZMYNrJctTBWfujHm1kJVpv/I1QXZELdTEgMAyJL7wTYErA==
X-Received: by 2002:a50:fe01:: with SMTP id f1mr32499223edt.272.1618918774374;
        Tue, 20 Apr 2021 04:39:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id bw26sm10109007ejb.119.2021.04.20.04.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 04:39:34 -0700 (PDT)
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
Subject: [PATCH v2 2/7] mfd: max8998: Simplify getting of_device_id match data
Date:   Tue, 20 Apr 2021 13:39:24 +0200
Message-Id: <20210420113929.278082-2-krzysztof.kozlowski@canonical.com>
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
1. Remove check for CONFIG_OF
---
 drivers/mfd/max8998.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 785f8e9841b7..0eb15e611b67 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
 #include <linux/mutex.h>
@@ -155,11 +156,8 @@ static struct max8998_platform_data *max8998_i2c_parse_dt_pdata(
 static inline unsigned long max8998_i2c_get_driver_data(struct i2c_client *i2c,
 						const struct i2c_device_id *id)
 {
-	if (IS_ENABLED(CONFIG_OF) && i2c->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(max8998_dt_match, i2c->dev.of_node);
-		return (unsigned long)match->data;
-	}
+	if (i2c->dev.of_node)
+		return (unsigned long)of_device_get_match_data(&i2c->dev);
 
 	return id->driver_data;
 }
-- 
2.25.1

