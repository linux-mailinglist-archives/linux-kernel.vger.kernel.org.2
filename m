Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3083B8030
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhF3Jny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhF3Jnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:43:52 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0779C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 02:41:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t9so1695895pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGtPfOV9vrhVOPGINw/acXqagOSexn7LkxSMLhxyAgo=;
        b=i9/0Vk6dG3P6YgfpMk9xA7naSxDqZjlBYCGd9eIkcQbQ+IF0iuh60zaNugjb6t2qPM
         peFz4bDnDBmS8tjDbjT3fgt8HdlWteQpaWcIcmHH1kaItrEb9Q5Ipu68yFLw8gSsj5ja
         eEAw6sbwbhtSQZO71/ei90c16T3oqsQi01GM5E0xPpIQEzO+/kLc1sXZHfY5TaMOo2zf
         nkJSoKzty2U9j6/AvPSHVDLsm+asZHYMxTnRi1WKq9xoLsiUNXzI7Bm41cP75abp2Uq9
         5fO2k41ZwQKmiD1SVI7kxzmu0+VdYF0IyNhyceiP6ZSITonF5aXqhBuMk91nTQqvHc4H
         5n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGtPfOV9vrhVOPGINw/acXqagOSexn7LkxSMLhxyAgo=;
        b=teCJwYFZl7oMa65KbBSNIodzrWRfnpf+U2VL6FGyQso9v1oP4V+zpYSPUKEEFVo11j
         2xmaxOO8cBxWk8M6Sxql5Q5ww8FV5guRfKBgQ6ndU6OIf7XiLLjrO1SygOQe6ksXwThs
         hqjKfT7KahoMjx82cs7cvg1S6prnqYDfd4Vd4572TVmdD67rjaRm6iOfA6T5jfub03WB
         RmUuGoijw++wsNXI9lpPy8c1dNyWNl5QS6KU1O1bnPZ1YXhz1ompq0BFYSZ9VFYVNtLS
         zCqpwXlEpAxUAtfWE/Fs0LZjkKnb4s/S+y0f6YfFyTVFNo3a9bvIjuUhkiJ6zbwyGBHG
         qNMQ==
X-Gm-Message-State: AOAM533KGs6ivCmS3ICoMdJA9FxthYWvIH+ds2c0eH/r7C/diG4kUKBu
        s//LafvS58iruLchBDbTnHQ=
X-Google-Smtp-Source: ABdhPJxkNo+W/y92LZwFlsPJabaIjxQSKwse/NwURc7x/qroVyTziihaN1ruCfdrpsj9Q8N8l8+ERg==
X-Received: by 2002:a65:62c1:: with SMTP id m1mr3947040pgv.389.1625046082526;
        Wed, 30 Jun 2021 02:41:22 -0700 (PDT)
Received: from ubuntu.localdomain ([218.17.89.92])
        by smtp.gmail.com with ESMTPSA id e13sm20273783pfd.8.2021.06.30.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 02:41:22 -0700 (PDT)
From:   gushengxian <gushengxian507419@gmail.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: fsl_xcvr: Remove redundant dev_err()
Date:   Wed, 30 Jun 2021 02:41:12 -0700
Message-Id: <20210630094112.3582-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/soc/fsl/fsl_xcvr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index fb7c29fc39d7..31c5ee641fe7 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1189,10 +1189,8 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 
 	/* get IRQs */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq[0]: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, irq0_isr, 0, pdev->name, xcvr);
 	if (ret) {
-- 
2.25.1

