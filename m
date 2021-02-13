Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29AA31AB32
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBMMJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhBMMJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:09:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAA1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 04:09:03 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z9so1136531pjl.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 04:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oO7vMSW0bfsJGTS5Qqt+bC8w+pkLjeLaJvk90+zKPLE=;
        b=GoQUPu9CaYvcu1GOJ9LBhCTwuu/1xBbtZrbhMjLjs9jVEJCDnivL4IPsVqJIvCB2ik
         wqq8Fs2UP/ucjrrtlqPPqNSSNunw47guJ0vj5RP6Yktrxk7VHaJoIkLDeUl6Bt06VDHl
         W0lsjD4+QUL9C0UUn2NUJVQsXgGoFMihrA0X7gFgSSNmqMAFwr1MeJpikLrBjqyf8fSR
         izp9r9X+jEpiXFt3Pt98Aoa8GXiOprlupuuIIWc5DD+Z07rjrylblkEPcFPf3gceSacJ
         8Y52f9Tk+q3npTZFwUIyMOK54OQ/B8sQU9nXLd0bx4Op5aDlPyaMM8bhrxY7FUkA7OYK
         OKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oO7vMSW0bfsJGTS5Qqt+bC8w+pkLjeLaJvk90+zKPLE=;
        b=XW7Qzvw6rep1l5Quva1a/RZVUOBkJFjIBVIvp9eODAK1V4QhLO7YdH6Ic56mm82i7J
         ngrJomDDcHPAQ9TY0BX3ejqpm/+xziOuD303EoMB0c//160Szdr2d3eHw2BADuqeTYuK
         VN3UwzXQNiI66u3Uzffh/fMpbqnXdSxOEGr2gq/ZLTG0M7pfltPXvEG2lz4p5y7jykaX
         hZxEkR5742zziMVkXKg2+AFuaxXFGzSXz1aHW3kAl4+WN5gDu/ZqJkdEqQSJbzN3dSPf
         kpcK+Qlf0OsyDNMVQ3E/aNbAD16Csbp5TBXkkZfxsyMQ0LSIHwvgCv7XSEmi+47eK/Pk
         no4w==
X-Gm-Message-State: AOAM5329CKClG31xo9hDq84/hUEyNew8iaa5Y1Dvolhf1JkdGjm62tKV
        GNyyCrEpGEi57yi4Sa6f6Kw=
X-Google-Smtp-Source: ABdhPJzUs5hnvIVxNPFD/RV2FAt44Ws9Cuiv/FRwlwtBLt8MnWLlpM+onpPR4m/5Qf7kmKeUk8JSxg==
X-Received: by 2002:a17:902:e309:b029:e2:86e9:cc75 with SMTP id q9-20020a170902e309b02900e286e9cc75mr6532272plc.59.1613218143063;
        Sat, 13 Feb 2021 04:09:03 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c0a:f013:e601:5200:b1d8:3ee7])
        by smtp.gmail.com with ESMTPSA id gt2sm154470pjb.0.2021.02.13.04.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 04:09:02 -0800 (PST)
From:   Mukul Mehar <mukulmehar02@gmail.com>
To:     mchehab+huawei@kernel.org, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Mukul Mehar <mukulmehar02@gmail.com>
Subject: [PATCH]: staging: hikey9xx: Fix alignment of function parameters
Date:   Sat, 13 Feb 2021 17:35:59 +0530
Message-Id: <20210213120556.73579-1-mukulmehar02@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl check:

CHECK: Alignment should match open parenthesis

Signed-off-by: Mukul Mehar <mukulmehar02@gmail.com>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 9c5e113e1a81..4ebcfea9f3bf 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -177,7 +177,7 @@ static void hi6421_spmi_pmic_irq_init(struct hi6421_spmi_pmic *ddata)
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++)
 		regmap_write(ddata->regmap, SOC_PMIC_IRQ_MASK_0_ADDR + i,
-					HISI_MASK);
+			     HISI_MASK);
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
 		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &pending);
@@ -235,7 +235,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 		return -ENOMEM;
 
 	ddata->domain = irq_domain_add_simple(np, HISI_IRQ_NUM, 0,
-					     &hi6421_spmi_domain_ops, ddata);
+					      &hi6421_spmi_domain_ops, ddata);
 	if (!ddata->domain) {
 		dev_err(dev, "Failed to create IRQ domain\n");
 		return -ENODEV;
-- 
2.25.1

