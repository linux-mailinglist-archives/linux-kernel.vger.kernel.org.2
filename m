Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FBA44EB00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbhKLQFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:05:52 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:32352 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235412AbhKLQFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:05:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UwDEbXc_1636732963;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UwDEbXc_1636732963)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 13 Nov 2021 00:02:46 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] mm/damon: Add 'age' of region tracepoint support
Date:   Sat, 13 Nov 2021 00:02:40 +0800
Message-Id: <44e07dbbabc6af626b1bddf0a4edd5759c21a5fa.1636732449.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1636732449.git.xhao@linux.alibaba.com>
References: <cover.1636732449.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Damon, we can get age information by analyzing the nr_access change,
But short time sampling is not effective, we have to obtain enough data
for analysis through long time trace, this also means that we need to
consume more cpu resources and storage space.

Now the region add a new 'age' variable, we only need to get the change
of age value through a little time trace, for example, age has been
increasing to 141, but nr_access shows a value of 0 at the same time,
Through this，we can conclude that the region has a very low nr_access
value for a long time.

Fixes: 2fcb93629ad8 ("mm/damon: add a tracepoint")
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
