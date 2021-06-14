Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7909E3A5B83
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 04:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhFNCO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 22:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhFNCOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 22:14:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0658DC061767
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:12:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z26so9421389pfj.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hc5tE0rYCbS37ZgBxKFPNr3nuu+6cVzWda11nQdq3iM=;
        b=Vh+7NPD40igcWMA8ZxCKb882Omc6aDgbk/irfaju7R6OY9JHsN4hyxBDkVJB/XXQeb
         vtzEuQVTi62SnxT6OobcfTLjOhUpuods3mnG6KdDw+Z59+x3hjUfsydiYzV2Br0XLibk
         HmBowFSmZoqqKF/uRr4SBf7/xG3uxM+6OYL4WSZ7iCDcvycMF8DCOo1wHBC4eIZvAfjm
         NQnCbAh1eLGVojwwuV7yl/Yzmj5Zt93GlIJ5JGMNA/QomFnvWoPayMRUSANzoMO/nX38
         nMmm0LEQ0/F02e2wKpIbuhG+KZp+R0MDP6rNv6KNnifZP7HcdMmBfBsdO1sUQIQrMs4c
         Ol4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hc5tE0rYCbS37ZgBxKFPNr3nuu+6cVzWda11nQdq3iM=;
        b=mzr7YT+avYMF/z8d/p8rxod62bKvwNtJXmAGH860qXvQK181k0iy7G/grJJCMptslJ
         7APonYmYKVr+lgHFjvD74j6W1Bwv7DpEYSIKcLD3WABqKKJDUtZV+9FmuaIIIG7JBufF
         7NX2XOPxdBu2eLh0c3tlBTZQQMKMKkhTMQgaKb8xsBF4/1nMCryuV3sFUJ8oxfXKLpvk
         LhfIL8l5buQRkz8MPHkpOecXgNySzFxdTgGl67OhBIMxvHKgTEQw0c4aNrd/PCEeScef
         PP5yowO4cQK/8vVosi72OI6j8UWghgDos7MbAj2NL5oGPzD54epoVhq7OaYzHT9H1CUb
         8DOA==
X-Gm-Message-State: AOAM532WkPALCP/D8az5DkoY4Q8WfpFBmiBKcvOvVeWuUBZbpQabeRLk
        n+E8c5PkDebD+68zgHGw3w==
X-Google-Smtp-Source: ABdhPJw9PDSjTntjgblnpRRtXcC12ps1LpPVexLCN0hoszoS8nN9Si7jFc9Ikr9TWPNAO/xM0yrnhw==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr14567258pgf.216.1623636756646;
        Sun, 13 Jun 2021 19:12:36 -0700 (PDT)
Received: from localhost.localdomain (h175-177-040-153.catv02.itscom.jp. [175.177.40.153])
        by smtp.gmail.com with ESMTPSA id z14sm10952986pfn.11.2021.06.13.19.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 19:12:36 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] mm/hwpoison: remove MF_MSG_BUDDY_2ND and MF_MSG_POISONED_HUGE
Date:   Mon, 14 Jun 2021 11:12:10 +0900
Message-Id: <20210614021212.223326-5-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614021212.223326-1-nao.horiguchi@gmail.com>
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

These action_page_types are no longer used, so remove them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h      | 2 --
 include/ras/ras_event.h | 2 --
 mm/memory-failure.c     | 2 --
 3 files changed, 6 deletions(-)

diff --git v5.13-rc5/include/linux/mm.h v5.13-rc5_patched/include/linux/mm.h
index 45008654f695..f1e3b82e1a93 100644
--- v5.13-rc5/include/linux/mm.h
+++ v5.13-rc5_patched/include/linux/mm.h
@@ -3105,7 +3105,6 @@ enum mf_action_page_type {
 	MF_MSG_SLAB,
 	MF_MSG_PAGETABLE,
 	MF_MSG_DIFFERENT_COMPOUND,
-	MF_MSG_POISONED_HUGE,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
 	MF_MSG_NON_PMD_HUGE,
@@ -3120,7 +3119,6 @@ enum mf_action_page_type {
 	MF_MSG_CLEAN_LRU,
 	MF_MSG_TRUNCATED_LRU,
 	MF_MSG_BUDDY,
-	MF_MSG_BUDDY_2ND,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
 	MF_MSG_UNKNOWN,
diff --git v5.13-rc5/include/ras/ras_event.h v5.13-rc5_patched/include/ras/ras_event.h
index 2f459f6f87fb..23306428f5e6 100644
--- v5.13-rc5/include/ras/ras_event.h
+++ v5.13-rc5_patched/include/ras/ras_event.h
@@ -359,7 +359,6 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_SLAB, "kernel slab page" )				\
 	EM ( MF_MSG_PAGETABLE, "page table page page" )			\
 	EM ( MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking" ) \
-	EM ( MF_MSG_POISONED_HUGE, "huge page already hardware poisoned" )	\
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
 	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
@@ -374,7 +373,6 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_CLEAN_LRU, "clean LRU page" )			\
 	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
-	EM ( MF_MSG_BUDDY_2ND, "free buddy page (2nd try)" )		\
 	EM ( MF_MSG_DAX, "dax page" )					\
 	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
diff --git v5.13-rc5/mm/memory-failure.c v5.13-rc5_patched/mm/memory-failure.c
index 30d6519ce203..b986936e50eb 100644
--- v5.13-rc5/mm/memory-failure.c
+++ v5.13-rc5_patched/mm/memory-failure.c
@@ -710,7 +710,6 @@ static const char * const action_page_types[] = {
 	[MF_MSG_SLAB]			= "kernel slab page",
 	[MF_MSG_PAGETABLE]		= "page table page",
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
-	[MF_MSG_POISONED_HUGE]		= "huge page already hardware poisoned",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
 	[MF_MSG_NON_PMD_HUGE]		= "non-pmd-sized huge page",
@@ -725,7 +724,6 @@ static const char * const action_page_types[] = {
 	[MF_MSG_CLEAN_LRU]		= "clean LRU page",
 	[MF_MSG_TRUNCATED_LRU]		= "already truncated LRU page",
 	[MF_MSG_BUDDY]			= "free buddy page",
-	[MF_MSG_BUDDY_2ND]		= "free buddy page (2nd try)",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
 	[MF_MSG_UNKNOWN]		= "unknown page",
-- 
2.25.1

