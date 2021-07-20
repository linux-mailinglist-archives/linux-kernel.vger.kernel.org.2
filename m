Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0BE3CFA84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhGTMps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbhGTMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:35 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F068CC0613DB;
        Tue, 20 Jul 2021 06:14:12 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z25so15256168qto.12;
        Tue, 20 Jul 2021 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IGNtAVR3k8XF7vgLV1Ypck6ucmf98cXrZIWCxjZwhEs=;
        b=GAvfz/BMO3wrFZlsSYPAxDLPt9E1IVrmnf78IudxRM3j8OdhKm/+plUr4YXsQBCWGp
         yUD6hbEqONcdSu+5I/Bdzbc65Xaojyv5E4RAF8ydd9jxhD1/5sgP/Jq8li09Sas/S5ZN
         LsknWXI6t/85mjINrn2UAE6TAZNnFq9AyxGBKIA9d+YR4PGNpNImmgDJPLy/j0o3cOlU
         V9bueOkTJWmFO76vT9zJk6pC+AzDO06zY1CiEwsRrdgDOMN+e9v/PDYF6ZW1XxJBTdRD
         rXYKVt31gh7ghliXZF0HlG5JgAnvQ0p7XG6uMeCMTVEaIEsaA3NpAxwChB8lXz0BgOGA
         JQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IGNtAVR3k8XF7vgLV1Ypck6ucmf98cXrZIWCxjZwhEs=;
        b=USlM20/YI3MRIj2MXh2OHN60JXPNoiDNTsCwMhcd/sVQ/A5piXTI9UnEATPlmoLPIK
         zZegIkTPohzJ+JwD9XKYo2VyFOLZA9VYhFOSxOMpyOEA/oJAdg4mDgrXqf3qaLEy6jYe
         EvT/oQy+OKd4lGoMtY7hro5CF6jakpQk/fKGcW96H3vke6D04xqkX/ZyESxWwmcFOtpI
         1lWprd/XtPMW0H/DrHMLqVSF8C9uXGv8WwtiKfqMeoT59bEeANfMPYJD2pY6gX0ZBbRE
         mFWAp+uXsgreO7Y6u7K3r75HHCAmXtRmRZcpRon1sUoQOgQeCdJMEqXN+OggmUoaQnSP
         /2OA==
X-Gm-Message-State: AOAM532GNbxPpak2GGfGsK/Rl50GixDQnWgPbOC8e7T+2XDJtK53mITV
        s76MLEDWI0eMr0CLozNlPA0=
X-Google-Smtp-Source: ABdhPJxvig77cKBciRJ2ldiG0pfJ9Ic/jAu3PCw2ZeX8znA6+2zHm5JQDCb9lPnGPoXl7zwhNPDLWg==
X-Received: by 2002:ac8:47c5:: with SMTP id d5mr26165672qtr.231.1626786852145;
        Tue, 20 Jul 2021 06:14:12 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:11 -0700 (PDT)
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
Subject: [RFC v3 05/15] mm/damon/dbgfs: Support schemes' time/IO quotas
Date:   Tue, 20 Jul 2021 13:12:59 +0000
Message-Id: <20210720131309.22073-6-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit makes the debugfs interface of DAMON to support the schemes'
time/IO quotas by chaning the format of the input for the schemes file.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon/dbgfs.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index ac0de2de1987..3cd253a07116 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -227,11 +227,14 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
 	damon_for_each_scheme(s, c) {
 		rc = scnprintf(&buf[written], len - written,
-				"%lu %lu %u %u %u %u %d %lu %lu\n",
+				"%lu %lu %u %u %u %u %d %lu %lu %lu %lu %lu\n",
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
-				s->action, s->stat_count, s->stat_sz);
+				s->action,
+				s->quota.ms, s->quota.sz,
+				s->quota.reset_interval,
+				s->stat_count, s->stat_sz);
 		if (!rc)
 			return -ENOMEM;
 
@@ -312,10 +315,11 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_quota quota = {};
 
-		ret = sscanf(&str[pos], "%lu %lu %u %u %u %u %u%n",
+		ret = sscanf(&str[pos], "%lu %lu %u %u %u %u %u %lu %lu %lu%n",
 				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
-				&min_age, &max_age, &action, &parsed);
-		if (ret != 7)
+				&min_age, &max_age, &action, &quota.ms,
+				&quota.sz, &quota.reset_interval, &parsed);
+		if (ret != 10)
 			break;
 		if (!damos_action_valid(action)) {
 			pr_err("wrong action %d\n", action);
@@ -1137,6 +1141,15 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
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
 	.write = dbgfs_mk_context_write,
 };
@@ -1150,13 +1163,18 @@ static const struct file_operations monitor_on_fops = {
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

