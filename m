Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763A2361DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbhDPKBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:01:14 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33514 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234291AbhDPKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:01:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UVk96.i_1618567246;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UVk96.i_1618567246)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Apr 2021 18:00:47 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ALSA: seq: oss: Fix inconsistent indenting
Date:   Fri, 16 Apr 2021 18:00:44 +0800
Message-Id: <1618567244-5704-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

smatch warnings:
sound/core/seq/oss/seq_oss_event.c:297 note_on_event() warn:
inconsistent indenting

Fixed the inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/core/seq/oss/seq_oss_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/oss/seq_oss_event.c b/sound/core/seq/oss/seq_oss_event.c
index 7b7c925..9a42713 100644
--- a/sound/core/seq/oss/seq_oss_event.c
+++ b/sound/core/seq/oss/seq_oss_event.c
@@ -294,7 +294,7 @@
 				/* set volume to zero -- note off */
 			//	type = SNDRV_SEQ_EVENT_NOTEOFF;
 			//else
-				if (info->ch[ch].vel)
+			if (info->ch[ch].vel)
 				/* sample already started -- volume change */
 				type = SNDRV_SEQ_EVENT_KEYPRESS;
 			else
-- 
1.8.3.1

