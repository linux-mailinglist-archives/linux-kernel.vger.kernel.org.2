Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B28236D4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhD1J3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:29:54 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44114 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238023AbhD1J3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:29:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UX3e5fb_1619602142;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0UX3e5fb_1619602142)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Apr 2021 17:29:07 +0800
From:   Hui Zhu <teawater@antfin.com>
To:     wufengguang@huawei.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@antfin.com>
Subject: [PATCH for vm-scalability] usemem: Update the usage of touch-alloc
Date:   Wed, 28 Apr 2021 17:29:01 +0800
Message-Id: <20210428092901.3103-1-teawater@antfin.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touch-alloc was updated to write memory in commit
3f9c6c227120db43873d1af20cea3f374eb99592.

This commit updates the usage of touch-alloc.

Signed-off-by: Hui Zhu <teawater@antfin.com>
---
 usemem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usemem.c b/usemem.c
index 0c76d17..3b4d207 100644
--- a/usemem.c
+++ b/usemem.c
@@ -158,7 +158,7 @@ void usage(int ok)
 	"    -Z|--read-again     read memory again after access the memory\n"
 	"    --punch-holes       free every other page after allocation\n"
 	"    --init-time         account/show initialization time separately from run time\n"
-	"    --touch-alloc       read memory after allocate it\n"
+	"    --touch-alloc       write memory to allocate the pages from Linux kernel after allocate it\n"
 	"    -h|--help           show this message\n"
 	,		ourname);
 
-- 
2.17.1

