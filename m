Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A064183A5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhIYRgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhIYRf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:35:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E255C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 10:34:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r2so13210342pgl.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOGXsR2lrn1dvNa/qlhz6wa9pGiy56aLxSKQi3X0iXU=;
        b=PCr602QkRq5ChttjxjsGMbOGLlm57bxLWVzHhG9I8KLAMRBFiMXX2mctmlGH0+wpzK
         +85vmB/dnmriHyyruQ8N2kWj3/x2a+61M0aamLwLNqj5dczTkXpeXS2ymEQHA50K+lBi
         XrTNd4n+tI1kq483mN0G8pWY1dNBQl+zUU/CLFZR8foGuquw/D68VsBh/gOK/i3rco9R
         7w7jFS8K9GR86np6LCLeCaJ3ZdOIUcmJHMDF/rguCD4u3TCcyvu4lG0PjBcgQM3iYoug
         9R8wL4g0V+VEll+NuJsxv2r9Sbb2qxpt/ZqrPHhexlUgPlXnr2jt3Ti5h4WIGGy8jRYe
         Xegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xOGXsR2lrn1dvNa/qlhz6wa9pGiy56aLxSKQi3X0iXU=;
        b=4KRHWUgFs7yOjcVcSw0DhW5Oy3+C8RqQt34a64BifDA8X6qhVwYLQKhvz8HGjjCvd9
         gDRGiYGcmQjlK6+Rq9XIRegSYtODYPFWbp5E4nMzkI/Av8GkkfcNRnWSM/A084jqydcz
         5nBRUgvM8st3MeLDtGL1g5r09lJgl8GvSOKVrCZGZbKgM7UORZBJiOd2fu5epsd9UIvv
         H4Lb6xp7cR52txbkzurjMzcu6xkQFMjxSY2d/A6sutf2cInH5HynqKgyEpQt3GLgVXwi
         RHVJfIiM5w1u1pbHo50pXwiFeM/YIvu33S0/8HO76qS25LeOnnBpkVHG/pP6tSRvbGWF
         oomA==
X-Gm-Message-State: AOAM5335aBgznYm69ZtpugTL0N77Leco6SPmasXmYU99dH228hGL13pO
        caKP7iO2zzgw5nMNt0m4Hpw=
X-Google-Smtp-Source: ABdhPJwow57UKHvlSPfIR1Ttemgg4A161D1G2paG/eKWqU5i7Y195BpJgW85Igoabj61Qo65/5L3fw==
X-Received: by 2002:a63:a70e:: with SMTP id d14mr9093741pgf.431.1632591262567;
        Sat, 25 Sep 2021 10:34:22 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.30])
        by smtp.gmail.com with ESMTPSA id j6sm13113980pgq.0.2021.09.25.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 10:34:22 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCHv4] regulator: pwm-regulator: Make use of the helper function dev_err_probe()
Date:   Sat, 25 Sep 2021 17:34:12 +0000
Message-Id: <20210925173413.1019-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_pwm_get() can return -EPROBE_DEFER if the pwm regulator is not
ready yet. Use dev_err_probe() for pwm regulator resources
to indicate the deferral reason when waiting for the
resource to come up.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V3 - Fix the coading style issue. dropped { }
V2 - Fix the return message and drop the FIX tag in commit.
V1 - Fix the wrong probe defer for devm_regulator_register.
   - Fix the commit message.
---
 drivers/regulator/pwm-regulator.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 7629476d94ae..b9eeaff1c661 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -352,15 +352,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	config.init_data = init_data;
 
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
-	if (IS_ERR(drvdata->pwm)) {
-		ret = PTR_ERR(drvdata->pwm);
-		if (ret == -EPROBE_DEFER)
-			dev_dbg(&pdev->dev,
-				"Failed to get PWM, deferring probe\n");
-		else
-			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(drvdata->pwm))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pwm),
+				     "Failed to get PWM\n");
 
 	if (init_data->constraints.boot_on || init_data->constraints.always_on)
 		gpio_flags = GPIOD_OUT_HIGH;
-- 
2.33.0

