Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23484412D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350490AbhIUCx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349438AbhIUC0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC8C1E327E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:04:36 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b5-20020a6541c5000000b002661347cfbcso16033211pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1U1dAkNma+fdm4jSudwakO8vMm1r2kh0beegFJljEIo=;
        b=TsHSnvzBbN84En7oW+PCc/zCFk/EPvWEaZq3R1414WOF/Lxq87g7OGRzKBHv1TXrEv
         DnOEaQs30DS/YggJ9M5f2Bxr6hCk6cr8OHjuawahsXa3C8m/XumaVTwCS+HDzWDxwjoq
         qhDO+FXCI6890cJfK227EBAhEmryB1vMgIhniqlQ6moP2UMDhqnALwM+GfNmkHe9t50A
         m2SHFLSFPlLr2mtr99EItwUsHR96QBKFNiQzORKb7ioLjWDnO1hoar2F9Ezj+aL0Mogf
         l8Dfu6cR7c5kTvkVTjyBRsrZLeAd010VW19y91ZT+dIV6hFh62OxcrN2I7k8ekicrUBe
         gByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1U1dAkNma+fdm4jSudwakO8vMm1r2kh0beegFJljEIo=;
        b=Q7eaLk1ipI1K4EWxCRnPY6cG4QX2UFw9RQsWkMxBsQsfJ/MLyLSKDBmS5XDozdMEYO
         OQSAU3Cj9Aab6dZT5GG1bRjC7gfBe12fh/8K76+SaSz/JUB33DE9TrebxWJevnbg2kFv
         IE/01qAZsmzmcp0PleluAUHsXSPrZz+9W+qlxEtt99FZLoy8yxh/JY2NFdmG/+TUC+eL
         vuO20H6Xs7K9UnsJkfiFlRY33LL2m/5YrEmlYmbj7YvIGbECARLPOuxaFQdtqDt+zqxJ
         b04G3z0sIkraMNDkxPk/+/HZtKZM0j0+NosOyYTb9xhiMckmPsN4cFOzX46nd9BT0AOt
         bDSg==
X-Gm-Message-State: AOAM5303czPZXLTQPOgPiLEQXieppvcGmxfOG5DWpNwMOzr6ORLCg4Z9
        R6Cbam90iZ7bieHcc27H11Y+yZyGMIOSX7giipg=
X-Google-Smtp-Source: ABdhPJwgy8dNNqo0W9D+WwgAi9NSG0PA3TseGreGWU8Y0X9DDCX1gdgvL88O56C484HZUhvjjZWM2GLGCjv/Xb7H9XA=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a05:6a00:16ca:b0:413:d3f7:646f with
 SMTP id l10-20020a056a0016ca00b00413d3f7646fmr26187055pfc.7.1632164675704;
 Mon, 20 Sep 2021 12:04:35 -0700 (PDT)
Date:   Mon, 20 Sep 2021 19:03:46 +0000
In-Reply-To: <20210920190350.3860821-1-willmcvicker@google.com>
Message-Id: <20210920190350.3860821-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20210920190350.3860821-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 1/4] clk: samsung: change COMMON_CLK_SAMSUNG default config logic
From:   Will McVicker <willmcvicker@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Will McVicker <willmcvicker@google.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

COMMON_CLK_SAMSUNG is selected by ARCH_EXYNOS which forces this config
to be built-in when ARCH_EXYNOS is enabled. Switch the logic to use a
"default y if ARCH_EXYNOS" to provide flexibilty for vendors to disable
or modularize this driver.

I verified the .config is identical with and without this change.

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 drivers/clk/samsung/Kconfig  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b0ce18d4cc98..3a66ed43088d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -91,7 +91,6 @@ config ARCH_BRCMSTB
 
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
-	select COMMON_CLK_SAMSUNG
 	select EXYNOS_CHIPID
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index 0441c4f73ac9..f3e189a06b03 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -2,6 +2,7 @@
 # Recent Exynos platforms should just select COMMON_CLK_SAMSUNG:
 config COMMON_CLK_SAMSUNG
 	bool "Samsung Exynos clock controller support" if COMPILE_TEST
+	default y if ARCH_EXYNOS
 	select S3C64XX_COMMON_CLK if ARM && ARCH_S3C64XX
 	select S5PV210_COMMON_CLK if ARM && ARCH_S5PV210
 	select EXYNOS_3250_COMMON_CLK if ARM && SOC_EXYNOS3250
-- 
2.33.0.464.g1972c5931b-goog

