Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94D3F7272
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhHYKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:00:41 -0400
Received: from mx316.baidu.com ([180.101.52.236]:17311 "EHLO
        njjs-sys-mailin05.njjs.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237077AbhHYKAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:00:39 -0400
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin05.njjs.baidu.com (Postfix) with ESMTP id 01996CF8003A;
        Wed, 25 Aug 2021 17:59:49 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id CFBF0D9932;
        Wed, 25 Aug 2021 17:59:48 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     peterz@infradead.org, dbueso@suse.de, mingo@kernel.org,
        michel@lespinasse.org, linux-kernel@vger.kernel.org,
        lirongqing@baidu.com
Subject: [PATCH] rbtree: stop iteration early in rb_find_first
Date:   Wed, 25 Aug 2021 17:59:48 +0800
Message-Id: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stop iteration if match is not NULL and result of cmp is
not zero, this means the matched node has been found, and
the node with same key has been passed

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 include/linux/rbtree.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index d31ecaf4fdd3..2689771df9bb 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -324,6 +324,9 @@ rb_find_first(const void *key, const struct rb_root *tree,
 		} else if (c > 0) {
 			node = node->rb_right;
 		}
+
+		if (match && c)
+			break;
 	}
 
 	return match;
-- 
2.33.0.69.gc420321.dirty

