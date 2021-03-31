Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7297334F79A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhCaDpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:45:07 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37558 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230160AbhCaDof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:44:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UTuuUW9_1617162268;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UTuuUW9_1617162268)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 31 Mar 2021 11:44:33 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     nico@fluxnic.net
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] fs/cramfs: Remove useless call "zlib_inflateEnd"
Date:   Wed, 31 Mar 2021 11:44:26 +0800
Message-Id: <1617162266-843-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following whitescan warning:

Calling "zlib_inflateEnd(&stream)" is only useful for its return value,
which is ignored.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/cramfs/uncompress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cramfs/uncompress.c b/fs/cramfs/uncompress.c
index 975d98f..9e1a392 100644
--- a/fs/cramfs/uncompress.c
+++ b/fs/cramfs/uncompress.c
@@ -41,7 +41,6 @@ int cramfs_uncompress_block(void *dst, int dstlen, void *src, int srclen)
 	err = zlib_inflateReset(&stream);
 	if (err != Z_OK) {
 		pr_err("zlib_inflateReset error %d\n", err);
-		zlib_inflateEnd(&stream);
 		zlib_inflateInit(&stream);
 	}
 
-- 
1.8.3.1

