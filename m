Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2FB39F5AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhFHLzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhFHLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:55:28 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B814C061787;
        Tue,  8 Jun 2021 04:53:21 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f70so4607646qke.13;
        Tue, 08 Jun 2021 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nFxPSjswgRnIxs2vNxK3L4JE5I+QJrKj8CTw993w1EM=;
        b=GVV3JJMQ0XCOg8jHkapL/ow7iREJv5SsbPj9zFzb0rwiLDvmbHCdQCuyTKqSKLk9KC
         4L5th8pMvcUFnVHUf3ChYt4sxsIFIVvxy6UwidbuXx0b+pstL8nK8emHY/hYZLs8JGOd
         fT/Fiy2x8bf341SreDqjTIAVCbPiDhMDrZ2gQuo2B0fchSg+NGcH7dfDl+gSUeD0eBkS
         2YRRfc/m81doMDzhpHJeBzJaLvlTjunzNXqJwiPc8sNE8nWw5T3gflkGPgduNsMPqXSN
         B5GG1BUAFSuGYVSgUB4cfmRosglzn++/cxc79q7VmvR33u4xfLLj2Ni2KrUJfw3bXNwH
         /XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nFxPSjswgRnIxs2vNxK3L4JE5I+QJrKj8CTw993w1EM=;
        b=pF46+2LQt/S0Bfl9soyaezhOt5LMEguODmrg5l3b6HM25LUhRomTDvHYDXvHpFXPDr
         +iQ31g46WmZnK+VFCInf0eTDwN75G8jpsT3J8igJHwxwUGQVskVVJZZj0wtHUWHA+sEk
         B0fY0xfSYxUoM3nSs5xBPLVukOZ6aQLYrvQ72vZ3f7MLpNbsdasdLTu/PX0fMXEoiSHt
         7wc0ug0HHKQh+3kZDh8MNpwEkp2pgFhHKcH/zWO8d+cIhwUGy+17iwp7ATxMATc0VB/u
         SxxlCQuQ0ES5aOcrYJxBxMqtVsVe9ECA7yzbj8LWoN0KwvFUI7UXGqNkAply+mUdided
         7qeA==
X-Gm-Message-State: AOAM533GiNITSCB8xfsC4rSRZW5DtfqsXsERWMrCdfQSCycDujhJ96wt
        kG3NIkC2Py3m965bK2mIisM=
X-Google-Smtp-Source: ABdhPJz0W4Tm3yxT5k/BicvuMfYTgFKUVIqEsXsSXgO0izcZdX2uEWYTaLsVGNAADQ7IvbEL4S0CMQ==
X-Received: by 2002:a37:7287:: with SMTP id n129mr20201503qkc.457.1623153200545;
        Tue, 08 Jun 2021 04:53:20 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id h4sm2133927qth.66.2021.06.08.04.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:53:20 -0700 (PDT)
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
Subject: [RFC v2 04/14] mm/damon/dbgfs: Support schemes speed limit
Date:   Tue,  8 Jun 2021 11:52:44 +0000
Message-Id: <20210608115254.11930-5-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608115254.11930-1-sj38.park@gmail.com>
References: <20210608115254.11930-1-sj38.park@gmail.com>
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

