Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FAB4213EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhJDQWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:22:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236773AbhJDQWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:22:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194G1hPr019235;
        Mon, 4 Oct 2021 12:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8mEx5a8kxg3IoTWi18BowCAvWWuK7NgNGuxSUB31DL4=;
 b=dhTcbDEYYhXVs/Zf/JRoOWEZmnJ2AOIPALxDIc/FXxPUyfqRJi6caxEdFcOx2ynUOBBC
 9uBJ3xpzfE5xgNl8LI7DyUlCsisUjNC4Wb8puj2KxOtBLbSj2a2xmlKF62v8CHxQfP2T
 B2fxOXtAjZtnmJp+ssgKjj5K1gmtLA5idiIiU7KrDpqlOX6I/SB/4CZMm0/b2ko2n8EV
 Hje6PsiRR86DS21DFC8c0fvx4fkl2T0ub/ehzKUwIJfniLn/+RgN7p0W53+4iXO58i9/
 YTydb8tZOg9D4MsZoTcbt/8fyM1rb7lsv8c2O6ix7tz1nfPYI7XfnYgmpAQ8AKtx05Iq Lg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bg4s98fwq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 12:20:43 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194G2VqS027596;
        Mon, 4 Oct 2021 16:06:47 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3bef29fwe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 16:06:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194G6hal5243392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 16:06:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E27DEAE073;
        Mon,  4 Oct 2021 16:06:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8CFEAE06A;
        Mon,  4 Oct 2021 16:06:40 +0000 (GMT)
Received: from [9.43.47.122] (unknown [9.43.47.122])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 16:06:40 +0000 (GMT)
Message-ID: <f13e218e-4e38-4076-672f-d555d7abfc02@linux.ibm.com>
Date:   Mon, 4 Oct 2021 21:36:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 3/3] powerpc: Set crashkernel offset to mid of RMA region
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>, mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        Abdul haleem <abdhalee@linux.vnet.ibm.com>
References: <20211004151142.256251-1-sourabhjain@linux.ibm.com>
 <20211004151142.256251-4-sourabhjain@linux.ibm.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20211004151142.256251-4-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 61JBjjd8jZRKX-tCbnGeSiqOHzgJ8QbI
X-Proofpoint-ORIG-GUID: 61JBjjd8jZRKX-tCbnGeSiqOHzgJ8QbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 20:41, Sourabh Jain wrote:
> On large config LPARs (having 192 and more cores), Linux fails to boot
> due to insufficient memory in the first memory block. It is due to the
> reserve crashkernel area starts at 128MB offset by default and which
> doesn't leave enough space in the first memory block to accommodate
> memory for other essential system resources.
> 
> Given that the RMA region size can be 512MB or more, setting the
> crashkernel offset to mid of RMA size will leave enough space to
> kernel to allocate memory for other system resources in the first
> memory block.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Reported-and-tested-by: Abdul haleem <abdhalee@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kernel/rtas.c |  3 +++
>   arch/powerpc/kexec/core.c  | 13 +++++++++----
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index ff80bbad22a5..ce5e62bb4d8e 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -1235,6 +1235,9 @@ int __init early_init_dt_scan_rtas(unsigned long node,
>   	entryp = of_get_flat_dt_prop(node, "linux,rtas-entry", NULL);
>   	sizep  = of_get_flat_dt_prop(node, "rtas-size", NULL);
>   
> +	if (of_get_flat_dt_prop(node, "ibm,hypertas-functions", NULL))
> +		powerpc_firmware_features |= FW_FEATURE_LPAR;
> +

The equivalent check that we currently do more than checking 
ibm,hypertas-functions.

	if (!strcmp(uname, "rtas") || !strcmp(uname, "rtas@0")) {
		prop = of_get_flat_dt_prop(node, "ibm,hypertas-functions",
					   &len);
		if (prop) {
			powerpc_firmware_features |= FW_FEATURE_LPAR;
			fw_hypertas_feature_init(prop, len);
		}


also do we expect other firmware features to be set along with 
FW_FEATURE_LPAR?

>   	if (basep && entryp && sizep) {
>   		rtas.base = *basep;
>   		rtas.entry = *entryp;
> diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
> index 48525e8b5730..f69cf3e370ec 100644
> --- a/arch/powerpc/kexec/core.c
> +++ b/arch/powerpc/kexec/core.c
> @@ -147,11 +147,16 @@ void __init reserve_crashkernel(void)
>   	if (!crashk_res.start) {
>   #ifdef CONFIG_PPC64
>   		/*
> -		 * On 64bit we split the RMO in half but cap it at half of
> -		 * a small SLB (128MB) since the crash kernel needs to place
> -		 * itself and some stacks to be in the first segment.
> +		 * crash kernel needs to placed in the first segment. On LPAR
> +		 * setting crash kernel start to mid of RMA size (512MB or more)
> +		 * would help primary kernel to boot properly on large config
> +		 * LPAR (with core count 192 or more) and for the reset keep
> +		 * cap the crash kernel start at 128MB offse.
>   		 */
> -		crashk_res.start = min(0x8000000ULL, (ppc64_rma_size / 2));
> +		if (firmware_has_feature(FW_FEATURE_LPAR))
> +			crashk_res.start = ppc64_rma_size / 2;
> +		else
> +			crashk_res.start = min(0x8000000ULL, (ppc64_rma_size / 2));
>   #else
>   		crashk_res.start = KDUMP_KERNELBASE;
>   #endif
> 

