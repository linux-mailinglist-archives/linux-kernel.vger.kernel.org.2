Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69B3C7196
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhGMN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:59:22 -0400
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:32995 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236468AbhGMN7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:59:17 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id CD12D1C3FAE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 14:56:26 +0100 (IST)
Received: (qmail 30379 invoked from network); 13 Jul 2021 13:56:26 -0000
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
Subject: [PATCH 2/4] mm/page_alloc: correct return value when failing at preparing
Date:   Tue, 13 Jul 2021 14:56:23 +0100
Message-Id: <20210713135625.7615-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210713135625.7615-1-mgorman@techsingularity.net>
References: <20210713135625.7615-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

If the array passed in is already partially populated, we should
return "nr_populated" even failing at preparing arguments stage.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20210709102855.55058-1-yanfei.xu@windriver.com
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6ef86f338151..803414ce9264 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5255,7 +5255,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &alloc_gfp, &alloc_flags))
-		return 0;
+		return nr_populated;
 	gfp = alloc_gfp;
 
 	/* Find an allowed local zone that meets the low watermark. */
-- 
2.26.2

