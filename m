Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393444339C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhJSPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233463AbhJSPKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:10:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EB5861378;
        Tue, 19 Oct 2021 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656078;
        bh=3D534yrUCTvMARvW+XXEKtdcBOmG/E4GnwElvn8JhEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uT9wV7x05Fs4C4X4b62IqH1a+LrrTdBAttlBBZZSltKlgSJtqkIEhkOBaS6fB51jn
         /SjOanKBMpm06qKbBCl40qT0dKQKQLm91uPkN8aA6QQ67WMkTgExw8kXP/kZ+Kjcai
         PU1w4r24BaG/QJDCZJiwhxPo7DmiypUH8Ipxukcqjk0ALf0gl2SbhcUxuLMQA9BSP1
         eYZRQE4G5wgqTgsEtcP1nB83R5f9sAufbmnycU6ku2rVCKQr1qs3Jcfb79lotcHDtB
         QC0/FLrghuYZ7GWCOYIg4VJ/nN4fUpZouwVtzbiWKa2p0pHudNkzNChAPjTGeh9BL/
         sfnnfhZFyBbJg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] mm/damon/dbgfs: Support quotas of schemes
Date:   Tue, 19 Oct 2021 15:07:21 +0000
Message-Id: <20211019150731.16699-6-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019150731.16699-1-sj@kernel.org>
References: <20211019150731.16699-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the debugfs interface of DAMON support the scheme
quotas by chaning the format of the input for the schemes file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index a04bd50cc4c4..097e6745ba75 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -105,11 +105,14 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
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
 
@@ -190,10 +193,11 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
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
-- 
2.17.1

