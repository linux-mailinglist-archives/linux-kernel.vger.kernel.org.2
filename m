Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4030845E124
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 20:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356779AbhKYTtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 14:49:06 -0500
Received: from smtpbg703.qq.com ([203.205.195.89]:56644 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1356778AbhKYTrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:47:05 -0500
X-QQ-mid: bizesmtp37t1637869414t7flocso
Received: from localhost.localdomain.localdoma (unknown [58.251.166.36])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 26 Nov 2021 03:43:07 +0800 (CST)
X-QQ-SSF: 01400000000000C0L000000A0000000
X-QQ-FEAT: Z953UCsBqO6+dtTTTmi9q2ZVeyylH6u5hmnaaeanX/IkKg0BSByxCXu2XDwOe
        fiaPyEFbvuw2u/KbsO9yP/MrKDmRYVipBT80HfOnS16InuAhubgCkG5bV12O402mxNaHV3j
        XPtkahN8msXdqlbTlVMadrTTRkXri9zdjcV/Wge7RN+IloN9JK72u4mknypAzPUNcw9W0xf
        HkxwKwOMoMgAmMLCVz9bhiD+cZXWdaX3Fiyh9oELgyJ3VeC9T/48FOTr2xbj5D1R1mqRwx7
        wvFqeE8eE0fxlG3hF+Z9r5h2cr+9ufBdiqtbMFu6EgBEI+0pn3s8D30mev5PkKENGOlsk0a
        c7KU19J8F46VSz44Qea8Q90e8HlfA==
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] mm: fix the type of a parameter
Date:   Fri, 26 Nov 2021 03:43:01 +0800
Message-Id: <20211125194301.19244-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of "last_migrate_reason" in struct page_owner is short.
However, the type of "reason" in the argument list of function
__set_page_owner_migrate_reason is int,
which is inconsistent.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 mm/page_owner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4f924957ce7a..4c23e910caf9 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -182,7 +182,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 }
 
-void __set_page_owner_migrate_reason(struct page *page, int reason)
+void __set_page_owner_migrate_reason(struct page *page, short reason)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
-- 
2.31.1



