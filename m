Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D96362E3A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 09:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhDQHJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 03:09:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhDQHJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 03:09:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13H72m7i152255;
        Sat, 17 Apr 2021 03:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PMhavcu4p+eI9dizc1TLnJI6iV6SINMaPXhTUjw1H/A=;
 b=qGWQ40eip1mObR6a+cJhw1EQT1TqMq8iV/HB5fO+witu1gMaHG0U5ODvgiEW4npKz2jl
 YOnDyiGWSMCrmJLEQUg7Hbd0TWKQ9QlindprP/6KOXQI3ZodWV9sj/ThlskMeCPMArZq
 NxzoVhI+Pw+JqKrW4bQdQ/lTBjbarHnVQU7rVR0ciO1QD13l/3mgw+uRIb7GBu6uOB1e
 nm2k66nSFCcGcwMM4X2sqCc0RVYx+C93DD8DoIaE1ouBdRI1Q9q6DSC2EM9931vRqXkA
 f9SDAisL5fN4X5DIosT206opn4e2IzofyohMhrqJ5Uo9foz8AOnIzPMmOm6kHIyMuW4c TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37y8rpj8ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Apr 2021 03:08:18 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13H73lJn155272;
        Sat, 17 Apr 2021 03:08:18 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37y8rpj8ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Apr 2021 03:08:17 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13H73gdN026041;
        Sat, 17 Apr 2021 07:08:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 37yt2rr0p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Apr 2021 07:08:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13H78DAs31130022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Apr 2021 07:08:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55F2F52050;
        Sat, 17 Apr 2021 07:08:13 +0000 (GMT)
Received: from [9.102.0.166] (unknown [9.102.0.166])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B222A5204F;
        Sat, 17 Apr 2021 07:08:10 +0000 (GMT)
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
To:     Roman Gushchin <guro@fb.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pratik.r.sampat@gmail.com
References: <20210408035736.883861-1-guro@fb.com>
 <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
 <YHmcorqNE5NpAN3G@google.com>
 <7a001bf6-5708-fb04-4970-367d9845ccb9@linux.ibm.com>
 <YHnFsL2G2bpOH8ML@carbon.dhcp.thefacebook.com>
 <8ea7c616-95e8-e391-5373-ebaf10836d2c@linux.ibm.com>
 <YHnYqMdyYtIdab6n@carbon.dhcp.thefacebook.com>
 <09a8d1eb-280d-9ee9-3d68-d065db47a516@linux.ibm.com>
 <YHng5nAPSLJHnRY9@carbon.dhcp.thefacebook.com>
 <2a0d371d-79f6-e7aa-6dcd-3b29264e1feb@linux.ibm.com>
 <YHntlmvfx3w79IUn@carbon.dhcp.thefacebook.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <6843bf1b-88cd-19fd-ddb0-5052af7ef2ac@linux.ibm.com>
Date:   Sat, 17 Apr 2021 12:38:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHntlmvfx3w79IUn@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YcMH3P6F6Ygird4dy-5GasYuz_DHhG7q
X-Proofpoint-ORIG-GUID: _2levPP0BQe-7tArsjRiIYqPgbABEUIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-17_06:2021-04-16,2021-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104170046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/04/21 1:33 am, Roman Gushchin wrote:
> On Sat, Apr 17, 2021 at 01:14:03AM +0530, Pratik Sampat wrote:
>>
>> On 17/04/21 12:39 am, Roman Gushchin wrote:
>>> On Sat, Apr 17, 2021 at 12:11:37AM +0530, Pratik Sampat wrote:
>>>> On 17/04/21 12:04 am, Roman Gushchin wrote:
>>>>> On Fri, Apr 16, 2021 at 11:57:03PM +0530, Pratik Sampat wrote:
>>>>>> On 16/04/21 10:43 pm, Roman Gushchin wrote:
>>>>>>> On Fri, Apr 16, 2021 at 08:58:33PM +0530, Pratik Sampat wrote:
>>>>>>>> Hello Dennis,
>>>>>>>>
>>>>>>>> I apologize for the clutter of logs before, I'm pasting the logs of before and
>>>>>>>> after the percpu test in the case of the patchset being applied on 5.12-rc6 and
>>>>>>>> the vanilla kernel 5.12-rc6.
>>>>>>>>
>>>>>>>> On 16/04/21 7:48 pm, Dennis Zhou wrote:
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
>>>>>>>>>> Hello Roman,
>>>>>>>>>>
>>>>>>>>>> I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
>>>>>>>>>>
>>>>>>>>>> My results of the percpu_test are as follows:
>>>>>>>>>> Intel KVM 4CPU:4G
>>>>>>>>>> Vanilla 5.12-rc6
>>>>>>>>>> # ./percpu_test.sh
>>>>>>>>>> Percpu:             1952 kB
>>>>>>>>>> Percpu:           219648 kB
>>>>>>>>>> Percpu:           219648 kB
>>>>>>>>>>
>>>>>>>>>> 5.12-rc6 + with patchset applied
>>>>>>>>>> # ./percpu_test.sh
>>>>>>>>>> Percpu:             2080 kB
>>>>>>>>>> Percpu:           219712 kB
>>>>>>>>>> Percpu:            72672 kB
>>>>>>>>>>
>>>>>>>>>> I'm able to see improvement comparable to that of what you're see too.
>>>>>>>>>>
>>>>>>>>>> However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
>>>>>>>>>>
>>>>>>>>>> POWER9 KVM 4CPU:4G
>>>>>>>>>> Vanilla 5.12-rc6
>>>>>>>>>> # ./percpu_test.sh
>>>>>>>>>> Percpu:             5888 kB
>>>>>>>>>> Percpu:           118272 kB
>>>>>>>>>> Percpu:           118272 kB
>>>>>>>>>>
>>>>>>>>>> 5.12-rc6 + with patchset applied
>>>>>>>>>> # ./percpu_test.sh
>>>>>>>>>> Percpu:             6144 kB
>>>>>>>>>> Percpu:           119040 kB
>>>>>>>>>> Percpu:           119040 kB
>>>>>>>>>>
>>>>>>>>>> I'm wondering if there's any architectural specific code that needs plumbing
>>>>>>>>>> here?
>>>>>>>>>>
>>>>>>>>> There shouldn't be. Can you send me the percpu_stats debug output before
>>>>>>>>> and after?
>>>>>>>> I'll paste the whole debug stats before and after here.
>>>>>>>> 5.12-rc6 + patchset
>>>>>>>> -----BEFORE-----
>>>>>>>> Percpu Memory Statistics
>>>>>>>> Allocation Info:
>>>>>>> Hm, this looks highly suspicious. Here is your stats in a more compact form:
>>>>>>>
>>>>>>> Vanilla
>>>>>>>
>>>>>>> nr_alloc            :         9038         nr_alloc            :        97046
>>>>>>> nr_dealloc          :         6992	   nr_dealloc          :        94237
>>>>>>> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2809
>>>>>>> nr_max_alloc        :         2178	   nr_max_alloc        :        90054
>>>>>>> nr_chunks           :            3	   nr_chunks           :           11
>>>>>>> nr_max_chunks       :            3	   nr_max_chunks       :           47
>>>>>>> min_alloc_size      :            4	   min_alloc_size      :            4
>>>>>>> max_alloc_size      :         1072	   max_alloc_size      :         1072
>>>>>>> empty_pop_pages     :            5	   empty_pop_pages     :           29
>>>>>>>
>>>>>>>
>>>>>>> Patched
>>>>>>>
>>>>>>> nr_alloc            :         9040         nr_alloc            :        97048
>>>>>>> nr_dealloc          :         6994	   nr_dealloc          :        95002
>>>>>>> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2046
>>>>>>> nr_max_alloc        :         2208	   nr_max_alloc        :        90054
>>>>>>> nr_chunks           :            3	   nr_chunks           :           48
>>>>>>> nr_max_chunks       :            3	   nr_max_chunks       :           48
>>>>>>> min_alloc_size      :            4	   min_alloc_size      :            4
>>>>>>> max_alloc_size      :         1072	   max_alloc_size      :         1072
>>>>>>> empty_pop_pages     :           12	   empty_pop_pages     :           61
>>>>>>>
>>>>>>>
>>>>>>> So it looks like the number of chunks got bigger, as well as the number of
>>>>>>> empty_pop_pages? This contradicts to what you wrote, so can you, please, make
>>>>>>> sure that the data is correct and we're not messing two cases?
>>>>>>>
>>>>>>> So it looks like for some reason sidelined (depopulated) chunks are not getting
>>>>>>> freed completely. But I struggle to explain why the initial empty_pop_pages is
>>>>>>> bigger with the same amount of chunks.
>>>>>>>
>>>>>>> So, can you, please, apply the following patch and provide an updated statistics?
>>>>>> Unfortunately, I'm not completely well versed in this area, but yes the empty
>>>>>> pop pages number doesn't make sense to me either.
>>>>>>
>>>>>> I re-ran the numbers trying to make sure my experiment setup is sane but
>>>>>> results remain the same.
>>>>>>
>>>>>> Vanilla
>>>>>> nr_alloc            :         9040         nr_alloc            :        97048
>>>>>> nr_dealloc          :         6994	   nr_dealloc          :        94404
>>>>>> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2644
>>>>>> nr_max_alloc        :         2169	   nr_max_alloc        :        90054
>>>>>> nr_chunks           :            3	   nr_chunks           :           10
>>>>>> nr_max_chunks       :            3	   nr_max_chunks       :           47
>>>>>> min_alloc_size      :            4	   min_alloc_size      :            4
>>>>>> max_alloc_size      :         1072	   max_alloc_size      :         1072
>>>>>> empty_pop_pages     :            4	   empty_pop_pages     :           32
>>>>>>
>>>>>> With the patchset + debug patch the results are as follows:
>>>>>> Patched
>>>>>>
>>>>>> nr_alloc            :         9040         nr_alloc            :        97048
>>>>>> nr_dealloc          :         6994	   nr_dealloc          :        94349
>>>>>> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2699
>>>>>> nr_max_alloc        :         2194	   nr_max_alloc        :        90054
>>>>>> nr_chunks           :            3	   nr_chunks           :           48
>>>>>> nr_max_chunks       :            3	   nr_max_chunks       :           48
>>>>>> min_alloc_size      :            4	   min_alloc_size      :            4
>>>>>> max_alloc_size      :         1072	   max_alloc_size      :         1072
>>>>>> empty_pop_pages     :           12	   empty_pop_pages     :           54
>>>>>>
>>>>>> With the extra tracing I can see 39 entries of "Chunk (sidelined)"
>>>>>> after the test was run. I don't see any entries for "Chunk (to depopulate)"
>>>>>>
>>>>>> I've snipped the results of slidelined chunks because they went on for ~600
>>>>>> lines, if you need the full logs let me know.
>>>>> Yes, please! That's the most interesting part!
>>>> Got it. Pasting the full logs of after the percpu experiment was completed
>>> Thanks!
>>>
>>> Would you mind to apply the following patch and test again?
>>>
>>> --
>>>
>>> diff --git a/mm/percpu.c b/mm/percpu.c
>>> index ded3a7541cb2..532c6a7ebdfd 100644
>>> --- a/mm/percpu.c
>>> +++ b/mm/percpu.c
>>> @@ -2296,6 +2296,9 @@ void free_percpu(void __percpu *ptr)
>>>                                   need_balance = true;
>>>                                   break;
>>>                           }
>>> +
>>> +               chunk->depopulated = false;
>>> +               pcpu_chunk_relocate(chunk, -1);
>>>           } else if (chunk != pcpu_first_chunk && chunk != pcpu_reserved_chunk &&
>>>                      !chunk->isolated &&
>>>                      (pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
>>>
>> Sure thing.
>>
>> I see much lower sideline chunks. In one such test run I saw zero occurrences
>> of slidelined chunks
>>
> So looking at the stats it now works properly. Do you see any savings in
> comparison to vanilla? The size of savings can significanlty depend on the exact
> size of cgroup-related objects, how many of them fit into a single chunk, etc.
> So you might want to play with numbers in the test...
>
> Anyway, thank you very much for the report and your work on testing follow-up
> patches! It helped to reveal a serious bug in the implementation (completely
> empty sidelined chunks were not released in some cases), which by pure
> coincidence wasn't triggered on x86.
>
> Thanks!
>
Unfortunately not, I don't see any savings from the test.

# ./percpu_test_roman.sh
Percpu:             6144 kB
Percpu:           122880 kB
Percpu:           122880 kB

I had assumed that because POWER has a larger page size, we would indeed also
have higher fragmentation which could possibly lead to a lot more savings.

I'll dive deeper into the patches and tweak around the setup to see if I can
understand this behavior.

Thanks for helping me understand this patchset a little better and I'm glad we
found a bug with sidelined chunks!

I'll get back to you if I do find something interesting and need help
understanding it.

Thank you again,
Pratik

