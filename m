Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7B40B292
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhINPKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:10:01 -0400
Received: from foss.arm.com ([217.140.110.172]:46052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233584AbhINPKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:10:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D945101E;
        Tue, 14 Sep 2021 08:08:42 -0700 (PDT)
Received: from a077416.arm.com (unknown [10.163.44.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 73B6D3F5A1;
        Tue, 14 Sep 2021 08:08:40 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/memory: Avoid unnecessary kernel/user pointer conversion
Date:   Tue, 14 Sep 2021 20:38:20 +0530
Message-Id: <20210914150820.19326-1-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotating a pointer from __user to kernel and then back again might
confuse sparse. In copy_huge_page_from_user() it can be avoided by
removing the intermediate variable since it is never used.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 mm/memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..90970d19b7dd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5411,7 +5411,6 @@ long copy_huge_page_from_user(struct page *dst_page,
 				unsigned int pages_per_huge_page,
 				bool allow_pagefault)
 {
-	void *src = (void *)usr_src;
 	void *page_kaddr;
 	unsigned long i, rc = 0;
 	unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
@@ -5424,8 +5423,7 @@ long copy_huge_page_from_user(struct page *dst_page,
 		else
 			page_kaddr = kmap_atomic(subpage);
 		rc = copy_from_user(page_kaddr,
-				(const void __user *)(src + i * PAGE_SIZE),
-				PAGE_SIZE);
+				usr_src + i * PAGE_SIZE, PAGE_SIZE);
 		if (allow_pagefault)
 			kunmap(subpage);
 		else
-- 
2.17.1

