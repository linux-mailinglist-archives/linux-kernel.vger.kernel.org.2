Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0618A3D59A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhGZL5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:57:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12264 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhGZL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:57:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GYK6m6n8Vz1CNFr;
        Mon, 26 Jul 2021 20:31:44 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 20:37:38 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 26 Jul 2021 20:37:37 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <acme@kernel.org>, <james.clark@arm.com>, <jolsa@kernel.org>
CC:     <peterz@infradead.org>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mliska@suse.cz>, <irogers@google.com>, <dzhu@wavecomp.com>,
        <rickyman7@gmail.com>, <yao.jin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>
Subject: [PATCH v2 1/2] perf env: Normalize aarch64.* and arm64.* to arm64 in normalize_arch()
Date:   Mon, 26 Jul 2021 20:38:53 +0800
Message-ID: <20210726123854.13463-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

It seems that there is also arm64_be architecture name, which we also
normalize to arm64.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
Changes in v2:
 - The error log added in symbol__annotate() is put into a single patch
 - Remove the "Fixes" tag
 - According to James' suggestion, "arm64_be" is also normalized to
   "arm64"

 tools/perf/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index cec2e6cad8aa..ab341050be46 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -349,7 +349,7 @@ static const char *normalize_arch(char *arch)
 		return "x86";
 	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
 		return "sparc";
-	if (!strcmp(arch, "aarch64") || !strcmp(arch, "arm64"))
+	if (!strncmp(arch, "aarch64", 7) || !strncmp(arch, "arm64", 5))
 		return "arm64";
 	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
 		return "arm";
-- 
2.17.1

