Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E945E435AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhJUGh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:37:29 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52272
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231268AbhJUGhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:37:19 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BFFBE40002
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634798103;
        bh=FmJ0rjr2j5+lZ1GrbJW3m6QcUxRmDvBVeUC/Lqmm3nw=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=WP18SOrx0BOOrHMAnutPxgIoglAs7Q5n7IJP0y53xk0WtLc4558xkVBkwFTLhDDLF
         iI5xyjIRDR7htOcux+KRNo/MMF9Pq9ETFbTQyyhLRPh3MRNPUOVFXYGuWNopzXdUcb
         uO0Up+0pByPgJbejYYF2UOJWMMAlNr7ldEmVZaTWhMv40DUrj7mV9FsdbNNcbw5uZT
         Lws3VUT/lHyDrhnHFpcWhka74kZqj5klysqMS6Olg/yyshWZfu0EMJzD0B1wCev9d9
         I/CWmcIydhpbTidXeVk3zWs8RMUESU/V3NWZ5wOIk+mASfg34BH81qkLb7VbCV/seN
         Q4G0tKlPpvUxA==
Received: by mail-lf1-f70.google.com with SMTP id u17-20020a05651206d100b003fd714d9a38so4243955lff.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmJ0rjr2j5+lZ1GrbJW3m6QcUxRmDvBVeUC/Lqmm3nw=;
        b=vHHRWmrazJEC7NGSQWMtwqBosn/S1CMfMGTB8Nzp50ChJOD5GfllobRUJG18vQOMsc
         W/O/QkA1Wd1OnuDvU14IZxoFZ4B0OU+r8tcDoQlMFpJOH/NLSUCjSE+3WlGVr5yQhOa9
         5vJr4lXw+7MGGGg3eCjSPMr+KwqApjkBLeAyzz9dXkdmjBtV9zEtG4ixAvVUIZ6vDZlK
         FiVwpg+2NHfWKQelLuTozxEOnOER0seViv0MSQSm4788PVfmnTsdyaZ4/W9XAA9tibmR
         aKnZ3Mo83E+i2JVqJNC2ezdU+MDpQNNDw44HPt+X+1HgiOAfL+ynF7ynn+fYAH5frtXd
         qn2Q==
X-Gm-Message-State: AOAM533kbR3So3TdHkPSZC/CtfOctR5gD3bVoynT+Xum4kXlGC2bcNV0
        6eHj80LIevEejj/XT6jPUoUfmB9SfnwyXsnKr65CJ9Q69QDA5m/ZUY3g7c1mH9Fla0qxGsp5wC4
        DSpt+mzZqXeGO66e7fRsSpOerNL5x+yPmaiWLM/upDA==
X-Received: by 2002:ac2:5210:: with SMTP id a16mr3742219lfl.279.1634798103081;
        Wed, 20 Oct 2021 23:35:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza9ue2pg33DwBqRkVK1XuyGjUU2kIoIrQ+EuluMtZxge5KEKRL9s/NaBB4FHMl7nmgQnaK6w==
X-Received: by 2002:ac2:5210:: with SMTP id a16mr3742195lfl.279.1634798102828;
        Wed, 20 Oct 2021 23:35:02 -0700 (PDT)
Received: from kozik-lap.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id q20sm423805ljp.61.2021.10.20.23.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 23:35:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] clocksource/drivers: depend on sub-architecture for Exynos MCT and Samsung PWM
Date:   Thu, 21 Oct 2021 08:35:00 +0200
Message-Id: <20211021063500.39314-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos MCT and Samsung PWM Timer clocksource drivers are not usable
on anything else than Samsung Exynos, S3C or S5P SoC platforms.  These
are integral parts of a SoC.  Even though the drivers are not user
selectable, still document the hardware architecture explicitly with
depends on ARCH_EXYNOS and others.  This also serves a purpose of
documenting use-case, if someone ever wonders whether to select the
driver for his platform.  No functional change, because drivers are
already selected by the platform described in depends. We follow similar
approach also for other SoC-specific drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clocksource/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0f5e3983951a..3ff6e1f87246 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -418,12 +418,14 @@ config ATMEL_TCB_CLKSRC
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Support for Multi Core Timer controller on Exynos SoCs.
 
 config CLKSRC_SAMSUNG_PWM
 	bool "PWM timer driver for Samsung S3C, S5P" if COMPILE_TEST
 	depends on HAS_IOMEM
+	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210 || COMPILE_TEST
 	help
 	  This is a new clocksource driver for the PWM timer found in
 	  Samsung S3C, S5P and Exynos SoCs, replacing an earlier driver
-- 
2.30.2

