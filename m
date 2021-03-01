Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F62327EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhCAM55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:57:57 -0500
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:44062 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbhCAM5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:57:55 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 79CF05400F8;
        Mon,  1 Mar 2021 20:57:08 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mm: delete bool "migrated"
Date:   Mon,  1 Mar 2021 20:57:01 +0800
Message-Id: <1614603421-2681-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSUIfTk9MHRpOSRlPVkpNSk9NS0hPSUNMSk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nww6Shw6ED8cFxA9NFYNSwsh
        EDRPCihVSlVKTUpPTUtIT0lCS0JLVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTkxONwY+
X-HM-Tid: 0a77eddd2319b038kuuu79cf05400f8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch gives the warning:
	do_numa_page() warn: assigning (-11) to unsigned variable 'migrated'

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 mm/memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 784249f..d8125df
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4102,7 +4102,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	int page_nid = NUMA_NO_NODE;
 	int last_cpupid;
 	int target_nid;
-	bool migrated = false;
 	pte_t pte, old_pte;
 	bool was_writable = pte_savedwrite(vmf->orig_pte);
 	int flags = 0;
@@ -4172,8 +4171,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	}
 
 	/* Migrate to the requested node */
-	migrated = migrate_misplaced_page(page, vma, target_nid);
-	if (migrated) {
+	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else
-- 
2.7.4

