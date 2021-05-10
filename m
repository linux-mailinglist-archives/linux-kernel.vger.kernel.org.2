Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA643378127
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhEJKWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:22:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230093AbhEJKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:22:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14AA313L149563;
        Mon, 10 May 2021 06:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=bJ7JlYWgCAAWacu3XEVi5wW4kqb+nakB3bWs0fbZcZM=;
 b=SXcnNda0ODB9FQQEzvLHYrN9lIURTQCtFODZFMhfIUPgRLtFxKWfEynex/VgxyzdxzR9
 oj/4UVrLaAEVOl8ixflqLyJtS2NARUitHNJbPG8BEbPGQtSkmX+Z2drhu3PEThTKymvb
 HTCjHBH6k4loLB21sV823C96JUQWGloB2i5c8tzbYu/nhghGM5D9z2lLg9J/b+fG2Hf2
 fvKSQcuzKlF5X2ddzW8iVQN/KM1o1naAcAQAtB432gCLwlU6mh3O/V1YEhBP9TpTuh0m
 8R6MKThJcf4C1DjQITB2EYXIvnc1j+9LLo0W+ULf1yachA0ytk0itwuPz2PdKpheqqmp xg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38f0g0vmfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 06:21:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14AAI1qI007790;
        Mon, 10 May 2021 10:21:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj988vdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 10:21:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14AALANF45154668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 10:21:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19C87A4060;
        Mon, 10 May 2021 10:21:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FB81A4067;
        Mon, 10 May 2021 10:21:08 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 10 May 2021 10:21:08 +0000 (GMT)
Date:   Mon, 10 May 2021 15:51:07 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64/numa: consider the max numa node for migratable
 LPAR
Message-ID: <20210510102107.GR2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210429181901.17674-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20210429181901.17674-1-ldufour@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7e6s0DcwPc3rkBodv8LanQ15Q6rfbf6Q
X-Proofpoint-GUID: 7e6s0DcwPc3rkBodv8LanQ15Q6rfbf6Q
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_06:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Laurent Dufour <ldufour@linux.ibm.com> [2021-04-29 20:19:01]:

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
> Without that patch, when a LPAR is started on a 2 nodes box and then
> migrated to a 3 nodes box, the hypervisor may spread the LPAR's CPUs on the
> 3rd node. In that case if a CPU from that 3rd node is added to the LPAR, it
> will be wrongly assigned to the node because the kernel has been set to use


> up to 2 nodes (the configuration of the departure node). With that patch
> applies, the CPU is correctly added to the 3rd node.

You probably meant, "With this patch applied"

Also you may want to add a fixes tag:

> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index f2bf98bdcea2..673fa6e47850 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -893,7 +893,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>  static void __init find_possible_nodes(void)
>  {
>  	struct device_node *rtas;
> -	const __be32 *domains;
> +	const __be32 *domains = NULL;
>  	int prop_length, max_nodes;
>  	u32 i;
> 
> @@ -909,9 +909,14 @@ static void __init find_possible_nodes(void)
>  	 * it doesn't exist, then fallback on ibm,max-associativity-domains.
>  	 * Current denotes what the platform can support compared to max
>  	 * which denotes what the Hypervisor can support.
> +	 *
> +	 * If the LPAR is migratable, new nodes might be activated after a LPM,
> +	 * so we should consider the max number in that case.
>  	 */
> -	domains = of_get_property(rtas, "ibm,current-associativity-domains",
> -					&prop_length);
> +	if (!of_get_property(of_root, "ibm,migratable-partition", NULL))
> +		domains = of_get_property(rtas,
> +					  "ibm,current-associativity-domains",
> +					  &prop_length);
>  	if (!domains) {
>  		domains = of_get_property(rtas, "ibm,max-associativity-domains",
>  					&prop_length);
> @@ -920,6 +925,9 @@ static void __init find_possible_nodes(void)
>  	}
> 
>  	max_nodes = of_read_number(&domains[min_common_depth], 1);
> +	printk(KERN_INFO "Partition configured for %d NUMA nodes.\n",
> +	       max_nodes);
> +

Another nit:
you may want to make this pr_info instead of printk

>  	for (i = 0; i < max_nodes; i++) {
>  		if (!node_possible(i))
>  			node_set(i, node_possible_map);
> -- 
> 2.31.1
> 

Otherwise looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
