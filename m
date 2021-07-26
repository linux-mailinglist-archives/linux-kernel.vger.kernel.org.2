Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCC3D59A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhGZL5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:57:13 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12308 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhGZL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:57:11 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GYK886BrVz7w4m;
        Mon, 26 Jul 2021 20:32:56 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
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
Subject: [PATCH 2/2] perf annotate: Add error log in symbol__annotate()
Date:   Mon, 26 Jul 2021 20:38:54 +0800
Message-ID: <20210726123854.13463-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726123854.13463-1-lihuafei1@huawei.com>
References: <20210726123854.13463-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When users use the perf annotate feature on unsupported machines, error
logs should be printed for user feedback.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 tools/perf/util/annotate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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
-- 
2.17.1

