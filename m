Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5D350CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhDAC2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:28:43 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:42908 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDAC2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:28:15 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 46970A83FE;
        Thu,  1 Apr 2021 10:28:04 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P22964T140517102843648S1617244084217314_;
        Thu, 01 Apr 2021 10:28:04 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4c726a1803186917ae5afbae6c64bdb7>
X-RL-SENDER: huxiang@uniontech.com
X-SENDER: huxiang@uniontech.com
X-LOGIN-NAME: huxiang@uniontech.com
X-FST-TO: akpm@linux-foundation.org
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   huxiang <huxiang@uniontech.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        huxiang <huxiang@uniontech.com>
Subject: [PATCH] mm/page_alloc: redundant definition variables of pfn in for loop
Date:   Thu,  1 Apr 2021 10:28:02 +0800
Message-Id: <20210401022802.10358-1-huxiang@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable pfn is defined repeatedly, so it can be deleted.

Signed-off-by: huxiang <huxiang@uniontech.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc728739..740224232 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3277,7 +3277,7 @@ void free_unref_page_list(struct list_head *list)
 
 	local_irq_save(flags);
 	list_for_each_entry_safe(page, next, list, lru) {
-		unsigned long pfn = page_private(page);
+		pfn = page_private(page);
 
 		set_page_private(page, 0);
 		trace_mm_page_free_batched(page);
-- 
2.20.1



