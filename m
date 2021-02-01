Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2530A2D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhBAHoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:44:20 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36510 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232286AbhBAHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:44:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UNWycPb_1612165368;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNWycPb_1612165368)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 15:43:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     akinobu.mita@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] fault_inject: Replace DEFINE_SIMPLE_ATTRIBUTE with  DEFINE_DEBUGFS_ATTRIBUTE
Date:   Mon,  1 Feb 2021 15:42:43 +0800
Message-Id: <1612165363-98394-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./lib/fault-inject.c:187:0-23: WARNING: fops_stacktrace_depth should be
defined with DEFINE_DEBUGFS_ATTRIBUTE.

./lib/fault-inject.c:169:0-23: WARNING: fops_ul should be defined with
DEFINE_DEBUGFS_ATTRIBUTE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/fault-inject.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index ce12621..cb7ea22 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -166,7 +166,7 @@ static int debugfs_ul_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
 
 static void debugfs_create_ul(const char *name, umode_t mode,
 			      struct dentry *parent, unsigned long *value)
@@ -184,8 +184,8 @@ static int debugfs_stacktrace_depth_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
-			debugfs_stacktrace_depth_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
+			  debugfs_stacktrace_depth_set, "%llu\n");
 
 static void debugfs_create_stacktrace_depth(const char *name, umode_t mode,
 					    struct dentry *parent,
-- 
1.8.3.1

