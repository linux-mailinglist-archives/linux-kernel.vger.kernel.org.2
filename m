Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2610F3962AB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhEaPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhEaOFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:05:22 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C33C08C5DF;
        Mon, 31 May 2021 06:38:36 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c20so11215413qkm.3;
        Mon, 31 May 2021 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nFxPSjswgRnIxs2vNxK3L4JE5I+QJrKj8CTw993w1EM=;
        b=m74qWc1fxlvfUslWSc/F/lyS4qFAN7RD9iimFswc47USsXVF3BUlDOaRLYO5wIRb//
         giH1pymp5n9qApmGnZCP2M4O3r7prMe/NVRVbuF1TcnI1t3kqMjo97YlL74r7htE5CNk
         WijcwdrF3dAqpntYCvKc5N+eU7NYt5nqAZudzf14OYhWn6dlYVnpZUSGXBsUcLpnEkK0
         CwJBQLCNLeOQrdRG0crsfc4hrrve9/zo7HKFVzuT+dH+M62TYGEjebwz8h6jdxKb7Oq1
         wR7h9TTfLWTxOhI2aYgN2J+pEZuYRX/IWb0AT+BnMXrF2sW+EQ50zhmvKRA+0LZsIynO
         Zc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nFxPSjswgRnIxs2vNxK3L4JE5I+QJrKj8CTw993w1EM=;
        b=mp55UTS0r4xeKBLTKibXL980ChAXAr8U2p/xzeV8TkCQDKoYM40nCmdF/XvVechUPi
         hJc9XCLJe+RZff/XyagoZB+0e8kU+HcluKKw4/5H+24smHsVggRLRaj1L2oSIdUBdWvn
         U819PATTbF4hX6SWXpB3jzbNMm4R0OpofIv/z2f9QoZlQIFQqATrpY8+cW+AdnUWEP2A
         3cQTQpMiNh4enQzFxyF/tgMxVg85zJBwUR7Py0aRDXTSVH/m0MSlVDzj4SQ/CQX/6QJx
         MQWwmKYyHYBtkslr1MRD948fX80bhl/A9Rn0kRsEOZ7zpwLknPMRqyVobxpuTRPqHhaT
         PDdQ==
X-Gm-Message-State: AOAM530UBXk/CfHMFrEDbAcd5cMhjHycXMc4eo+MMnGh1BVlE3xUXx6E
        lWJNtKGM2sf0ypvnMpzaUhE=
X-Google-Smtp-Source: ABdhPJzrRjfJlv1JKyyWqYStIkKE7rV/3041YIhNVd3oq5fCb8jNMib106B6KKGMiyjgzx8Fvpv4jw==
X-Received: by 2002:a37:a6c2:: with SMTP id p185mr16715419qke.191.1622468316035;
        Mon, 31 May 2021 06:38:36 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h8sm8293085qtp.46.2021.05.31.06.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 06:38:35 -0700 (PDT)
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
Subject: [RFC PATCH 04/13] mm/damon/dbgfs: Support schemes speed limit
Date:   Mon, 31 May 2021 13:38:07 +0000
Message-Id: <20210531133816.12689-5-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-1-sj38.park@gmail.com>
References: <20210531133816.12689-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit makes the debugfs interface of DAMON to support the schemes
speed limit by chaning the format of the input for the schemes file.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 4b45b69db697..ea6d4fdb57fa 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -227,11 +227,12 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
 	damon_for_each_scheme(s, c) {
 		rc = scnprintf(&buf[written], len - written,
-				"%lu %lu %u %u %u %u %d %lu %lu\n",
+				"%lu %lu %u %u %u %u %d %lu %lu %lu %lu\n",
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
-				s->action, s->stat_count, s->stat_sz);
+				s->action, s->limit.sz, s->limit.ms,
+				s->stat_count, s->stat_sz);
 		if (!rc)
 			return -ENOMEM;
 
@@ -312,10 +313,11 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_speed_limit limit = {};
 
-		ret = sscanf(&str[pos], "%lu %lu %u %u %u %u %u%n",
+		ret = sscanf(&str[pos], "%lu %lu %u %u %u %u %u %lu %lu%n",
 				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
-				&min_age, &max_age, &action, &parsed);
-		if (ret != 7)
+				&min_age, &max_age, &action, &limit.sz,
+				&limit.ms, &parsed);
+		if (ret != 9)
 			break;
 		if (!damos_action_valid(action)) {
 			pr_err("wrong action %d\n", action);
@@ -1133,6 +1135,15 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 	return ret;
 }
 
+/*
+ * v1: Add the scheme speed limit
+ */
+static ssize_t dbgfs_version_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	return simple_read_from_buffer(buf, count, ppos, "1\n", 2);
+}
+
 static const struct file_operations mk_contexts_fops = {
 	.owner = THIS_MODULE,
 	.write = dbgfs_mk_context_write,
@@ -1149,13 +1160,18 @@ static const struct file_operations monitor_on_fops = {
 	.write = dbgfs_monitor_on_write,
 };
 
+static const struct file_operations version_fops = {
+	.owner = THIS_MODULE,
+	.read = dbgfs_version_read,
+};
+
 static int __init __damon_dbgfs_init(void)
 {
 	struct dentry *dbgfs_root;
 	const char * const file_names[] = {"mk_contexts", "rm_contexts",
-		"monitor_on"};
+		"monitor_on", "version"};
 	const struct file_operations *fops[] = {&mk_contexts_fops,
-		&rm_contexts_fops, &monitor_on_fops};
+		&rm_contexts_fops, &monitor_on_fops, &version_fops};
 	int i;
 
 	dbgfs_root = debugfs_create_dir("damon", NULL);
-- 
2.17.1

