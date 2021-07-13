Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672823C7197
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhGMN7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:59:24 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:39171 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236807AbhGMN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:59:19 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 33CC1FAE1E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 14:56:27 +0100 (IST)
Received: (qmail 30423 invoked from network); 13 Jul 2021 13:56:26 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 13 Jul 2021 13:56:26 -0000
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
Date:   Tue, 13 Jul 2021 14:56:25 +0100
Message-Id: <20210713135625.7615-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210713135625.7615-1-mgorman@techsingularity.net>
References: <20210713135625.7615-1-mgorman@techsingularity.net>
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
index e0eeb7391ec7..147bbd467214 100644
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

