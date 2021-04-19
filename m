Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5951363F04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhDSJmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:42:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:60390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233488AbhDSJmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:42:33 -0400
IronPort-SDR: eQ9BX6XaxFBTCHvD8Ff5F6PG9G9dkpR6frbV0xxi+7AyJuN43BJiJn/JhwrDvN5Kvmxp2Kz494
 ZZWi3rKV8trA==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="174787686"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="174787686"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 02:42:04 -0700
IronPort-SDR: Qi0OeztN+UzBgws8TtO3DpXagIJKjlDs9QBJLKIMupL1+UoDIdoCeb98HFypjvRuJCIF/Zjojv
 FP8Y+zOSh5bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; 
   d="scan'208";a="452089710"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2021 02:42:01 -0700
From:   alexander.antonov@linux.intel.com
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com
Subject: [RESEND PATCH v5 4/4] perf: Update .gitignore file
Date:   Mon, 19 Apr 2021 12:41:47 +0300
Message-Id: <20210419094147.15909-5-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210419094147.15909-1-alexander.antonov@linux.intel.com>
References: <20210419094147.15909-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

After a "make -C tools/perf", git reports the following untracked file:
perf-iostat

Add this generated file to perf's .gitignore file.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index f3f84781fd74..e555e9729758 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -20,6 +20,7 @@ perf.data.old
 output.svg
 perf-archive
 perf-with-kcore
+perf-iostat
 tags
 TAGS
 cscope*
-- 
2.21.3

