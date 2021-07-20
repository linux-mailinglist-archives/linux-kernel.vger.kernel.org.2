Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53663CFA76
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbhGTMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhGTMeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:34:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84690C061768;
        Tue, 20 Jul 2021 06:14:38 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id k3so15288926qtq.7;
        Tue, 20 Jul 2021 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VVbmUrxw+u6qngGhg59S6mmfEHwMiesMjAfWbg/XAgs=;
        b=cExFOH1nBjn1ObWW/rCGWAbZARXNv9jlHIeIlBAjTD98oLaE8iOzHo+Om4oafQnCH6
         rT5fK4H8sQu2prO4+fznCC0hl/5IXpsu0Oh73i7ozhaqPd1ZLg+FdhebR4ID7L2uCu6W
         93JtUEN4gtapZD2xRRPotQfbcNzxiGHHYqPuIKHPlYgEWQF1rYO0mFRi/iYsG2kZkaGK
         TEw37uLftGQ2NWaeBwehJGA4Q3AVCQw1jxUJmc7aGBSCUd6AWYx+1NcvkQvRsbV8wDzI
         Fz+WTVjMNY+7yLv7WXovmVWideZgLxiRDnK3bj9ZqzRUsm21PHz6mSLgjyb5ZusjuAmB
         wJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VVbmUrxw+u6qngGhg59S6mmfEHwMiesMjAfWbg/XAgs=;
        b=muy+lgx8vSfzXZlezB5fObCYfGDjJlTTWlJ9nMA+SWpHdT//Zq0rXRloO9LknwV5fP
         EeW4I5TqzC2IgN5DPtzkmn1CfS14gD+k8kQTElUy8G3oyd0K98zvtfROAhpyylr/kWJ+
         lIDhn7H459WvwcY4GiMC19z3m9+bsgd0/nbpZp54BnWUUB3AtRSbwNNjOn4MD+tZ5CSd
         U7zEM2HLbxAlxU9e0g/++8BNmlhh/T2TFWVjHww1eXC0qZtGwOHqOg3EPhwOrfGEyetS
         us2Q8HdDT0tFTlTP6cI7kuHJjNCaIBGAP6X9+AgdRHnrdbtkmdyzx5zZwn3KnZGUcMfp
         pCVQ==
X-Gm-Message-State: AOAM533uCdsqClzpmylNuGPeiA61G6ofPB3F0pX6AoCbUY2wMMFMVftC
        T0pmV60cXGlI8u6uioEHBwc=
X-Google-Smtp-Source: ABdhPJwaqkELLyml0pvKZt5ZF5XE8mHpJ4f+Mn/CnQd/+B+Z8jr+2HjvimhLkAR2vf0YZd63SwaH4w==
X-Received: by 2002:ac8:47c5:: with SMTP id d5mr26167300qtr.231.1626786877747;
        Tue, 20 Jul 2021 06:14:37 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:37 -0700 (PDT)
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
Subject: [RFC v3 12/15] mm/damon/dbgfs: Support watermarks
Date:   Tue, 20 Jul 2021 13:13:06 +0000
Message-Id: <20210720131309.22073-13-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates DAMON debugfs interface to support the watermarks
based schemes activation.  For this, now 'schemes' file receives five
more values.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 2509c0b634b4..168bd6406a3f 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -227,7 +227,7 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
 	damon_for_each_scheme(s, c) {
 		rc = scnprintf(&buf[written], len - written,
-				"%lu %lu %u %u %u %u %d %lu %lu %lu %u %u %u %lu %lu\n",
+				"%lu %lu %u %u %u %u %d %lu %lu %lu %u %u %u %d %lu %lu %lu %lu %lu %lu\n",
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
@@ -237,6 +237,8 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 				s->quota.weight_sz,
 				s->quota.weight_nr_accesses,
 				s->quota.weight_age,
+				s->wmarks.metric, s->wmarks.interval,
+				s->wmarks.high, s->wmarks.mid, s->wmarks.low,
 				s->stat_count, s->stat_sz);
 		if (!rc)
 			return -ENOMEM;
@@ -317,18 +319,18 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	*nr_schemes = 0;
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_quota quota = {};
-		struct damos_watermarks wmarks = {
-			.metric = DAMOS_WMARK_NONE,
-		};
+		struct damos_watermarks wmarks;
 
 		ret = sscanf(&str[pos],
-				"%lu %lu %u %u %u %u %u %lu %lu %lu %u %u %u%n",
+				"%lu %lu %u %u %u %u %u %lu %lu %lu %u %u %u %u %lu %lu %lu %lu%n",
 				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
 				&min_age, &max_age, &action, &quota.ms,
 				&quota.sz, &quota.reset_interval,
 				&quota.weight_sz, &quota.weight_nr_accesses,
-				&quota.weight_age, &parsed);
-		if (ret != 13)
+				&quota.weight_age, &wmarks.metric,
+				&wmarks.interval, &wmarks.high, &wmarks.mid,
+				&wmarks.low, &parsed);
+		if (ret != 18)
 			break;
 		if (!damos_action_valid(action)) {
 			pr_err("wrong action %d\n", action);
-- 
2.17.1

