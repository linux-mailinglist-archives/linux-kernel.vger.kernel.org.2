Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16513F1520
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhHSIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:24:48 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53568 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237167AbhHSIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:24:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uk-AU5A_1629361442;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Uk-AU5A_1629361442)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 16:24:05 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] fs/ntfs3: Remove unused including <linux/version.h>
Date:   Thu, 19 Aug 2021 16:23:37 +0800
Message-Id: <1629361417-94657-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow versioncheck warning:

./fs/ntfs3/inode.c: 16 linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/ntfs3/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index bf51e29..bb01f1b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -13,7 +13,6 @@
 #include <linux/namei.h>
 #include <linux/nls.h>
 #include <linux/uio.h>
-#include <linux/version.h>
 #include <linux/writeback.h>
 
 #include "debug.h"
-- 
1.8.3.1

