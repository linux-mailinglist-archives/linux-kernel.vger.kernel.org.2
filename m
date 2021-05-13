Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279DF37F4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 11:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhEMJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 05:40:55 -0400
Received: from out28-169.mail.aliyun.com ([115.124.28.169]:46057 "EHLO
        out28-169.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhEMJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 05:40:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.197983|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0093466-3.37296e-05-0.99062;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.KClSHxe_1620898781;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.KClSHxe_1620898781)
          by smtp.aliyun-inc.com(10.194.99.21);
          Thu, 13 May 2021 17:39:41 +0800
From:   Liu Xiang <liu.xiang@zlingsmart.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, liuxiang1999@gmail.com,
        Liu Xiang <liu.xiang@zlingsmart.com>
Subject: [PATCH] mm/memory.c: fix comment of finish_mkwrite_fault()
Date:   Thu, 13 May 2021 17:39:31 +0800
Message-Id: <20210513093931.15234-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the return value in comment of finish_mkwrite_fault().

Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 730daa009..b844afded 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3035,7 +3035,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  * The function expects the page to be locked or other protection against
  * concurrent faults / writeback (such as DAX radix tree locks).
  *
- * Return: %VM_FAULT_WRITE on success, %0 when PTE got changed before
+ * Return: %0 on success, %VM_FAULT_NOPAGE when PTE got changed before
  * we acquired PTE lock.
  */
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
-- 
2.17.1

