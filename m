Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF04175BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbhIXNbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:31:45 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37528
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344365AbhIXNbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:31:40 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 10B7C4079F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490205;
        bh=F70yOyVZZjxlDll0pjQntOrMr5BdXyTooQkEjSqxu5A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=bvCkdON6OON/xBy62aiuJxacxTkgplY0rBmUrOanIX1Xu1K/gkwKXs5eR1vJ08HfM
         bdN3fTBvvcDh/5qIsLXB4adTs0j6lu/vNkHa4N5OErS13df68u62Wy3NacpMu8+SpH
         00HDu5CIQWIUEjAd23EaTKAuhhJ7quSzEE5AgU3PqnWlp486ycMUclgIRksbDHCIhN
         Fymy+df5zABlva8XS8F+xVZT0WEs8zbmh2NUC36h9aprb5Qdw40onknHz0bPXfuSSb
         BGu84Pzo8U5pcylatiIg1q8Vjj4f6rJLOgVxqA9FDIbbNYMTprXYhSRRsfLmdT+/q5
         wYq1yXGoQjxDQ==
Received: by mail-wr1-f72.google.com with SMTP id r15-20020adfce8f000000b0015df1098ccbso8111416wrn.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F70yOyVZZjxlDll0pjQntOrMr5BdXyTooQkEjSqxu5A=;
        b=HaU+mu9q82I1IXDeQ1QyislkLUjjJYs7OLsE0lHfa2TNI4C3ymD3wL4Yoi5t76cF51
         908qVrPfGi3yjipxcsbbzx1p4Z6m33gLlwpNZzqrme1JEuWNwhCanO3NUezX/WZQ/1jJ
         8lV/+QRPf+sCF6gDXU2PObNo73UATtvljEhIY7CH2N1xe5P+tEfQuF1QebxJnmAV3lbL
         tvznXSOaoVHFSNvDZHotYACjWu0qYYwO7ZqvpgXpggXbTmbrl6krT+hS/kHtM1ChaJyU
         SIOkhNn/AQnskASzlwA/arIFufuDCOnjrL54AwR/hzpehoO4KsmmFabsLlYvFwPiDnH/
         ICGQ==
X-Gm-Message-State: AOAM530xT+czLMKLOwHdmy1nOqi+TcxeIqiKPOsnvAeEOMTHLfBYvXyw
        l+z8B0ImtvGej3TmokKMJolCmlX1x3k7QvwkpvofvFHRPAH4B/V2Pf7/r9FVdG74SQJBLoZvxfu
        Y8s8TuegF/bGXaTPqYXyNzYozz1LGmajWGe6Sr/4h3w==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr11248672wrt.209.1632490204794;
        Fri, 24 Sep 2021 06:30:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkbc8Da6V2TsZslzItTVmktEElS+30iL6GeasX73+gONH6uwFQeCmkiLeu5/Bg32tsZMpPnw==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr11248655wrt.209.1632490204659;
        Fri, 24 Sep 2021 06:30:04 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i2sm8034262wrq.78.2021.09.24.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:30:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: s3c2410: describe driver in KConfig
Date:   Fri, 24 Sep 2021 15:29:30 +0200
Message-Id: <20210924132930.111443-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/watchdog/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b81fe4f7d434..75591ba261e2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -496,16 +496,18 @@ config S3C2410_WATCHDOG
 	select WATCHDOG_CORE
 	select MFD_SYSCON if ARCH_EXYNOS
 	help
-	  Watchdog timer block in the Samsung SoCs. This will reboot
-	  the system when the timer expires with the watchdog enabled.
+	  Watchdog timer block in the Samsung S3C24xx, S3C64xx, S5Pv210 and
+	  Exynos SoCs. This will reboot the system when the timer expires with
+	  the watchdog enabled.
 
 	  The driver is limited by the speed of the system's PCLK
 	  signal, so with reasonably fast systems (PCLK around 50-66MHz)
 	  then watchdog intervals of over approximately 20seconds are
 	  unavailable.
 
+	  Choose Y/M here only if you build for such Samsung SoC.
 	  The driver can be built as a module by choosing M, and will
-	  be called s3c2410_wdt
+	  be called s3c2410_wdt.
 
 config SA1100_WATCHDOG
 	tristate "SA1100/PXA2xx watchdog"
-- 
2.30.2

