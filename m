Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3940E403
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbhIPQyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:54:25 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53394
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245165AbhIPQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:48:08 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3D96D3F2FC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631810807;
        bh=12aSWj1ztiQqgKWmd2hSEEbr16jSEW8EbSNL339apz0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Xe13lpFL8OGZvjlTuIOs3G+JUE6MjNIgbFq2CHZNnQqK9gaX6OEEhcljc7RzxolV7
         u1YpLzzwg/CNkDyGxww4kWTi5COA5t7iFUTwjb6yv6VG9HH9444y4LcB/PiXUZip38
         cnYJ+hALEGlAtektK5ANFh5kcN0aDEybztOjF/ms80UIj3CMQnzQ5YKSiFrrDtlvlX
         ZH6ARVyu7grIiAryJ6kQBlhoxV4eV3SSjZy2aQh+ufgSOZ3x3xJ7bjRxrTHUspNUEr
         z/O3nWBFAvvMtWIDo7ch7DuWrED4vbDTy22InkTix26AH5tOaS6zt/sC2sh6+/URA4
         ZsQxlZdheBX8g==
Received: by mail-wm1-f69.google.com with SMTP id j16-20020a1c2310000000b0030b3dce20e1so561990wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12aSWj1ztiQqgKWmd2hSEEbr16jSEW8EbSNL339apz0=;
        b=fR4wjjNSYWOXmkezhJE+/HBbJS5CRFRftih8c0ErrPsgrX/pap8K2QrdF2Knz1P7rH
         29tQFm+rmV9ktSgSyr4HeLQOYSyF+AcWLeG6dSsqDcyc/P7Ce3xbqV25Ipx2j85al1ko
         t7BrI+KkLHi6ZQMHbcVdz+P8M0nI8VULNTOgZawDgU1NKbV2VKzC9UCVhru0gqnHk0/V
         zYEhUYmtKlDk4JtwYEIytc4qq2V27aexu9ufdqeSr9Utg4QBpMBclZ/i5PORGXQ8ex2m
         OL5cRVphL2UCbAvLKz954nYSu24HWkGbnWQxdfpwFQSDFztWK1ZrBGOTw53f1Xk335m+
         S5SA==
X-Gm-Message-State: AOAM532rZZgZMwJ+8UAodj1kXn1fS6IiHnXo5VVurbxghcObZ/bTth0M
        z09CzPRq3kvKr5gzR+skFl9PRTLynnmaYqQ2EvaYZQYv37HTmr4j4FzFkUJh0/20oEikUYJrrlK
        VXouQfRqmBwE2SDKRL8ZJ+SH+LDLyLuHcCfvCnqDc/Q==
X-Received: by 2002:a5d:4744:: with SMTP id o4mr7275320wrs.188.1631810806771;
        Thu, 16 Sep 2021 09:46:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw70yN5qCekMYA/rlQ8OzX3mdhQZ6OaZhSR5bUUc9V4g6B0MZyaLy/wh9mnnYQUZFT1U3yQGQ==
X-Received: by 2002:a5d:4744:: with SMTP id o4mr7275306wrs.188.1631810806585;
        Thu, 16 Sep 2021 09:46:46 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id o1sm3975340wru.91.2021.09.16.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:46:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] gpio: max77620: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 18:46:40 +0200
Message-Id: <20210916164641.135008-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/gpio/gpio-max77620.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index 82b3a913005d..ebf9dea6546b 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -365,5 +365,4 @@ module_platform_driver(max77620_gpio_driver);
 MODULE_DESCRIPTION("GPIO interface for MAX77620 and MAX20024 PMIC");
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_AUTHOR("Chaitanya Bandi <bandik@nvidia.com>");
-MODULE_ALIAS("platform:max77620-gpio");
 MODULE_LICENSE("GPL v2");
-- 
2.30.2

