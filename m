Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61F93130DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhBHLah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:30:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232970AbhBHLOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:14:51 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 118B2Wrr091338;
        Mon, 8 Feb 2021 06:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CYhf9PMTw1CrwCGAo4Ig5FyKzIrxgCtIzPptnJTdg28=;
 b=r/0xi4LF+ZU5ea3VokLk2uWSNjL2cftsxT1J+X/DJEgNkqpalQmZQrBLQnKjnDj2zRT9
 lDFc14s6LparEO/92SSO/zAyVOndUpA936e1AHNzq7ibuMvMOJF4SuW7covjBlj26UQ0
 pD8kNH+EpCkWqAQi8e4xi1m0TxQu6gfsIsOVSk1zrDaJL1j40E0oWfs2yo1ILRgt8w+B
 6Bo7vQXrUmI7iQfsSjWrm68L2i5iXexjM3krEgYRDIVaXGilb6iMQhulxJabE8uefB0S
 s1GP/crJ732dfzKxbWq6sBP5QYVeBdv5PvYYlVmrqt7aZoxlzpmeZyVxXwTzm0C3GQ1e SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36k3strxht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 06:13:23 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 118B45aQ103381;
        Mon, 8 Feb 2021 06:13:23 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36k3strxgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 06:13:23 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 118B3frL031693;
        Mon, 8 Feb 2021 11:13:20 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 36hjr810ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 11:13:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 118BDHTu22675918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Feb 2021 11:13:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89E694204D;
        Mon,  8 Feb 2021 11:13:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F26DE42049;
        Mon,  8 Feb 2021 11:13:14 +0000 (GMT)
Received: from [9.199.47.177] (unknown [9.199.47.177])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Feb 2021 11:13:14 +0000 (GMT)
Subject: Re: [PATCH v2] powerpc/uprobes: Validation for prefixed instruction
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     mpe@ellerman.id.au, oleg@redhat.com, rostedt@goodmis.org,
        paulus@samba.org, jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20210204104703.273429-1-ravi.bangoria@linux.ibm.com>
 <20210204130821.GK210@DESKTOP-TDPLP67.localdomain>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <b8f629b7-ea04-a77a-10bb-dd4bdcd231f7@linux.ibm.com>
Date:   Mon, 8 Feb 2021 16:43:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204130821.GK210@DESKTOP-TDPLP67.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_03:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/21 6:38 PM, Naveen N. Rao wrote:
> On 2021/02/04 04:17PM, Ravi Bangoria wrote:
>> Don't allow Uprobe on 2nd word of a prefixed instruction. As per
>> ISA 3.1, prefixed instruction should not cross 64-byte boundary.
>> So don't allow Uprobe on such prefixed instruction as well.
>>
>> There are two ways probed instruction is changed in mapped pages.
>> First, when Uprobe is activated, it searches for all the relevant
>> pages and replace instruction in them. In this case, if we notice
>> that probe is on the 2nd word of prefixed instruction, error out
>> directly. Second, when Uprobe is already active and user maps a
>> relevant page via mmap(), instruction is replaced via mmap() code
>> path. But because Uprobe is invalid, entire mmap() operation can
>> not be stopped. In this case just print an error and continue.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>> v1: http://lore.kernel.org/r/20210119091234.76317-1-ravi.bangoria@linux.ibm.com
>> v1->v2:
>>    - Instead of introducing new arch hook from verify_opcode(), use
>>      existing hook arch_uprobe_analyze_insn().
>>    - Add explicit check for prefixed instruction crossing 64-byte
>>      boundary. If probe is on such instruction, throw an error.
>>
>>   arch/powerpc/kernel/uprobes.c | 66 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
>> index e8a63713e655..485d19a2a31f 100644
>> --- a/arch/powerpc/kernel/uprobes.c
>> +++ b/arch/powerpc/kernel/uprobes.c
>> @@ -7,6 +7,7 @@
>>    * Adapted from the x86 port by Ananth N Mavinakayanahalli <ananth@in.ibm.com>
>>    */
>>   #include <linux/kernel.h>
>> +#include <linux/highmem.h>
>>   #include <linux/sched.h>
>>   #include <linux/ptrace.h>
>>   #include <linux/uprobes.h>
>> @@ -28,6 +29,69 @@ bool is_trap_insn(uprobe_opcode_t *insn)
>>   	return (is_trap(*insn));
>>   }
>>   
>> +#ifdef CONFIG_PPC64
>> +static int get_instr(struct mm_struct *mm, unsigned long addr, u32 *instr)
>> +{
>> +	struct page *page;
>> +	struct vm_area_struct *vma;
>> +	void *kaddr;
>> +	unsigned int gup_flags = FOLL_FORCE | FOLL_SPLIT_PMD;
>> +
>> +	if (get_user_pages_remote(mm, addr, 1, gup_flags, &page, &vma, NULL) <= 0)
>> +		return -EINVAL;
>> +
>> +	kaddr = kmap_atomic(page);
>> +	*instr = *((u32 *)(kaddr + (addr & ~PAGE_MASK)));
>> +	kunmap_atomic(kaddr);
>> +	put_page(page);
>> +	return 0;
>> +}
>> +
>> +static int validate_prefixed_instr(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	struct ppc_inst inst;
>> +	u32 prefix, suffix;
>> +
>> +	/*
>> +	 * No need to check if addr is pointing to beginning of the
>> +	 * page. Even if probe is on a suffix of page-unaligned
>> +	 * prefixed instruction, hw will raise exception and kernel
>> +	 * will send SIGBUS.
>> +	 */
>> +	if (!(addr & ~PAGE_MASK))
>> +		return 0;
>> +
>> +	if (get_instr(mm, addr, &prefix) < 0)
>> +		return -EINVAL;
>> +	if (get_instr(mm, addr + 4, &suffix) < 0)
>> +		return -EINVAL;
>> +
>> +	inst = ppc_inst_prefix(prefix, suffix);
>> +	if (ppc_inst_prefixed(inst) && (addr & 0x3F) == 0x3C) {
>> +		printk_ratelimited("Cannot register a uprobe on 64 byte "
> 		^^^^^^^^^^^^^^^^^^ pr_info_ratelimited()
> 
> It should be sufficient to check the primary opcode to determine if it
> is a prefixed instruction. You don't have to read the suffix. I see that
> we don't have a helper to do this currently, so you could do:
> 
> 	if (ppc_inst_primary_opcode(ppc_inst(prefix)) == 1)

Ok.

> 
> In the future, it might be worthwhile to add IS_PREFIX() as a macro
> similar to IS_MTMSRD() if there are more such uses.
> 
> Along with this, if you also add the below to the start of this
> function, you can get rid of the #ifdef:
> 
> 	if (!IS_ENABLED(CONFIG_PPC64))
> 		return 0;

Yeah this is better.

Thanks for the review, Naveen!
Ravi
