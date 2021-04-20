Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A330365E21
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhDTRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:03:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50135 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhDTRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:03:21 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtlw-0004bX-TB
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 17:02:48 +0000
Received: by mail-ed1-f69.google.com with SMTP id r14-20020a50d68e0000b0290385504d6e4eso3544567edi.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rjka4Njemna1OOKJdcZeeFwVYEY/9hgKuOFFKuvjSYE=;
        b=TYnfl/8O7SlissfAmDGfV9MN4TZOvxOudM0G6k1swVa0jDXvXQ/egl6Ig+O6Fdk4Cp
         vImfRcRbsnxQt0RpDnKRnRmiCAK0CDA9HKyI4nt5aepQI4kbfBuMDb/A+ke2JNlELwvc
         U9taDbRgLCUKCgwqaOam9OYE22F1OeBI0hat49/L9kybjyv5WS6DyjdxJt4HFMfA8bd6
         9vo+GgSw/zGda9nYC3pStqaI2XdRQ6uAUZ4XhGCy9dbxCMCA8IYklDC0POcjSQcS0DAX
         jXFk2O3P4A9EKPfNXEUKcY30RBjv3uvc72UWHLiAcKurfVO+rccrCID+a03mC8ECI3uM
         W2nA==
X-Gm-Message-State: AOAM531EeahWaXxXnwr2/bNUja62FtmY2y5qgEcFZWhV0ONSe8DdtdGM
        umSqHgnKPZio1GLh/45JP9fONOFry8+jjFrmQrlD/PlKzF2a1EK87GWBHRmPe3A32W6dEkyjiJR
        Ht8uNmKyFSpmMaj4QHAtzFVXG7sN/0h7yq+1QGATCkA==
X-Received: by 2002:a17:907:33cb:: with SMTP id zk11mr29272731ejb.231.1618938168644;
        Tue, 20 Apr 2021 10:02:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEptLquhZ2/QqZ4X/5o6u/BOlY7S9w9blCK0zCE6EhdECvGDYJS8VhGVzjFSaiOFlOBW2WUw==
X-Received: by 2002:a17:907:33cb:: with SMTP id zk11mr29272709ejb.231.1618938168470;
        Tue, 20 Apr 2021 10:02:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id s20sm16590714edu.93.2021.04.20.10.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:02:48 -0700 (PDT)
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
Subject: [PATCH 6/9] mfd: sec: Remove unused platform data members
Date:   Tue, 20 Apr 2021 19:02:41 +0200
Message-Id: <20210420170244.13467-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420170244.13467-1-krzysztof.kozlowski@canonical.com>
References: <20210420170118.12788-1-krzysztof.kozlowski@canonical.com>
 <20210420170244.13467-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung PMIC drivers for early chipsets like S5M8767 stored quite a
lot in platform data (struct sec_platform_data).  The s5m8767 regulator
driver currently references only some of its fields.  Newer regulator
drivers (e.g. s2mps11) use even less platform data fields.

Clean up the structure to reduce memory footprint and source code size.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/linux/mfd/samsung/core.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index b0d049a56d16..f92fe090473d 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -80,8 +80,6 @@ struct sec_platform_data {
 	struct sec_opmode_data		*opmode;
 	int				num_regulators;
 
-	bool				buck_voltage_lock;
-
 	int				buck_gpios[3];
 	int				buck_ds[3];
 	unsigned int			buck2_voltage[8];
@@ -91,35 +89,12 @@ struct sec_platform_data {
 	unsigned int			buck4_voltage[8];
 	bool				buck4_gpiodvs;
 
-	int				buck_set1;
-	int				buck_set2;
-	int				buck_set3;
-	int				buck2_enable;
-	int				buck3_enable;
-	int				buck4_enable;
 	int				buck_default_idx;
-	int				buck2_default_idx;
-	int				buck3_default_idx;
-	int				buck4_default_idx;
-
 	int				buck_ramp_delay;
 
-	int				buck2_ramp_delay;
-	int				buck34_ramp_delay;
-	int				buck5_ramp_delay;
-	int				buck16_ramp_delay;
-	int				buck7810_ramp_delay;
-	int				buck9_ramp_delay;
-	int				buck24_ramp_delay;
-	int				buck3_ramp_delay;
-	int				buck7_ramp_delay;
-	int				buck8910_ramp_delay;
-
-	bool				buck1_ramp_enable;
 	bool				buck2_ramp_enable;
 	bool				buck3_ramp_enable;
 	bool				buck4_ramp_enable;
-	bool				buck6_ramp_enable;
 
 	int				buck2_init;
 	int				buck3_init;
-- 
2.25.1

