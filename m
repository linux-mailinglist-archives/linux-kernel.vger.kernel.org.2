Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163463521A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhDAVYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:24:52 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58146 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234334AbhDAVYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:24:51 -0400
Received: by sf.home (Postfix, from userid 1000)
        id 4C2B85A22061; Thu,  1 Apr 2021 22:24:47 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>, linux-mm@kvack.org
Subject: [PATCH] mm: page_owner: fetch backtrace only for tracked pages
Date:   Thu,  1 Apr 2021 22:24:45 +0100
Message-Id: <20210401212445.3534721-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very minor optimization.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-mm@kvack.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 mm/page_owner.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 63e4ecaba97b..7147fd34a948 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -140,14 +140,14 @@ void __reset_page_owner(struct page *page, unsigned int order)
 {
 	int i;
 	struct page_ext *page_ext;
-	depot_stack_handle_t handle = 0;
+	depot_stack_handle_t handle;
 	struct page_owner *page_owner;
 
-	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
-
 	page_ext = lookup_page_ext(page);
 	if (unlikely(!page_ext))
 		return;
+
+	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 		page_owner = get_page_owner(page_ext);
-- 
2.31.1

