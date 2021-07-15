Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58F83C9664
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhGODTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:19:36 -0400
Received: from foss.arm.com ([217.140.110.172]:46084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234351AbhGODT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:19:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F9651042;
        Wed, 14 Jul 2021 20:16:34 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4535B3F7D8;
        Wed, 14 Jul 2021 20:16:32 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH RFC 12/13] mm: simplify the printing with '%pd' specifier
Date:   Thu, 15 Jul 2021 11:15:32 +0800
Message-Id: <20210715031533.9553-13-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '%pd' to simplify the printing since kbasename(file_path()) is to
get the last dentry of the full path.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 mm/memory.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 747a01d495f2..350692ada6f7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5217,18 +5217,14 @@ void print_vma_addr(char *prefix, unsigned long ip)
 	vma = find_vma(mm, ip);
 	if (vma && vma->vm_file) {
 		struct file *f = vma->vm_file;
-		char *buf = (char *)__get_free_page(GFP_NOWAIT);
-		if (buf) {
-			char *p;
-
-			p = file_path(f, buf, PAGE_SIZE);
-			if (IS_ERR(p))
-				p = "?";
-			printk("%s%s[%lx+%lx]", prefix, kbasename(p),
+
+		if (f)
+			printk("%s%pd[%lx+%lx]", prefix, f->f_path.dentry,
 					vma->vm_start,
 					vma->vm_end - vma->vm_start);
-			free_page((unsigned long)buf);
-		}
+		else
+			printk("%s?[%lx+%lx]", prefix, vma->vm_start,
+					vma->vm_end - vma->vm_start);
 	}
 	mmap_read_unlock(mm);
 }
-- 
2.17.1

