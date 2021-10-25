Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB243A806
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhJYXQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhJYXQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:16:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B14CC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:14:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso159745pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=Lh3py47gA8jg6Gb0rOjwQD82lb53Sm8VrPET+7wqweU=;
        b=oC7s9lfcXvHb8GRvOWEgcGhIyRfEicCKCTCuu+2KC7c3BABC0NHhIBow7E6xLZIUyC
         0xsSBuSoyShsveED9PlDgizbLrEAyiULB3490fdPvkS3iDgv1aEHxsl25nxTCwvBbpPA
         jMjqJo93kja70FwMf6zXL663O2Lh3CdcM70xFd4xNpBxDLVt41lVBxdRU0BEB6LkwD6/
         Ll5Bjm1ZtwoD3lpGAcur5UaX9jaAKjAwuJgrE3rcEBd8dAIlY6q28kBLFagPNN6UTO5w
         w4ruzR2/Afvvyva2nkbLvm3B6gTOojkma9/APlNGsmvOlgZa86E6fzq6Uyg/Ipb9kXx5
         i7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=Lh3py47gA8jg6Gb0rOjwQD82lb53Sm8VrPET+7wqweU=;
        b=3G+hgn4wL3jLcQgGDQ4vWQHVQcyfFNs7hlwyw1jpcdyPk4gmewXYC6Uh45A/Wat7bx
         9FG6yUiva2OUsCoVk0+56KsJ23cUeEwn8otwZmxvW4PHv+itBfDu2kURu04pI1ovcwjw
         uQS4u4aLqwkbOxdW8Jju9c0hMAOQnxvyIr+K15O1UrCYYdAzY6EZbllUW0vdipXNJEKV
         hJgsAydnD05ilQby5WfMppXLjLENg1NPabGIARm++EK1hgHWNSg53ij2A8xz5E/lrdhE
         QeQIKALI5kaIBNKP1NCA5//8Uz8pL5+kMUqQdYHWhikjXwUKBV3UX11EXwK7S+qXeIEr
         /WhQ==
X-Gm-Message-State: AOAM5318hEfZyst/9690qotlFunHtq0CoT4vbue0HnjTVZiJWmb/VCKa
        tQoSRGJyY2SMFrpbqpMi7A==
X-Google-Smtp-Source: ABdhPJwQNFIGfOE2VPjqLATShIXQYysjolvs2G1MnC0uCysSRth3EfS/RS0y3Jzr9s2LlVT31xGGyw==
X-Received: by 2002:a17:90b:4a07:: with SMTP id kk7mr24128073pjb.37.1635203657849;
        Mon, 25 Oct 2021 16:14:17 -0700 (PDT)
Received: from u2004 ([2407:c800:3f11:740:8ea1:3c5:6c2d:e5c9])
        by smtp.gmail.com with ESMTPSA id g5sm12041028pfc.65.2021.10.25.16.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:14:17 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
X-Google-Original-From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
Date:   Tue, 26 Oct 2021 08:14:13 +0900
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
Subject: [PATCH 3/4] mm/hwpoison: remove MF_MSG_BUDDY_2ND and
 MF_MSG_POISONED_HUGE
Message-ID: <20211025231120.GA2651146@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
X-Mutt-References: <20211025230503.2650970-1-naoya.horiguchi@linux.dev>
X-Mutt-Fcc: =Sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I failed to send patch 3/4 and 4/4 due to the ratelimit of linux.dev,
so I switched mail server...)

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

These action_page_types are no longer used, so remove them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h      | 2 --
 include/ras/ras_event.h | 2 --
 mm/memory-failure.c     | 2 --
 3 files changed, 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a3229f609856..71d886470d71 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3246,7 +3246,6 @@ enum mf_action_page_type {
 	MF_MSG_KERNEL_HIGH_ORDER,
 	MF_MSG_SLAB,
 	MF_MSG_DIFFERENT_COMPOUND,
-	MF_MSG_POISONED_HUGE,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
 	MF_MSG_NON_PMD_HUGE,
@@ -3261,7 +3260,6 @@ enum mf_action_page_type {
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
index a47b741ca04b..09f079987928 100644
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












From: Naoya Horiguchi <nao.horiguchi@gmail.com>
To: 
Cc: 
Bcc: nao.horiguchi@gmail.com
Subject: 
Reply-To: 

