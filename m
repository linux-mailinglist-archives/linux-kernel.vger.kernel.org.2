Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2E361DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbhDPKAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:00:31 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47136 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239819AbhDPKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:00:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UVjzO5K_1618567200;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UVjzO5K_1618567200)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Apr 2021 18:00:01 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ALSA: isa: Fix inconsistent indenting
Date:   Fri, 16 Apr 2021 17:59:58 +0800
Message-Id: <1618567198-5120-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

smatch warnings:
sound/isa/opti9xx/opti92x-ad1848.c:191 snd_opti9xx_init() warn:
inconsistent indenting
sound/isa/opti9xx/opti92x-ad1848.c:488 snd_opti9xx_init() warn:
inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/isa/opti9xx/opti92x-ad1848.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 08e61d9..234f023 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -188,7 +188,7 @@ static int snd_opti9xx_init(struct snd_opti9xx *chip,
 		chip->mc_base_size = opti9xx_mc_size[hardware];
 	}
 #else
-		chip->mc_base_size = opti9xx_mc_size[hardware];
+	chip->mc_base_size = opti9xx_mc_size[hardware];
 #endif
 
 	switch (hardware) {
@@ -485,7 +485,7 @@ static int snd_opti9xx_configure(struct snd_opti9xx *chip,
 #endif	/* CS4231 || OPTi93X */
 
 #ifndef OPTi93X
-	 outb(irq_bits << 3 | dma_bits, chip->wss_base);
+	outb(irq_bits << 3 | dma_bits, chip->wss_base);
 #else /* OPTi93X */
 	snd_opti9xx_write(chip, OPTi9XX_MC_REG(3), (irq_bits << 3 | dma_bits));
 #endif /* OPTi93X */
-- 
1.8.3.1

