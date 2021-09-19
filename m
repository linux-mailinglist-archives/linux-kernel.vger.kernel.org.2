Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0709C410AED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhISJc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 05:32:58 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36466
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237648AbhISJcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:32:52 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7713440268
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632043886;
        bh=kQQ3DII0goGULsKC3IpaIdAzj47jj9Kr+j3EHg4ikV4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=na/6ARgKSk4/gNsBLxTVV1GLpyaJDj6P6Z8Z3qM4BF0i81EiHJIPji7GHgLIDAPPC
         oimtHcGxbtykZ8xeNzO1APDOHWXgpvOUR+kMJTEVb3UoBc8KP8BS3HoM4PoNz9YnD+
         ng0FKOyMEdeC2RU64GZuSTgNzxcISM7vHmaFV60RNWV94c78p0BYIxHjNfhKLcAauZ
         bMTX/IcdiJPD1ZVIE0M//YoAu2HnYPW9N/IRZwsQT32QVCr9isDBf29TXbtn4qSz6Q
         EmpWVrUH6kLTXIGgflZ2JovkGMHTVd4o8EAiUbgwpqB6bK4NmcqREJrX72Pd8QuSed
         CgKcWSlw3GWfQ==
Received: by mail-ed1-f69.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so10363873edy.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 02:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQQ3DII0goGULsKC3IpaIdAzj47jj9Kr+j3EHg4ikV4=;
        b=ynDgEf94OhnKU9kplkqTbS5401xZv+POdaEpnyAJm7ZSOPLiTXV/50jm9uV1YeRKGa
         hHM+YKRL5qCM78JPdyTOkGgWYwZkOah0UZgNl2kJN0EM9MPzrZqvVCCCGdlrhmhQxqIR
         YDx0Comfxzxt5aHfJp6xE2krvDeLcTNbPYdW5vWrJepYGgcivnie/+IwfWdppHe9VcDi
         RgNu0/S3CSDqXvlaM1q5eG2hjkMshXVP2+OG4OKfVuL7Aa6jtKUePNyqYyX3I2kgEdpl
         4bOPW3HYNAjT9H8mJna2YBWiLWp94ej1a/ChjOY1d+pKNZ6f7h8gicw1HzolioxIcQVD
         QhJQ==
X-Gm-Message-State: AOAM530tg/VqxyEouc7XT8kMZIVNYaYskKqqZjd0VXYt+1ep6/aySlQe
        KnZ22Mh1dJzFBoJe83Db7Zev4X0TIaucEAGY8gSElBbmJSWZl+xR203tlQ/j1zVv8GbB1HGGNfR
        xSJ6mUy7H89fudTAxYaEe1thDMFCyxkb5jvqyKOCnbg==
X-Received: by 2002:a17:906:9742:: with SMTP id o2mr22771109ejy.532.1632043885746;
        Sun, 19 Sep 2021 02:31:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEFAa7c6Av7U5U1PtRddqgYSD610UFSt0vKxt2koSA5G3bvhYKyXN1L5uDJ1+O+zIJYe7yrQ==
X-Received: by 2002:a17:906:9742:: with SMTP id o2mr22771093ejy.532.1632043885610;
        Sun, 19 Sep 2021 02:31:25 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id p24sm514111edq.27.2021.09.19.02.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 02:31:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2 3/3] soc: samsung: exynos-chipid: do not enforce built-in
Date:   Sun, 19 Sep 2021 11:31:14 +0200
Message-Id: <20210919093114.35987-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210919093114.35987-1-krzysztof.kozlowski@canonical.com>
References: <20210919093114.35987-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After converting the Exynos ChipID and ASV driver to a module, allow to
actually choose it to be a module, while being a default built-in.  The
side effect is that driver could be now entirely disabled even for
kernel with ARCH_EXYNOS, but this is not a critical issue because driver
is not necessary for the proper platform boot.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/mach-exynos/Kconfig | 1 -
 drivers/soc/samsung/Kconfig  | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 5a48abac6af4..30f930e20599 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -13,7 +13,6 @@ menuconfig ARCH_EXYNOS
 	select ARM_GIC
 	select EXYNOS_IRQ_COMBINER
 	select COMMON_CLK_SAMSUNG
-	select EXYNOS_CHIPID
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
 	select EXYNOS_SROM
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index fe139f26d093..e2cedef1e8d1 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -13,8 +13,9 @@ config EXYNOS_ASV_ARM
 	depends on EXYNOS_CHIPID
 
 config EXYNOS_CHIPID
-	tristate "Exynos ChipID controller and ASV driver" if COMPILE_TEST
+	tristate "Exynos ChipID controller and ASV driver"
 	depends on ARCH_EXYNOS || COMPILE_TEST
+	default ARCH_EXYNOS
 	select EXYNOS_ASV_ARM if ARM && ARCH_EXYNOS
 	select MFD_SYSCON
 	select SOC_BUS
-- 
2.30.2

