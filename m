Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19BC35214E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhDAVJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:09:34 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:54304 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233710AbhDAVJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:09:30 -0400
Received: by sf.home (Postfix, from userid 1000)
        id 729335A22061; Thu,  1 Apr 2021 22:09:22 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>, linux-mm@kvack.org
Subject: [PATCH] mm: page_owner: use kstrtobool() to parse bool option
Date:   Thu,  1 Apr 2021 22:09:09 +0100
Message-Id: <20210401210909.3532086-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to use page_owner=1 for a while noticed too late it had
no effect as opposed to similar init_on_alloc=1 (these work).

Let's make them consistent.

The change decreses binary size slightly:
   text    data     bss     dec     hex filename
  12408     321      17   12746    31ca mm/page_owner.o.before
  12320     321      17   12658    3172 mm/page_owner.o.after

CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-mm@kvack.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 mm/page_owner.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index d15c7c4994f5..63e4ecaba97b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -41,13 +41,7 @@ static void init_early_allocated_pages(void);
 
 static int __init early_page_owner_param(char *buf)
 {
-	if (!buf)
-		return -EINVAL;
-
-	if (strcmp(buf, "on") == 0)
-		page_owner_enabled = true;
-
-	return 0;
+	return kstrtobool(buf, &page_owner_enabled);
 }
 early_param("page_owner", early_page_owner_param);
 
-- 
2.31.1

