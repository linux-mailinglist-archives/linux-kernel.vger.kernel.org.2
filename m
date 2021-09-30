Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6970241D453
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 09:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348592AbhI3HSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 03:18:25 -0400
Received: from mx313.baidu.com ([180.101.52.140]:34331 "EHLO
        njjs-sys-mailin08.njjs.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348531AbhI3HSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 03:18:23 -0400
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin08.njjs.baidu.com (Postfix) with ESMTP id 334E760C004A;
        Thu, 30 Sep 2021 15:16:36 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 17FFED9932;
        Thu, 30 Sep 2021 15:16:36 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-kernel@vger.kernel.org, michel@lespinasse.org
Subject: [PATCH] rbtree: Remove unneeded check condition in rb_find_first
Date:   Thu, 30 Sep 2021 15:16:36 +0800
Message-Id: <1632986196-20074-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the variable c is int type, so change the following condition

	 if (c <= 0) {

	 }
	 else if (c > 0) {

	 }
as:
	 if (c <= 0) {

	 }
	 else {

	 }

Spotted-by: Michel Lespinasse <<michel@lespinasse.org>>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 include/linux/rbtree.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 235047d..d5ac8f7 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -294,7 +294,7 @@ static inline void rb_replace_node_cached(struct rb_node *victim,
 			if (!c)
 				match = node;
 			node = node->rb_left;
-		} else if (c > 0) {
+		} else {
 			node = node->rb_right;
 		}
 	}
-- 
1.7.1

