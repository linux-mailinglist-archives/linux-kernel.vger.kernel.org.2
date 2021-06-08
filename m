Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9F539F5A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhFHLz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbhFHLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:55:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C42DC06178B;
        Tue,  8 Jun 2021 04:53:30 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id t6so4702170qvp.5;
        Tue, 08 Jun 2021 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=exn5/9MVsYyepOBbFagm+4+x6JfQKNCd23hgVVQiw28=;
        b=rW6VO0cYPPeohtegDgnMo56MynBg4r79O6s7fPi4Hdgb4YViiGit5ckAJxLvBxTHKG
         I8FeR8VtXvr2EsTbwvkB1bkBqhxzyiVvac7rSpDQhZj/P7OOAUfHdMCQkqlAkdbbLgr3
         kQFCw79tAR2RAt/tCkDe6g4r0ptta+kQEJ6fYily/2qY5EUGH27vOKm7tarHYyj7spii
         Yeoje3bC0c7/17CK7Hy2F44baCEKYEdfvrHfIh248bmIgT/c6nc9e4OBf60PVslSTSj2
         x08zgiiqh6DG0CuZvXn+j0UXu6G+Q3T8n4pat88EsZSJey77bIC0MZiVQDfFutphW8K2
         ySaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=exn5/9MVsYyepOBbFagm+4+x6JfQKNCd23hgVVQiw28=;
        b=WrfWyamBQhmkRjUX+cRRAh0QG8KJiO+IEv0BPB6WpczZj3I5W5ILYI1VWR7v4qINBE
         zKo0iLYVjg4g0KqzgDp94TAnXKGUjxzeuuEtYOTSNO3D0dMmMKfaYkDMmmL+1SH0Cj+U
         uwIc8pY67BDnLvO5zYnv7PUaTg1yR/V+2tZQlF6bRJd4G1SjtayRQWp3bD9BiEsCHzZc
         LcZThJsQo1QF25jbdxj4l+ZNqONqppq5NGi5Rp4RbYTt+WbPqCIaODHHhXTIjPA3t32U
         zN//zM28EeSuziiptfGMQ4K27QbNipTiYYG+fiyRmfvksScjqAM5HjZ7ZfAZkgYcfz5k
         YnLQ==
X-Gm-Message-State: AOAM532eMx+ZDw4a18/SVhsKcVDgtzty+qaX+tR7h8jiaFPSSbg4Q0VC
        bisVIMY0T8TKp/jnoyh428Y=
X-Google-Smtp-Source: ABdhPJywm2xA13cQrhGtHNB/ZXuL7WSc2fz2N2COdktA1EihuHv9PfAyl9AWb4EmC9kEbP0RMKU+Zg==
X-Received: by 2002:a0c:a99c:: with SMTP id a28mr22979057qvb.33.1623153209315;
        Tue, 08 Jun 2021 04:53:29 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:28 -0700 (PDT)
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
Subject: [RFC v2 08/14] mm/damon/dbgfs: Support prioritization weights
Date:   Tue,  8 Jun 2021 11:52:48 +0000
Message-Id: <20210608115254.11930-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit allows DAMON debugfs interface users set the prioritization
weights by putting three more numbers to the 'schemes' file.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index ea6d4fdb57fa..b90287b1e576 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -227,11 +227,14 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
 	damon_for_each_scheme(s, c) {
 		rc = scnprintf(&buf[written], len - written,
-				"%lu %lu %u %u %u %u %d %lu %lu %lu %lu\n",
+				"%lu %lu %u %u %u %u %d %lu %lu %u %u %u %lu %lu\n",
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
 				s->action, s->limit.sz, s->limit.ms,
+				s->limit.weight_sz,
+				s->limit.weight_nr_accesses,
+				s->limit.weight_age,
 				s->stat_count, s->stat_sz);
 		if (!rc)
 			return -ENOMEM;
@@ -313,11 +316,14 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_speed_limit limit = {};
 
-		ret = sscanf(&str[pos], "%lu %lu %u %u %u %u %u %lu %lu%n",
+		ret = sscanf(&str[pos],
+				"%lu %lu %u %u %u %u %u %lu %lu %u %u %u%n",
 				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
 				&min_age, &max_age, &action, &limit.sz,
-				&limit.ms, &parsed);
-		if (ret != 9)
+				&limit.ms, &limit.weight_sz,
+				&limit.weight_nr_accesses, &limit.weight_age,
+				&parsed);
+		if (ret != 12)
 			break;
 		if (!damos_action_valid(action)) {
 			pr_err("wrong action %d\n", action);
@@ -1141,7 +1147,7 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 static ssize_t dbgfs_version_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, "1\n", 2);
+	return simple_read_from_buffer(buf, count, ppos, "2\n", 2);
 }
 
 static const struct file_operations mk_contexts_fops = {
-- 
2.17.1

