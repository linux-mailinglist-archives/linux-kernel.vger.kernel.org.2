Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37152378E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350695AbhEJNFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:05:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351036AbhEJNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:02:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ACY4lv035857;
        Mon, 10 May 2021 09:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JKevJ24GbocfghegZ4JHnukiJZdjdLq2k563NxcWWeI=;
 b=tCvMjw3PSaPSTkw09rCM69rRXfzCUvA1LWRBdH7TOxcRJX7s0Z62yGPzMCjZFSXDkugs
 XRLX4A+9OdowwaxniXBOiE7/Ni/qO4YD1OX8BHVgJIbbqCE+3IOvRvDJNCVGrCIJ06pi
 Ir1e1PZmBLZMUcmH+MSAN5JOBbSRVGPpUfSD31ODwNxC5c79NCar/cxDqhLSFrIvp/kb
 7sHIeoo+ytaqxLDTZ7Eicwx5p+GDh7e/8V+05xS8IFBobe13LGedYW3b0SLx938oXQGJ
 daDXit8oB+FwqlypH9h2uQSqxQf98WQaCxM1lg7RETw8BfwtGDeFXZtP5j2KtqWohpcu jw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38f30bmgrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 09:01:10 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14ACimxU009453;
        Mon, 10 May 2021 13:01:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 38ef37ganr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 May 2021 13:01:05 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14AD12Lj30671318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 13:01:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FDF8A4054;
        Mon, 10 May 2021 13:01:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBA3FA4065;
        Mon, 10 May 2021 13:01:01 +0000 (GMT)
Received: from pomme.local (unknown [9.145.174.43])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 May 2021 13:01:01 +0000 (GMT)
Subject: Re: [PATCH] ppc64/numa: consider the max numa node for migratable
 LPAR
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210429181901.17674-1-ldufour@linux.ibm.com>
 <20210510102107.GR2633526@linux.vnet.ibm.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Message-ID: <97b19b51-783c-ba64-bb21-5ebedeebc4f0@linux.ibm.com>
Date:   Mon, 10 May 2021 15:01:01 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210510102107.GR2633526@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wKE8B6PLpZTCzA5MjXwJNq6MDO5xMmUf
X-Proofpoint-ORIG-GUID: wKE8B6PLpZTCzA5MjXwJNq6MDO5xMmUf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_07:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/05/2021 à 12:21, Srikar Dronamraju a écrit :
> * Laurent Dufour <ldufour@linux.ibm.com> [2021-04-29 20:19:01]:
> 
>> When a LPAR is migratable, we should consider the maximum possible NUMA
>> node instead the number of NUMA node from the actual system.
>>
>> The DT property 'ibm,current-associativity-domains' is defining the maximum
>> number of nodes the LPAR can see when running on that box. But if the LPAR
>> is being migrated on another box, it may seen up to the nodes defined by
>> 'ibm,max-associativity-domains'. So if a LPAR is migratable, that value
>> should be used.
>>
>> Unfortunately, there is no easy way to know if a LPAR is migratable or
>> not. The hypervisor is exporting the property 'ibm,migratable-partition' in
>> the case it set to migrate partition, but that would not mean that the
>> current partition is migratable.
>>
>> Without that patch, when a LPAR is started on a 2 nodes box and then
>> migrated to a 3 nodes box, the hypervisor may spread the LPAR's CPUs on the
>> 3rd node. In that case if a CPU from that 3rd node is added to the LPAR, it
>> will be wrongly assigned to the node because the kernel has been set to use
> 
> 
>> up to 2 nodes (the configuration of the departure node). With that patch
>> applies, the CPU is correctly added to the 3rd node.
> 
> You probably meant, "With this patch applied"
> 
> Also you may want to add a fixes tag:

I'll fix "that" and add the fixes tag.

>> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>> ---
>>   arch/powerpc/mm/numa.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index f2bf98bdcea2..673fa6e47850 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -893,7 +893,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>>   static void __init find_possible_nodes(void)
>>   {
>>   	struct device_node *rtas;
>> -	const __be32 *domains;
>> +	const __be32 *domains = NULL;
>>   	int prop_length, max_nodes;
>>   	u32 i;
>>
>> @@ -909,9 +909,14 @@ static void __init find_possible_nodes(void)
>>   	 * it doesn't exist, then fallback on ibm,max-associativity-domains.
>>   	 * Current denotes what the platform can support compared to max
>>   	 * which denotes what the Hypervisor can support.
>> +	 *
>> +	 * If the LPAR is migratable, new nodes might be activated after a LPM,
>> +	 * so we should consider the max number in that case.
>>   	 */
>> -	domains = of_get_property(rtas, "ibm,current-associativity-domains",
>> -					&prop_length);
>> +	if (!of_get_property(of_root, "ibm,migratable-partition", NULL))
>> +		domains = of_get_property(rtas,
>> +					  "ibm,current-associativity-domains",
>> +					  &prop_length);
>>   	if (!domains) {
>>   		domains = of_get_property(rtas, "ibm,max-associativity-domains",
>>   					&prop_length);
>> @@ -920,6 +925,9 @@ static void __init find_possible_nodes(void)
>>   	}
>>
>>   	max_nodes = of_read_number(&domains[min_common_depth], 1);
>> +	printk(KERN_INFO "Partition configured for %d NUMA nodes.\n",
>> +	       max_nodes);
>> +
> 
> Another nit:
> you may want to make this pr_info instead of printk

Sure !

>>   	for (i = 0; i < max_nodes; i++) {
>>   		if (!node_possible(i))
>>   			node_set(i, node_possible_map);
>> -- 
>> 2.31.1
>>
> 
> Otherwise looks good to me.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks Srikar, I'll add you review tag in the v2.


