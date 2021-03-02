Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19D132A242
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836900AbhCBHVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:21:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235242AbhCBGyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:54:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1226Z7wu166851;
        Tue, 2 Mar 2021 01:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=N8NTLeH6ygpcuDWFrCgBmLNur4LlNudqKL2nb5bJpo4=;
 b=LNKvQTKumKwzKnxKmLIWK7gwIsYZD3DKapVNwSC8VYCsEXu91hHxZuqbDX1wVeqqBvA0
 TEnpm75S1YhXIzDjViyLdtUcrywMfSHDe4XOu6xgrtITpRde5JnBA2uMtBBsjv7cIgDi
 p5lxXKuZhLrru0oODRq8/DALvT8/KR0c+lS8xV40g3yg3Su2u7UitSItc6hGeQsUeo8t
 IXWfA2uqzDuJ+bcla2jKC55BWbJ7Z2x2YJevA32Qrfvwj2GI1c91q4+FmwrRSXmyrRsv
 x8kyBu0sC0Q22HTLVI9ogA31kN7Jm7m6+mI7q1SdzskId2g1ewrp1BpoiUAVihcpDVU+ vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 371fgc9npu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 01:53:37 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1226q8fH035142;
        Tue, 2 Mar 2021 01:53:36 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 371fgc9npn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 01:53:36 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1226qof4018640;
        Tue, 2 Mar 2021 06:53:35 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 36ydq8w0f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 06:53:34 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1226rXYD28311962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Mar 2021 06:53:33 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99EC6BE04F;
        Tue,  2 Mar 2021 06:53:33 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70749BE053;
        Tue,  2 Mar 2021 06:53:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.103.19])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  2 Mar 2021 06:53:27 +0000 (GMT)
Subject: Re: [PATCH] perf stat: improve readability of shadow stats
To:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210301172402.6794-1-changbin.du@gmail.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <6f110cc6-87a9-5e1f-87f5-eb62ce0ce951@linux.ibm.com>
Date:   Tue, 2 Mar 2021 12:23:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210301172402.6794-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_02:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/21 10:54 PM, Changbin Du wrote:
> This does follow two changes:
>   1) Select appropriate unit between K/M/G.
>   2) Use 'cpu-sec' instead of 'sec' to state this is not the wall-time.
> 
> $ sudo ./perf stat -a -- sleep 1
> 
> Before: Unit 'M' is selected even the number is very small.
>  Performance counter stats for 'system wide':
> 
>           4,003.06 msec cpu-clock                 #    3.998 CPUs utilized
>             16,179      context-switches          #    0.004 M/sec
>                161      cpu-migrations            #    0.040 K/sec
>              4,699      page-faults               #    0.001 M/sec
>      6,135,801,925      cycles                    #    1.533 GHz                      (83.21%)
>      5,783,308,491      stalled-cycles-frontend   #   94.26% frontend cycles idle     (83.21%)
>      4,543,694,050      stalled-cycles-backend    #   74.05% backend cycles idle      (66.49%)
>      4,720,130,587      instructions              #    0.77  insn per cycle
>                                                   #    1.23  stalled cycles per insn  (83.28%)
>        753,848,078      branches                  #  188.318 M/sec                    (83.61%)
>         37,457,747      branch-misses             #    4.97% of all branches          (83.48%)
> 
>        1.001283725 seconds time elapsed
> 
> After:
> $ sudo ./perf stat -a -- sleep 2
> 
>  Performance counter stats for 'system wide':
> 
>           8,003.20 msec cpu-clock                 #    3.998 CPUs utilized
>              9,768      context-switches          #    1.221 K/cpu-sec
>                164      cpu-migrations            #   20.492  /cpu-sec
>             74,146      page-faults               #    9.265 K/cpu-sec
>     19,008,796,806      cycles                    #    2.375 GHz                      (83.21%)
>     14,789,443,853      stalled-cycles-frontend   #   77.80% frontend cycles idle     (83.29%)
>     11,867,812,064      stalled-cycles-backend    #   62.43% backend cycles idle      (66.80%)
>      9,898,252,603      instructions              #    0.52  insn per cycle
>                                                   #    1.49  stalled cycles per insn  (83.41%)
>      2,063,251,998      branches                  #  257.803 M/cpu-sec                (83.41%)
>         86,941,704      branch-misses             #    4.21% of all branches          (83.30%)
> 
>        2.001743706 seconds time elapsed
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/util/stat-shadow.c | 13 +++++--------
>  tools/perf/util/units.c       | 22 ++++++++++++++++++++++
>  tools/perf/util/units.h       |  1 +
>  3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 6ccf21a72f06..786b5ef512d8 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -9,6 +9,7 @@
>  #include "expr.h"
>  #include "metricgroup.h"
>  #include "cgroup.h"
> +#include "units.h"
>  #include <linux/zalloc.h>
>  

>  /*
> @@ -1270,18 +1271,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
>  				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
>  	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
> -		char unit = 'M';
> +		char unit = ' ';
>  		char unit_buf[10];
>  
>  		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
> -
>  		if (total)
> -			ratio = 1000.0 * avg / total;
> -		if (ratio < 0.001) {
> -			ratio *= 1000;
> -			unit = 'K';
> -		}
> -		snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> +			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
> +
> +		snprintf(unit_buf, sizeof(unit_buf), "%c/cpu-sec", unit);
>  		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
>  	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
>  		print_smi_cost(config, cpu, out, st, &rsd);
> diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
> index a46762aec4c9..ac13b5ecde31 100644
> --- a/tools/perf/util/units.c
> +++ b/tools/perf/util/units.c
> @@ -55,6 +55,28 @@ unsigned long convert_unit(unsigned long value, char *unit)
>  	return value;
>  }
>

Hi Changbin,
      Since we are using added function `convert_unit_double` just in stat-shadow.c,
I think there is no need to add it in units.h, we can directly create static func inside `stat-shadow.c`itself.

Thanks,
Kajol Jain
  
> +double convert_unit_double(double value, char *unit)
> +{
> +	*unit = ' ';
> +
> +	if (value > 1000.0) {
> +		value /= 1000.0;
> +		*unit = 'K';
> +	}
> +
> +	if (value > 1000.0) {
> +		value /= 1000.0;
> +		*unit = 'M';
> +	}
> +
> +	if (value > 1000.0) {
> +		value /= 1000.0;
> +		*unit = 'G';
> +	}
> +
> +	return value;
> +}
> +
>  int unit_number__scnprintf(char *buf, size_t size, u64 n)
>  {
>  	char unit[4] = "BKMG";
> diff --git a/tools/perf/util/units.h b/tools/perf/util/units.h
> index 99263b6a23f7..b3ace67ac16f 100644
> --- a/tools/perf/util/units.h
> +++ b/tools/perf/util/units.h
> @@ -13,6 +13,7 @@ struct parse_tag {
>  unsigned long parse_tag_value(const char *str, struct parse_tag *tags);
>  
>  unsigned long convert_unit(unsigned long value, char *unit);
> +double convert_unit_double(double value, char *unit);
>  int unit_number__scnprintf(char *buf, size_t size, u64 n);
>  
>  #endif /* PERF_UNIT_H */
> 
