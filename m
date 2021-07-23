Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A0B3D3161
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhGWBH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 21:07:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7045 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhGWBH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:07:57 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GWBsD3fC8zYfQr;
        Fri, 23 Jul 2021 09:42:40 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 09:48:29 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Jul 2021 09:48:29 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <jolsa@kernel.org>, <acme@kernel.org>
CC:     <peterz@infradead.org>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mliska@suse.cz>, <irogers@google.com>, <dzhu@wavecomp.com>,
        <rickyman7@gmail.com>, <yao.jin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>
Subject: [PATCH] perf env: Normalize aarch64.* to arm64 in normalize_arch()
Date:   Fri, 23 Jul 2021 09:49:44 +0800
Message-ID: <20210723014944.214887-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my aarch64 big endian machine, the perf annotate does not work.

 # perf annotate
  Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (253 samples, percent: local period)
 --------------------------------------------------------------------------------------------------------------
  Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (1 samples, percent: local period)
 ------------------------------------------------------------------------------------------------------------
  Percent |      Source code & Disassembly of [kernel.kallsyms] for cycles (47 samples, percent: local period)
 -------------------------------------------------------------------------------------------------------------
 ...

This is because the arch_find() function uses the normalized architecture
name provided by normalize_arch(), and my machine's architecture name
aarch64_be is not normalized to arm64.  Like other architectures such as
arm and powerpc, we can fuzzy match the architecture names associated with
aarch64.* and normalize them.

Fixes: c34df25b40c2 ("perf annotate: Add symbol__annotate function")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/util/annotate.c | 4 +++-
 tools/perf/util/env.c      | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index aa04a3655236..cb280de3369f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2192,8 +2192,10 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		return errno;
 
 	args.arch = arch = arch__find(arch_name);
-	if (arch == NULL)
+	if (arch == NULL) {
+		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
 		return ENOTSUP;
+	}
 
 	if (parch)
 		*parch = arch;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index cec2e6cad8aa..a91da1e9b201 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -349,7 +349,7 @@ static const char *normalize_arch(char *arch)
 		return "x86";
 	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
 		return "sparc";
-	if (!strcmp(arch, "aarch64") || !strcmp(arch, "arm64"))
+	if (!strncmp(arch, "aarch64", 7) || !strcmp(arch, "arm64"))
 		return "arm64";
 	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
 		return "arm";
-- 
2.17.1

