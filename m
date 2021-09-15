Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1840C2AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhIOJTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:19:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:17:43 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g14so2175711pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Yym1sMZa0HbFN1TnfkZBnrVhuEnYae/tLFANPpbkxc=;
        b=HZN0rAF31KUWgwdjhYPAAOL62X6/w7lEYomR5RdTEAAmMmC8UxeCMWBih0Q6DBzuIx
         f5Y+jZ+dnQx9CLxEHYIEhvuJ8vIgDQdRhuPpEegbQbXCWn2cbQoP+OUZBKShypuM9EvY
         kxddoa0q+ZQ+EAJmmMRswsBRrTB0C/kQQ28BpDBjSFiYnZFCF5LxNs4k7sWwf9ZXisOs
         /IwZd8Jd4phnRok1ApiOUGTeUBLTkS9MY/OeeZosM9IqzmIgS8utqzL4WwFNa6tXiQ5f
         1dv/F5NQhw/vrymBOrF7RC55sa9iH8jlCDVrz1W8LKV+yKz8Oo+dJq4eEaacCldNe/8d
         LNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Yym1sMZa0HbFN1TnfkZBnrVhuEnYae/tLFANPpbkxc=;
        b=KqiS3MVXE8kqpWu0FEwtaqRzPiPg8hoMjB7MqsUccywai8zeGW28SPPUYb/F9ArOaO
         PeJw+o30xtgV5MCLtvZ1NOX1OodmMzsEg8Rkjm5Tgq4mV5xMOLFEkFW8UcWdoAIE6c0m
         csnp+r9UGxH2gm7ypc0skYYMIaZ8dAkw13oF/GdmXfAUbYivB6bpuDUbuRA1JSl7//g2
         8zFyxIy6hKFlyN/SELqAkhqAvKN2vtmBuryB35JJPOpSf6KjB7qDDTNvzyNaT4XGzdoa
         owPHh1+A6TcYq1NnUUkZg/0PQmJAbW2vjUSowoEXJ8z79s6sN5UNvMblSIct2t+SnA/0
         D+qA==
X-Gm-Message-State: AOAM531b7x6bConfaf3GUXq86SBPGVtsIkynnLpy3mJingOJ8WdLxS6s
        5V11Sw+Fp12svJCWpKfGCAE=
X-Google-Smtp-Source: ABdhPJw5dU9KybpyYHFJXLsJ8m3W36jHpgzQALTXYkfUl9RQr2dzEcVujPYVkenuVLxR+9WRpENrZw==
X-Received: by 2002:a63:4c5c:: with SMTP id m28mr19400180pgl.67.1631697462800;
        Wed, 15 Sep 2021 02:17:42 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id u10sm4168620pjf.46.2021.09.15.02.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:17:42 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: sprd: Add support for SC2730 PMIC
Date:   Wed, 15 Sep 2021 17:17:26 +0800
Message-Id: <20210915091726.251031-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

SC2730 is a PMIC SoC integrated in UMS512.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 6b7956604a0f..57fb2445720f 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -18,6 +18,9 @@
 #define SPRD_PMIC_INT_RAW_STATUS	0x4
 #define SPRD_PMIC_INT_EN		0x8
 
+#define SPRD_SC2730_IRQ_BASE		0x80
+#define SPRD_SC2730_IRQ_NUMS		10
+#define SPRD_SC2730_CHG_DET		0x1b9c
 #define SPRD_SC2731_IRQ_BASE		0x140
 #define SPRD_SC2731_IRQ_NUMS		16
 #define SPRD_SC2731_CHG_DET		0xedc
@@ -52,6 +55,12 @@ struct sprd_pmic_data {
  * base address and irq number, we should save irq number and irq base
  * in the device data structure.
  */
+static const struct sprd_pmic_data sc2730_data = {
+	.irq_base = SPRD_SC2730_IRQ_BASE,
+	.num_irqs = SPRD_SC2730_IRQ_NUMS,
+	.charger_det = SPRD_SC2730_CHG_DET,
+};
+
 static const struct sprd_pmic_data sc2731_data = {
 	.irq_base = SPRD_SC2731_IRQ_BASE,
 	.num_irqs = SPRD_SC2731_IRQ_NUMS,
@@ -232,6 +241,7 @@ static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
 
 static const struct of_device_id sprd_pmic_match[] = {
 	{ .compatible = "sprd,sc2731", .data = &sc2731_data },
+	{ .compatible = "sprd,sc2730", .data = &sc2730_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sprd_pmic_match);
-- 
2.25.1

