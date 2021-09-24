Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A554175DC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbhIXNeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:34:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59744
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346289AbhIXNd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:33:58 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4945F40827
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490344;
        bh=WNNN/oInJzxgO+63uGtXtE4bZ4URhmkG4TzZ5wV565c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=GpHj8e366DJQx/PSG/WWvAloiyKtpR1XdGF32+ufXq6XAQvkWlPlXzbwmwGWsBmLT
         0vVFpOnz2ooOe7OdAXwTyOGTprrE9KFIbRvnZzz5S8AOgC44AV1x6VvxJKSEvPtHk3
         EwjbR9owjTtAOkBypc2Sb6QCQBZwHYRP7v2/oyVtqfEcd/hGWwxqmE/c/E5TjSCr7O
         RPJEdrkDAXqwH79Vp8JY+vHRXVtU1o7y31pd1UtzJPh1S9bYKZHqSl4a2lTa0RTm4x
         fGp5mVikRaF1MgDGM5526UArTHMEqz8E5Kh5UxL4UebyMMEvih0jhnuyArgP8LtXwK
         VPm9YsjN1iZrA==
Received: by mail-wr1-f72.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso8071309wrw.22
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNNN/oInJzxgO+63uGtXtE4bZ4URhmkG4TzZ5wV565c=;
        b=yiLXwhznr47YnJ1WdBXi5YOV8e000pn2mlfnnolAX6clE7JhOG5jW/xit4HyXXkIbv
         xaANW/3qSUuRrwjaPzFJ0KiAguREpaYEQakWBuk9LKE9nfGqZ03lWDd9PYsnX84d06AI
         pNlv6JRzis/8606/N1yBI8L+Kwv5sSHO0cyiS1mNS8NbE4ZKmLEEfF8RV4EfpRYCo5oN
         Xglal3GQqc4FgAdpHUgxpIT2LOLenMEh6FqYdBf4YcLefdRDI/36iAfqefTQKcrKTQPy
         lQX3JJqiylKmf9cxj3n4dNzdGxdI9Y6jVJwk17jO8SpbfJlM1nbXFaESTOHuA1l03QOr
         560w==
X-Gm-Message-State: AOAM532xXS5DAkWnYBy0XZ+RjrWoN1F4cRZtwS/QhmBbe1sKBdjH3icQ
        5uug1bOU6NNdNU+a9IdMAF5uyKjj0Mpo25BlM3ggpwC+OL1UYvCelUJwr88AUA9wh946Qsttxon
        v9vmlzQRlPOTbdDQhcYhhvF4zLlfo+3pds7W1GJ2ItQ==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr2175626wmd.34.1632490342960;
        Fri, 24 Sep 2021 06:32:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxdm8BNCQifJ7uMGJIzTnRdy/iOjAr/qBwQBxmwjwyGKGSg/k4Yt8m0Ov2/oVtlzy9V/5yqA==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr2175602wmd.34.1632490342836;
        Fri, 24 Sep 2021 06:32:22 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id v18sm8400743wml.44.2021.09.24.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:32:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: samsung: describe driver in KConfig
Date:   Fri, 24 Sep 2021 15:31:48 +0200
Message-Id: <20210924133148.111845-1-krzysztof.kozlowski@canonical.com>
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
 drivers/pwm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index aa29841bbb79..21e3b05a5153 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -476,7 +476,9 @@ config PWM_SAMSUNG
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  Generic PWM framework driver for Samsung.
+	  Generic PWM framework driver for Samsung S3C24xx, S3C64xx, S5Pv210
+	  and Exynos SoCs.
+	  Choose Y here only if you build for such Samsung SoC.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-samsung.
-- 
2.30.2

