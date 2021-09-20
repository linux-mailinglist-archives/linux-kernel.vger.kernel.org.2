Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B956412A95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhIUBob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhIUBk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:40:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492AC06B8E0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:38:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 17so18582511pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psFhvnbomh4BZTHkKL4KzrE+hE5GmzxDRBn3ytu83Jc=;
        b=Jh5/S6Nlh5+moSDgJ1X+Hpv/uzVrmbgY4JdP4Iotvd1D5DO4axLaOg+hR6OHl5bh6l
         tRI515gAI99q7d3KNnQx/OBcGArC5zQtHf2BOHg1XUBjcjWkWa6HlZ7Yf9ZIrQxmDxoC
         H3XjmgptwGTgoUl8LfIHhUQZsX0NUTqMcbrocgs0RMX9HSwuNaS9W51GRVfsmPiPHw/K
         LMkNOWKEMRbgxX4hLzDlY1XPfwdLLdUKKVgXpkSLWFGPsrAvTKu8SPw9hYlF5M8cpQ4o
         ynQb30DS3W/2qDi9r37/VFXdjfEyFTwHgknpuUQ95PVfZ4807AHQ4dN4/oh0roAkczu2
         X2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psFhvnbomh4BZTHkKL4KzrE+hE5GmzxDRBn3ytu83Jc=;
        b=0UlxtGhNUWZnFQx3Yu7x8snhpPv/L9HzCWBmgmVIAIrzSZMxuNHK348ZN4XSh8+q8J
         S7omQOCVk9f25NgVVbp6x08tXJvdhuFiXEbBNS2MY/CIM2awUHXo9v/+cByZtjVeLJ4e
         ZVj5muRZ/qxIjI8PVFpv2sOr3ELDTI8NHrRBZpV+ggLXsDygU6+QB0XGm8PCXAi1Acq1
         YIyAwmTsF7Xz3HRV+iCWGowtny8blUI+VSoW7S68ULBX6ckqKlNxaXSvQ8rg/klX1xMv
         jEgrMcU+jAM6nkbX6p+dJl4kqbGlIJkAp6bXaCUqXoB11GpjratmaBPLoYLnHAa0/XC7
         jZ9g==
X-Gm-Message-State: AOAM533x+u6g0HiOGp63cXysMojvZG0L3lbdt8RGiIy4HeBNVsGkOnWk
        Mhwd7RiB5siPIf7TFgZUd4NSFymR5V4qVQ==
X-Google-Smtp-Source: ABdhPJxLb6UoG311c4JNQ3zT8ZX2EPvkY/tErqjRqz98DnU3DimZy4ausiw057w6+HzJTCD2vQv5iw==
X-Received: by 2002:a63:7554:: with SMTP id f20mr24835256pgn.161.1632170290437;
        Mon, 20 Sep 2021 13:38:10 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.29])
        by smtp.gmail.com with ESMTPSA id 18sm12904814pfh.115.2021.09.20.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 13:38:09 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCHv2] regulator: pwm-regulator: Make use of the helper function dev_err_probe()
Date:   Mon, 20 Sep 2021 20:37:33 +0000
Message-Id: <20210920203735.675-1-linux.amoon@gmail.com>
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

Fixes: 0cd71b9a43ad ("regulator: pwm: Don't warn on probe deferral")

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V1 - Fix the wrong probe defer for devm_regulator_register.
   - Fix the commit message.
---
 drivers/regulator/pwm-regulator.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 7629476d94ae..3bd020641b67 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -353,13 +353,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
-		ret = PTR_ERR(drvdata->pwm);
-		if (ret == -EPROBE_DEFER)
-			dev_dbg(&pdev->dev,
-				"Failed to get PWM, deferring probe\n");
-		else
-			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
-		return ret;
+		return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pwm),
+				     "Failed to register regulator %s\n",
+				     drvdata->desc.name);
 	}
 
 	if (init_data->constraints.boot_on || init_data->constraints.always_on)
-- 
2.33.0

