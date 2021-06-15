Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A973A7C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhFOK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:56:09 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59213 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbhFOK4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:56:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UcW4duE_1623754437;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UcW4duE_1623754437)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Jun 2021 18:54:00 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ALSA: oss: Remove redundant assignment to src_access
Date:   Tue, 15 Jun 2021 18:53:43 +0800
Message-Id: <1623754423-84072-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable src_access is set to 'dst_access', but this value is never read
as it is not used later on, hence it is a redundant assignment and can
be removed.

Clean up the following clang-analyzer warning:

sound/core/oss/pcm_plugin.c:472:4: warning: Value stored to 'src_access'
is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/core/oss/pcm_plugin.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 061ba06..a7c0e50 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -469,7 +469,6 @@ int snd_pcm_plug_format_plugins(struct snd_pcm_substream *plug,
 				return err;
 			}
 			srcformat = tmpformat;
-			src_access = dst_access;
 		}
 		tmpformat.rate = dstformat.rate;
         	err = snd_pcm_plugin_build_rate(plug,
-- 
1.8.3.1

