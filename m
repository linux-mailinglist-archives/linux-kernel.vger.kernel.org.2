Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610B232D18C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbhCDLEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:04:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239499AbhCDLE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:04:28 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124AZ030036335;
        Thu, 4 Mar 2021 06:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=47WtE5ae2zvgrB38qLb/0Ac8W5I+rgoTfpMMr9YgruA=;
 b=f/FqU1LRd12MzE7HvPl9AU98uhttD7/BkcYgIF5hrad08qvYVPtGSKodEJmvyAlmNPrZ
 8yTBqCNFlHvOla6XVUqHHxvSl7mauAlZAfiILcPA19GzJV+vnBsRRTnYFqK4+09JKv8f
 jsqnrVYsMKSyR4E4Q8VrddOypuBSqKo6D/pVwQ6NxnSyYLOsoZgd56usNjZcvslAftXw
 n+9hQtdpreB4sOfemOVUUU73KmdFKcWO3ylgiWHp5sKlJLADsSWJc5YEMRdnIVDKy/WK
 VU41YlTIjRiJoBTkIA4Xs1I7NqbGHku8ukKeM2lx9NEFv1HGuUdpjNvqr1e2g/7M/ODl 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372vghupay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 06:02:56 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 124AZwhM042808;
        Thu, 4 Mar 2021 06:02:55 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372vghup9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 06:02:55 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 124AsQpY027790;
        Thu, 4 Mar 2021 11:02:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3712v51eap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 11:02:53 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 124B2oHp65143286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 11:02:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 692B74C046;
        Thu,  4 Mar 2021 11:02:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FFA74C044;
        Thu,  4 Mar 2021 11:02:48 +0000 (GMT)
Received: from [9.199.37.77] (unknown [9.199.37.77])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Mar 2021 11:02:47 +0000 (GMT)
Subject: Re: [PATCH v3] powerpc/uprobes: Validation for prefixed instruction
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     jniethe5@gmail.com, oleg@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        sandipan@linux.ibm.com, naveen.n.rao@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20210304050529.59391-1-ravi.bangoria@linux.ibm.com>
 <ac7aa126-59dd-31be-1084-6d3a2f0e4eb4@csgroup.eu>
 <4d365b9f-6f25-a4bc-c145-c06ee33f1f9f@linux.ibm.com>
 <f1a61cd9-436e-b486-b99c-0c06f2956a89@csgroup.eu>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <1f873079-2aa1-3818-3070-bce459034cec@linux.ibm.com>
Date:   Thu, 4 Mar 2021 16:32:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f1a61cd9-436e-b486-b99c-0c06f2956a89@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_03:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/21 4:21 PM, Christophe Leroy wrote:
> 
> 
> Le 04/03/2021 à 11:13, Ravi Bangoria a écrit :
>>
>>
>> On 3/4/21 1:02 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 04/03/2021 à 06:05, Ravi Bangoria a écrit :
>>>> As per ISA 3.1, prefixed instruction should not cross 64-byte
>>>> boundary. So don't allow Uprobe on such prefixed instruction.
>>>>
>>>> There are two ways probed instruction is changed in mapped pages.
>>>> First, when Uprobe is activated, it searches for all the relevant
>>>> pages and replace instruction in them. In this case, if that probe
>>>> is on the 64-byte unaligned prefixed instruction, error out
>>>> directly. Second, when Uprobe is already active and user maps a
>>>> relevant page via mmap(), instruction is replaced via mmap() code
>>>> path. But because Uprobe is invalid, entire mmap() operation can
>>>> not be stopped. In this case just print an error and continue.
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>> ---
>>>> v2: https://lore.kernel.org/r/20210204104703.273429-1-ravi.bangoria@linux.ibm.com
>>>> v2->v3:
>>>>    - Drop restriction for Uprobe on suffix of prefixed instruction.
>>>>      It needs lot of code change including generic code but what
>>>>      we get in return is not worth it.
>>>>
>>>>   arch/powerpc/kernel/uprobes.c | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
>>>> index e8a63713e655..c400971ebe70 100644
>>>> --- a/arch/powerpc/kernel/uprobes.c
>>>> +++ b/arch/powerpc/kernel/uprobes.c
>>>> @@ -41,6 +41,14 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
>>>>       if (addr & 0x03)
>>>>           return -EINVAL;
>>>> +    if (!IS_ENABLED(CONFIG_PPC64) || !cpu_has_feature(CPU_FTR_ARCH_31))
>>>
>>> cpu_has_feature(CPU_FTR_ARCH_31) should return 'false' when CONFIG_PPC64 is not enabled, no need to double check.
>>
>> Ok.
>>
>> I'm going to drop CONFIG_PPC64 check because it's not really
>> required as I replied to Naveen. So, I'll keep CPU_FTR_ARCH_31
>> check as is.
>>
>>>
>>>> +        return 0;
>>>> +
>>>> +    if (ppc_inst_prefixed(auprobe->insn) && (addr & 0x3F) == 0x3C) {
>>>
>>> Maybe 3C instead of 4F ? : (addr & 0x3C) == 0x3C
>>
>> Didn't follow. It's not (addr & 0x3C), it's (addr & 0x3F).
> 
> Sorry I meant 3c instead of 3f (And usually we don't use capital letters for that).
> The last two bits are supposed to always be 0, so it doesn't really matter, I just thought it would look better having the same value both sides of the test, ie (addr & 0x3c) == 0x3c.

Ok yeah makes sense. Thanks.

> 
>>
>>>
>>> What about
>>>
>>> (addr & (SZ_64 - 4)) == SZ_64 - 4 to make it more explicit ?
>>
>> Yes this is bit better. Though, it should be:
>>
>>      (addr & (SZ_64 - 1)) == SZ_64 - 4
> 
> -1 or -4 should give the same results as instructions are always 32 bits aligned though.

Got it.

Ravi
