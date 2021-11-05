Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1326C445F82
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 06:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhKEFza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 01:55:30 -0400
Received: from out0.migadu.com ([94.23.1.103]:40778 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhKEFz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 01:55:27 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636091567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QmlSkdjeXrMBerY937XOVquwZ2X/0l2XaAAw15nVfp0=;
        b=KDMAazU6k+qbS8+pPmG1lARdwzwkTYUxpJTEntdM6O51PP4zKf0RstU8FLu3qx/JqCQUer
        ZTvzjA/pNbJ9/v+fn9XYDYwNVe+PfH+254kzqxiDQqTRXY2JJnHpixU5/dzvk95IKpbMCE
        g3KkLiyL/qgJQPGv/x/kUiUfYg+hVr4=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] mm/hwpoison: remove MF_MSG_BUDDY_2ND and MF_MSG_POISONED_HUGE
Date:   Fri,  5 Nov 2021 14:50:57 +0900
Message-Id: <20211105055058.3152564-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20211105055058.3152564-1-naoya.horiguchi@linux.dev>
References: <20211105055058.3152564-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

These action_page_types are no longer used, so remove them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Acked-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/mm.h      | 2 --
 include/ras/ras_event.h | 2 --
 mm/memory-failure.c     | 2 --
 3 files changed, 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..7941bca871dc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3247,7 +3247,6 @@ enum mf_action_page_type {
 	MF_MSG_KERNEL_HIGH_ORDER,
 	MF_MSG_SLAB,
 	MF_MSG_DIFFERENT_COMPOUND,
-	MF_MSG_POISONED_HUGE,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
 	MF_MSG_NON_PMD_HUGE,
@@ -3262,7 +3261,6 @@ enum mf_action_page_type {
 	MF_MSG_CLEAN_LRU,
 	MF_MSG_TRUNCATED_LRU,
 	MF_MSG_BUDDY,
-	MF_MSG_BUDDY_2ND,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
 	MF_MSG_UNKNOWN,
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 0bdbc0d17d2f..d0337a41141c 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -358,7 +358,6 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )	\
 	EM ( MF_MSG_SLAB, "kernel slab page" )				\
 	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
-	EM ( MF_MSG_POISONED_HUGE, "huge page already hardware poisoned" )	\
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
 	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
@@ -373,7 +372,6 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_CLEAN_LRU, "clean LRU page" )			\
 	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
-	EM ( MF_MSG_BUDDY_2ND, "free buddy page (2nd try)" )		\
 	EM ( MF_MSG_DAX, "dax page" )					\
 	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d29c79de6034..722036539b44 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -723,7 +723,6 @@ static const char * const action_page_types[] = {
 	[MF_MSG_KERNEL_HIGH_ORDER]	= "high-order kernel page",
 	[MF_MSG_SLAB]			= "kernel slab page",
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
-	[MF_MSG_POISONED_HUGE]		= "huge page already hardware poisoned",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
 	[MF_MSG_NON_PMD_HUGE]		= "non-pmd-sized huge page",
@@ -738,7 +737,6 @@ static const char * const action_page_types[] = {
 	[MF_MSG_CLEAN_LRU]		= "clean LRU page",
 	[MF_MSG_TRUNCATED_LRU]		= "already truncated LRU page",
 	[MF_MSG_BUDDY]			= "free buddy page",
-	[MF_MSG_BUDDY_2ND]		= "free buddy page (2nd try)",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
 	[MF_MSG_UNKNOWN]		= "unknown page",
-- 
2.25.1

