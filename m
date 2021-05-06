Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A2F375C39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhEFUam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:30:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49230 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbhEFUaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:30:39 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lekcu-0001dB-8s
        for linux-kernel@vger.kernel.org; Thu, 06 May 2021 20:29:40 +0000
Received: by mail-qv1-f70.google.com with SMTP id p20-20020a0ce1940000b02901be3272e620so5055463qvl.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 13:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaN2sKrS+2gNp66ooV3kIZkyoZhndv/BbfpM71H4E2s=;
        b=PmA+4KzDuT5UI325uaBEn+anx0CzAH54wbU4r2/ZXMCHEae2akhg5UdstsTAWAIiW3
         k5S43hQ2JE+wur3LHqBHArahT6xBx2UYMh+yJvVvHHN7Fm8/fBpuQjAR4idqz/LFD28p
         0kdbv49ri926IStfpFLJOETWoVQVLPzCurcVaXjaYe5r9mg3FTErwg5x+TWBFUmKN8qe
         PD/ZAq1gpyOTWG4RB7Q6Ag6Q2kvuDtbgcWlBypm4IymA3teyMQfBzwZyslsglL8rSttT
         QCOq42Lka05FEsxcLhwz8nqe1kB+j4Ek5XA3k7wvh1yPDo1qt+bbgVU5z/jh8iUJ91JR
         Tyrg==
X-Gm-Message-State: AOAM5316NtjYXbbo6tUH0tzvF5QWlmqxdM9osGAqEH+YSej7DmURIyzR
        q6b5QLek4P78dcQC5PAzqql87P0r645O6fhyNZ2WGdiHciXEYUSjA+TBvR7s4e+YO4W6JsDAbjt
        e+hjjSpvl0fQ45pCx4/eP2wl/nW8PkG2WaNJVE8EwZA==
X-Received: by 2002:a05:620a:4081:: with SMTP id f1mr5956458qko.203.1620332979446;
        Thu, 06 May 2021 13:29:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzapbevGV176ziXFWsYiPHEgdYz4M/VREvFTBrCMRIegcj3hsTKcp6weSBOfIpotKXfoR086A==
X-Received: by 2002:a05:620a:4081:: with SMTP id f1mr5956445qko.203.1620332979286;
        Thu, 06 May 2021 13:29:39 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.6])
        by smtp.gmail.com with ESMTPSA id r9sm3151363qtf.62.2021.05.06.13.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:29:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/5] clocksource/drivers/samsung_pwm: Constify source IO memory
Date:   Thu,  6 May 2021 16:27:28 -0400
Message-Id: <20210506202729.157260-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
References: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'source_reg' IO memory is only read, so the pointer can point to
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 55e2f9fa2a15..6e46781bc9ac 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -61,7 +61,7 @@ EXPORT_SYMBOL(samsung_pwm_lock);
 
 struct samsung_pwm_clocksource {
 	void __iomem *base;
-	void __iomem *source_reg;
+	const void __iomem *source_reg;
 	unsigned int irq[SAMSUNG_PWM_NUM];
 	struct samsung_pwm_variant variant;
 
-- 
2.25.1

