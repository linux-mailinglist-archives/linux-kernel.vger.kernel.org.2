Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C562D434306
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJTBow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:44:52 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52470 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhJTBou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:44:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ut.2tuf_1634694154;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Ut.2tuf_1634694154)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 09:42:35 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm/damon: Remove unnecessary variable initialization
Date:   Wed, 20 Oct 2021 09:42:32 +0800
Message-Id: <a2ddd67548879fe8f386f8daf522b47fdf99f581.1634693911.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1634693911.git.xhao@linux.alibaba.com>
References: <cover.1634693911.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 'damon_va_apply_three_regions', There is no
need to set variable 'i' as 0

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/vaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b8ba44f69db6..90be463efff7 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -305,7 +305,7 @@ static void damon_va_apply_three_regions(struct damon_target *t,
 		struct damon_addr_range bregions[3])
 {
 	struct damon_region *r, *next;
-	unsigned int i = 0;
+	unsigned int i;
 
 	/* Remove regions which are not in the three big regions now */
 	damon_for_each_region_safe(r, next, t) {
-- 
2.31.0

