Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03437B8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhELJEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:04:01 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56644 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230114AbhELJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:04:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UYdpVrJ_1620810169;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UYdpVrJ_1620810169)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 May 2021 17:02:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bernie@plugable.com
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] video: fbdev: udlfb: Remove redundant initialization of 
Date:   Wed, 12 May 2021 17:02:47 +0800
Message-Id: <1620810167-89132-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integer variable 'identical' is being initialized however
this value is never read as 'identical' is assigned the result
of 'start + (width - end)'. Remove the redundant assignment.
At the same time, adjust the declarations order of variables
to keep the "upside-down x-mas tree" look of them.

Clean up clang warning:

drivers/video/fbdev/udlfb.c:370:6: warning: Value stored to 'identical'
during its initialization is never read
[clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/video/fbdev/udlfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index b9cdd02..f40dd6d8 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -363,13 +363,13 @@ static int dlfb_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
  */
 static int dlfb_trim_hline(const u8 *bback, const u8 **bfront, int *width_bytes)
 {
-	int j, k;
-	const unsigned long *back = (const unsigned long *) bback;
 	const unsigned long *front = (const unsigned long *) *bfront;
+	const unsigned long *back = (const unsigned long *) bback;
 	const int width = *width_bytes / sizeof(unsigned long);
-	int identical = width;
 	int start = width;
 	int end = width;
+	int identical;
+	int j, k;
 
 	for (j = 0; j < width; j++) {
 		if (back[j] != front[j]) {
-- 
1.8.3.1

