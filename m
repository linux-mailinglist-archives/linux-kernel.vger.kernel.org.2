Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5B3E2DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbhHFPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbhHFPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:22:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E3C0617BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 08:21:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z2so1827434lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1kCCgoXt/RH2VyRBayEiDwtnpxlIkmp9gMMzKnZ2tY=;
        b=gTKdWZTGrq0nkIjUWSQPn/d5ZzZ3QDECPUQd4NMQL76ikDODLNIB29E9+uxjHaiZaZ
         QYknqk3wRZTH9ky1MsXU76Kj1EyvNEcgNYTRNBR0D8796K9P1di9lJA4DsRcX+Wz0sE2
         +/AVYm5a+YbbL7gFe3qNVI485mAkTJGiM0ThXfA5DSdQB9d8zuLxMzz7zHG7yqIyoOBl
         6Sf6NM/uBUwsOAC2iSzEevFDDgnzXJ5jPJDYp1ke/nC4a6yEqMyVZAqa962W3cm9Kmt5
         QUIqpkShTrlGeD0Z3PH0Bq1nHCG8G2RaDuNM+IER7PX760GzZuEy0niDMIJmBT4lyJOT
         ZnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1kCCgoXt/RH2VyRBayEiDwtnpxlIkmp9gMMzKnZ2tY=;
        b=uA47TtybmbxepVjR77hVWKV8kExyt9z3rYFD+C8D0vdXqqknJGUSNVWlAghJwMuJri
         Hy97b4T3gdOWmRBrFXeGq5HNR2lImP7pgoXYW7Ek6piQjgk6QcCmGXaD/PkPhItzl3NC
         4vh1WnAo+ItbM/02C69BoP/pwaqMKjE7X7LJuYYEt/w8zce9rBdoQADYoPuiMx2kN9J+
         fetoP7KbFoGbswirSgeM4UPIbzNMkJFpV2W6oZFr6k+E90BkTz4BcUMIci2wDKaShekn
         lykoU4+dLjMe1Cp4LN9apsvPrqPRXKVJFdfz1HPRKeumz8DqtHVyw15sxERCflCjSbaf
         ydeA==
X-Gm-Message-State: AOAM530WCSknzYyh3+e2pwNRIgjNOExfbD7yV/wgZKRzSGKUuN/a/3XZ
        U5zPJPHQ6ZSzrG0gEMq99QdYwQ==
X-Google-Smtp-Source: ABdhPJwYlIS3ylvtYTVOsdN67qQi0hBTMhLV3llriBHUAISYG65bfxAvCkFBB9c5J5yE88XuOqqt2w==
X-Received: by 2002:ac2:42d2:: with SMTP id n18mr3695877lfl.505.1628263316001;
        Fri, 06 Aug 2021 08:21:56 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id u9sm861444lfc.278.2021.08.06.08.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 08:21:55 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 5/8] tty: serial: samsung: Fix driver data macros style
Date:   Fri,  6 Aug 2021 18:21:43 +0300
Message-Id: <20210806152146.16107-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210806152146.16107-1-semen.protsenko@linaro.org>
References: <20210806152146.16107-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make checkpatch happy by fixing this error:

    ERROR: Macros with complex values should be enclosed in parentheses

Although this change is made to keep macros consistent with consequent
patches (adding driver data for new SoC), it's intentionally added as a
separate patch to ease possible porting efforts in future.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Added Reviewed-by tag by Krzysztof Kozlowski

 drivers/tty/serial/samsung_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index b8034c1168e0..130bdc978e93 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2816,8 +2816,8 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
 #define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos4210_serial_drv_data)
 #define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)&exynos5433_serial_drv_data)
 #else
-#define EXYNOS4210_SERIAL_DRV_DATA (kernel_ulong_t)NULL
-#define EXYNOS5433_SERIAL_DRV_DATA (kernel_ulong_t)NULL
+#define EXYNOS4210_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
+#define EXYNOS5433_SERIAL_DRV_DATA ((kernel_ulong_t)NULL)
 #endif
 
 #ifdef CONFIG_ARCH_APPLE
-- 
2.30.2

