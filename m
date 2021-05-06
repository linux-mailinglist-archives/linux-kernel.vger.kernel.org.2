Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7191375C3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhEFUao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 16:30:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49236 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhEFUal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 16:30:41 -0400
Received: from mail-qt1-f200.google.com ([209.85.160.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lekcv-0001dh-L8
        for linux-kernel@vger.kernel.org; Thu, 06 May 2021 20:29:41 +0000
Received: by mail-qt1-f200.google.com with SMTP id z5-20020a05622a0285b02901b943be06b5so4307589qtw.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 13:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEVMUDWkqGHYlLcG9Az7Ro+mD4OVQo3sjNJ8RnA9DCE=;
        b=QVIO3NSnlmjrRpXG58UFi/4WhRV2jLg9v/6LvhUJO7uRyjX6XGJa/pxPf/1um8vS2h
         ipHAtNHFqtRH+fjFrNOUffNwlHxsMiO4wUnOuBArEhLN3aUpDQcUVVy4hNeU5/vSF6bB
         DREvj+TsTy6tnbNf+86t0rR4nKtzgIJgYV2dvJYsW/0a5M3fq/o7MIb33DweNf3Ve7Yd
         Fgao1dP46obnKV6q3X2MuByvSpDCboFytXzhF7/oG3Q89nqRSW5AdcznDD95Cge2XJ5I
         b8XxKRnGthqlhcRBO40FJB6hp951slzA8jHNPbzzEtBlnDk5aXRdFkqnloosrvW1d6M2
         AWew==
X-Gm-Message-State: AOAM530DXfzrtF/2amvcu+/Lya924A8o8rb0LA4a0jZ2JptFa+/GCqlq
        uD99qLtaop1gABxgE8RrDrghgY77a8jyPlk4KwtY5ML3d6IOWbX0yuRzbfHQM7Dv8/iNmhqjS0e
        B2dtnRV0UFtC3hntyXU4667fYOMrh/W9tA7LznQnBrw==
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr6289058qtr.74.1620332980814;
        Thu, 06 May 2021 13:29:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGTOcflvNGn/QW/M44UQ6PapIvsGKyEKZR1mufl7BaAi09QOxao1TSWpkNhvwAlfCnFrWG3Q==
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr6289043qtr.74.1620332980669;
        Thu, 06 May 2021 13:29:40 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.6])
        by smtp.gmail.com with ESMTPSA id r9sm3151363qtf.62.2021.05.06.13.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:29:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 5/5] MAINTAINERS: Include Samsung PWM in Samsung SoC entry
Date:   Thu,  6 May 2021 16:27:29 -0400
Message-Id: <20210506202729.157260-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
References: <20210506202729.157260-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung PWM and PWM-based timer/clocksource drivers lacked dedicated
maintainers entry.  They are used on all Samsung SoC designs (although
timer/clocksource driver only on older platforms), so include them in
Samsung SoC entry maintained by Krzysztof Kozlowski.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

This can go via clocksource/drivers tree or I can take it via Samsung
SoC.
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efeaebe1bcae..bb9c5815a308 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2436,9 +2436,12 @@ F:	drivers/*/*/*s3c24*
 F:	drivers/*/*s3c24*
 F:	drivers/*/*s3c64xx*
 F:	drivers/*/*s5pv210*
+F:	drivers/clocksource/samsung_pwm_timer.c
 F:	drivers/memory/samsung/
+F:	drivers/pwm/pwm-samsung.c
 F:	drivers/soc/samsung/
 F:	drivers/tty/serial/samsung*
+F:	include/clocksource/samsung_pwm.h
 F:	include/linux/platform_data/*s3c*
 F:	include/linux/serial_s3c.h
 F:	include/linux/soc/samsung/
-- 
2.25.1

