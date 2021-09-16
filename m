Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329D940E3ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbhIPQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:53:07 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53402
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245256AbhIPQsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:48:12 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 278DB40291
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631810809;
        bh=SMR3OEjJnvU6Lq70UuE37nqW0hNeWUERd9tx+SjC/vg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TI0DBY4jjXkzmNSWBNIg+LzPLp9ZS0NbXca7o7I0ZjPYvFWmj/dc/DQ7f11nWOPnd
         5B4/8AtliYSv9Z/JFO1jECXr7ecd6hOaUUZlAHK7t640maLVCSkVokaZa2SPpedc5z
         NMzklmvnlY38/KrGUYTCpJehrhBXl39TG/LyhiV5/2qfMSE9puTodNfmQdEhu89vSC
         ROHdj7a+VriYPKG7GbY42mrHLeL2F/vzz/MkUGvFO5DbTONt1hJAlVwHV52iOKpDg+
         BqlMWUWnO35FoNErQX5viiprPaTjZYlcW/8tEfbpM9cML/kaOt8n0hedVwpErfnZYo
         kJVwR8vJmnXKg==
Received: by mail-wr1-f70.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so2672523wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMR3OEjJnvU6Lq70UuE37nqW0hNeWUERd9tx+SjC/vg=;
        b=uavBFFXaUBC0oFm1fb2a+BK2A8szAHPLroM7EJm06f0WSYalJ02SFAHfvZtAXfMUOu
         NVTPJd69jp6nn+6m1Pu5uAUpJYpEPuoA+dn/CkUMpQTcvu1FWHC+rFXeJUAeAkS0Nlfh
         AXpqLr4uIg+H7W/fagdibRWphTEXbqyd0lIsOguiUX1a2+QwUoyUPsn8oLpJ25WyL8cm
         a0BOyf0P4GueT2AokL0NSc2X7EEPi+09kjQiM3ZOb3W1085UzB/Dynw716QKzv56ObYf
         KLZLKGQeWtj7wdMNl0kxVlgYlQyGGffVk0BYXnTGQCrf6XddZZLJIgTjHc6PQCyhxJsl
         q9Fg==
X-Gm-Message-State: AOAM5318Lc+upMBVedGDgIP4CD+xqrstmw/pOQVW+I0717MXWZZOMYFT
        kNzpJEZtE06l2XSHD0GBGGim0Nn9+NFgWqgowuaNZE7qwj83dIsR25xBVOTD4Mc9g3KOGGlWPAK
        8GE2+dWBRQMD7y/cdN8V+M/oX1xyT/bXteqTi1u/bfg==
X-Received: by 2002:adf:b7c1:: with SMTP id t1mr7086033wre.387.1631810808900;
        Thu, 16 Sep 2021 09:46:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk+/VktLMkMTDXQ8ed1cN2PJYqdXSHljTkdq8A5dkKwHxD6n28xm+Y9U8aBc6AaCQuaMX66A==
X-Received: by 2002:adf:b7c1:: with SMTP id t1mr7086023wre.387.1631810808793;
        Thu, 16 Sep 2021 09:46:48 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id o1sm3975340wru.91.2021.09.16.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:46:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] gpio: tps65218: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 18:46:41 +0200
Message-Id: <20210916164641.135008-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916164641.135008-1-krzysztof.kozlowski@canonical.com>
References: <20210916164641.135008-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/gpio/gpio-tps65218.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index 3517debe2b0b..912382be48e1 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -230,4 +230,3 @@ module_platform_driver(tps65218_gpio_driver);
 MODULE_AUTHOR("Nicolas Saenz Julienne <nicolassaenzj@gmail.com>");
 MODULE_DESCRIPTION("GPO interface for TPS65218 PMICs");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:tps65218-gpio");
-- 
2.30.2

