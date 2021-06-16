Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1901B3A9168
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 07:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFPFxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 01:53:31 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44386 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229543AbhFPFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:53:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UcaDBpQ_1623822676;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UcaDBpQ_1623822676)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Jun 2021 13:51:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ASoC: codecs: Fix duplicate included sound/soc.h
Date:   Wed, 16 Jun 2021 13:51:07 +0800
Message-Id: <1623822667-130511-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warnings:

./sound/soc/codecs/wcd938x.c: sound/soc.h is included more than once.
./sound/soc/codecs/wcd938x-sdw.c: sound/soc.h is included more than
once.

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/wcd938x-sdw.c | 1 -
 sound/soc/codecs/wcd938x.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index d82c40e..88334d3 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -7,7 +7,6 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/component.h>
-#include <sound/soc.h>
 #include <linux/pm_runtime.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 2cf6145..c0d7452 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/pm_runtime.h>
 #include <linux/component.h>
-#include <sound/soc.h>
 #include <sound/tlv.h>
 #include <linux/of_gpio.h>
 #include <linux/of.h>
-- 
1.8.3.1

