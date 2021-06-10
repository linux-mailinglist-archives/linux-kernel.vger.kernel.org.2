Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC2B3A2251
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 04:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhFJCpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 22:45:19 -0400
Received: from m12-15.163.com ([220.181.12.15]:49719 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFJCpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 22:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=w8moP
        c3hHLCFUQuSedhYS174W2JUhWhhiPc7iombNd0=; b=Ob3bPwE29KUeYSMy80hYv
        5YwzPzLBYIvSB6kNJXyMRKRS+fTNkU+/5n7SNrB7BIvASp7+Zriq9gnBKA1Nl/40
        qouRpFEGjF39ru7uNVVXK1tvB85eeMYjNYT3SufFap+aNuYG2HkdxdDIeyQBx+j9
        rvUxGpCe8YJCfT1IyFUpeA=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp11 (Coremail) with SMTP id D8CowADn75+te8FgtmN8AA--.6S2;
        Thu, 10 Jun 2021 10:42:34 +0800 (CST)
From:   zuoqilin1@163.com
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, perex@perex.cz, tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] sound/arm: Remove unnecessary variables
Date:   Thu, 10 Jun 2021 10:40:53 +0800
Message-Id: <20210610024053.1217-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowADn75+te8FgtmN8AA--.6S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4DJF4kXryDWw47Cry8Zrb_yoW3Zwb_ta
        yIqF4kWryIvw1Svw1fAw15XFW0qF47uF4rWr10kF15ZF45X39Y9ryDJr17uryFva109r43
        W3y2qry3Cr9a9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1ZNVJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiTgCsiVUDKBc7vgABsG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

There is no need to define the variable "ret" to receive.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 sound/arm/pxa2xx-ac97.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 6322e639..a67e668 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -47,9 +47,7 @@ static unsigned short pxa2xx_ac97_legacy_read(struct snd_ac97 *ac97,
 static void pxa2xx_ac97_legacy_write(struct snd_ac97 *ac97,
 				     unsigned short reg, unsigned short val)
 {
-	int __always_unused ret;
-
-	ret = pxa2xx_ac97_write(ac97->num, reg, val);
+	pxa2xx_ac97_write(ac97->num, reg, val);
 }
 
 static const struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
-- 
1.9.1

