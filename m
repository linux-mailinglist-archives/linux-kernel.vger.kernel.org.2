Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E441C36C33E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 12:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhD0K13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 06:27:29 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43223 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230341AbhD0K1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:27:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UWzF1d5_1619519195;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UWzF1d5_1619519195)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Apr 2021 18:26:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ALSA: usb-audio: Remove redundant assignment to len
Date:   Tue, 27 Apr 2021 18:26:34 +0800
Message-Id: <1619519194-57806-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable len is set to zero but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed.

Cleans up the following clang-analyzer warning:

sound/usb/mixer.c:2713:3: warning: Value stored to 'len' is never read
[clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/usb/mixer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b004b2e..937bc17 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2710,7 +2710,6 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 #define MAX_ITEM_NAME_LEN	64
 	for (i = 0; i < desc->bNrInPins; i++) {
 		struct usb_audio_term iterm;
-		len = 0;
 		namelist[i] = kmalloc(MAX_ITEM_NAME_LEN, GFP_KERNEL);
 		if (!namelist[i]) {
 			err = -ENOMEM;
-- 
1.8.3.1

