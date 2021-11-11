Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D879D44D1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 07:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhKKGKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 01:10:03 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57187 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhKKGJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 01:09:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uw.HkwB_1636610826;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Uw.HkwB_1636610826)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 14:07:08 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] mm/damon: Add 'age' of region tracepoint support
Date:   Thu, 11 Nov 2021 14:07:02 +0800
Message-Id: <df8d52f1fb2f353a62ff34dc09fe99e32ca1f63f.1636610337.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1636610337.git.xhao@linux.alibaba.com>
References: <cover.1636610337.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In patch "mm/damon: add a tracepoint", it adds a
tracepoint for DAMON, it can monitor each region
for each aggregation interval, Now the region add
a new 'age' variable, some primitive would calculate
the priority of each region as a weight, there put it
into tracepoint, so we can easily track the change of
its value through perf or damon-tools.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 include/trace/events/damon.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 2f422f4f1fb9..99ffa601e351 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -22,6 +22,7 @@ TRACE_EVENT(damon_aggregated,
 		__field(unsigned long, start)
 		__field(unsigned long, end)
 		__field(unsigned int, nr_accesses)
+		__field(unsigned int, age)
 	),

 	TP_fast_assign(
@@ -30,11 +31,13 @@ TRACE_EVENT(damon_aggregated,
 		__entry->start = r->ar.start;
 		__entry->end = r->ar.end;
 		__entry->nr_accesses = r->nr_accesses;
+		__entry->age = r->age;
 	),

-	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u",
+	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
 			__entry->target_id, __entry->nr_regions,
-			__entry->start, __entry->end, __entry->nr_accesses)
+			__entry->start, __entry->end,
+			__entry->nr_accesses, __entry->age)
 );

 #endif /* _TRACE_DAMON_H */
--
2.31.0
