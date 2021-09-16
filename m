Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB2740DA1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbhIPMlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:41:01 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3838 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbhIPMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:54 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H9Gmx01wWz67rZ8;
        Thu, 16 Sep 2021 20:37:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 14:39:32 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 13:39:28 +0100
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <irogers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <zhangshaokun@hisilicon.com>,
        <liuqi115@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 2/5] perf jevents: Support ConfigCode
Date:   Thu, 16 Sep 2021 20:34:22 +0800
Message-ID: <1631795665-240946-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1631795665-240946-1-git-send-email-john.garry@huawei.com>
References: <1631795665-240946-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMUs use "config=XXX" for eventcodes, like:

more /sys/bus/event_source/devices/hisi_sccl1_ddrc3/events/act_cmd
config=0x5

However jevents would give an alias with .event field "event=0x5" for this
event. This is handled without issue by the parse events code, but the pmu
alias code gets a bit confused, as it warns about assigning "event=0x5"
over "config=0x5" in perf_pmu_assign_str() when merging aliases:
./perf stat -v -e act_cmd
...
alias act_cmd differs in field 'value'
...

To make things a bit more straightforward, allow jevents to support
"config=XXX" as well, by supporting a "ConfigCode" field.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 6731b3cf0c2f..ef92c2fdd45d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -575,10 +575,12 @@ static int json_events(const char *fn,
 		struct json_event je = {};
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
+		unsigned long long configcode = 0;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
 		jsmntok_t *precise = NULL;
 		jsmntok_t *obj = tok++;
+		bool configcode_present = false;
 
 		EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
 		for (j = 0; j < obj->size; j += 2) {
@@ -601,6 +603,12 @@ static int json_events(const char *fn,
 				addfield(map, &code, "", "", val);
 				eventcode |= strtoul(code, NULL, 0);
 				free(code);
+			} else if (json_streq(map, field, "ConfigCode")) {
+				char *code = NULL;
+				addfield(map, &code, "", "", val);
+				configcode |= strtoul(code, NULL, 0);
+				free(code);
+				configcode_present = true;
 			} else if (json_streq(map, field, "ExtSel")) {
 				char *code = NULL;
 				addfield(map, &code, "", "", val);
@@ -682,7 +690,10 @@ static int json_events(const char *fn,
 				addfield(map, &extra_desc, " ",
 						"(Precise event)", NULL);
 		}
-		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
+		if (configcode_present)
+			snprintf(buf, sizeof buf, "config=%#llx", configcode);
+		else
+			snprintf(buf, sizeof buf, "event=%#llx", eventcode);
 		addfield(map, &event, ",", buf, NULL);
 		if (je.desc && extra_desc)
 			addfield(map, &je.desc, " ", extra_desc, NULL);
-- 
2.26.2

