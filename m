Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70B396310
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhEaPEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhEaOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:07:37 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A83EC0612F1;
        Mon, 31 May 2021 06:38:50 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 124so11172652qkh.10;
        Mon, 31 May 2021 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nfDK/Bf/e4nvbxsoi7WegXjXDWkjyIFNxz/IfnwgRq4=;
        b=YVe4kR7YSWJuL+Mtxc7uh7lzec7foD5jyMaxd24Y766wnUPENpK9qVBJjgCgwF+Ogb
         lgxREx7zqjvgYyPj6bDL4zZGNArHVQWrfUBgY+ZbceACh8RX+Z0QXUek8FEGLUX4BLUz
         gsoMR1ATCZTUxS/w70ugXR6vurZtCBqzQOmoRBaki101bpmC2CZz8BckmhPyvkbEY0A8
         iOIwi9wID+1hqN7vAD7YKxFRXN7SN9DFlbOrEr2NMNDHbOtzPcVnAjnAaswsU7mQU4YX
         m9AJA+FTWkGS3w0n8E2yHhY36yvl3Tusei+EW1zMPNJBobIYDeA96hVogBVdytaVsyon
         2ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nfDK/Bf/e4nvbxsoi7WegXjXDWkjyIFNxz/IfnwgRq4=;
        b=sT67pkakfgc5HoQgTX/4tT0Lx5dRsPCta8/SW2HF4BTUszDpaEAB2CS/sCHhtqNF4b
         d+2aaKCFjpmo+NxYWgsgD4M823RvlX6Yd1NFUuVSTe/1w30i2AJ4hqFCtNar8JdZbqRQ
         r8m7eYiRxlJ4cdD3n/6xfrfv6z5l2KHEPO2Wzk6L7qfIkZtuDE3htB3Nywvemtu7Tjhx
         pat5+3j7Tm+xM+myfvhgbuqPhqjam5yovCinTeX1vdJbXTS10LK/qRaFG4zKGxD72x/B
         I07haNTXKZwRiFC2ApjDVGPKF0JeiXmqtU85LC6B8SYTsX5LHTTooG1BIwqbTM/iv6+l
         SqFQ==
X-Gm-Message-State: AOAM530N4uZBt2aKj6wokSNjkBw7O6MhCXv6iIAgUTIe70Unn0LXOKoj
        rw5nG8fLdM9i/QKb30j6qTc=
X-Google-Smtp-Source: ABdhPJwCugJm5bVyy4s3sIyiN9JCFD8zm3wCpg6E74cgJbmcIKiaDZK3NPzK3gleXJoNAxdVTzzIAQ==
X-Received: by 2002:a37:a092:: with SMTP id j140mr16803968qke.382.1622468329708;
        Mon, 31 May 2021 06:38:49 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:49 -0700 (PDT)
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
Subject: [RFC PATCH 11/13] mm/damon/dbgfs: Support watermarks
Date:   Mon, 31 May 2021 13:38:14 +0000
Message-Id: <20210531133816.12689-12-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates DAMON debugfs interface to support the watermarks
based schemes activation.  For this, now 'schemes' file receives five
more values.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 1680fb1be8e1..768ef3eb9550 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -227,7 +227,7 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
 	damon_for_each_scheme(s, c) {
 		rc = scnprintf(&buf[written], len - written,
-				"%lu %lu %u %u %u %u %d %lu %lu %u %u %u %lu %lu\n",
+				"%lu %lu %u %u %u %u %d %lu %lu %u %u %u %d %lu %lu %lu %lu %lu %lu\n",
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
@@ -235,6 +235,8 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 				s->limit.weight_sz,
 				s->limit.weight_nr_accesses,
 				s->limit.weight_age,
+				s->wmarks.metric, s->wmarks.interval,
+				s->wmarks.high, s->wmarks.mid, s->wmarks.low,
 				s->stat_count, s->stat_sz);
 		if (!rc)
 			return -ENOMEM;
@@ -315,18 +317,18 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	*nr_schemes = 0;
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_speed_limit limit = {};
-		struct damos_watermarks wmarks = {
-			.metric = DAMOS_WMARK_NONE,
-		};
+		struct damos_watermarks wmarks;
 
 		ret = sscanf(&str[pos],
-				"%lu %lu %u %u %u %u %u %lu %lu %u %u %u%n",
+				"%lu %lu %u %u %u %u %u %lu %lu %u %u %u %u %lu %lu %lu %lu%n",
 				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
 				&min_age, &max_age, &action, &limit.sz,
 				&limit.ms, &limit.weight_sz,
 				&limit.weight_nr_accesses, &limit.weight_age,
+				&wmarks.metric, &wmarks.interval,
+				&wmarks.high, &wmarks.mid, &wmarks.low,
 				&parsed);
-		if (ret != 12)
+		if (ret != 17)
 			break;
 		if (!damos_action_valid(action)) {
 			pr_err("wrong action %d\n", action);
-- 
2.17.1

