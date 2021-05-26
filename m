Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598D9391DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhEZRXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:23:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36808 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhEZRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:22:39 -0400
Received: from mail-vs1-f72.google.com ([209.85.217.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llxDN-0003eL-EB
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 17:21:06 +0000
Received: by mail-vs1-f72.google.com with SMTP id d19-20020a0561020413b029023877d74e72so551785vsq.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 10:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYv9QSwtcmYn0218F0zCf1aEruGYQ8/WBysY7w5EfCc=;
        b=kFkBpQMWb+AzJDEVvqG502r+SFqcwxG8VMwbqNPkW5raTccxz5A5rQrCL7z/A1MsJE
         YxCdWOXCmY1kxyhNNKl4OBGqoOq0uc/4fdq4vILAsYb1/1TekfLSmZ9sXFD9XVp+EIjP
         zvVFnI0dK2hbRqJPwfGvGHN4830y78lTsjNI1g/z6nBTDGAOJ7dHPkxX0ZNgscz27GpB
         +YV0stwMPLVS0RXxXk55lPBuf5hRA6XmU9Ug8ykVvTNmvYynDnznCN03hP4cQuPiZqnL
         5TepyueG9VA3S1qfl5wH6eDCzNMvxwhQisEWnRpN4hQWH6AhLMsihfMJGx8bW2RwXZfM
         5lSg==
X-Gm-Message-State: AOAM5313uAx3s1uzW851Jb6BQHXtoPOnkg6GZSnWkz3eU4XT7LU/o5uo
        vZMuaQU6RmMto3/aUOdgtrB5/lSDOzengPPz1ZaAKOkPTbeI2dn3MEp5PxPRxvD0JHnbOu1iVqq
        WU032iuYwSQJWrsNbMbWRdYHkDqZSICzjZne70NLmqQ==
X-Received: by 2002:ac5:c382:: with SMTP id s2mr31980821vkk.24.1622049664525;
        Wed, 26 May 2021 10:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBWWyrs1VJTSEVr7gNlAWxnMbfMY4X+d68llpnvHKbyCP4O8ma7yU99jBXSJa7bdYyXsWV8g==
X-Received: by 2002:ac5:c382:: with SMTP id s2mr31980793vkk.24.1622049664379;
        Wed, 26 May 2021 10:21:04 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id u195sm2036032vsc.10.2021.05.26.10.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 10:21:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 7/7] power: supply: max17040: Do not enforce (incorrect) interrupt trigger type
Date:   Wed, 26 May 2021 13:20:36 -0400
Message-Id: <20210526172036.183223-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210526172036.183223-1-krzysztof.kozlowski@canonical.com>
References: <20210526172036.183223-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Interrupt line can be configured on different hardware in different way,
even inverted.  Therefore driver should not enforce specific trigger
type - edge falling - but instead rely on Devicetree to configure it.

The Maxim 14577/77836 datasheets describe the interrupt line as active
low with a requirement of acknowledge from the CPU therefore the edge
falling is not correct.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Iskren Chernev <iskren.chernev@gmail.com>

---

Changes since v1:
1. Remove the 'flags' variable.
2. Added ack.
3. Rebase - the bindings were converted to dtschema.
---
 .../devicetree/bindings/power/supply/maxim,max17040.yaml      | 2 +-
 drivers/power/supply/max17040_battery.c                       | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
index de91cf3f058c..f792d06db413 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
@@ -89,7 +89,7 @@ examples:
         reg = <0x36>;
         maxim,alert-low-soc-level = <10>;
         interrupt-parent = <&gpio7>;
-        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+        interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
         wakeup-source;
       };
     };
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 1aab868adabf..e80dd9141ae7 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -361,12 +361,10 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
 static int max17040_enable_alert_irq(struct max17040_chip *chip)
 {
 	struct i2c_client *client = chip->client;
-	unsigned int flags;
 	int ret;
 
-	flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
 	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					max17040_thread_handler, flags,
+					max17040_thread_handler, IRQF_ONESHOT,
 					chip->battery->desc->name, chip);
 
 	return ret;
-- 
2.27.0

