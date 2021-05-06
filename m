Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00ED375C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhEFUar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:30:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49240 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbhEFUal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:30:41 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lekcw-0001cD-4w
        for linux-kernel@vger.kernel.org; Thu, 06 May 2021 20:29:42 +0000
Received: by mail-qk1-f197.google.com with SMTP id s123-20020a3777810000b02902e9adec2313so4343003qkc.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 13:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PflL7ALzIS28zgo9gRKf5LrSO5ZMKaq1J727pxpPmSA=;
        b=Ewr9fKzvTQZo8mTzriloN5FNSyFHhBLup9o/4Ivlbo5tkUgZCcmFDk/rIDtPEXfIFP
         tECs09N6N6nOY8p5/LjOasyVyIJfhYsqCb4qaMjyK+c4K+nbLVK82G2QQ3oijq3aOj4o
         LckoZ0R+9E0Scubr6dPGCnZDr4ZiaA+4SrzYgGWKfb/mMBDhel2eNny0bkcjBl8scv7k
         w84pTEIO9+qzltKPq4yYgoApCTn6YMkXclCK+K2VYe/twWVZCccMjQTPfPN7CszV8bnI
         HRrLOv8pzQ7zIKmOTsWAu/VsDuMDvXWWtd9a6SRvYtT1IzmriGA+pG4tL58ropab6VyW
         nHeQ==
X-Gm-Message-State: AOAM530OMjul9qYUfjI+bdDhulqHLKj9DOZGiqdXh+S1vDuv7O3k1inW
        pN6o1fAAmkrQl8xX/DM+ORLOL81dE7VzNHO78/380RMBQ06TraFKx8YahgquLZa38KF7vW5935w
        a7mSFeibNdI7HPhWJEb2kvQDK9WbxOfdaNlgWzBqLVQ==
X-Received: by 2002:a37:f503:: with SMTP id l3mr5848971qkk.307.1620332975222;
        Thu, 06 May 2021 13:29:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO/jXf1XyPty4NXaJwbxTsZ7FayuPAfdAwFO8HWJXLvf8aCh7QXhu7leoeiVIxg4xBQN7sbg==
X-Received: by 2002:a37:f503:: with SMTP id l3mr5848955qkk.307.1620332974997;
        Thu, 06 May 2021 13:29:34 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.6])
        by smtp.gmail.com with ESMTPSA id r9sm3151363qtf.62.2021.05.06.13.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:29:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/5] clocksource/drivers/samsung_pwm: Minor whitespace cleanup
Date:   Thu,  6 May 2021 16:27:25 -0400
Message-Id: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the code to be slightly more readable and follow coding
convention - only whitespace.  This fixes checkpatch warnings:

  WARNING: Block comments should align the * on each line
  WARNING: please, no space before tabs
  WARNING: Missing a blank line after declarations
  CHECK: Alignment should match open parenthesis

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 19 +++++++++++--------
 include/clocksource/samsung_pwm.h       |  3 ++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index f760229d0c7f..69bf79c7f462 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -4,7 +4,7 @@
  *		http://www.samsung.com/
  *
  * samsung - Common hr-timer support (s3c and s5p)
-*/
+ */
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -22,7 +22,6 @@
 
 #include <clocksource/samsung_pwm.h>
 
-
 /*
  * Clocksource driver
  */
@@ -38,8 +37,8 @@
 #define TCFG0_PRESCALER_MASK		0xff
 #define TCFG0_PRESCALER1_SHIFT		8
 
-#define TCFG1_SHIFT(x)	  		((x) * 4)
-#define TCFG1_MUX_MASK	  		0xf
+#define TCFG1_SHIFT(x)			((x) * 4)
+#define TCFG1_MUX_MASK			0xf
 
 /*
  * Each channel occupies 4 bits in TCON register, but there is a gap of 4
@@ -183,7 +182,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 }
 
 static int samsung_set_next_event(unsigned long cycles,
-				struct clock_event_device *evt)
+				  struct clock_event_device *evt)
 {
 	/*
 	 * This check is needed to account for internal rounding
@@ -225,6 +224,7 @@ static void samsung_clockevent_resume(struct clock_event_device *cev)
 
 	if (pwm.variant.has_tint_cstat) {
 		u32 mask = (1 << pwm.event_id);
+
 		writel(mask | (mask << 5), pwm.base + REG_TINT_CSTAT);
 	}
 }
@@ -248,6 +248,7 @@ static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
 
 	if (pwm.variant.has_tint_cstat) {
 		u32 mask = (1 << pwm.event_id);
+
 		writel(mask | (mask << 5), pwm.base + REG_TINT_CSTAT);
 	}
 
@@ -272,7 +273,7 @@ static void __init samsung_clockevent_init(void)
 
 	time_event_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&time_event_device,
-						clock_rate, 1, pwm.tcnt_max);
+					clock_rate, 1, pwm.tcnt_max);
 
 	irq_number = pwm.irq[pwm.event_id];
 	if (request_irq(irq_number, samsung_clock_event_isr,
@@ -282,6 +283,7 @@ static void __init samsung_clockevent_init(void)
 
 	if (pwm.variant.has_tint_cstat) {
 		u32 mask = (1 << pwm.event_id);
+
 		writel(mask | (mask << 5), pwm.base + REG_TINT_CSTAT);
 	}
 }
@@ -347,7 +349,7 @@ static int __init samsung_clocksource_init(void)
 		pwm.source_reg = pwm.base + pwm.source_id * 0x0c + 0x14;
 
 	sched_clock_register(samsung_read_sched_clock,
-						pwm.variant.bits, clock_rate);
+			     pwm.variant.bits, clock_rate);
 
 	samsung_clocksource.mask = CLOCKSOURCE_MASK(pwm.variant.bits);
 	return clocksource_register_hz(&samsung_clocksource, clock_rate);
@@ -398,7 +400,8 @@ static int __init _samsung_pwm_clocksource_init(void)
 }
 
 void __init samsung_pwm_clocksource_init(void __iomem *base,
-			unsigned int *irqs, struct samsung_pwm_variant *variant)
+					 unsigned int *irqs,
+					 struct samsung_pwm_variant *variant)
 {
 	pwm.base = base;
 	memcpy(&pwm.variant, variant, sizeof(pwm.variant));
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
index c395238d0922..76341988fb4f 100644
--- a/include/clocksource/samsung_pwm.h
+++ b/include/clocksource/samsung_pwm.h
@@ -27,6 +27,7 @@ struct samsung_pwm_variant {
 };
 
 void samsung_pwm_clocksource_init(void __iomem *base,
-		unsigned int *irqs, struct samsung_pwm_variant *variant);
+				  unsigned int *irqs,
+				  struct samsung_pwm_variant *variant);
 
 #endif /* __CLOCKSOURCE_SAMSUNG_PWM_H */
-- 
2.25.1

