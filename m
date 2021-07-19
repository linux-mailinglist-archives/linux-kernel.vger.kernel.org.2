Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4128D3CD65C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbhGSNe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:34:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239523AbhGSNe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:34:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JE4RvH019531;
        Mon, 19 Jul 2021 10:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wrNzt1WBw4y/MVelaIxzrQvPfFZ+JaBY8YERVGr24Pk=;
 b=Br7qR/8x+c0LNAisWax8FYApxqSj/n9kFcffKrBgEkimya4gsfU/QhqcJlFXfmd1b4li
 0M20bp2NKKXz9bOW4xMFG/ZZsm+38YT0HkQ3M63j1cB0l6KQzTtMizH8oUCUutG+1NpD
 Lh8EDH+a1yVzSHanGZD9lxEhXX1fDqKFgPvfGP+cAqDwmGemR+x/jMO1hfhWJGOJ4GEx
 fwO0eLPoLAyTn/AAObAl+aDht4QtZm1Mo5fzyjEu0tCDUzp9sozhnJWrwtnrYOSQ+7hI
 zO9Va0l52w+e1HqrVXbWcffqI+5d4cNf4dDBN2Kc2kTrN5ozIbTn7N4PWgKujB5TmM/K sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wadbhqqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 10:14:52 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16JE54hM024404;
        Mon, 19 Jul 2021 10:14:51 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39wadbhqnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 10:14:51 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16JDDroP008583;
        Mon, 19 Jul 2021 14:14:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 39upu88d1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 14:14:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16JEEjBb23396638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 14:14:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4882DAE057;
        Mon, 19 Jul 2021 14:14:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6615AE059;
        Mon, 19 Jul 2021 14:14:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.62.205])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jul 2021 14:14:44 +0000 (GMT)
Subject: Re: [PATCH v5 04/11] powerpc/pseries/iommu: Add ddw_list_new_entry()
 helper
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
 <20210716082755.428187-5-leobras.c@gmail.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <ae8fe44e-24c1-9d5f-70f9-96098167170a@linux.ibm.com>
Date:   Mon, 19 Jul 2021 16:14:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716082755.428187-5-leobras.c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J-EzlINOzKb0RHd-jVPdEm_skdQJOdDr
X-Proofpoint-ORIG-GUID: vZD-PRUnaf3PTTLrhdipL06pM5iJbcqk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_05:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/07/2021 10:27, Leonardo Bras wrote:
> There are two functions creating direct_window_list entries in a
> similar way, so create a ddw_list_new_entry() to avoid duplicity and
> simplify those functions.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

LGTM
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   arch/powerpc/platforms/pseries/iommu.c | 32 +++++++++++++++++---------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 33d82865d6e6..712d1667144a 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -874,6 +874,21 @@ static u64 find_existing_ddw(struct device_node *pdn, int *window_shift)
>   	return dma_addr;
>   }
>   
> +static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
> +						const struct dynamic_dma_window_prop *dma64)
> +{
> +	struct direct_window *window;
> +
> +	window = kzalloc(sizeof(*window), GFP_KERNEL);
> +	if (!window)
> +		return NULL;
> +
> +	window->device = pdn;
> +	window->prop = dma64;
> +
> +	return window;
> +}
> +
>   static int find_existing_ddw_windows(void)
>   {
>   	int len;
> @@ -886,18 +901,15 @@ static int find_existing_ddw_windows(void)
>   
>   	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
>   		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
> -		if (!direct64)
> -			continue;
> -
> -		window = kzalloc(sizeof(*window), GFP_KERNEL);
> -		if (!window || len < sizeof(struct dynamic_dma_window_prop)) {
> -			kfree(window);
> +		if (!direct64 || len < sizeof(*direct64)) {
>   			remove_ddw(pdn, true);
>   			continue;
>   		}
>   
> -		window->device = pdn;
> -		window->prop = direct64;
> +		window = ddw_list_new_entry(pdn, direct64);
> +		if (!window)
> +			break;
> +
>   		spin_lock(&direct_window_list_lock);
>   		list_add(&window->list, &direct_window_list);
>   		spin_unlock(&direct_window_list_lock);
> @@ -1307,7 +1319,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
>   		  create.liobn, dn);
>   
> -	window = kzalloc(sizeof(*window), GFP_KERNEL);
> +	window = ddw_list_new_entry(pdn, ddwprop);
>   	if (!window)
>   		goto out_clear_window;
>   
> @@ -1326,8 +1338,6 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   		goto out_free_window;
>   	}
>   
> -	window->device = pdn;
> -	window->prop = ddwprop;
>   	spin_lock(&direct_window_list_lock);
>   	list_add(&window->list, &direct_window_list);
>   	spin_unlock(&direct_window_list_lock);
> 
