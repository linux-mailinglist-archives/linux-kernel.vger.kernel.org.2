Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52ED3B459F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhFYOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:35:33 -0400
Received: from m12-12.163.com ([220.181.12.12]:58208 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFYOfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Sq+56
        LG+NYg1RczZk7C9+MOdW8UjSsGo6o/mWqUjXM4=; b=KAYyZfaIFWEbMQGKzRuoF
        rPFODj0SucRjgXu9+SCwbWhx4tkdiCJd1C543/9V54n5TfCYWcjiOdTLlfDmX6XS
        PiEjaK+slahVL+Pg0SB0oNJM01VccB208a1lyTr2J/jAvmmmQxbFGhYc7QD9jUVw
        hGRpa/fNwr4P5KIOAHjPT0=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowABXKSroxNVgmrXxLg--.60396S2;
        Fri, 25 Jun 2021 19:58:33 +0800 (CST)
From:   13145886936@163.com
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: fsl: fsl_easrc: remove unnecessary print function dev_err()
Date:   Fri, 25 Jun 2021 04:58:31 -0700
Message-Id: <20210625115831.416152-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowABXKSroxNVgmrXxLg--.60396S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUCF45ur1kKr1ktw4UCFg_yoW3Cwb_t3
        48C34fX3y8JFyI9a4UJa13Zr47WFs7CF4jvr4DKFnFq34UJw4ruayUJr4kuFWFgr4IvrZ7
        W34Y9rWFkr1ayjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5XjjPUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiGgm8g1aD+PLDDgAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/soc/fsl/fsl_easrc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index b1765c7d3bcd..25747433916e 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1901,10 +1901,8 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq for node %pOF\n", np);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_easrc_isr, 0,
 			       dev_name(dev), easrc);
-- 
2.25.1


