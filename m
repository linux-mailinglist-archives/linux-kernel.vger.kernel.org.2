Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1275307367
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhA1KH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhA1KHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:07:16 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 02:06:30 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id NA6T2400T4C55Sk01A6TE5; Thu, 28 Jan 2021 11:06:28 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l54C3-001KNc-83; Thu, 28 Jan 2021 11:06:27 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l54C2-009TKH-NB; Thu, 28 Jan 2021 11:06:26 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next] mm/nommu: Fix return type of filemap_map_pages()
Date:   Thu, 28 Jan 2021 11:06:26 +0100
Message-Id: <20210128100626.2257638-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_MMU is not set (e.g. m68k/m5272c3_defconfig):

    mm/nommu.c:1671:6: error: conflicting types for ‘filemap_map_pages’
     1671 | void filemap_map_pages(struct vm_fault *vmf,
	  |      ^~~~~~~~~~~~~~~~~
    In file included from mm/nommu.c:20:
    ./include/linux/mm.h:2578:19: note: previous declaration of ‘filemap_map_pages’ was here
     2578 | extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
	  |                   ^~~~~~~~~~~~~~~~~

The signature of filemap_map_pages() was changed, but the nommu
implementation wasn't updated.

Reported-by: noreply@ellerman.id.au
Fixes: f9ce0be71d1fbb03 ("mm: Cleanup faultaround and finish_fault() codepaths")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
Feel free to fold into the commit introducing the issue.
---
 mm/nommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 870fea12823e633d..5c9ab799c0e63958 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1668,10 +1668,11 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(filemap_fault);
 
-void filemap_map_pages(struct vm_fault *vmf,
+vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
 	BUG();
+	return 0;
 }
 EXPORT_SYMBOL(filemap_map_pages);
 
-- 
2.25.1

