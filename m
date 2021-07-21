Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF673D14B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhGUQQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGUQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:16:45 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C598FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:57:20 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so2659935otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0OvHkCyz9LLvT220NYOgNLNjrYsQy7YCoK/EMW9oPo=;
        b=ouW36uQxrsGLkiCVHb0wKAfUecN1TovOyYPnNt5BrPq8E31tTUtSSZzPDGy6jXXldP
         33YulQQDEUBqXnVMS7yjSTVBCgDCH1QHTJoGCI6gBUGVoNaHE680PXhWRRbzzaSzkhe8
         UEMxYeFwHPRxW1rgaAiwVXmc23LKlYWoRCRoop+dTAnLtdO1dN4kfAvPF23QO/uZb08Z
         vH7dDijlKTDxvzs5hZAXZeMyAqwjs/zN370B2sss4J1quxQHDRzlYuoYVT0L4vtOWZjz
         HU/9fRbIBuRaI5NGQXi1bFH+zvCL5tmv34hpApIQwOMU20g8ZNA5HudJ4B8TiIBjQM8i
         FKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0OvHkCyz9LLvT220NYOgNLNjrYsQy7YCoK/EMW9oPo=;
        b=Cl0YX8C+ns8huuGmoyE81EItTmIgvgvQDLBi1KBlQ/oCz3CCZYOPGu4aQNsgHQaHoO
         btFHlg9lrNAy/jODN5S8y7RVJbS/sHR2KoKEXAAZrR0pZS/31ApOGO5ZPmXj+bENiToG
         Abl5JYdS9PSFs/NFdI3pFhOO2K3ZjpXteGuo81Q97FffI8ca2IzUgGyznjjlKB2H9Ss3
         Jngebw2yTnwCJAbixUyDcDH2n33zRgeyj6wUlFguChZqJRHDTsvBm1MVtVB602vU/zsr
         jdCxlvF0QE3YXwK4sTxD6z2uDFZPak4WR00kjz1kx+zXT1Bdj0JNb0mg3tHEIRBg6cUJ
         eMrw==
X-Gm-Message-State: AOAM531PI8eCfnLffieHb/eMZ3mPAj7wx+ihIkWQnLvmrypi8uUpxJOY
        qQ9XJ2rIqweyWg+OGsf4lrTjT1zmFl8=
X-Google-Smtp-Source: ABdhPJxQTBHFfKAjnO6xV/GDlCFojZY9S2/Rd/zth54gWqpMI4ZmM51DBghGDbTRLBHxLY6g+CKMYw==
X-Received: by 2002:a05:6830:30b8:: with SMTP id g24mr26890126ots.248.1626886639846;
        Wed, 21 Jul 2021 09:57:19 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id y26sm4933042otq.23.2021.07.21.09.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 09:57:19 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] regulator: fixed: use dev_err_probe for register
Date:   Wed, 21 Jul 2021 11:57:16 -0500
Message-Id: <20210721165716.19915-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Instead of returning error directly, use dev_err_probe. This avoids
messages in the dmesg log for devices which will be probed again later.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/regulator/fixed.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 39284610a536..599ad201dca7 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -287,8 +287,9 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	drvdata->dev = devm_regulator_register(&pdev->dev, &drvdata->desc,
 					       &cfg);
 	if (IS_ERR(drvdata->dev)) {
-		ret = PTR_ERR(drvdata->dev);
-		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(drvdata->dev),
+				    "Failed to register regulator: %ld\n",
+				    PTR_ERR(drvdata->dev));
 		return ret;
 	}
 
-- 
2.25.1

