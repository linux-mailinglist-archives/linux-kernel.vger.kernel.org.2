Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED93117FE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhBFAza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:55:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2505 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhBEJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:58:34 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DX9jz0rf3z67fhr;
        Fri,  5 Feb 2021 17:54:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 5 Feb 2021 10:57:47 +0100
Received: from [10.210.170.68] (10.210.170.68) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Feb 2021 09:57:46 +0000
Subject: Re: [PATCH] perf metricgroup: Fix system PMU metrics
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
 <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
 <20210120125622.GE1760208@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fe5fb278-ca58-d344-4f0e-a1c4cca5c210@huawei.com>
Date:   Fri, 5 Feb 2021 09:56:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210120125622.GE1760208@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.68]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>>
> that's fixing the issue for me, this was crashing:
>    # perf stat -a -I 1000 -M L1D_Cache_Fill_BW,L2_Cache_Fill_BW
> 

To cover this scenario (multiple metrics listed), how about a simple 
addition like:

---->8----

 From bd2ded1b0ef4962a9443cd180eed4e5c5b75ae5f Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Fri, 5 Feb 2021 09:50:54 +0000
Subject: [PATCH] perf test: Add parse-metric list test scenario


diff --git a/tools/perf/tests/parse-metric.c 
b/tools/perf/tests/parse-metric.c
index ce7be37f0d88..0626e389354c 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -201,6 +201,13 @@ static int compute_metric_group(const char *name, 
struct value *vals,
  	return __compute_metric(name, vals, name1, ratio1, name2, ratio2);
  }

+static int compute_metric_list(const char *list, struct value *vals,
+				const char *name1, double *ratio1,
+				const char *name2, double *ratio2)
+{
+	return __compute_metric(list, vals, name1, ratio1, name2, ratio2);
+}
+
  static int test_ipc(void)
  {
  	double ratio;
@@ -279,7 +286,7 @@ static int test_cache_miss_cycles(void)
   */
  static int test_dcache_l2(void)
  {
-	double ratio;
+	double ratio, ratio1, ratio2;
  	struct value vals[] = {
  		{ .event = "l2_rqsts.demand_data_rd_hit", .val = 100 },
  		{ .event = "l2_rqsts.pf_hit",             .val = 200 },
@@ -301,6 +308,15 @@ static int test_dcache_l2(void)

  	TEST_ASSERT_VAL("DCache_L2_Misses failed, wrong ratio",
  			ratio == 0.7);
+
+	TEST_ASSERT_VAL("failed to compute metric",
+			compute_metric_list("DCache_L2_Hits,DCache_L2_Misses", vals, 
"DCache_L2_Hits", &ratio1, "DCache_L2_Misses", &ratio2) == 0);
+
+	TEST_ASSERT_VAL("DCache_L2_Hits failed, wrong ratio",
+			ratio1 == 0.3);
+
+	TEST_ASSERT_VAL("DCache_L2_Misses failed, wrong ratio",
+			ratio2 == 0.7);
  	return 0;
  }


----8<----

> could you please send it formaly, so it can be merged?
> 
> I can't reproduce the original patch issue and I need
> to check the code in more depth

Thanks,
John

