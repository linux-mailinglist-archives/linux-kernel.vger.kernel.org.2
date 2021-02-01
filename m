Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B840430A2C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhBAHmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:42:09 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42191 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231526AbhBAHmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:42:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UNWxrPH_1612165279;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNWxrPH_1612165279)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 15:41:19 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] perf metricgroup: remove unneeded semicolon
Date:   Mon,  1 Feb 2021 15:41:17 +0800
Message-Id: <1612165277-95878-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./tools/perf/util/metricgroup.c:382:3-4: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index e6d3452..26c990e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -379,7 +379,7 @@ static int metricgroup__setup_events(struct list_head *groups,
 				metric_refs[i].metric_expr = ref->metric_expr;
 				i++;
 			}
-		};
+		}
 
 		expr->metric_refs = metric_refs;
 		expr->metric_expr = m->metric_expr;
-- 
1.8.3.1

