Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645BE412D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhIUCyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349471AbhIUC0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:40 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749E9C1E3A54
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:04:42 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id f9-20020a1709028609b0290128bcba6be7so7769209plo.18
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F6cGi29a7AfEikhLMTK8OrCpcnf5YNIMe8XqMKTgBWE=;
        b=WaybUjqVu/zv+vIZpFhmoCtqsH0J+cSC+hsipU29HLqreSTA/oMTEV/usynjaGKZv9
         msiqVmzTwaISJLYoVuxNtt/gOJvHGb5rzFhqx8PlX8iGzC6ckmoHCoC+/hATCx2U31/j
         TkVCx8hqU8GF/UDHHT56XsQM+OTxqhNkZk9Y/iPCywv/zZ7F4ZAIi8ehJxEe76mkRz7m
         hH6zzWmqGPwAO8mqf7wcq0CCIre4iWQ3SvtB3uVg9xWldB19R5ZESw1sLbOiM9W/8gnD
         Z3arInj4gTz0ScRRtSPLos5dgfQAQrczWtK0J4PeTHKcyQw2hrt9Qdw4zYI2rIzCUBRJ
         /bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F6cGi29a7AfEikhLMTK8OrCpcnf5YNIMe8XqMKTgBWE=;
        b=ygjd/8PUqH5FSswgh54uTISyRMfSoHD+eczP2XMkHc/J0+FP58TfWaqqUQC6l7NIKU
         mL8udDec0AQL8ZcR5WS4apfDRXd+GJ66oICFbeI8fJanvf+bssLYvvUsj/bhvQJgKrnJ
         Q6e6E0McokSZpdAHMl4MrgYgCnH769UR56GQcMSVaWokLp1HMBFPgevVYQYwTv3E6lAI
         x55GtsTdlwcjI9BQTEgKEq+0G4PAhMIBt7sNWYi4n15VoUxHgU0lbauKsZXz3n0nDiM2
         tH8a20UsSgVxnP5cfbY82/+k37NcJZG3pjHtjVbNocTikW1EYJcHe13d9YWVKs4xN7zH
         D3aQ==
X-Gm-Message-State: AOAM5327K9SMg3zXYTybNwT0gnxSTjghLj8zntKup0nbIK3N0nr9yYns
        pW5nleLZqlmjqun7mZFTdoHn3ME/r9N4E8yg3kY=
X-Google-Smtp-Source: ABdhPJxzkMfeAZXRaAianGXffx1iCvr9RAwg8Omo/kfgyxb2a4u5Shp06Gkd/wq7B2gWBPNgyV3oA9U2ASPf6mLOHUo=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a05:6a00:1141:b0:440:3c27:807c with
 SMTP id b1-20020a056a00114100b004403c27807cmr26237287pfm.71.1632164681943;
 Mon, 20 Sep 2021 12:04:41 -0700 (PDT)
Date:   Mon, 20 Sep 2021 19:03:49 +0000
In-Reply-To: <20210920190350.3860821-1-willmcvicker@google.com>
Message-Id: <20210920190350.3860821-5-willmcvicker@google.com>
Mime-Version: 1.0
References: <20210920190350.3860821-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 4/4] rtc: change HAVE_S3C_RTC default config logic
From:   Will McVicker <willmcvicker@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Will McVicker <willmcvicker@google.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switches the default config logic of HAVE_S3C_RTC to use "default y if
(ARCH_EXYNOS && RTC_CLASS)" versus having ARCH_EXYNOS directly select
it. This provides vendors flexibility to disable the config if desired
or modularize it in the presence of a generic kernel.

Verified this change doesn't impact the .config.

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 drivers/rtc/Kconfig          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a884e5da8b0f..f9f829aab511 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -91,7 +91,6 @@ config ARCH_BRCMSTB
 
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
-	select HAVE_S3C_RTC if RTC_CLASS
 	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM
 	help
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e1bc5214494e..40afdb37d2a5 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1406,6 +1406,7 @@ config RTC_DRV_OMAP
 
 config HAVE_S3C_RTC
 	bool
+	default y if (ARCH_EXYNOS && RTC_CLASS)
 	help
 	  This will include RTC support for Samsung SoCs. If
 	  you want to include RTC support for any machine, kindly
-- 
2.33.0.464.g1972c5931b-goog

