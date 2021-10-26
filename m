Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D319943B1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhJZMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJZMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:01:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1797C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:59:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq11so17100439lfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85BwCPaPUHtT9osJtiBZEBY3ZDasvCEOaM7Ylyi8QL8=;
        b=K60jYV1zHtMnWk3mrz15ZGPS/PTHH3vmMdXuccIwrUnwrgdDxA7/gaelCPgYhQKanQ
         4e9xhffNGbhZQLdGOo1iH4o0ATDrxIq+bEJ2dx4QMNUT+wHKtrc1PIUyWV9HcFGM83zm
         dwAqPwomivHB/5cUlR7Qb+Ha1hgMJrmzHtiAq8uZQyEr3SfHT5Wk4SNSy+zEYmIykxT+
         EQ5vL7GjSD8ggx+rUS49D+Ki7KW2/T1ht0w7hEjG1b7Anqz21X1VJ0mdkMI6nBQ2p+ST
         rI+7bJPO5N3OoTkbmUH6iBHiwBkROhNoxzXJr4sQ3i5onELkeEXm5EbZ1/S+4bbzhgor
         9/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85BwCPaPUHtT9osJtiBZEBY3ZDasvCEOaM7Ylyi8QL8=;
        b=dtbk2OM4ORQY8gq4HcJWnbU5kQdY3544vR+mBSdHaQku1OoR5rqnMOa8iv0ydPdmuc
         WEPkbD7uMheqHGjslbs6k8z0eJAwTNvOTaoZKQueK1Sfc1I3bmj388zV3PhnJ7WSsw4M
         8kLkuc2v5Ot2BRUYQ3AFe7hFp24yFJBBdNoUSNhwVkhPq7eSWXca3m2HAWoYY2dlu2H2
         4x5oYvvz4/kCJFqLu9aTWQ/4wV3sfN6b6IZ9VcADvYDNVONXLAVxKUi2crOxbHwXYEoo
         b41mo5rUxCXvJLCG1fVD8JqSXPB0jHTL8P5I7rxoETvibJQzfseICAAYp2UtUgcGu2T3
         cl1A==
X-Gm-Message-State: AOAM531Z2cxW5D0o6d1mlShxZG3rTVXeY+y5Dc2WPNDz6uprm2/yp6Nh
        y1P70D1I3wWd3aL3IUnJVI/KWA==
X-Google-Smtp-Source: ABdhPJyBLtrSGYC9ap6Hn68rkt1HPKlNRpB5+PleW5X04PcnTdOWY1ILt3UowmrWrN/pdiLhAQnx4g==
X-Received: by 2002:a05:6512:22c5:: with SMTP id g5mr22417386lfu.646.1635249558087;
        Tue, 26 Oct 2021 04:59:18 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id j26sm459759lfb.84.2021.10.26.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:59:17 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] arm64: Kconfig: Enable MCT timer for ARCH_EXYNOS
Date:   Tue, 26 Oct 2021 14:59:16 +0300
Message-Id: <20211026115916.31553-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ARM64 Exynos SoCs have MCT timer block, e.g. Exynos850 and
Exynos5433. CLKSRC_EXYNOS_MCT option is not visible unless COMPILE_TEST
is enabled. Select CLKSRC_EXYNOS_MCT option for ARM64 ARCH_EXYNOS like
it's done in arch/arm/mach-exynos/Kconfig, to enable MCT timer support
for ARM64 Exynos SoCs.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 1aa8b7073218..7a6ef7883a0b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -95,6 +95,7 @@ config ARCH_EXYNOS
 	select PINCTRL_EXYNOS
 	select PM_GENERIC_DOMAINS if PM
 	select SOC_SAMSUNG
+	select CLKSRC_EXYNOS_MCT
 	help
 	  This enables support for ARMv8 based Samsung Exynos SoC family.
 
-- 
2.30.2

