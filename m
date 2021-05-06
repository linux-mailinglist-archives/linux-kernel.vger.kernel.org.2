Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3D375C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhEFUat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:30:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49241 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhEFUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:30:44 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lekcz-0001cm-E1
        for linux-kernel@vger.kernel.org; Thu, 06 May 2021 20:29:45 +0000
Received: by mail-qv1-f70.google.com with SMTP id h17-20020a0cb4d10000b02901c51890529dso5038790qvf.18
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 13:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kr71HxmM9qcmrtqnZvjbEArHjJcDpTE8gEhMoKfplI8=;
        b=KnxF/CjCR9p04LTR92WY3veYPmYjmr0L+UY1Zr9ztx93s2v5XU0rCAF0k/RzuhI6YB
         ol3NeKYlvSIfDPngctwgUWmKGmwK5zLFzRRFoJUemo4GpNJReT6if/XWTKN+wBPijMWN
         LmaV32uIa2Xgw1qsEuJit4eoxOnCCaHEdvZ6KswjiaBcoq8iu6cJKipIbD5neyUxNhON
         VZdUbdfwzhVSBhTFr97IgaiD+lxfkiKk/fI2I/mXPOAkNTXFtCY5RecH1k5rWfLiC8ly
         qb4kiaKJ5oXl72yXEAgawCYiDF8ct6O6NwltFpoIRiz2tsfeIvImxzt+RvUHzyNggA/t
         jgJQ==
X-Gm-Message-State: AOAM530fcE9LlM9mTsGVNj9yp3y4DUGvJSo7bub8UzlxYEA2ah/0DbnL
        KWIPNKpf4KQcw0sQT1A2CNEoWI8mTwAJysy+ZJepW4fxvl4mJoBA+iAbwrWfvBGKHlBzvWB0VFS
        luvdEco4z0zdwU3rMFHjKhZ8nVp0m7b1lFqudpL+yzg==
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr5876572qtx.282.1620332976523;
        Thu, 06 May 2021 13:29:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyk3b8O3zAhrDM7x/cMI1eJVdxQMKUo6w7vmzjoPUcDq01NFnKYHmva7Zxpns1CqKXuC7HwQA==
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr5876557qtx.282.1620332976322;
        Thu, 06 May 2021 13:29:36 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.6])
        by smtp.gmail.com with ESMTPSA id r9sm3151363qtf.62.2021.05.06.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:29:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/5] clocksource/drivers/samsung_pwm: Constify passed structure
Date:   Thu,  6 May 2021 16:27:26 -0400
Message-Id: <20210506202729.157260-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
References: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'struct samsung_pwm_variant' argument passed to initialization
functions is not modified, so it can be made const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 2 +-
 include/clocksource/samsung_pwm.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 69bf79c7f462..bfad61b509f9 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -401,7 +401,7 @@ static int __init _samsung_pwm_clocksource_init(void)
 
 void __init samsung_pwm_clocksource_init(void __iomem *base,
 					 unsigned int *irqs,
-					 struct samsung_pwm_variant *variant)
+					 const struct samsung_pwm_variant *variant)
 {
 	pwm.base = base;
 	memcpy(&pwm.variant, variant, sizeof(pwm.variant));
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
index 76341988fb4f..9b435caa95fe 100644
--- a/include/clocksource/samsung_pwm.h
+++ b/include/clocksource/samsung_pwm.h
@@ -28,6 +28,6 @@ struct samsung_pwm_variant {
 
 void samsung_pwm_clocksource_init(void __iomem *base,
 				  unsigned int *irqs,
-				  struct samsung_pwm_variant *variant);
+				  const struct samsung_pwm_variant *variant);
 
 #endif /* __CLOCKSOURCE_SAMSUNG_PWM_H */
-- 
2.25.1

