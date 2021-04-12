Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FAD35C880
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbhDLOSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:18:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237579AbhDLOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:18:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CE3Nof183803;
        Mon, 12 Apr 2021 10:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=t0nkKZ1tFc78oeNoAs6TRGwPCsk81OARjmNHFCq3Gds=;
 b=LIIxFjtgjHd5ao8VrEcKlCqs9Lb2BDu5unuwP2AlMJq3qu4ZAY6gYHmvPWBFqlvwpweb
 p+j/isSdxuU+fYvFW4xzj5VI37RNr/JSusa6SSfJ2zXThqhNYbbvNv3TmuPj7kiEh+RU
 piQ6SKW1TOAUayJN0IRd8Ht8iYyYoi71r79nxRbOFN0unHU9crRzYs3LZBKSlrrLWiGr
 I9YzwEW2piKktyJspMpBBecc0Py3gk4yYz8D6IMpPIJtjmJXzzSharRCLf/48iuRMf23
 R1UHWHldOXx5IEbKEq91+NwhTUns93AkCVw4VLKBNBD5kW4k9qBpZpLv4nfz4ss5MGBi wA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37usn5xhqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 10:17:57 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CECu0q020523;
        Mon, 12 Apr 2021 14:17:57 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 37u3n8vvdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 14:17:57 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CEHtsj58327366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 14:17:55 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D639E6A04F;
        Mon, 12 Apr 2021 14:17:55 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F12E6A047;
        Mon, 12 Apr 2021 14:17:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.91])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 14:17:52 +0000 (GMT)
Subject: Re: [PATCH -next] powerpc/perf: Make symbol 'isa207_pmu_format_attr'
 static
To:     Bixuan Cui <cuibixuan@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210409090119.59444-1-cuibixuan@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <55248414-7fde-d156-ca0b-3f2d867d7861@linux.ibm.com>
Date:   Mon, 12 Apr 2021 19:47:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210409090119.59444-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dTT67JJJ8bj9V22NmDJVRGX7DdcGLoHB
X-Proofpoint-ORIG-GUID: dTT67JJJ8bj9V22NmDJVRGX7DdcGLoHB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_10:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/21 2:31 PM, Bixuan Cui wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/perf/isa207-common.c:24:18: warning:
>  symbol 'isa207_pmu_format_attr' was not declared. Should it be static?
> 
> This symbol is not used outside of isa207-common.c, so this
> commit marks it static.

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  arch/powerpc/perf/isa207-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
> index e4f577da33d8..487f9e914b5c 100644
> --- a/arch/powerpc/perf/isa207-common.c
> +++ b/arch/powerpc/perf/isa207-common.c
> @@ -21,7 +21,7 @@ PMU_FORMAT_ATTR(thresh_stop,	"config:32-35");
>  PMU_FORMAT_ATTR(thresh_start,	"config:36-39");
>  PMU_FORMAT_ATTR(thresh_cmp,	"config:40-49");
>  
> -struct attribute *isa207_pmu_format_attr[] = {
> +static struct attribute *isa207_pmu_format_attr[] = {
>  	&format_attr_event.attr,
>  	&format_attr_pmcxsel.attr,
>  	&format_attr_mark.attr,
> 
