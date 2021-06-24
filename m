Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DCB3B253E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 04:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFXDAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:00:03 -0400
Received: from proxy25212.mail.163.com ([103.129.252.12]:49577 "EHLO
        proxy25212.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFXDAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:00:01 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 23:00:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jkRB7
        +CdbZZDxXzB9kStaj+s1gSa66q7h6WCrs62Ai4=; b=ZTSM8tb3rWZ9yYU+4+RtP
        qYaavccM2beelK7wV/mAGHHBfBV/7yDU50K2Ze3zXoda8wNxRJ4a83H7hNzj8sJX
        xtxxhdKLjW+mWi5Oko65f5Dc4kqsyN2eUqd3vaUCGNo2VqEHZzOkpg2vZuzbuaEe
        H6jfqd+OgRFnO1L53ITDng=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowADHxU3p8NNgqyD+QQ--.38820S2;
        Thu, 24 Jun 2021 10:41:46 +0800 (CST)
From:   13145886936@163.com
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ARM: pxa: ssp: remove unnecessary print function dev_err()
Date:   Wed, 23 Jun 2021 19:41:39 -0700
Message-Id: <20210624024139.23879-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowADHxU3p8NNgqyD+QQ--.38820S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUCF45ur4kXF48Aw13urg_yoWxCFb_AF
        s2kay8GrWrAr1vv34UJw1ayry7twnxuryqvr1DG3WIkrW5Aw48Aw1DWFWxGFnrXw1Ik3y3
        X393u3y3Ar12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5l1v3UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiGgq7g1aD+N9XOAAAs1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 arch/arm/plat-pxa/ssp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 563440315acd..96b8765e4f57 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -147,7 +147,6 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	ssp->irq = platform_get_irq(pdev, 0);
 	if (ssp->irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
 		return -ENODEV;
 	}
 
-- 
2.25.1

