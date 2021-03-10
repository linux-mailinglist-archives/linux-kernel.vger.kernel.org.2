Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1740E334552
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhCJRnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhCJRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:43:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9EC061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:43:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1907755wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVRp3XgdEf96v7bzdf/9udqO1z6/YKzarZhSzPUl2Ao=;
        b=qQNgkKkaoVuUb8svFTJfxDaCJw+KYrPfZ4DjT5xDAeg6PDddio33O0CtuYm6nTYR4y
         cSCCXEmy3S32fkBMfB/hFoJv1Bqt53M6NyOBMWF+8iFEf8Na8T7rXZ7FjdsfkwOGSDih
         jkjX2968pOr5lSbyFAMg0eMti6gE51hbQxx6ewxOMu67bxvU1Ouc8JFgbZsOeA6bw9QB
         XX9aNBhUeUkJuF7l06dtLz15DIGADdgq47TNXfFt1DM2kHcJuWn+rKmxjjRY0IhELP1M
         OWxsTMBu8J5VxfmrGdpAH7Hlr61AZaseHBrdWLFdE9dtVgX3hvL0zAn27YLT7+6hrThK
         XwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVRp3XgdEf96v7bzdf/9udqO1z6/YKzarZhSzPUl2Ao=;
        b=knH9ROxfbKqbiAM85IM8fbqC4E5xfZAjNt6h3wg3VAeYq4VQI1ugREp96vN2PEW1pt
         opluJcoJfbt2TjrYYTi69msVIoBrlZbQUcA4ywOBtVMe/2XrHbhxBDJFOQYlOpenQKPq
         xMsF1DVHsCgyU4P+VyKScTYFgjdgdVEXxSBbMdyV+fK0CxSvzTOahA/egX2qthFJ9z36
         q75U4gfNbjeCFQnKD6bVYaprLjwoNOVaGsr6RMV+5MQW5fecSpDp2GNLLnK7ZtrhHHc8
         ylHINmDYKeQi5DATR7L5vo7PmpK1IbjR3W9UK1aYFaOao8Nnyiq+6M7tmeTRZGSvk0T2
         +3SQ==
X-Gm-Message-State: AOAM532z6tXP0M1Visevjl4Mj7rf7Rss41O8J45ldYWRp60cm36wuWec
        amqdq45IhG0GXVJL6Jkt3Re57Q==
X-Google-Smtp-Source: ABdhPJxDHNp6Whpz1hiBgu5T6d+44kp1IWNIJGT0ruD2WXDrYgnHL1NxCazodV1ym8YBs6ql05WYKg==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr4528031wml.147.1615398197012;
        Wed, 10 Mar 2021 09:43:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x13sm24371wrt.75.2021.03.10.09.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:43:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        amit.pundir@linaro.org, bjorn.andersson@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] gpio: wcd934x: Fix shift-out-of-bounds error
Date:   Wed, 10 Mar 2021 17:43:04 +0000
Message-Id: <20210310174304.22176-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bit-mask for pins 0 to 4 is BIT(0) to BIT(4) however we ended up with BIT(n - 1)
which is not right, and this was caught by below usban check

UBSAN: shift-out-of-bounds in drivers/gpio/gpio-wcd934x.c:34:14

Fixes: 59c324683400 ("gpio: wcd934x: Add support to wcd934x gpio controller")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
changes since v1:
	- removed unnecessary dump stack from log

 drivers/gpio/gpio-wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index 1cbce5990855..97e6caedf1f3 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -7,7 +7,7 @@
 #include <linux/slab.h>
 #include <linux/of_device.h>
 
-#define WCD_PIN_MASK(p) BIT(p - 1)
+#define WCD_PIN_MASK(p) BIT(p)
 #define WCD_REG_DIR_CTL_OFFSET 0x42
 #define WCD_REG_VAL_CTL_OFFSET 0x43
 #define WCD934X_NPINS		5
-- 
2.21.0

