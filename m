Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4DD3DA5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhG2OJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:09:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3534 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbhG2OEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:04:51 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbBp147Vnz6FGKx;
        Thu, 29 Jul 2021 21:53:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 16:03:02 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:02:58 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 09/11] perf pmu: Make pmu_add_sys_aliases() public
Date:   Thu, 29 Jul 2021 21:56:24 +0800
Message-ID: <1627566986-30605-10-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function pmu_add_sys_aliases() will be required for the PMU events test
for system events aliases, so make it public.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/pmu.c | 2 +-
 tools/perf/util/pmu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 238792197006..534b91ccb2a2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -926,7 +926,7 @@ static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
 	return 0;
 }
 
-static void pmu_add_sys_aliases(struct list_head *head, struct perf_pmu *pmu)
+void pmu_add_sys_aliases(struct list_head *head, struct perf_pmu *pmu)
 {
 	struct pmu_sys_event_iter_data idata = {
 		.head = head,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 926da483a141..033e8211c025 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -81,6 +81,7 @@ struct perf_pmu_alias {
 
 struct perf_pmu *perf_pmu__find(const char *name);
 struct perf_pmu *perf_pmu__find_by_type(unsigned int type);
+void pmu_add_sys_aliases(struct list_head *head, struct perf_pmu *pmu);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-- 
2.26.2

