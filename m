Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9F3C7313
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbhGMPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:23:59 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:50360 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236987AbhGMPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:23:52 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id A6AB5F61AA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 16:21:01 +0100 (IST)
Received: (qmail 14907 invoked from network); 13 Jul 2021 15:21:01 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 13 Jul 2021 15:21:01 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/4] Revert "mm/page_alloc: make should_fail_alloc_page() static"
Date:   Tue, 13 Jul 2021 16:21:00 +0100
Message-Id: <20210713152100.10381-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210713152100.10381-1-mgorman@techsingularity.net>
References: <20210713152100.10381-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.

Fix an unresolved symbol error when CONFIG_DEBUG_INFO_BTF=y:

  LD      vmlinux
  BTFIDS  vmlinux
FAILED unresolved symbol should_fail_alloc_page
make: *** [Makefile:1199: vmlinux] Error 255
make: *** Deleting file 'vmlinux'

Fixes: f7173090033c ("mm/page_alloc: make should_fail_alloc_page() static")
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20210708191128.153796-1-mcroce@linux.microsoft.com
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c66f1e6204c2..3e97e68aef7a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3820,7 +3820,7 @@ static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 
 #endif /* CONFIG_FAIL_PAGE_ALLOC */
 
-static noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	return __should_fail_alloc_page(gfp_mask, order);
 }
-- 
2.26.2

