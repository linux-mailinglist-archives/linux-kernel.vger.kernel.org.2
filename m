Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE71433861
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJSO2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:28:32 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:5178 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhJSO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:28:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Usyv4Hp_1634653565;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Usyv4Hp_1634653565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 22:26:07 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon: Remove unnecessary variable initialization
Date:   Tue, 19 Oct 2021 22:26:03 +0800
Message-Id: <a2ddd67548879fe8f386f8daf522b47fdf99f581.1634653088.git.bier@B-X3VXMD6M-2058.local>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1634653088.git.bier@B-X3VXMD6M-2058.local>
References: <cover.1634653088.git.bier@B-X3VXMD6M-2058.local>
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

