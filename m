Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316B04420EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhKATiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhKATiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:38:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD393C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 12:35:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z20so68255033edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJg2E2PZjjgu+8s1D3x+r4IQ/mozouniDkUsuWAbOxQ=;
        b=wYtr7iadpvUwY/TMc/2Q8HPKNi/z9n/VMDQEK0Cc0nvTIe6jwIoif8ptsdeuAl/DiK
         FMpHQTB7+3bVpB5IMWJX0E/5LhqTOKkScZNwI2LRBC6TqF+zu6ADbTs/KqtanEue8QlK
         QarqGB1wZ1333V4wqsg8ycyG1l9IA1vYl19vR+TLdxSCIZ8ZfP91hFgcvTgCpww4HVTq
         f9yXnnI/9TsrXIJE4Ov50FwA13Q3/LXji5XdIFmqFM6NFwzruO+TIa1BElDZVLhXgg6X
         HK1ArYqwcb3qB1U48C60BlGGYQN2Xrnnba1Y8RJKgEwLsdN+fhxJOUPvN3Lt7zl17vAi
         Xw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJg2E2PZjjgu+8s1D3x+r4IQ/mozouniDkUsuWAbOxQ=;
        b=DNvYjCvZESAcefKlOvOD0F8/WYN14Cu12kOmzqRoA2D8pLPZh3BcusqNERF8amci/G
         cwqCXn9ncSkhhfDcRghKgKwHCHntXjOZjRO4JxSFMFkoFF1MskQtYyDw1rkFTdLFyyM0
         lsvOnOzQe+gcv/Np4Pk7Jllr+aJ515bDLa7TrvH9kaj3Zf/wpZTtDs00U3MOvZkkvr/X
         W+2Zg8D4q+aPyaVvpmBtVdhNc55eHNKDf7UXYsBuPT76AGKxFSwjmiXBoeRM5WV9ezay
         Ha6AnhGdNnc6hOTOcuzdwqkr2rmGOuAbxoj73K8ZeU4PG5xHOFFHkTmweDKFdumIyIPU
         Q2JA==
X-Gm-Message-State: AOAM530b6RYrT17xvQPFS9C2y+9RS9TXJJJzojIGaUr56FkKX9QzqBgI
        ilwxDq4BRzMUTUpYSEqEV9hQvQ==
X-Google-Smtp-Source: ABdhPJxDe2EhUvzms0LEnj7lbftyQ/puvq2iCIoQ3jxubRDZpjngPJln0CQPd8jLz24nRtLkaC7PzQ==
X-Received: by 2002:a17:906:1749:: with SMTP id d9mr38637143eje.178.1635795336283;
        Mon, 01 Nov 2021 12:35:36 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id pw14sm2336124ejb.108.2021.11.01.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:35:35 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] arm64: platform: Enable Exynos Multi-Core Timer driver
Date:   Mon,  1 Nov 2021 21:35:31 +0200
Message-Id: <20211101193531.15078-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211101193531.15078-1-semen.protsenko@linaro.org>
References: <20211101193531.15078-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Some ARM64 Exynos SoCs have MCT timer block, e.g. Exynos850 and
Exynos5433. CLKSRC_EXYNOS_MCT option is not visible unless COMPILE_TEST
is enabled. Select CLKSRC_EXYNOS_MCT option for ARM64 ARCH_EXYNOS like
it's done in arch/arm/mach-exynos/Kconfig, to enable MCT timer support
for ARM64 Exynos SoCs.

Even though ARM architected timer is available on all ARM64 SoCs, and
used for managing timer hardware and clock source events, MCT timer
still can be used as a wakeup source, as stated in commitae460fd9164b
("clocksource/drivers/exynos_mct: Prioritise Arm arch timer on arm64").
It's also nice to be able to test available MCT IP-core.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 1aa8b7073218..91f5e9568122 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -89,6 +89,7 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select CLKSRC_EXYNOS_MCT
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select PINCTRL
-- 
2.30.2

