Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632AD39F5A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhFHLzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFHLzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:55:12 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8CEC061787;
        Tue,  8 Jun 2021 04:53:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j189so19853954qkf.2;
        Tue, 08 Jun 2021 04:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1v3jF6xE2cadC0A5okidQotQQ/sADUe8F+zXLAj+QLM=;
        b=mDHQ2YMh1wx+gC9L9QO0GSL2MxjH0qEDBREBkT9xZfRPHTih2jw4S6xa1bbGfaOZrs
         CwcL3xX1gTSfuPCDIYBAJ66P1bZam83EPUrmm6/K0avsxZZU+kHgpf/6wf0J9FLkqWEP
         htvwgvuyJrf4saioMmd1RvXq0nVd1ZLxa/yZ+FKnH4GYUj7jJxm7KOZnW9MM+rZziU/r
         tzzFszZw0W1TZaqN8Pnlv7Ouo4k/mFznd8bXE86+0y3+kO3eGD3P4467F8iR97Md891y
         UYYGgQdVJbo0MKn67nGnjtbW0Kf7dwPRIkrbRqtZWF7TkacXxoZGHMED7KZLxPZ5v8B2
         XZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1v3jF6xE2cadC0A5okidQotQQ/sADUe8F+zXLAj+QLM=;
        b=YBmSRrDQPsi9q47fDN6Mk57FDKqiaESUAwMMSfGIXCxDj1QCdTxbe+SiSMeNCJv8td
         ML8kGjF65c4NT3bx+cLvDwFuB9Gk/4Fk0nCAnX33gbosWLSMEM19twiPqDpq35E684XZ
         PXbcND/El/+oyb8NkTY5LgN2GOGGCdODWxqNekuiwMF34mx0t3Q7XRZkbPuU8AfQvxHE
         kyWV/9QB5OLGIxkcG8YaaiJZGZzUPBJVlvEB5OhUBu78MwQQKTWCTp1pIDA1Saxm4xO7
         HYgwMw5XowQeSvsMGGauo1mRPkfJw+6ImMSHCPUxzpTdczR/bLApJJQLXphcU0xkJysi
         NHWw==
X-Gm-Message-State: AOAM530R94Hc4990KkJb4n4mJxprdveD1a8PVmvobjU9ekOgQTSN58Ks
        //E7IDKasAA32RAsLc3+s04=
X-Google-Smtp-Source: ABdhPJwUvb+KltsTXZs159GKaS7Z/4amSHZTojI8glTyC1QaSMs/x/Ym94/UGCYQevE7izxWu9Lo+g==
X-Received: by 2002:a37:73c7:: with SMTP id o190mr6613475qkc.314.1623153198298;
        Tue, 08 Jun 2021 04:53:18 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:17 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 03/14] damon/core/schemes: Skip already charged targets and regions
Date:   Tue,  8 Jun 2021 11:52:43 +0000
Message-Id: <20210608115254.11930-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

If DAMOS stopped applying action to memory regions due to the speed
limit, it does nothing until next charge window starts.  Then, it starts
the work from the beginning of the address space.  If there is a huge
memory region at the beginning of the address space and it fulfills the
scheme target data access pattern, the action will applied to only the
region.

This commit mitigates the case by skipping memory regions that charged
in previous charge window at the beginning of current charge window.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  5 +++++
 mm/damon/core.c       | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 35068b0ece6f..0df81dd2d560 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -104,6 +104,8 @@ struct damos_speed_limit {
 /* private: for limit accounting */
 	unsigned long charged_sz;
 	unsigned long charged_from;
+	struct damon_target *charge_target_from;
+	unsigned long charge_addr_from;
 };
 
 /**
@@ -331,6 +333,9 @@ struct damon_ctx {
 #define damon_prev_region(r) \
 	(container_of(r->list.prev, struct damon_region, list))
 
+#define damon_last_region(t) \
+	(list_last_entry(&t->regions_list, struct damon_region, list))
+
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4ac4a9aa2514..5864b63c18f9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -107,6 +107,8 @@ struct damos *damon_new_scheme(
 	scheme->limit.ms = limit->ms;
 	scheme->limit.charged_sz = 0;
 	scheme->limit.charged_from = 0;
+	scheme->limit.charge_target_from = NULL;
+	scheme->limit.charge_addr_from = 0;
 
 	return scheme;
 }
@@ -558,6 +560,21 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (limit->sz && limit->charged_sz >= limit->sz)
 			continue;
 
+		if (limit->charge_target_from) {
+			if (t != limit->charge_target_from)
+				continue;
+			if (r == damon_last_region(t)) {
+				limit->charge_target_from = NULL;
+				limit->charge_addr_from = 0;
+				continue;
+			}
+			if (limit->charge_addr_from &&
+					r->ar.start < limit->charge_addr_from)
+				continue;
+			limit->charge_target_from = NULL;
+			limit->charge_addr_from = 0;
+		}
+
 		sz = r->ar.end - r->ar.start;
 		/* Check the target regions condition */
 		if (sz < s->min_sz_region || s->max_sz_region < sz)
@@ -576,6 +593,10 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 			}
 			c->primitive.apply_scheme(c, t, r, s);
 			limit->charged_sz += sz;
+			if (limit->sz && limit->charged_sz >= limit->sz) {
+				limit->charge_target_from = t;
+				limit->charge_addr_from = r->ar.end + 1;
+			}
 		}
 		if (s->action != DAMOS_STAT)
 			r->age = 0;
-- 
2.17.1

