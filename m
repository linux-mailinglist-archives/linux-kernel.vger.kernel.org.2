Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAEA41D80E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350152AbhI3KuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:50:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349873AbhI3KuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:50:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UAGpC9016386;
        Thu, 30 Sep 2021 06:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kOD3bvXUnMe6stz9qu+HqBAWNlQvhO2QXS/xAS45MPo=;
 b=f1z+bbfKgf05Hk3UqatLcqUVgy5Mm3HNPOx5duMizmHK/PnEYIUyGTW2Q49qKHNqul11
 me3nJZgDZwFkxDcHH9o7jotfTki0j5O/ZiEpcsQ0+/yVhsjLRB5xuZGog3pHuCf4lQ4l
 /VEMxgh2SW+qKT7jA3vd8AXZlB/RqFHYs3g3lbHIcA/KzNX7YYT8U7KFn54tmQMf4qcv
 USq8PJSMNslsWlhOuzU67c6lvmu9yCIek0kPkYuYzR2ZWPC2/BVkbrZTvNdULLe1jYUf
 5WE3ztlccOeBc0tg9VHLXVYt0rf5xY1/peryQpYWdnY6LWHBykPTnQFagIeGpa1iwZtt TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd9bqkhnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 06:48:22 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18U9RHcg022663;
        Thu, 30 Sep 2021 06:48:22 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd9bqkhms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 06:48:21 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18UAlS3S015760;
        Thu, 30 Sep 2021 10:48:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3bc11f4qem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 10:48:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18UAhBpD55640382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 10:43:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D6244C08C;
        Thu, 30 Sep 2021 10:48:16 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A927E4C082;
        Thu, 30 Sep 2021 10:48:14 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.93.90])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Sep 2021 10:48:14 +0000 (GMT)
Subject: Re: [PATCH 1/2] perf script: Fix PERF_SAMPLE_WEIGHT_STRUCT support
To:     kan.liang@linux.intel.com, acme@kernel.org, jolsa@redhat.com,
        jmario@redhat.com, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com
References: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <43867afa-e8da-a932-f87b-5ac109057929@linux.ibm.com>
Date:   Thu, 30 Sep 2021 16:18:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1632929894-102778-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pssGj_6p2g5LvM-_NpwxgUCYi_Um6Q9K
X-Proofpoint-ORIG-GUID: Wl1fclskAAaspHhEEKBZny7XxwXfoXhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_03,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/21 9:08 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> -F weight in perf script is broken.
> 
>   # ./perf mem record
>   # ./perf script -F weight
>   Samples for 'dummy:HG' event do not have WEIGHT attribute set. Cannot
> print 'weight' field.

Hi Kan,
    This issue can also be reproduce in powerpc box.
Given patch fix the issue.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
> The sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
> PERF_SAMPLE_WEIGHT sample type. They share the same space, weight. The
> lower 32 bits are exactly the same for both sample type. The higher 32
> bits may be different for different architecture. For a new kernel on
> x86, the PERF_SAMPLE_WEIGHT_STRUCT is used. For an old kernel or other
> ARCHs, the PERF_SAMPLE_WEIGHT is used.
> 
> With -F weight, current perf script will only check the input string
> "weight" with the PERF_SAMPLE_WEIGHT sample type. Because the commit
> ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT") didn't
> update the PERF_SAMPLE_WEIGHT_STRUCT sample type for perf script. For a
> new kernel on x86, the check fails.
> 
> Use PERF_SAMPLE_WEIGHT_TYPE, which supports both sample types, to
> replace PERF_SAMPLE_WEIGHT.
> 
> Reported-by: Joe Mario <jmario@redhat.com>
> Fixes: ea8d0ed6eae3 ("perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 6211d0b..9f62ac6 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -459,7 +459,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(WEIGHT) &&
> -	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT", PERF_OUTPUT_WEIGHT))
> +	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT))
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(SYM) &&
> 
