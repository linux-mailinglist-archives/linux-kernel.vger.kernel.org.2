Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E793CD64B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbhGSNYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:24:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237189AbhGSNYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:24:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JE3XUj134066;
        Mon, 19 Jul 2021 10:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=K/qph8xAPs+/unSVzbU2OaBjL7zxFBbX5wIrfrydwSY=;
 b=XLqCNBxXD7UjO+Ygm2kv3fO1zb8MtgSEUBDiYO/C+AoMqdOwsZFisAucGuSkcbsZ8rbB
 Jg8/7nri9U8pC6flbdIQw7dyU0ldRi8Xy1uYtXOYdlSx1r6hhXMFNA/k/LZwjmaSjutM
 6aWs1WpOs+tItQoVla3VgsxomxC9Xd/well7uHu6WlhIvS7Yon1JA/KnSOVx1mQLxTij
 EgWNnIsf6WYZAmRXzPbkMAwutmfjNzyL5s7yKtfLZJzhevb0hAVEkMC1nDU++fuRMQp5
 +pFqS4C0rYfRgNAUPBcRKWH/5EybG6pEDP9eC6KLlIcutUlAnPCVUUlR24E1tITZ47/d BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wa3h1vce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 10:04:40 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JE3nt1136584;
        Mon, 19 Jul 2021 10:04:39 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wa3h1vab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 10:04:39 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JDDY9g024395;
        Mon, 19 Jul 2021 14:04:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 39upu88cw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 14:04:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JE2CLr22937888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 14:02:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B364AE057;
        Mon, 19 Jul 2021 14:04:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D92AEAE05A;
        Mon, 19 Jul 2021 14:04:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.62.205])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 14:04:33 +0000 (GMT)
Subject: Re: [PATCH v5 03/11] powerpc/pseries/iommu: Add
 iommu_pseries_alloc_table() helper
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210716082755.428187-1-leobras.c@gmail.com>
 <20210716082755.428187-4-leobras.c@gmail.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <8110756f-a41f-3ba1-d7bc-af15630c4fbc@linux.ibm.com>
Date:   Mon, 19 Jul 2021 16:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716082755.428187-4-leobras.c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hmEZvi-D7tjyR4oDIrYgvtF1RswvzWsC
X-Proofpoint-ORIG-GUID: zI9xunaWU2iMx6Ea44WrVkNBPaRfpz9X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_05:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107190082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/07/2021 10:27, Leonardo Bras wrote:
> Creates a helper to allow allocating a new iommu_table without the need
> to reallocate the iommu_group.
> 
> This will be helpful for replacing the iommu_table for the new DMA window,
> after we remove the old one with iommu_tce_table_put().
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   arch/powerpc/platforms/pseries/iommu.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index b1b8d12bab39..33d82865d6e6 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -53,28 +53,31 @@ enum {
>   	DDW_EXT_QUERY_OUT_SIZE = 2
>   };
>   
> -static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> +static struct iommu_table *iommu_pseries_alloc_table(int node)
>   {
> -	struct iommu_table_group *table_group;
>   	struct iommu_table *tbl;
>   
> -	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
> -			   node);
> -	if (!table_group)
> -		return NULL;
> -
>   	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
>   	if (!tbl)
> -		goto free_group;
> +		return NULL;
>   
>   	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
>   	kref_init(&tbl->it_kref);
> +	return tbl;
> +}
>   
> -	table_group->tables[0] = tbl;
> +static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> +{
> +	struct iommu_table_group *table_group;
> +
> +	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL, node);
> +	if (!table_group)
> +		return NULL;
>   
> -	return table_group;
> +	table_group->tables[0] = iommu_pseries_alloc_table(node);
> +	if (table_group->tables[0])
> +		return table_group;


Nitpick: for readability, we'd usually expect the error path to be 
detected with the if statement and keep going on the good path, and here 
the code does the opposite. No big deal though, so

Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   
> -free_group:
>   	kfree(table_group);
>   	return NULL;
>   }
> 
