Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3314131222B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 08:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGHEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 02:04:38 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54941 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhBGHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 02:04:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UO3X7ct_1612681362;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UO3X7ct_1612681362)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 07 Feb 2021 15:02:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ALSA: pci: Assign boolean values to a bool variable
Date:   Sun,  7 Feb 2021 15:02:41 +0800
Message-Id: <1612681361-63404-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./sound/pci/azt3328.c:2451:2-16: WARNING: Assignment of 0/1 to bool
variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/pci/azt3328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 77c7030..37f8fc4 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2448,7 +2448,7 @@ static void snd_azf3328_mixer_reg_decode(struct azf3328_mixer_reg *r, unsigned l
 
 		/* shutdown codecs to reduce power / noise */
 			/* have ...ctrl_codec_activity() act properly */
-		codec->running = 1;
+		codec->running = true;
 		snd_azf3328_ctrl_codec_activity(chip, codec_type, 0);
 
 		spin_lock_irq(codec->lock);
-- 
1.8.3.1

