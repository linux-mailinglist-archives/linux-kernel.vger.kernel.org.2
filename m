Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A292365E15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhDTRCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:02:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50077 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhDTRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:02:05 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtkj-0004TR-8o
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 17:01:33 +0000
Received: by mail-ed1-f72.google.com with SMTP id m18-20020a0564025112b0290378d2a266ebso13455910edd.15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cK2ReUjBLXXBh4lxBc6DTRo7cWOdEm7mAeUsBKVXSvQ=;
        b=RdJ6p7zMK63RHi4fnGdtjMCLrNuuISp5g3flatNxcCvDyMIj2Ibj5QIWbQHqaUD0XM
         9gtMFTw1gUiq8TnA280ShHTxOBxR50xQYMyRx0eNqw8fu4g2OfWzK0ZuAKMaW9ufEXYN
         x1S9rRkafSRxl+ALudePkN5X4dBAPWpI0zyQoErkqjLKa7cPyAGvIgH6GYv/icnFDO4o
         Spoc073NyXCOLIEc1ehYbNe/LvUgrixAAYUra2SXCtsoc8A3CCUUSPLp+5j5sXTH6ngn
         ju4oSV4C02TiLirV5wdIKmEJBWwzmYmrPF+SACbGWphsHqLlqmhwvpgMsqvPmXRLQHqR
         l5aQ==
X-Gm-Message-State: AOAM530Qo9fKuTtN5viDTDpURgKkUdw1mwAqTOd9W6J1if73KqIxl2TD
        uHWkZ9CtXokPoFJ+UvP2Ir+73erUbBw90PPOwlDg6gq3IEGXqtukz1b4+Dri2NH5KkXKSSq35XG
        m6inGn0TZd49oA84Y331sqOyD6nyQ3QW5YFCbELhLfg==
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr33272138edv.333.1618938092891;
        Tue, 20 Apr 2021 10:01:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsfo95Qfe4xzN04pErckPsV4xUg8gCjdkg5/kz+p8rSAzf6rBygGzRUjfOHfAKmqHyncJAFA==
X-Received: by 2002:a05:6402:1393:: with SMTP id b19mr33272118edv.333.1618938092757;
        Tue, 20 Apr 2021 10:01:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id x7sm16334441eds.67.2021.04.20.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:01:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 2/9] mfd: sec: Remove unused cfg_pmic_irq in platform data
Date:   Tue, 20 Apr 2021 19:01:11 +0200
Message-Id: <20210420170118.12788-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420170118.12788-1-krzysztof.kozlowski@canonical.com>
References: <20210420170118.12788-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'cfg_pmic_irq' field of platform data structure is not used and can
be safely dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/sec-core.c           | 3 ---
 include/linux/mfd/samsung/core.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index c61c1fc62165..653d02b98d53 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -382,9 +382,6 @@ static int sec_pmic_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	if (pdata->cfg_pmic_irq)
-		pdata->cfg_pmic_irq();
-
 	sec_irq_init(sec_pmic);
 
 	pm_runtime_set_active(sec_pmic->dev);
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index f1631a39acfc..68afc2b97a41 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -85,7 +85,6 @@ struct sec_platform_data {
 	int				num_regulators;
 
 	int				irq_base;
-	int				(*cfg_pmic_irq)(void);
 
 	bool				wakeup;
 	bool				buck_voltage_lock;
-- 
2.25.1

