Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C374365E29
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhDTRD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:03:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50168 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhDTRDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:03:25 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtm1-0004dc-1N
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 17:02:53 +0000
Received: by mail-ed1-f69.google.com with SMTP id o4-20020a0564024384b0290378d45ecf57so13583100edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHDtfujd3OPxNtMM86LnHidWuIbqjKYUJi1OA9n+rmQ=;
        b=KT5rs99NtBgPI1TEVfWcqjZgJXhPB+L+oOc2qWypNftiu7gnq8y6EatxKUjqKMGKvP
         aS9rZuXE1BEOI7F1ffBKVIitphyMb4J2K6AYyfpshGLN3sruFNuvG7dC8BU9nazJXSCz
         MNT1tl/FoldSnTWp0IyERe8Du/VXc4HGUsye5fn1/874EXgsoFdbVoSPdUYaJGL2YrOc
         PrVCGFB/jlE8UsI8nYybchACNE/cJtHTyQL2cc+5lNOAH1WAUonyu1bgf1sHhOEVhiz4
         deKFcbsnb9BNWQJt1ugCty6P6O00XWUbt9Od6X1A4P18Tk6DmDKTlDRIHMQvOc7HhVDb
         Itig==
X-Gm-Message-State: AOAM532OCxwLa4arz0sepDGCUTmvbK1QvBS7H4HX7mc+uJbHGyH3JGai
        bj9js604e/CZmxjGDLDiiE7mPLbOOTkJ+3eQlC0d0pzMJrm9AHWZQAqOJAYwhtxTSlUUuOyaHsy
        QtI+EG47Mkw3VTyv2lErqMMSlE8NXMZXCLP9SnOXRGw==
X-Received: by 2002:a05:6402:26ca:: with SMTP id x10mr19010616edd.386.1618938172775;
        Tue, 20 Apr 2021 10:02:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/sePBPRPQUTmx8fDkJ2+CsjWnEpj49FgojrQhVJZqntZu2qHLjMn0Vt3q4U7LC4bOpSKRAQ==
X-Received: by 2002:a05:6402:26ca:: with SMTP id x10mr19010591edd.386.1618938172615;
        Tue, 20 Apr 2021 10:02:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id s20sm16590714edu.93.2021.04.20.10.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:02:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 8/9] regulator: s2mpa01: Drop initialization via platform data
Date:   Tue, 20 Apr 2021 19:02:43 +0200
Message-Id: <20210420170244.13467-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420170244.13467-1-krzysztof.kozlowski@canonical.com>
References: <20210420170118.12788-1-krzysztof.kozlowski@canonical.com>
 <20210420170244.13467-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the platforms with S2MPA01 use board files, so any
initialization via platform data can be safely removed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/regulator/s2mpa01.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 115f59530852..28b424fe7bea 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -340,7 +340,6 @@ static const struct regulator_desc regulators[] = {
 static int s2mpa01_pmic_probe(struct platform_device *pdev)
 {
 	struct sec_pmic_dev *iodev = dev_get_drvdata(pdev->dev.parent);
-	struct sec_platform_data *pdata = dev_get_platdata(iodev->dev);
 	struct regulator_config config = { };
 	struct s2mpa01_info *s2mpa01;
 	int i;
@@ -356,9 +355,6 @@ static int s2mpa01_pmic_probe(struct platform_device *pdev)
 	for (i = 0; i < S2MPA01_REGULATOR_MAX; i++) {
 		struct regulator_dev *rdev;
 
-		if (pdata)
-			config.init_data = pdata->regulators[i].initdata;
-
 		rdev = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
 		if (IS_ERR(rdev)) {
-- 
2.25.1

