Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC02F32CAD9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhCDDdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:33:49 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:12735 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232455AbhCDDdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:33:40 -0500
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 22:33:40 EST
IronPort-SDR: /El76av0wT3ThsRIfEAM/GECKTA9loD3ywJA8dlx3+uBcQkT3SVrcp44FVsOxQt8pQ36tAdI4p
 MKSpo5+7ohJcOEPu9HuMdDF/EcFrQW04OPTP8NLfu89Q8259uxnHe8di+gTK+/bw9Dcqxn9PND
 /p059/nd2a0hE3w/FP0JnmOeG1I40E4k+5tb33/SPVIyJB/AvewJzcqpgpt7ovGT0p1CUWVo9q
 001ti36cUjSMIL9s21hAoBokgzpROSY+3JG3772V6NsrRQ4/MDrg1LklQi8E0dwn/d4ojVgF1E
 uD0=
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="21614270"
X-IronPort-AV: E=Sophos;i="5.81,221,1610377200"; 
   d="scan'208";a="21614270"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2021 12:26:29 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 71A6DEC7AA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:26:27 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D00B11C281
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:26:26 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id BC9F54007EDA9;
        Thu,  4 Mar 2021 12:26:26 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] perf test: Add test for event name starting with a number
Date:   Thu,  4 Mar 2021 12:26:10 +0900
Message-Id: <20210304032610.3112996-5-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210304032610.3112996-1-nakamura.shun@fujitsu.com>
References: <20210304032610.3112996-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>

Add test for event name starting with a number.
This test pattern checks that event names starting with a number do not 
result in a 'parse error'.

Committer notes:

Testing arm64 and x86:
  # ./perf test fake
  10: PMU events                                                      :
  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

  # ./perf test fake -vv
  parsing metric: 0inst_commit + 1inst_commit + 2inst_commit + 3inst_commit + 4inst_commit
  Attempting to add event pmu '4inst_commit' with '' that may result in non-fatal errors
  Attempting to add event pmu '0inst_commit' with '' that may result in non-fatal errors
  Attempting to add event pmu '2inst_commit' with '' that may result in non-fatal errors
  Attempting to add event pmu '3inst_commit' with '' that may result in non-fatal errors
  Attempting to add event pmu '1inst_commit' with '' that may result in non-fatal errors
  parsing metric: 0inst_commit + 1inst_commit + 2inst_commit + 3inst_commit + 4inst_commit
  lookup(0inst_commit): val 2.000000
  lookup(1inst_commit): val 5.000000
  lookup(2inst_commit): val 3.000000
  lookup(3inst_commit): val 4.000000
  lookup(4inst_commit): val 1.000000
  test child finished with 0
  ---- end ----
  PMU events subtest 4: Ok


Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/perf/tests/pmu-events.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 0ca6a5a53523..1a95080373ee 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -398,27 +398,12 @@ static int test_aliases(void)
 	return 0;
 }
 
-static bool is_number(const char *str)
-{
-	char *end_ptr;
-	double v;
-
-	errno = 0;
-	v = strtod(str, &end_ptr);
-	(void)v; // We're not interested in this value, only if it is valid
-	return errno == 0 && end_ptr != str;
-}
-
 static int check_parse_id(const char *id, struct parse_events_error *error,
 			  struct perf_pmu *fake_pmu)
 {
 	struct evlist *evlist;
 	int ret;
 
-	/* Numbers are always valid. */
-	if (is_number(id))
-		return 0;
-
 	evlist = evlist__new();
 	if (!evlist)
 		return -ENOMEM;
@@ -540,6 +525,7 @@ static struct test_metric metrics[] = {
 	{ "imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@ * 4", },
 	{ "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100", },
 	{ "(imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@)", },
+	{ "0inst_commit + 1inst_commit + 2inst_commit + 3inst_commit + 4inst_commit",} ,
 };
 
 static int metric_parse_fake(const char *str)
-- 
2.25.1

