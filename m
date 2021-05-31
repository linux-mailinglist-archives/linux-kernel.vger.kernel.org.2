Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6D39626C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhEaO4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 10:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhEaOEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:04:12 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10ECC08C5CF;
        Mon, 31 May 2021 06:38:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s12so7928008qta.3;
        Mon, 31 May 2021 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8oDfTPCaQHlfzMwtOb005Z5DVxnI2Qln9RV3pvHJRdc=;
        b=t3TM6phNfaa5xYMVX8AEe5RlN5nfvUoJJh6cR8bm14DiIK4ocwxBKgcyRl95FzdPGs
         lx0Zhee/UBxZ4vOhVDawXg7/HsYLI5Mmybs1Y0Iau8CxNQci7q0MkMue9L3K1dcod8/o
         FSKePvElzSupZm4snBt4KXBz6DZlNmZUNGpycmslcq7s0wywn9Kq113yKtVElvTdSjpm
         GcPk0n5iuDGm0A3pl82wfVA32OFheVZjNUBqQ4TuO+JcWButvSnyN2fbxVKR0PPdTw0J
         xKNgVibW0LQPCSX7q8Cy9W1EAFIjlpzu4Hh//Pz7O1m8hX24dr3Z0ww2vXigUzvFUGDS
         UStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8oDfTPCaQHlfzMwtOb005Z5DVxnI2Qln9RV3pvHJRdc=;
        b=FAzAPJYNDRP08gN4pba3qGXsc0IIIrOZpnZzLUFDSoKT6f0pttvEs+0aeuCEfypAFK
         E5RyS1PWdY8FfrsjlniZY+OnT1hJy30z/JVaTbCirmLxUQlb3/Rh+yZXKdcXaTOikX1B
         qZflAVAbmJCxQ48me2uyBhIyaIgmRMmqh/z29JfyxuwauG4ccEqBTW0XcoNSFB/tWEIP
         FNadbS7+D13K3RqLqfXrK55PGlnk6P4KtDKv0U2/Qi2UrTyCQrw0h/WjfYdZ8wxvBv7G
         12zS38gbtbYXaYKa6dFdnnnsGo8mbrGBJjIW9py/jY/aP/IYZk+E0ZZLL9mq9yX4HYXU
         mR0g==
X-Gm-Message-State: AOAM533TLO4Na1ntIWh38mVxrYs2+p7i0v32uwXIX/W3QNm8vHFWsBBM
        BTvb+VaLf3P60hqkoAT3X3k=
X-Google-Smtp-Source: ABdhPJzUxCfrhtWHdhZnTNc2ZGr4kXBoiYlFu6aWGvcHzSWJBIYI4qNtXCuSzcdIBXO/QKPoySCDFA==
X-Received: by 2002:aed:20e7:: with SMTP id 94mr9765856qtb.66.1622468313949;
        Mon, 31 May 2021 06:38:33 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:33 -0700 (PDT)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/13] damon/core/schemes: Skip already charged targets and regions
Date:   Mon, 31 May 2021 13:38:06 +0000
Message-Id: <20210531133816.12689-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
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
 mm/damon/core.c       | 29 ++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

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
index df784c72ea80..fab687f18d9c 100644
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
@@ -593,11 +614,13 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damos *s;
 
 	damon_for_each_scheme(s, c) {
+		struct damos_speed_limit *limit = &s->limit;
+
 		/* Reset charge window if the duration passed */
-		if (time_after_eq(jiffies, s->limit.charged_from +
+		if (limit->sz && time_after_eq(jiffies, s->limit.charged_from +
 					msecs_to_jiffies(s->limit.ms))) {
-			s->limit.charged_from = jiffies;
-			s->limit.charged_sz = 0;
+			limit->charged_from = jiffies;
+			limit->charged_sz = 0;
 		}
 	}
 
-- 
2.17.1

