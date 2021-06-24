Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D968B3B2BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhFXJ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:56:20 -0400
Received: from m12-15.163.com ([220.181.12.15]:57524 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhFXJ4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=D6rgt
        o8QOwuzbuG3+IcLd2Dpya5XNWPjc+F0E2n2abk=; b=W8lp65PwdW6zFcfV6KUeA
        Tnaqd6lGWEdfRyjzN7FkbaSv7I8FijDeHP/MelCNK5XuSjNCR3ucHpHjNuEseIku
        DilAPU9IUB05XgQ0ts6YEsIWD6BCpOK/VaSJXF30maXaiYd8vh9oVc/rm0ecTxki
        zeBA3QVRnCfXITmaDxzCLQ=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp11 (Coremail) with SMTP id D8CowADnVs+NVdRgzs9MAQ--.96S2;
        Thu, 24 Jun 2021 17:53:25 +0800 (CST)
From:   13145886936@163.com
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ARM: pxa: ssp: remove unnecessary print function dev_err()
Date:   Thu, 24 Jun 2021 02:51:06 -0700
Message-Id: <20210624095106.392317-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowADnVs+NVdRgzs9MAQ--.96S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUCF45ur4kXFWUKr45Jrb_yoW3WFc_Ca
        1Ika4kG3yrAr1vva4UJw1ayryaq3ZI9rWqkr1DKF1xKrW5Aa18G34DWFs7JF9rWw4I93y3
        Xa93u3y3Cr1akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5dR67UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiXBe7g1Xl0Ei+8QABsV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 arch/arm/plat-pxa/ssp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 563440315acd..9e77b3392c1e 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -146,10 +146,8 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	}
 
 	ssp->irq = platform_get_irq(pdev, 0);
-	if (ssp->irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
+	if (ssp->irq < 0)
 		return -ENODEV;
-	}
 
 	if (dev->of_node) {
 		const struct of_device_id *id =
-- 
2.25.1

