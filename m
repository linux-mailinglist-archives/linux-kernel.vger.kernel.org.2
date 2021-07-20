Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0743D00F6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhGTRLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:11:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231551AbhGTRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:11:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KHYCAk179163;
        Tue, 20 Jul 2021 13:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9bnhQvRLYGoNSB93faO/jHiSUEYYV8/oFNbROn61XjY=;
 b=S3kkrlpQF5Z5mpi2/4xHhRsKrgtlxVHH33uh8ejGDDfYNuXgq08zXwT/g22DjFKIDm0a
 suavRRnhHiktPFxW0evwaKWQo4BQusShj2u2X+GoEN6EeEChgaLvUw0DDZP1xCF4U971
 1MZr+qGAlxDvQjqfkiBD69P24cPKwlw/Zi0z/f9GOh/hT6gP5Ac+8Vl+ZChU5u6NWFIT
 fGFy5SJOyvXdSWdl35mHrzLKkoOrqJC6hMcYLs4wmgrJbUMVzsWyIwJuiVLmC3rbazKX
 8U10/tGfwuSt6KzcvR2WGsNHY7nr7OPpf6NXWeh9vZu4wwETaivQljnvJkKmLeAafK2/ Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39x2aehqfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 13:51:29 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16KHYGPX179453;
        Tue, 20 Jul 2021 13:51:28 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39x2aehqf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 13:51:28 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16KHgq86020996;
        Tue, 20 Jul 2021 17:51:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 39vng71364-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 17:51:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16KHpOEm19464602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jul 2021 17:51:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6423F4C04A;
        Tue, 20 Jul 2021 17:51:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04DD44C04E;
        Tue, 20 Jul 2021 17:51:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.178.12])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Jul 2021 17:51:23 +0000 (GMT)
Subject: Re: [PATCH v5 08/11] powerpc/pseries/iommu: Update
 remove_dma_window() to accept property name
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
 <20210716082755.428187-9-leobras.c@gmail.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <8dbd08fb-375c-9f21-f8ab-bec163b157bf@linux.ibm.com>
Date:   Tue, 20 Jul 2021 19:51:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716082755.428187-9-leobras.c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QCDqk0UFMkiIT9ieWu8IjsMD4GxkBiwI
X-Proofpoint-ORIG-GUID: -URziJyoi3VgPwzsYqhJlYsCz5PR1_Rb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_12:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107200115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/07/2021 10:27, Leonardo Bras wrote:
> Update remove_dma_window() so it can be used to remove DDW with a given
> property name.
> 
> This enables the creation of new property names for DDW, so we can
> have different usage for it, like indirect mapping.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   arch/powerpc/platforms/pseries/iommu.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 108c3dcca686..17c6f4706e76 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -830,31 +830,32 @@ static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
>   			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
>   }
>   
> -static void remove_ddw(struct device_node *np, bool remove_prop)
> +static int remove_ddw(struct device_node *np, bool remove_prop, const char *win_name)
>   {


Why switch to returning an int? None of the callers check it.

   Fred


>   	struct property *win;
>   	u32 ddw_avail[DDW_APPLICABLE_SIZE];
>   	int ret = 0;
>   
> +	win = of_find_property(np, win_name, NULL);
> +	if (!win)
> +		return -EINVAL;
> +
>   	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
>   					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
>   	if (ret)
> -		return;
> -
> -	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
> -	if (!win)
> -		return;
> +		return 0;
>   
>   	if (win->length >= sizeof(struct dynamic_dma_window_prop))
>   		remove_dma_window(np, ddw_avail, win);
>   
>   	if (!remove_prop)
> -		return;
> +		return 0;
>   
>   	ret = of_remove_property(np, win);
>   	if (ret)
>   		pr_warn("%pOF: failed to remove direct window property: %d\n",
>   			np, ret);
> +	return 0;
>   }
>   
>   static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
> @@ -907,7 +908,7 @@ static int find_existing_ddw_windows(void)
>   	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
>   		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
>   		if (!direct64 || len < sizeof(*direct64)) {
> -			remove_ddw(pdn, true);
> +			remove_ddw(pdn, true, DIRECT64_PROPNAME);
>   			continue;
>   		}
>   
> @@ -1382,7 +1383,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   	kfree(win64);
>   
>   out_remove_win:
> -	remove_ddw(pdn, true);
> +	remove_ddw(pdn, true, DIRECT64_PROPNAME);
>   
>   out_failed:
>   	if (default_win_removed)
> @@ -1547,7 +1548,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
>   		 * we have to remove the property when releasing
>   		 * the device node.
>   		 */
> -		remove_ddw(np, false);
> +		remove_ddw(np, false, DIRECT64_PROPNAME);
>   		if (pci && pci->table_group)
>   			iommu_pseries_free_group(pci->table_group,
>   					np->full_name);
> 
