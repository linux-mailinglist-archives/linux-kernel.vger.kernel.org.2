Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722CB3B4306
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhFYMUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:20:15 -0400
Received: from m12-14.163.com ([220.181.12.14]:43756 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhFYMUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ll5wP
        2RKhdsiju9OyGOyhweozs4U8+CZxPAsBohFRCY=; b=V1Hs0sYlL5KZVdtxOFYU+
        SzxieUkk44Dwk8s9xYNGepXzKWhoJC60060K0EUP2B/hGLg5cy1Aa4ZrBP0AfeJ3
        bRe6gVvmcAXJ3bk1zF80ruvf6CD1tC/HUupE1Mw13B6qBFCKpLGQrT/JHN5AWK0/
        m5bCICrKBNXgNKJ4zWjYRo=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowACnrCguydVgUprnQg--.54887S2;
        Fri, 25 Jun 2021 20:16:46 +0800 (CST)
From:   13145886936@163.com
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: fsl_xcvr: remove unnecessary print function dev_err()
Date:   Fri, 25 Jun 2021 05:16:36 -0700
Message-Id: <20210625121636.453231-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowACnrCguydVgUprnQg--.54887S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUCF45ur1kKr4UGrWruFg_yoW3Crb_tw
        10kwnYq3yrJryIva4kGw43AFy7XwsrCFWUWrs8KF17J345Jw4rXa4UGF4kurs8uw4xA34x
        WFyYvrZ3Cr1SyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5JR67UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBzh+8g1QHNBM05gAAsI
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
index 6cb558165848..e34d57ad66fb 100644
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

