Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7263628D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbhDPTos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:44:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237760AbhDPTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:44:47 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GJXgDb195006;
        Fri, 16 Apr 2021 15:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4h/D3F/h68YsTSK+/g/VR+ZkCNwyFI1Fa/7GWlQ1YIw=;
 b=UQCcggthQ+8juHOgv4Q7efBxylO57AM3epbfxnmgFlqMNIeeh8SgDiaNnHi+JEmDgBeZ
 ktsMIEo6AAv4CAu5lEwMdawxvH4hbUvLWtmSDGLLRIUwHV+ojp9ypQcHza4EecQeAYeo
 wVbfbCaRgxiF37WzLMJJM4rEPC3udIYzh/RAsapCeQJpykbq/yjPvEfHKviZNjZm7DyU
 SEGo7NcuSeZxQCz2riZNSRdp2z3WgA75m+a0tfkODvgPNAHYTcBwkcSTB2bYVvyYujsO
 O6dmQ6dTADTKPl+xM+C1IVlL6xRsT+Q59B7Flc5OfoHY0YNfz+CAUSXoPvKImAjBu2xF vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37yg6q16k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 15:44:13 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13GJY6WI001413;
        Fri, 16 Apr 2021 15:44:13 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37yg6q16ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 15:44:13 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13GJRq7B001007;
        Fri, 16 Apr 2021 19:44:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 37u39hmn97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 19:44:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13GJi8O417039766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 19:44:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07BD452051;
        Fri, 16 Apr 2021 19:44:08 +0000 (GMT)
Received: from [9.85.71.169] (unknown [9.85.71.169])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1BEE05204E;
        Fri, 16 Apr 2021 19:44:04 +0000 (GMT)
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
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <2a0d371d-79f6-e7aa-6dcd-3b29264e1feb@linux.ibm.com>
Date:   Sat, 17 Apr 2021 01:14:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHng5nAPSLJHnRY9@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HuMV6lisyAOgKNDFbc5i3PDOCfADqWSu
X-Proofpoint-GUID: 42i-XF14gTKoSJltaBqLID0y4AIxf1Hv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160137
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/04/21 12:39 am, Roman Gushchin wrote:
> On Sat, Apr 17, 2021 at 12:11:37AM +0530, Pratik Sampat wrote:
>>
>> On 17/04/21 12:04 am, Roman Gushchin wrote:
>>> On Fri, Apr 16, 2021 at 11:57:03PM +0530, Pratik Sampat wrote:
>>>> On 16/04/21 10:43 pm, Roman Gushchin wrote:
>>>>> On Fri, Apr 16, 2021 at 08:58:33PM +0530, Pratik Sampat wrote:
>>>>>> Hello Dennis,
>>>>>>
>>>>>> I apologize for the clutter of logs before, I'm pasting the logs of before and
>>>>>> after the percpu test in the case of the patchset being applied on 5.12-rc6 and
>>>>>> the vanilla kernel 5.12-rc6.
>>>>>>
>>>>>> On 16/04/21 7:48 pm, Dennis Zhou wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
>>>>>>>> Hello Roman,
>>>>>>>>
>>>>>>>> I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
>>>>>>>>
>>>>>>>> My results of the percpu_test are as follows:
>>>>>>>> Intel KVM 4CPU:4G
>>>>>>>> Vanilla 5.12-rc6
>>>>>>>> # ./percpu_test.sh
>>>>>>>> Percpu:             1952 kB
>>>>>>>> Percpu:           219648 kB
>>>>>>>> Percpu:           219648 kB
>>>>>>>>
>>>>>>>> 5.12-rc6 + with patchset applied
>>>>>>>> # ./percpu_test.sh
>>>>>>>> Percpu:             2080 kB
>>>>>>>> Percpu:           219712 kB
>>>>>>>> Percpu:            72672 kB
>>>>>>>>
>>>>>>>> I'm able to see improvement comparable to that of what you're see too.
>>>>>>>>
>>>>>>>> However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
>>>>>>>>
>>>>>>>> POWER9 KVM 4CPU:4G
>>>>>>>> Vanilla 5.12-rc6
>>>>>>>> # ./percpu_test.sh
>>>>>>>> Percpu:             5888 kB
>>>>>>>> Percpu:           118272 kB
>>>>>>>> Percpu:           118272 kB
>>>>>>>>
>>>>>>>> 5.12-rc6 + with patchset applied
>>>>>>>> # ./percpu_test.sh
>>>>>>>> Percpu:             6144 kB
>>>>>>>> Percpu:           119040 kB
>>>>>>>> Percpu:           119040 kB
>>>>>>>>
>>>>>>>> I'm wondering if there's any architectural specific code that needs plumbing
>>>>>>>> here?
>>>>>>>>
>>>>>>> There shouldn't be. Can you send me the percpu_stats debug output before
>>>>>>> and after?
>>>>>> I'll paste the whole debug stats before and after here.
>>>>>> 5.12-rc6 + patchset
>>>>>> -----BEFORE-----
>>>>>> Percpu Memory Statistics
>>>>>> Allocation Info:
>>>>> Hm, this looks highly suspicious. Here is your stats in a more compact form:
>>>>>
>>>>> Vanilla
>>>>>
>>>>> nr_alloc            :         9038         nr_alloc            :        97046
>>>>> nr_dealloc          :         6992	   nr_dealloc          :        94237
>>>>> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2809
>>>>> nr_max_alloc        :         2178	   nr_max_alloc        :        90054
>>>>> nr_chunks           :            3	   nr_chunks           :           11
>>>>> nr_max_chunks       :            3	   nr_max_chunks       :           47
>>>>> min_alloc_size      :            4	   min_alloc_size      :            4
>>>>> max_alloc_size      :         1072	   max_alloc_size      :         1072
>>>>> empty_pop_pages     :            5	   empty_pop_pages     :           29
>>>>>
>>>>>
>>>>> Patched
>>>>>
>>>>> nr_alloc            :         9040         nr_alloc            :        97048
>>>>> nr_dealloc          :         6994	   nr_dealloc          :        95002
>>>>> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2046
>>>>> nr_max_alloc        :         2208	   nr_max_alloc        :        90054
>>>>> nr_chunks           :            3	   nr_chunks           :           48
>>>>> nr_max_chunks       :            3	   nr_max_chunks       :           48
>>>>> min_alloc_size      :            4	   min_alloc_size      :            4
>>>>> max_alloc_size      :         1072	   max_alloc_size      :         1072
>>>>> empty_pop_pages     :           12	   empty_pop_pages     :           61
>>>>>
>>>>>
>>>>> So it looks like the number of chunks got bigger, as well as the number of
>>>>> empty_pop_pages? This contradicts to what you wrote, so can you, please, make
>>>>> sure that the data is correct and we're not messing two cases?
>>>>>
>>>>> So it looks like for some reason sidelined (depopulated) chunks are not getting
>>>>> freed completely. But I struggle to explain why the initial empty_pop_pages is
>>>>> bigger with the same amount of chunks.
>>>>>
>>>>> So, can you, please, apply the following patch and provide an updated statistics?
>>>> Unfortunately, I'm not completely well versed in this area, but yes the empty
>>>> pop pages number doesn't make sense to me either.
>>>>
>>>> I re-ran the numbers trying to make sure my experiment setup is sane but
>>>> results remain the same.
>>>>
>>>> Vanilla
>>>> nr_alloc            :         9040         nr_alloc            :        97048
>>>> nr_dealloc          :         6994	   nr_dealloc          :        94404
>>>> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2644
>>>> nr_max_alloc        :         2169	   nr_max_alloc        :        90054
>>>> nr_chunks           :            3	   nr_chunks           :           10
>>>> nr_max_chunks       :            3	   nr_max_chunks       :           47
>>>> min_alloc_size      :            4	   min_alloc_size      :            4
>>>> max_alloc_size      :         1072	   max_alloc_size      :         1072
>>>> empty_pop_pages     :            4	   empty_pop_pages     :           32
>>>>
>>>> With the patchset + debug patch the results are as follows:
>>>> Patched
>>>>
>>>> nr_alloc            :         9040         nr_alloc            :        97048
>>>> nr_dealloc          :         6994	   nr_dealloc          :        94349
>>>> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2699
>>>> nr_max_alloc        :         2194	   nr_max_alloc        :        90054
>>>> nr_chunks           :            3	   nr_chunks           :           48
>>>> nr_max_chunks       :            3	   nr_max_chunks       :           48
>>>> min_alloc_size      :            4	   min_alloc_size      :            4
>>>> max_alloc_size      :         1072	   max_alloc_size      :         1072
>>>> empty_pop_pages     :           12	   empty_pop_pages     :           54
>>>>
>>>> With the extra tracing I can see 39 entries of "Chunk (sidelined)"
>>>> after the test was run. I don't see any entries for "Chunk (to depopulate)"
>>>>
>>>> I've snipped the results of slidelined chunks because they went on for ~600
>>>> lines, if you need the full logs let me know.
>>> Yes, please! That's the most interesting part!
>> Got it. Pasting the full logs of after the percpu experiment was completed
> Thanks!
>
> Would you mind to apply the following patch and test again?
>
> --
>
> diff --git a/mm/percpu.c b/mm/percpu.c
> index ded3a7541cb2..532c6a7ebdfd 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2296,6 +2296,9 @@ void free_percpu(void __percpu *ptr)
>                                  need_balance = true;
>                                  break;
>                          }
> +
> +               chunk->depopulated = false;
> +               pcpu_chunk_relocate(chunk, -1);
>          } else if (chunk != pcpu_first_chunk && chunk != pcpu_reserved_chunk &&
>                     !chunk->isolated &&
>                     (pcpu_nr_empty_pop_pages[pcpu_chunk_type(chunk)] >
>
Sure thing.

I see much lower sideline chunks. In one such test run I saw zero occurrences
of slidelined chunks

Pasting the full logs as an example:

BEFORE
Percpu Memory Statistics
Allocation Info:
----------------------------------------
   unit_size           :       655360
   static_size         :       608920
   reserved_size       :            0
   dyn_size            :        46440
   atom_size           :        65536
   alloc_size          :       655360

Global Stats:
----------------------------------------
   nr_alloc            :         9038
   nr_dealloc          :         6992
   nr_cur_alloc        :         2046
   nr_max_alloc        :         2200
   nr_chunks           :            3
   nr_max_chunks       :            3
   min_alloc_size      :            4
   max_alloc_size      :         1072
   empty_pop_pages     :           12

Per Chunk Stats:
----------------------------------------
Chunk: <- First Chunk
   nr_alloc            :         1092
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :        16247
   free_bytes          :            4
   contig_bytes        :            4
   sum_frag            :            4
   max_frag            :            4
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :         1072
   memcg_aware         :            0

Chunk:
   nr_alloc            :          594
   max_alloc_size      :          992
   empty_pop_pages     :            8
   first_bit           :          456
   free_bytes          :       645008
   contig_bytes        :       319984
   sum_frag            :       325024
   max_frag            :       318680
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :          424
   memcg_aware         :            0

Chunk:
   nr_alloc            :          360
   max_alloc_size      :         1072
   empty_pop_pages     :            4
   first_bit           :        26595
   free_bytes          :       506640
   contig_bytes        :       506540
   sum_frag            :          100
   max_frag            :           32
   cur_min_alloc       :            4
   cur_med_alloc       :          156
   cur_max_alloc       :         1072
   memcg_aware         :            1


AFTER
Percpu Memory Statistics
Allocation Info:
----------------------------------------
   unit_size           :       655360
   static_size         :       608920
   reserved_size       :            0
   dyn_size            :        46440
   atom_size           :        65536
   alloc_size          :       655360

Global Stats:
----------------------------------------
   nr_alloc            :        97046
   nr_dealloc          :        94304
   nr_cur_alloc        :         2742
   nr_max_alloc        :        90054
   nr_chunks           :           11
   nr_max_chunks       :           47
   min_alloc_size      :            4
   max_alloc_size      :         1072
   empty_pop_pages     :           18

Per Chunk Stats:
----------------------------------------
Chunk: <- First Chunk
   nr_alloc            :         1092
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :        16247
   free_bytes          :            4
   contig_bytes        :            4
   sum_frag            :            4
   max_frag            :            4
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :         1072
   memcg_aware         :            0

Chunk:
   nr_alloc            :          838
   max_alloc_size      :         1072
   empty_pop_pages     :            7
   first_bit           :          464
   free_bytes          :       640476
   contig_bytes        :       290672
   sum_frag            :       349804
   max_frag            :       304344
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :         1072
   memcg_aware         :            0

Chunk:
   nr_alloc            :           90
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :          536
   free_bytes          :       595752
   contig_bytes        :        26164
   sum_frag            :       575132
   max_frag            :        26164
   cur_min_alloc       :          156
   cur_med_alloc       :         1072
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :           90
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :            0
   free_bytes          :       597428
   contig_bytes        :        26164
   sum_frag            :       596848
   max_frag            :        26164
   cur_min_alloc       :          156
   cur_med_alloc       :          312
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :           92
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :            0
   free_bytes          :       595284
   contig_bytes        :        26164
   sum_frag            :       590360
   max_frag            :        26164
   cur_min_alloc       :          156
   cur_med_alloc       :          312
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :           92
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :            0
   free_bytes          :       595284
   contig_bytes        :        26164
   sum_frag            :       583768
   max_frag            :        26164
   cur_min_alloc       :          156
   cur_med_alloc       :          312
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :          360
   max_alloc_size      :         1072
   empty_pop_pages     :            7
   first_bit           :        26595
   free_bytes          :       506640
   contig_bytes        :       506540
   sum_frag            :          100
   max_frag            :           32
   cur_min_alloc       :            4
   cur_med_alloc       :          156
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :           12
   max_alloc_size      :         1072
   empty_pop_pages     :            3
   first_bit           :            0
   free_bytes          :       647524
   contig_bytes        :       563492
   sum_frag            :        57872
   max_frag            :        26164
   cur_min_alloc       :          156
   cur_med_alloc       :          312
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :            0
   max_alloc_size      :         1072
   empty_pop_pages     :            1
   first_bit           :            0
   free_bytes          :       655360
   contig_bytes        :       655360
   sum_frag            :            0
   max_frag            :            0
   cur_min_alloc       :            0
   cur_med_alloc       :            0
   cur_max_alloc       :            0
   memcg_aware         :            1

Chunk (sidelined):
   nr_alloc            :           72
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :            0
   free_bytes          :       608344
   contig_bytes        :       145552
   sum_frag            :       590340
   max_frag            :       145552
   cur_min_alloc       :          156
   cur_med_alloc       :          312
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk (sidelined):
   nr_alloc            :            4
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :            0
   free_bytes          :       652748
   contig_bytes        :       426720
   sum_frag            :       426720
   max_frag            :       426720
   cur_min_alloc       :          156
   cur_med_alloc       :          312
   cur_max_alloc       :         1072
   memcg_aware         :            1





