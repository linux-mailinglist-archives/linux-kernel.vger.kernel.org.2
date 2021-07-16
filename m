Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2E3CB2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhGPGoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234855AbhGPGoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:44:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB047613D0;
        Fri, 16 Jul 2021 06:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626417690;
        bh=1m5fIVQ+uzhPSG8PcXdPuiaqf6mOXHckGOgF9HakSdU=;
        h=From:To:Cc:Subject:Date:From;
        b=O0nSboG6Uvy0kvQyUWGTnI+y+0XZJJrGEjIMXwizY7m1Vy9QZBJPnl6J7o+Dgr8pk
         mi1nuBfwWYMXaeOC0vnChZJFKyFuma6w2eh0cuOLx/j96ndAb6wVohKDv++XGTeZlm
         RzVdutZzrB+PayvGnX/bwcHC6AJ6uxA/8VXBlCJIW66tz4jThEkwk56awoPTGE/BD4
         q+SWWwV5hFhMBYk2zBXZQdkfW5DSbbq7HkPQkdzLmFqkbyqopc6vezAk67aqNW69vI
         8Wn1Ax3kNtgj5oLDp/s+3h66X+6DXRh5HKs+wKHcTa53uUw5JypmWFY1d+PIOYcUlB
         tWVoiq/xKMp/w==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: make alloc_node_mem_map() __init rather than __ref
Date:   Fri, 16 Jul 2021 09:41:24 +0300
Message-Id: <20210716064124.31865-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

alloc_node_mem_map() is never only called from free_area_init_node() that
is an __init function.

Make the actual alloc_node_mem_map() also __init and its stub version
static inline.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b82e55006894..246a4f40ec41 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7497,7 +7497,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 }
 
 #ifdef CONFIG_FLATMEM
-static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
+static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 {
 	unsigned long __maybe_unused start = 0;
 	unsigned long __maybe_unused offset = 0;
@@ -7543,7 +7543,7 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 #endif
 }
 #else
-static void __ref alloc_node_mem_map(struct pglist_data *pgdat) { }
+static inline void alloc_node_mem_map(struct pglist_data *pgdat) { }
 #endif /* CONFIG_FLATMEM */
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-- 
2.28.0

