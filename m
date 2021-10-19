Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1D4339BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhJSPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232972AbhJSPKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2E1361175;
        Tue, 19 Oct 2021 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656075;
        bh=WoxuiuW5ka+DD5finWjE4Ns8AxADPKz/Lw8DZGKEVeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCKiE2JbsN58QcbQfWhEq26QhF4I8TsbVcmAMRn9o+FBtyVwwOaTjzbOsPwuP5EwF
         tLjCqDzVoQlhgirX0EtyNrwxEVBIt46kG0erIefltLCaybjza4/fEWgTg2fPv/lKF9
         oII69bloejhjJEfmyn6d1peVMeT9QtqfqF0+NeISOE/XAlonyRBBg7/y8DRVdAY9uC
         c/3a2vXAP9kpx2J5AC/3qSlhlKT0HTGwE2FVm+geB+kagW2MHV6YHEIOX2GeAsIKs5
         5dvKcnpMMr4GLVPzNPUqDn9+GTHj2ar2E9s6qLURcFHr/UGH04nFMIj5dh0n+JfpRO
         c2AdcgsN1r4rw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] mm/damon/schemes: Skip already charged targets and regions
Date:   Tue, 19 Oct 2021 15:07:19 +0000
Message-Id: <20211019150731.16699-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DAMOS has stopped applying action in the middle of a group of memory
regions due to its size quota, it starts the work again from the
beginning of the address space in the next charge window.  If there is a
huge memory region at the beginning of the address space and it fulfills
the scheme's target data access pattern always, the action will applied
to only the region.

This commit mitigates the case by skipping memory regions that charged
in current charge window at the beginning of next charge window.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  5 +++++
 mm/damon/core.c       | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index af8c2ada2655..1fec32e18319 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -107,6 +107,8 @@ struct damos_quota {
 /* private: For charging the quota */
 	unsigned long charged_sz;
 	unsigned long charged_from;
+	struct damon_target *charge_target_from;
+	unsigned long charge_addr_from;
 };
 
 /**
@@ -307,6 +309,9 @@ struct damon_ctx {
 #define damon_prev_region(r) \
 	(container_of(r->list.prev, struct damon_region, list))
 
+#define damon_last_region(t) \
+	(list_last_entry(&t->regions_list, struct damon_region, list))
+
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index cce14a0d5c72..693b75bc3450 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -111,6 +111,8 @@ struct damos *damon_new_scheme(
 	scheme->quota.reset_interval = quota->reset_interval;
 	scheme->quota.charged_sz = 0;
 	scheme->quota.charged_from = 0;
+	scheme->quota.charge_target_from = NULL;
+	scheme->quota.charge_addr_from = 0;
 
 	return scheme;
 }
@@ -553,6 +555,37 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->sz && quota->charged_sz >= quota->sz)
 			continue;
 
+		/* Skip previously charged regions */
+		if (quota->charge_target_from) {
+			if (t != quota->charge_target_from)
+				continue;
+			if (r == damon_last_region(t)) {
+				quota->charge_target_from = NULL;
+				quota->charge_addr_from = 0;
+				continue;
+			}
+			if (quota->charge_addr_from &&
+					r->ar.end <= quota->charge_addr_from)
+				continue;
+
+			if (quota->charge_addr_from && r->ar.start <
+					quota->charge_addr_from) {
+				sz = ALIGN_DOWN(quota->charge_addr_from -
+						r->ar.start, DAMON_MIN_REGION);
+				if (!sz) {
+					if (r->ar.end - r->ar.start <=
+							DAMON_MIN_REGION)
+						continue;
+					sz = DAMON_MIN_REGION;
+				}
+				damon_split_region_at(c, t, r, sz);
+				r = damon_next_region(r);
+				sz = r->ar.end - r->ar.start;
+			}
+			quota->charge_target_from = NULL;
+			quota->charge_addr_from = 0;
+		}
+
 		/* Check the target regions condition */
 		if (sz < s->min_sz_region || s->max_sz_region < sz)
 			continue;
@@ -573,6 +606,10 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			}
 			c->primitive.apply_scheme(c, t, r, s);
 			quota->charged_sz += sz;
+			if (quota->sz && quota->charged_sz >= quota->sz) {
+				quota->charge_target_from = t;
+				quota->charge_addr_from = r->ar.end + 1;
+			}
 		}
 		if (s->action != DAMOS_STAT)
 			r->age = 0;
-- 
2.17.1

