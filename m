Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01796435DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhJUJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:24:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4013 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhJUJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:24:18 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HZhk71h40z67xLq;
        Thu, 21 Oct 2021 17:18:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 11:22:00 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 10:21:57 +0100
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <mingo@redhat.com>
CC:     <irogers@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kjain@linux.ibm.com>,
        <james.clark@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/2] perf jevents: Fix some would-be warnings
Date:   Thu, 21 Oct 2021 17:16:44 +0800
Message-ID: <1634807805-40093-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before enabling warnings through HOSTCFLAGS, fix the would-be warnings:

  HOSTCC  pmu-events/jevents.o
pmu-events/jevents.c:74:22: warning: no previous prototype for ‘convert’ [-Wmissing-prototypes]
   74 | enum aggr_mode_class convert(const char *aggr_mode)
      |                      ^~~~~~~
pmu-events/jevents.c: In function ‘print_events_table_entry’:
pmu-events/jevents.c:373:8: warning: declaration of ‘topic’ shadows a global declaration [-Wshadow]
  373 |  char *topic = pd->topic;
      |        ^~~~~
pmu-events/jevents.c:316:14: note: shadowed declaration is here
  316 | static char *topic;
      |              ^~~~~
pmu-events/jevents.c: In function ‘json_events’:
pmu-events/jevents.c:554:9: warning: declaration of ‘func’ shadows a global declaration [-Wshadow]
  554 |   int (*func)(void *data, struct json_event *je),
      |   ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pmu-events/jevents.c:85:15: note: shadowed declaration is here
   85 | typedef int (*func)(void *data, struct json_event *je);
      |               ^~~~
pmu-events/jevents.c: In function ‘main’:
pmu-events/jevents.c:1211:25: warning: initialization discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
 1211 |  char *err_string_ext = "";
      |                         ^~
pmu-events/jevents.c:1304:17: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
 1304 |  err_string_ext = " for std arch event";
      |                 ^

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index b7c8aae6bcf1..70eacc22dfef 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -71,7 +71,7 @@ struct json_event {
 	char *metric_constraint;
 };
 
-enum aggr_mode_class convert(const char *aggr_mode)
+static enum aggr_mode_class convert(const char *aggr_mode)
 {
 	if (!strcmp(aggr_mode, "PerCore"))
 		return PerCore;
@@ -82,8 +82,6 @@ enum aggr_mode_class convert(const char *aggr_mode)
 	return -1;
 }
 
-typedef int (*func)(void *data, struct json_event *je);
-
 static LIST_HEAD(sys_event_tables);
 
 struct sys_event_table {
@@ -370,7 +368,7 @@ static int print_events_table_entry(void *data, struct json_event *je)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
-	char *topic = pd->topic;
+	char *topic_local = pd->topic;
 
 	/*
 	 * TODO: Remove formatting chars after debugging to reduce
@@ -385,7 +383,7 @@ static int print_events_table_entry(void *data, struct json_event *je)
 	fprintf(outfp, "\t.desc = \"%s\",\n", je->desc);
 	if (je->compat)
 		fprintf(outfp, "\t.compat = \"%s\",\n", je->compat);
-	fprintf(outfp, "\t.topic = \"%s\",\n", topic);
+	fprintf(outfp, "\t.topic = \"%s\",\n", topic_local);
 	if (je->long_desc && je->long_desc[0])
 		fprintf(outfp, "\t.long_desc = \"%s\",\n", je->long_desc);
 	if (je->pmu)
@@ -1208,7 +1206,7 @@ int main(int argc, char *argv[])
 	const char *arch;
 	const char *output_file;
 	const char *start_dirname;
-	char *err_string_ext = "";
+	const char *err_string_ext = "";
 	struct stat stbuf;
 
 	prog = basename(argv[0]);
-- 
2.17.1

