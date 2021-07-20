Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCD93CFA79
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbhGTMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbhGTMdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:33:51 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A9C061767;
        Tue, 20 Jul 2021 06:14:28 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id o9so10057120qvu.5;
        Tue, 20 Jul 2021 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QWr2BUkC4vvi9PM11ezntCMBhcCSyWA7DgM4Q5kuaLU=;
        b=Utq+RpuMRXgMXcdrvC6umPzmRtG3+auvypucw0Mh9V5KsDQKasPqaKQZhixrOKk1hJ
         ZS7kXhz6SXpwJGP18CvVNsIsbd9UGqtsOS0mvqwodSY1bz5CNud6AvNz7A/R/kms7qD6
         P+YiMKGadHslMcq4Z5RMuKRtVL61+M7kvkKGoaODW5vCwZnEdVA2ecB6LZClGKv/oW4a
         ainJ7pgrwoSLp0trcw4w6KNiElr6L7G3EKqfU+wvgM/LIIezdbkKzQQCS+sVAlx6eeeT
         yMb5d5oLL4Cui6iwx8cAAT4x8psgvyGQdSlQMxgx+21ctylM0GXxmNjZWfdX8oIZ0fX6
         achA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QWr2BUkC4vvi9PM11ezntCMBhcCSyWA7DgM4Q5kuaLU=;
        b=de4Knogthtl5DDun+3naJKFuFBW/EGfDl5LbZd9c1dvSYkuY7Ut2jUP5hJYI/e45E9
         TkZ55ygnJbz7MI4PtdtGz5X8FVi9TwiEldAfZlr3Ucz6lZyFD07J9PKkN/wJ87FzfXao
         vysjyE/y6cXfT/XmITz3FJY/VAEK/6IvP2oH0acA/oWbHKxxlN3ZDHG+axTKNpgmJDyo
         iQT2UwF/tr7pKxt5ZBqsDxqV6XfbgVGtpCdq1c22gHCg3yl9QxF6umSXPVSjp15ztUmH
         /E68VpXVmYeOns2bFyf2TDSx9mVZZa5USqtxH+we7g+e96qLEZxHnJdI7UB8DAescNA7
         GMRw==
X-Gm-Message-State: AOAM532bL+neSfsQQJrtTfgN7CwCIggAnMJHbAe/Nokw6IfVmCQ2XiO2
        xZGe2xtcNVZE6MPZi6qRBEk=
X-Google-Smtp-Source: ABdhPJzU/oZsWMgvR36q8SniWa6pLaFlm6s2cnx4Cx9k+RudbNGPvCx5QEqWVowKYTRc2Qo3plfjng==
X-Received: by 2002:a0c:fa08:: with SMTP id q8mr25163182qvn.8.1626786867608;
        Tue, 20 Jul 2021 06:14:27 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g17sm9701225qkm.34.2021.07.20.06.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:14:27 -0700 (PDT)
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
Subject: [RFC v3 09/15] mm/damon/dbgfs: Support prioritization weights
Date:   Tue, 20 Jul 2021 13:13:03 +0000
Message-Id: <20210720131309.22073-10-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720131309.22073-1-sj38.park@gmail.com>
References: <20210720131309.22073-1-sj38.park@gmail.com>
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
index 3cd253a07116..93ac15cb5786 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -227,13 +227,16 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
 	damon_for_each_scheme(s, c) {
 		rc = scnprintf(&buf[written], len - written,
-				"%lu %lu %u %u %u %u %d %lu %lu %lu %lu %lu\n",
+				"%lu %lu %u %u %u %u %d %lu %lu %lu %u %u %u %lu %lu\n",
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
 				s->action,
 				s->quota.ms, s->quota.sz,
 				s->quota.reset_interval,
+				s->quota.weight_sz,
+				s->quota.weight_nr_accesses,
+				s->quota.weight_age,
 				s->stat_count, s->stat_sz);
 		if (!rc)
 			return -ENOMEM;
@@ -315,11 +318,14 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_quota quota = {};
 
-		ret = sscanf(&str[pos], "%lu %lu %u %u %u %u %u %lu %lu %lu%n",
+		ret = sscanf(&str[pos],
+				"%lu %lu %u %u %u %u %u %lu %lu %lu %u %u %u%n",
 				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
 				&min_age, &max_age, &action, &quota.ms,
-				&quota.sz, &quota.reset_interval, &parsed);
-		if (ret != 10)
+				&quota.sz, &quota.reset_interval,
+				&quota.weight_sz, &quota.weight_nr_accesses,
+				&quota.weight_age, &parsed);
+		if (ret != 13)
 			break;
 		if (!damos_action_valid(action)) {
 			pr_err("wrong action %d\n", action);
@@ -1147,7 +1153,7 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 static ssize_t dbgfs_version_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, "1\n", 2);
+	return simple_read_from_buffer(buf, count, ppos, "2\n", 2);
 }
 
 static const struct file_operations mk_contexts_fops = {
-- 
2.17.1

