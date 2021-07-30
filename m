Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B1D3DBB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbhG3Otu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbhG3Otk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:49:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0573BC061381
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:49:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id da26so13582187edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ot32ht04BXO8SKhUwdTi6PwT+/ZyNLaqR53YTHmra28=;
        b=CH1XwFDMONkRoS0L/kjL/lrkowO/ss3qdcPZnBTDvs9TyvKmuerCCsIOLDQ9whEtb6
         LW4ewm6dUjJsvwEntmn+i8e6kPjj/FgSpYDhkxFjVmelJcH3ZhgN36FF0dxTD1qPnf6P
         FBXuv+h7IKzdGuw8Uyr2ElP4rMeGixDfNhev/gZamNoxmF/aIMYvjdbjO3vcgi/079cy
         07aaQRfBED4oskkILUpFNugLxcz+o6RS1BLFD4+OdlaR9aXEiIpedeZE8fE1ovYCH5R3
         lxiDVpYXFudf4biV3k/60rOdqE665ZtCoAD4SoPrQtq8xxCqsIwIZU8i9D+EL4Q9Wbl8
         KTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ot32ht04BXO8SKhUwdTi6PwT+/ZyNLaqR53YTHmra28=;
        b=SB5qqfbSbyWBMRqFqlKJjWaB70tuvMzvPXFuSMMX1bWUwHbudHwozO6jdNO8Un71rq
         8K/Yl1XfOnVHDLASz1nQwIEsA9Bmbd49lis3pPHm8rkv0n6aC/NwHgh60fpiL4RlErID
         6cmO+irHNp29oIUEmtnVAhlv/fCbUz2e0mklaDslsxDSVC9nNdnbkzAL/ZGz2ySZUPEL
         HgGCLzk65ejzoNSpHH2+SlLydes7h/c49FGNIMZFtH0b9PzU5I5S6KM1Nmj5gULX6Rq5
         v+x0ahDwLeDWkHDzxrXCt+5lXYzi6tks1JaLVHhgEgVx8+1rdKBIZTacdmeOWY6dLt5r
         /SdQ==
X-Gm-Message-State: AOAM533omMwoY//oREuf+oA+RO0rTMt+Pv0rxo4wokYcpFp22OcnrNNi
        LCw7fS+3RGOsZw1/u+19Sq/X1g==
X-Google-Smtp-Source: ABdhPJzJHeG6sX0rfzJjBc24DJrsJii8Q6q/W+APtZpb/CrAtPhcTiGt4fyoTMLI3v8zLI+1ZAdKFA==
X-Received: by 2002:aa7:df09:: with SMTP id c9mr3446384edy.379.1627656571652;
        Fri, 30 Jul 2021 07:49:31 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id ks26sm639920ejb.58.2021.07.30.07.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:49:31 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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
Subject: [PATCH 05/12] tty: serial: samsung: Fix driver data macros style
Date:   Fri, 30 Jul 2021 17:49:15 +0300
Message-Id: <20210730144922.29111-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730144922.29111-1-semen.protsenko@linaro.org>
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
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

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 0f3cbd0b37e3..75ccbb08df4a 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2817,8 +2817,8 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
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

