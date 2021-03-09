Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AEB3325F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhCIM7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:59:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229688AbhCIM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:59:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129CYCfi022923;
        Tue, 9 Mar 2021 07:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=E9Z5K4c9KLZDikZeIsX4UkCzElBTga+tVCdllv+XDCU=;
 b=cKFeeBaAL1qNqU84XgVrc1u3Smz3hvZmo0PzKVXjKbJS0EnnzPR3BDOLQ7GEmJ5WrNQo
 aMXmBp+mg7CFZ3FSmT5Pnnm71UVld/tO7bKKPGiyPvB6PJU0RzFyq6W2CIKhxCNw3F+N
 11xlcJfq8aBBl6nfNDfPXhxXExUYFWh5jcNxWUdHR0Khp7ofymmHumXeFzlcur4PMcAB
 t/K+OaeRm66ilO2yehL9UeiYTSAA1XhsjiPpnK4fL6nxLtv4WOFo9i8DveKTSzz4rY8+
 6OwxtMFOtF7DPktZHqY522F/s8UnhnE30rRye3xYmfSTLdPNo6OF8/Lihq5aH+kelklF wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 375wgv9vv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 07:58:12 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 129CYDmN023041;
        Tue, 9 Mar 2021 07:58:11 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 375wgv9vuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 07:58:11 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 129Cq06B001183;
        Tue, 9 Mar 2021 12:58:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3768urr14r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 12:58:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 129Cw6kc42074568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 12:58:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4E60A404D;
        Tue,  9 Mar 2021 12:58:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28403A4057;
        Tue,  9 Mar 2021 12:58:04 +0000 (GMT)
Received: from [9.199.45.167] (unknown [9.199.45.167])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 12:58:03 +0000 (GMT)
Subject: Re: [PATCH v4] powerpc/uprobes: Validation for prefixed instruction
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     oleg@redhat.com, rostedt@goodmis.org, paulus@samba.org,
        jniethe5@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20210305115433.140769-1-ravi.bangoria@linux.ibm.com>
 <87ft14r6sa.fsf@mpe.ellerman.id.au>
 <20210309112115.GG145@DESKTOP-TDPLP67.localdomain>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <1a080cb5-af98-6b6e-352d-772a90cfa902@linux.ibm.com>
Date:   Tue, 9 Mar 2021 18:28:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309112115.GG145@DESKTOP-TDPLP67.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_11:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/21 4:51 PM, Naveen N. Rao wrote:
> On 2021/03/09 08:54PM, Michael Ellerman wrote:
>> Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
>>> As per ISA 3.1, prefixed instruction should not cross 64-byte
>>> boundary. So don't allow Uprobe on such prefixed instruction.
>>>
>>> There are two ways probed instruction is changed in mapped pages.
>>> First, when Uprobe is activated, it searches for all the relevant
>>> pages and replace instruction in them. In this case, if that probe
>>> is on the 64-byte unaligned prefixed instruction, error out
>>> directly. Second, when Uprobe is already active and user maps a
>>> relevant page via mmap(), instruction is replaced via mmap() code
>>> path. But because Uprobe is invalid, entire mmap() operation can
>>> not be stopped. In this case just print an error and continue.
>>>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>>
>> Do we have a Fixes: tag for this?
> 
> Since this is an additional check we are adding, I don't think we should
> add a Fixes: tag. Nothing is broken per-se -- we're just adding more
> checks to catch simple mistakes. Also, like Oleg pointed out, there are
> still many other ways for users to shoot themselves in the foot with
> uprobes and prefixed instructions, if they so desire.
> 
> However, if you still think we should add a Fixes: tag, we can perhaps
> use the below commit since I didn't see any specific commit adding
> support for prefixed instructions for uprobes:
> 
> Fixes: 650b55b707fdfa ("powerpc: Add prefixed instructions to
> instruction data type")

True. IMO, It doesn't really need any Fixes tag.

> 
>>
>>> ---
>>> v3: https://lore.kernel.org/r/20210304050529.59391-1-ravi.bangoria@linux.ibm.com
>>> v3->v4:
>>>    - CONFIG_PPC64 check was not required, remove it.
>>>    - Use SZ_ macros instead of hardcoded numbers.
>>>
>>>   arch/powerpc/kernel/uprobes.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
>>> index e8a63713e655..4cbfff6e94a3 100644
>>> --- a/arch/powerpc/kernel/uprobes.c
>>> +++ b/arch/powerpc/kernel/uprobes.c
>>> @@ -41,6 +41,13 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>>>   	if (addr & 0x03)
>>>   		return -EINVAL;
>>>   
>>> +	if (cpu_has_feature(CPU_FTR_ARCH_31) &&
>>> +	    ppc_inst_prefixed(auprobe->insn) &&
>>> +	    (addr & (SZ_64 - 4)) == SZ_64 - 4) {
>>> +		pr_info_ratelimited("Cannot register a uprobe on 64 byte unaligned prefixed instruction\n");
>>> +		return -EINVAL;
>>
>> I realise we already did the 0x03 check above, but I still think this
>> would be clearer simply as:
>>
>> 	    (addr & 0x3f == 60)
> 
> Indeed, I like the use of `60' there -- hex is overrated ;)

Sure. Will resend.

Ravi
