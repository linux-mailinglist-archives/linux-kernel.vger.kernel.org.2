Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33364339CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhJSPK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233527AbhJSPKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F21A860F22;
        Tue, 19 Oct 2021 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656085;
        bh=BUbtItIfGpDhgNPVfTufa4K3O0hNi69LHwsG38Q6v04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KaY83aVaq0NJhJnK4EynzmbtFkeMG5QwqzaJ1tx7kc3gOOZoNtKn7m9dkiMdN2mz8
         mIBKo1xZwVVCCFQXsHokIjVJDG8pneLZNyS2maG+8ACLzX4Xid947GhciJKeQzw2fO
         E1elwY5OD7w8MHh0JXOt9XRySpyW+x0Dr9bJqjK3cbcfO5FcyIshvgE6Dj24v8kn5b
         jr9Oz7xDvzdjxK0dVcAP0erpoGYp5RvP8XN18TPXA0aNuJ7mnLXbYC1d1OFYiJWbZa
         p5JWtk/3osHWgw7b+RhAVSWMthBbrlE7u/t3MWCEXFqlk+JzcksO4pXUymqqYXYRuR
         UfztV5XC5rZjQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] mm/damon/dbgfs: Support prioritization weights
Date:   Tue, 19 Oct 2021 15:07:25 +0000
Message-Id: <20211019150731.16699-10-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit allows DAMON debugfs interface users set the prioritization
weights by putting three more numbers to the 'schemes' file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 097e6745ba75..20c4feb8b918 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -105,13 +105,16 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
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
@@ -193,11 +196,14 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
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
-- 
2.17.1

