Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5844337B45B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhELDCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:02:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2447 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhELDCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:02:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ffzxv3dp3zCrRX;
        Wed, 12 May 2021 10:58:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:01:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/3] mm: Make __dump_page() static
Date:   Wed, 12 May 2021 11:10:56 +0800
Message-ID: <20210512031057.13580-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210512031057.13580-1-wangkefeng.wang@huawei.com>
References: <20210512031057.13580-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No __dump_page() caller, so make it static.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mmdebug.h | 1 -
 mm/debug.c              | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 5d0767cb424a..9086157b46f3 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -10,7 +10,6 @@ struct vm_area_struct;
 struct mm_struct;
 
 extern void dump_page(struct page *page, const char *reason);
-extern void __dump_page(struct page *page, const char *reason);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
 
diff --git a/mm/debug.c b/mm/debug.c
index 0bdda8407f71..84cdcd0f7bd3 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -42,7 +42,7 @@ const struct trace_print_flags vmaflag_names[] = {
 	{0, NULL}
 };
 
-void __dump_page(struct page *page, const char *reason)
+static void __dump_page(struct page *page, const char *reason)
 {
 	struct page *head = compound_head(page);
 	struct address_space *mapping;
-- 
2.26.2

