Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD2361853
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 05:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhDPDrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 23:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhDPDro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:47:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE16C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 20:47:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so5755101pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 20:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jvn+FcPs/a8mF8oTY+ng564VcLse+XohALlgtHB3uwo=;
        b=fVtzqO2Oan3mRRwUs6ytpq9WeFjhRKIeSqlX275fOf6HbWmZHvPwxONXFNFxRyatyE
         wZSz2oOyXqRqEvqeOmNaVOFKTwnBlbuMCbXJNqHzeahF10FO2tEU2zteKY5MoRtSAceL
         MJD6S1zb4K6/B8renhWJu4/Ln1ufTBcV8Fo6u37Uea8nEf/Jp/RcYFDe4JsSx4tEADnP
         mcBIN9EMTBmyvZIRhGnJSqRB2+AX2V4QcrDusA7CTyFbXr9bHiGAT6YCS0OrFjNZ/YXQ
         kVaXmTzublVV/LfJ+6rYWRdM1TVTRw85loS9mB4WHpVfpruaKpXZ3S0M2wOXFW16nYuq
         aH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jvn+FcPs/a8mF8oTY+ng564VcLse+XohALlgtHB3uwo=;
        b=iH4Q3AYo84GwQf4P6e2qGhHQwe+VbH5mRfxBXkT6zszsF5bROB3JGKz/3aGDAnAMlj
         5SYlYK5sbSCw2LCaw3Qf0Zld8M0CmKiPPIOytpic0FZQrKnAhWvheufAXvDb9mSDlfFt
         qzQoyJbVwgklrG5IyvkaxdDPx/Ne6377sftg3VcoDajSjG5SgC239oJi2kmDmbvzNI7f
         9VcxAnBcf4Xbe79byze7QPtWHPBVyCvSLCY555Os6/tLtGjG2OrruEbJGCSHkP4CUwaw
         9s3VCvSjiu2nEefr+PPWCHitF9nD+V2m2puwRJUUUzxjrHqE4vX9jY5QSinmjldZiFcg
         MeJQ==
X-Gm-Message-State: AOAM5329KE3MG+qYSbFpgl9G+uFy1NbWIpjB3MUZkvekNJ8l355ji4wd
        MHO3gGoTIbwdr6NwafoWxqw=
X-Google-Smtp-Source: ABdhPJyPo6utWxE0Gwapva5Ja+v1DD4LsFNIwStS89Rfk+n5ieosIu/rgOG6S9Fsd8Ze2p2t8fv2zA==
X-Received: by 2002:a17:902:e051:b029:eb:4411:db58 with SMTP id x17-20020a170902e051b02900eb4411db58mr7387386plx.11.1618544839034;
        Thu, 15 Apr 2021 20:47:19 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id q25sm3326239pfh.83.2021.04.15.20.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 20:47:18 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH] regulator: mt6360: Fix missing IRQF_ONESHOT as only threaded handler
Date:   Fri, 16 Apr 2021 11:47:12 +0800
Message-Id: <20210416034712.7891-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Coccinelle noticed:
drivers/regulator/mt6360-regulator.c:386:8-33: ERROR: Threaded IRQ with no
primary handler requested without IRQF_ONESHOT

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
 drivers/regulator/mt6360-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index 4d34be94d166..34c354721ef0 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -383,8 +383,8 @@ static int mt6360_regulator_irq_register(struct platform_device *pdev,
 		if (irq < 0)
 			return irq;
 
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, irq_desc->handler, 0,
-						irq_desc->name, rdev);
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, irq_desc->handler,
+						IRQF_ONESHOT, irq_desc->name, rdev);
 		if (ret) {
 			dev_err(&pdev->dev, "Fail to request %s irq\n", irq_desc->name);
 			return ret;
-- 
2.17.1

