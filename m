Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D23B8EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhGAIi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:38:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235067AbhGAIi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:38:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1618WxrL167388;
        Thu, 1 Jul 2021 04:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R5yL6pTh7cUobdM+tI6gVHVO1q6wA8Pr5E4WwTo8bFo=;
 b=W324cAN9f3ZlFFrk6Ea6tz5hNJ62GalpC0B83qfl9GKpX5m+YvPkAmuCf3bKP01QMtdF
 oT/0bsyuODhd+g4XtsF8LGWuWwOKj8okNnXxUyhM1KIYv32yvM1qfi66UWS+ZCZ3OkpN
 bPwTlYiR5eXWy/uj/O91QXCeu7n9ka643HzQ5M0u0T1NPFfvmx9A5WLuiDbLzJr65to8
 fXB9gJjmCJgih4Aq8IsX6Ml5Qn6SIspT0jNcixSAFyERHjQKjnm61RPBWbunQEVRAic9
 aqJ1VqmPn9JEf3elkNZDRXC1Y8BfUu2WcSwnY4cDGnmndWPY/VK65d+0ufP/xytVR7Fx xw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39h5wdxuje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 04:36:17 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1618Vu22017540;
        Thu, 1 Jul 2021 08:36:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 39fv59rmc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 08:36:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1618aCjd14025156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 08:36:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1DED520E0;
        Thu,  1 Jul 2021 08:36:12 +0000 (GMT)
Received: from pomme.local (unknown [9.145.32.224])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 721CC520DE;
        Thu,  1 Jul 2021 08:36:12 +0000 (GMT)
Subject: Re: [PATCH v2] ppc64/numa: consider the max numa node for migratable
 LPAR
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210511073136.17795-1-ldufour@linux.ibm.com>
Message-ID: <dd5e73b1-bc65-dd4a-828c-314fc2eeea64@linux.ibm.com>
Date:   Thu, 1 Jul 2021 10:36:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210511073136.17795-1-ldufour@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KPp0LTgbVEREARSnRUtR1degv_KChC87
X-Proofpoint-GUID: KPp0LTgbVEREARSnRUtR1degv_KChC87
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_06:2021-06-30,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Do you mind taking this patch of 5.14?

Thanks,
Laurent.

Le 11/05/2021 à 09:31, Laurent Dufour a écrit :
> When a LPAR is migratable, we should consider the maximum possible NUMA
> node instead the number of NUMA node from the actual system.
> 
> The DT property 'ibm,current-associativity-domains' is defining the maximum
> number of nodes the LPAR can see when running on that box. But if the LPAR
> is being migrated on another box, it may seen up to the nodes defined by
> 'ibm,max-associativity-domains'. So if a LPAR is migratable, that value
> should be used.
> 
> Unfortunately, there is no easy way to know if a LPAR is migratable or
> not. The hypervisor is exporting the property 'ibm,migratable-partition' in
> the case it set to migrate partition, but that would not mean that the
> current partition is migratable.
> 
> Without this patch, when a LPAR is started on a 2 nodes box and then
> migrated to a 3 nodes box, the hypervisor may spread the LPAR's CPUs on the
> 3rd node. In that case if a CPU from that 3rd node is added to the LPAR, it
> will be wrongly assigned to the node because the kernel has been set to use
> up to 2 nodes (the configuration of the departure node). With this patch
> applies, the CPU is correctly added to the 3rd node.
> 
> Fixes: f9f130ff2ec9 ("powerpc/numa: Detect support for coregroup")
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
> V2: Address Srikar's comments
>   - Fix the commit message
>   - Use pr_info instead printk(KERN_INFO..)
> ---
>   arch/powerpc/mm/numa.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index f2bf98bdcea2..094a1076fd1f 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -893,7 +893,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>   static void __init find_possible_nodes(void)
>   {
>   	struct device_node *rtas;
> -	const __be32 *domains;
> +	const __be32 *domains = NULL;
>   	int prop_length, max_nodes;
>   	u32 i;
>   
> @@ -909,9 +909,14 @@ static void __init find_possible_nodes(void)
>   	 * it doesn't exist, then fallback on ibm,max-associativity-domains.
>   	 * Current denotes what the platform can support compared to max
>   	 * which denotes what the Hypervisor can support.
> +	 *
> +	 * If the LPAR is migratable, new nodes might be activated after a LPM,
> +	 * so we should consider the max number in that case.
>   	 */
> -	domains = of_get_property(rtas, "ibm,current-associativity-domains",
> -					&prop_length);
> +	if (!of_get_property(of_root, "ibm,migratable-partition", NULL))
> +		domains = of_get_property(rtas,
> +					  "ibm,current-associativity-domains",
> +					  &prop_length);
>   	if (!domains) {
>   		domains = of_get_property(rtas, "ibm,max-associativity-domains",
>   					&prop_length);
> @@ -920,6 +925,8 @@ static void __init find_possible_nodes(void)
>   	}
>   
>   	max_nodes = of_read_number(&domains[min_common_depth], 1);
> +	pr_info("Partition configured for %d NUMA nodes.\n", max_nodes);
> +
>   	for (i = 0; i < max_nodes; i++) {
>   		if (!node_possible(i))
>   			node_set(i, node_possible_map);
> 

