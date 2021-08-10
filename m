Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25D93DA609
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhG2OLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:11:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3532 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhG2ODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:03:11 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GbBl24ShSz6L9JT;
        Thu, 29 Jul 2021 21:51:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 16:03:06 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 15:03:02 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 10/11] perf jevents: Print SoC name per system event table
Date:   Thu, 29 Jul 2021 21:56:25 +0800
Message-ID: <1627566986-30605-11-git-send-email-john.garry@huawei.com>
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

Print the SoC name per system event table, which will allow the test SoC be
identified by the pmu-events test.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c    | 3 ++-
 tools/perf/pmu-events/pmu-events.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 405bdd36b9b9..6731b3cf0c2f 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -836,7 +836,8 @@ static int process_system_event_tables(FILE *outfp)
 	print_system_event_mapping_table_prefix(outfp);
 
 	list_for_each_entry(sys_event_table, &sys_event_tables, list) {
-		fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t},",
+		fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t\t.name = \"%s\",\n\t},",
+			sys_event_table->soc_id,
 			sys_event_table->soc_id);
 	}
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index d1172f6aebf1..5c2bf7275c1c 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -45,6 +45,7 @@ struct pmu_events_map {
 };
 
 struct pmu_sys_events {
+	const char *name;
 	struct pmu_event *table;
 };
 
-- 
2.26.2

