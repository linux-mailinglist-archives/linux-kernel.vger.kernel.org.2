Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE83950F5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhE3Mm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 08:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhE3Mmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 08:42:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F096C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 05:41:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so1595831pja.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 05:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Jqx113MBKnddNhzOkprXtVqZyLIV/wglPd8diwf1ko=;
        b=CJgb739M797kbA83Q52TiLOP8vLw5oBe13Fgh1uf0V2ess2TD7jB9hG3hPRVC2LK8U
         cR4DuvA3lBDPfogfZWLKN6Eo7Y16JDmjrMR0dBmgoRhdoQRsHCyYpSQ3hFVsSfZk0VNn
         ruWY77L7AfHDl3sPLuR1ckiULO8Mh79ORo1Cz/+Z7ITc406ry9dwd/PQoKMpW4uY5T2s
         1LMbj6SM+kQv6qLola/BsW/F07rwUZUr5H0uHbiVtIDnvjMCuSp/b2gh5yQEObzVP8Mg
         9Gueurng8ITXU+x2Ljtt7nt8JYzxON0mj7qH1abAM5NBmWr0pYlq2DkUBIRdK78h/Wpl
         bqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Jqx113MBKnddNhzOkprXtVqZyLIV/wglPd8diwf1ko=;
        b=Th30XBdMqjddyzaaYxHDfxR2LllMAaDk4xfhP+it/HahA485/yEzVwq1haCoEQxj5u
         X/z1uNGUAIeTW4YaBWHtklnivDrHyktSfJ95T8NRr0y+VMEkA4FdEw512No1DtJBa1/M
         ycZ2aRv067C/c7jJ9p9Ik6Chc8UglUNZqMejvJuUbLFr8h3DliQeHw6idU/brMwLHWHm
         msYpcvcGwcsvyFXqR59fSVudcfwVIdKGW4YfqFRHYlzsoUUfcZzzDpqULdk/rgDz4Avt
         nmpeTbNrr7zC8I4Ht2pjIbNpp4YPvqnuQExXYLtg0qUhk8cAb93ADo/MobE8eQqN29zO
         CSww==
X-Gm-Message-State: AOAM530cYi3dx9I5NeBRctMtL2Q3392nRrszjgsWdG+gAV94pVyzHhiE
        EBODgJb/w8i5FMnhxj0W+fIthg==
X-Google-Smtp-Source: ABdhPJwbR31uTGoF7HC1Q8RtTtA5fPn1B42JLtLJCfn7PpLwECKkASoRGesIBX4SSQvtn1of2ZtcwA==
X-Received: by 2002:a17:90a:17e7:: with SMTP id q94mr13865070pja.117.1622378476147;
        Sun, 30 May 2021 05:41:16 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id c11sm8661658pjr.32.2021.05.30.05.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 05:41:15 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: rtmv20: Add Richtek to Kconfig text
Date:   Sun, 30 May 2021 20:41:01 +0800
Message-Id: <20210530124101.477727-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210530124101.477727-1-axel.lin@ingics.com>
References: <20210530124101.477727-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The other Richtek drivers has Richtek prefix, make it consistent.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 9aeb32c320aa..fc9e8f589d16 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1032,7 +1032,7 @@ config REGULATOR_RT5033
 	  current source, LDO and Buck.
 
 config REGULATOR_RTMV20
-	tristate "RTMV20 Laser Diode Regulator"
+	tristate "Richtek RTMV20 Laser Diode Regulator"
 	depends on I2C
 	select REGMAP_I2C
 	help
-- 
2.25.1

