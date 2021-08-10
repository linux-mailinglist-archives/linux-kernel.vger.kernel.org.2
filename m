Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5B3D8BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhG1K3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:29:43 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:52918
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235913AbhG1K3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:29:40 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A48F03FE70;
        Wed, 28 Jul 2021 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627468177;
        bh=08v9EnWWhb7N+pT1ksAl83l8mO7xM8LVAJkXVI7FsWE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=irV5N8ws4Be4YXlU5m4pLzyb/ZNDwLBF7tKjEu86BFwhXMhU9cELJvU9/dIVg++fs
         jKeI84qQbvXf3O8Np4bqoOQVGXU2kt2ILoNR43iUJ1ilYeKsK/+dp69ANUNTgW9VyL
         sIc52hlgo+lTOzS/4lVAyzRTCCYJSc4u8tzzZ0VJ+mel1F64Ih2j17GW+O4OvV5DGJ
         RdyJ2XedWZx77AsvXuA2NCYKZLj9i9jV9iaVqnzt8W21ExTgnX0L578klYh7NV2y/Z
         C4Ks8zuGDDih79hsLuG/czlob0cV1Hc7/810pLKCKQcyJ+6VjHp9aoniO0TvnbXW/Y
         1kmZVYaYMrh/w==
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools:  Fix spelling contraction "cant'" -> "can't"
Date:   Wed, 28 Jul 2021 11:29:35 +0100
Message-Id: <20210728102935.171274-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_warning message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 44249027507a..5c9f7444939e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1284,7 +1284,7 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_warning("failed: cant' open memory sysfs data\n");
+		pr_warning("failed: can't open memory sysfs data\n");
 		return -1;
 	}
 
-- 
2.31.1

