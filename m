Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B713962E6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhEaPC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhEaOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:06:33 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB74C0612F0;
        Mon, 31 May 2021 06:38:44 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ez19so5514580qvb.3;
        Mon, 31 May 2021 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=exn5/9MVsYyepOBbFagm+4+x6JfQKNCd23hgVVQiw28=;
        b=LoL5jRQElHsWm8LP8+SICgLUszyYP4O8t1uqdvQmeQsZECaPPZY/kWOcm07z1B7UQo
         jTF1C5D4Hg0l8j09qydZPydD4kMxveKATIGUD6q1C7S085WoKCIDArlPHvvUq2qi/mgw
         0iGFshXRXAngdNliONNtzB/uGMW8WN2HH1b/Mzoa0rt61TZRNE7t2SXLnikZqc3YgM3J
         oQM2xWcNp+/dZs54de9GmKcZcXRlT9djcS4QzqWjV+Z1OUJg1k0eHvfTeSqSPxRyZqm9
         LDQeKcm8JCwILy9vUAjhg6qhLnU5dgY/HcagizHT89CWGcq27S9iIvCYLH896+O/5dwp
         c9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=exn5/9MVsYyepOBbFagm+4+x6JfQKNCd23hgVVQiw28=;
        b=buEpS4I+Xg8tFak4qwfMVy6wNoTVeHf5/U7lFonrntdR0zaHoJTTdg7rwVNPzQwjk5
         6x59PhLjmfv+aeXjVp5n0re8CO56M/b2k40bFEtvq2RVzQUdgzYS1hjZCQ/OQMosY/Y/
         VtdU58pZ1cy3krAQ5q2VuEg6II6GR5TdLnPJLNXpBqdT6lrVhONyz0HXFhH2JImg5RTh
         E5Pi0Ewt/oFcM3AEniPnfnQYIilzJ4QPRUv5TOVMw87A9b0o7hShicIuGnSO2smz/sqb
         eLyCTFlef7b3svVi+AARBJIF09j/JizKdn4EVpR8TCt+qm3kKll/qDozRgG+IhorI6Gz
         BhVA==
X-Gm-Message-State: AOAM533/AbLnQ7ZvbgsK0VUO0LaBmtFl8mY27sUw5CZ7fOZajtGS9N8n
        rwbWKzM1PQfnnlcq/M4dO4JU/AJ7vOtLeLuB
X-Google-Smtp-Source: ABdhPJzaecqIbH5Aze6LUtz/O51SmCe+Lju51wAkX5nYBg4pbUR9YbFLliNHty1gW03wN5sUd9/1pQ==
X-Received: by 2002:a0c:ea31:: with SMTP id t17mr5765216qvp.47.1622468324012;
        Mon, 31 May 2021 06:38:44 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:43 -0700 (PDT)
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
Subject: [RFC PATCH 08/13] mm/damon/dbgfs: Support prioritization weights
Date:   Mon, 31 May 2021 13:38:11 +0000
Message-Id: <20210531133816.12689-9-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
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

