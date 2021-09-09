Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B18405F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbhIIWbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIIWbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:31:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A4BC061574;
        Thu,  9 Sep 2021 15:30:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id e21so86019ejz.12;
        Thu, 09 Sep 2021 15:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sB1PMWA/ZgtSnuaLYnidQDY1PRQoxYpPc51bJqK9AUA=;
        b=WiYCeUYtMcYFG6FgNoxwGnoohj1120C8ISU6S6jG1suPLJMJfsQAEVBY7C5Q0nONJN
         AkcQC5CjkaUCQHaq4fRS8JpF7hWkmKJna8hsFfu+/Aiuzwns3kwFMXWnqZzd+ErVtj15
         LnDmGr2NMsK9m0sqqcHEoAWR7eKNQr7Cpqa4HzBlsROsiz5SkEl/ll+MOl6BlE/kUUtI
         61WUDzovGO5H6ThPNF1n8BfPqVV6m7qv6S3Zscnc7eqs93/ayrkh+mxLEWSDVC68ayxj
         0+NeeKW52o+b3d8XtURwl3ul8/kPF3WjyBkYG0fqf3gwXADJOVnHHj5rZcfLsyrztPxh
         cMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sB1PMWA/ZgtSnuaLYnidQDY1PRQoxYpPc51bJqK9AUA=;
        b=KKvjk5bs165Y+dFR7FAaSFGnRb9R6xR8R/ru81Vbf2PVK4uhyXyZ4AnbO2m+05iL9S
         2vtW/EXNV7tRD2mCkjcnLVWzYyUQEXsLE5PxHxjgKCYZ0uFZvzSsS7XOvoyK5HtEsbQr
         e42p+kzKA+UaUWzcnl7/WC2wBHTHeWr9Fn0tH2aIG1iGfzxhWmj+raTYU1dbsdMB6l6E
         opPLJeAiX8gwDwZWYHyzGeOOKnz3hDcFkcqFJUitrwQBbRojL9ZJWx1WE21+mLHla4n0
         XFNG4sNmJO1Zl5gO8QGGD4epKYToEAs53k9MdzwhFBOWKu7IyfSxG5UXLMCVojIS/LrR
         Yahg==
X-Gm-Message-State: AOAM533p8P9cMyCRokT2xPG7tw2Oji7/Mh2QmliJ1I8KKSPy3pA5qoOu
        CL3rb5ri8Z1fhWss60rPI9w=
X-Google-Smtp-Source: ABdhPJw/iEC4zfda/17vuVcH5S+7dLC1aQchLJ2YA0gDqQf7+Z87zv2aAGQwjrrgMvG7KcFdqntimg==
X-Received: by 2002:a17:907:7f29:: with SMTP id qf41mr5992812ejc.211.1631226613331;
        Thu, 09 Sep 2021 15:30:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:3694:e80:aff:4a9a:bef5:ef56])
        by smtp.googlemail.com with ESMTPSA id m6sm1670883edi.10.2021.09.09.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 15:30:12 -0700 (PDT)
From:   David Virag <virag.david003@gmail.com>
Cc:     virag.david003@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: samsung: exynos-pmu: Fix compilation when nothing selects CONFIG_MFD_CORE
Date:   Fri, 10 Sep 2021 00:28:12 +0200
Message-Id: <20210909222812.108614-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 93618e344a5e ("soc: samsung: exynos-pmu: instantiate clkout driver as MFD")
adds a "devm_mfd_add_devices" call in the exynos-pmu driver which depends
on CONFIG_MFD_CORE. If no driver selects that config, the build will fail
if CONFIG_EXYNOS_PMU is enabled with the following error:
drivers/soc/samsung/exynos-pmu.c:137: undefined reference to `devm_mfd_add_devices'

Fix this by making CONFIG_EXYNOS_PMU select CONFIG_MFD_CORE.
Fixes: 93618e344a5e ("soc: samsung: exynos-pmu: instantiate clkout driver as MFD")

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/soc/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 5745d7e5908e..1f643c0f5c93 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -25,6 +25,7 @@ config EXYNOS_PMU
 	bool "Exynos PMU controller driver" if COMPILE_TEST
 	depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
 	select EXYNOS_PMU_ARM_DRIVERS if ARM && ARCH_EXYNOS
+	select MFD_CORE
 
 # There is no need to enable these drivers for ARMv8
 config EXYNOS_PMU_ARM_DRIVERS
-- 
2.33.0

