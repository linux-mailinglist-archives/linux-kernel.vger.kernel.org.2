Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEFA3CFA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbhGTMtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbhGTMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CCEC0613E1;
        Tue, 20 Jul 2021 06:14:01 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id q15so10332893qtp.0;
        Tue, 20 Jul 2021 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d+FN8BCXq1Njo+3jWyl699IvNI4knnaapCBiI4jANDs=;
        b=sKV3Sub0ZWw3J1A9H/aM4MCg5TP6Cvdgb2f7j3O/vH1twUs7qUxGwfjlPc0VoLhBhf
         2S3YMwYU+fYaMmkQNYqu6QhhxGxlprKZxcsoJ22fQ11snxI27MW2ZXHJJ3neqsKVeuIH
         zvkcT5OIscQO/gbb9s48YC+nIUdo8hh7dEqm9htIbKh1bW/jTrqZr726zllpFT9yRspS
         2IFTgDPtJt2075MHXgPyv5K1a2C6NuShpJ5v72Cpmp838BXVuFtabI3s8TQjHghL6K78
         ukovvHU4whQsk5WpK0lihTKtn4eKBwysGwHFlEI8DHeVsSR3ryLtVE2YaWMRq8gt/bOD
         mIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d+FN8BCXq1Njo+3jWyl699IvNI4knnaapCBiI4jANDs=;
        b=SEOflCUIfvN351FF9g376dyGots2Uds1djylUBXTyahqR6ZkwabHX2pTOPAVTlkQHP
         6fkfrDejOYz0AvoQahVaW5zM8Es240f4VYNd0KFKJv6y0+oqGplBsK26l+yunFWyFPBp
         SkIL9ibDswrBodb5pye6aDy1Ly/b7PhYqrs+uMBXgkauZPKDfNqPQSZKzS4ZH5/mIRG/
         Kyhai86J6fV9drLB9RoZs/FNox+AXRkJ24xTV/ppkvV4sXAMru+PsYbkE6t/giH1fetv
         XIF4h8LfFBSvMWdIBrQtkejnuIRLPpa3EWMH7/Y8vt6EZGbCyFXIJZoMCkNSQLTULi5+
         nRmA==
X-Gm-Message-State: AOAM530/7uV0egHY1EB3AR0DJ/MyQwSYgcEjFMFr+CA4DJVhx4GhKOqi
        a4BHGy0lxX9YksJNmIE8Yxo=
X-Google-Smtp-Source: ABdhPJya1WocZ2Abu2uH1JFsFZnGgG+TUYEiCkCCCkaOrXAB7pUilYbjSriLMVokCmVpZDpmD3CNpw==
X-Received: by 2002:a05:622a:207:: with SMTP id b7mr19490392qtx.377.1626786840957;
        Tue, 20 Jul 2021 06:14:00 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:00 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v3 03/15] damon/core/schemes: Skip already charged targets and regions
Date:   Tue, 20 Jul 2021 13:12:57 +0000
Message-Id: <20210720131309.22073-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
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
 mm/damon/core.c       | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9c996adb02b8..7b1fa506e7a6 100644
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
@@ -335,6 +337,9 @@ struct damon_ctx {
 #define damon_prev_region(r) \
 	(container_of(r->list.prev, struct damon_region, list))
 
+#define damon_last_region(t) \
+	(list_last_entry(&t->regions_list, struct damon_region, list))
+
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 00804a1e5e2a..a41eb9d885bb 100644
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
@@ -558,6 +560,37 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
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
@@ -578,6 +611,10 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
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

