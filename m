Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7569C435AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhJUGeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:34:11 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:32855 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231389AbhJUGdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:33:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ut77num_1634797893;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ut77num_1634797893)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Oct 2021 14:31:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     mhocko@kernel.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] hugetlb: Remove redundant VM_BUG_ON() in add_reservation_in_range()
Date:   Thu, 21 Oct 2021 14:31:19 +0800
Message-Id: <2b565552f3d06753da1e8dda439c0d96d6d9a5a3.1634797639.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
References: <cover.1634797639.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling hugetlb_resv_map_add(), we've guaranteed that the parameter
'to' is always larger than 'from', so it never returns a negative value
from hugetlb_resv_map_add(). Thus remove the redundant VM_BUG_ON().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5922629..166cfa1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -446,7 +446,6 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		add += hugetlb_resv_map_add(resv, rg, last_accounted_offset,
 					    t, h, h_cg, regions_needed);
 
-	VM_BUG_ON(add < 0);
 	return add;
 }
 
-- 
1.8.3.1

