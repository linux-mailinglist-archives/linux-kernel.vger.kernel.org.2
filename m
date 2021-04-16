Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5E3623E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbhDPP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:29:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343654AbhDPP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:29:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GF4OjO130586;
        Fri, 16 Apr 2021 11:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=756DS750TqgL3LLrSK51IVXvUAq+P/E2rcicsfkcPNo=;
 b=IusXtg3j34YDCMzlyeaAMfg0mDjVHEBe6yGYXyN8z/8v/w3ST7KMBbD2lH5ApY0+YzWd
 Wyca6hXrKOLZLju3iRVxIRRBc9ZlJlgOS4YuRWe+WFYEd9npQqv8zAKBR+W6Skzc4yMo
 jWhUBqLAfq3WweWmGW0FIW6QhVHx4COR7OXsnW0/1umKIq74s2PNwpEA0joWNzCJM8BK
 KNV0ypjIYH6DhmwfnWgpjpHr3t2Bb4srVKnnDouMdY3P+719tfo9kXk1e4lOs9g1MVEN
 U5bB7vMFo8kFcnAj/5CCOIm/WtGjvB73lEkjGmjF+2qgvSbEiyVtdduaP9IVAFCSJHD/ xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xxnppp2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 11:28:42 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13GF5U27137465;
        Fri, 16 Apr 2021 11:28:41 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xxnppp28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 11:28:41 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13GFHm3O014516;
        Fri, 16 Apr 2021 15:28:39 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 37u3n8ched-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 15:28:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13GFSbhP59572580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 15:28:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 166B152057;
        Fri, 16 Apr 2021 15:28:37 +0000 (GMT)
Received: from [9.85.93.147] (unknown [9.85.93.147])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9910E5204F;
        Fri, 16 Apr 2021 15:28:34 +0000 (GMT)
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pratik.r.sampat@gmail.com
References: <20210408035736.883861-1-guro@fb.com>
 <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
 <YHmcorqNE5NpAN3G@google.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <7a001bf6-5708-fb04-4970-367d9845ccb9@linux.ibm.com>
Date:   Fri, 16 Apr 2021 20:58:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YHmcorqNE5NpAN3G@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9QFRaTFOkazCLP3QsbPMrRWS7p4AqV00
X-Proofpoint-ORIG-GUID: EaHb9JAEzzZeRk1uCMQJuvB8UcJ1Q3ZO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_08:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dennis,

I apologize for the clutter of logs before, I'm pasting the logs of before and
after the percpu test in the case of the patchset being applied on 5.12-rc6 and
the vanilla kernel 5.12-rc6.

On 16/04/21 7:48 pm, Dennis Zhou wrote:
> Hello,
>
> On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
>> Hello Roman,
>>
>> I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
>>
>> My results of the percpu_test are as follows:
>> Intel KVM 4CPU:4G
>> Vanilla 5.12-rc6
>> # ./percpu_test.sh
>> Percpu:             1952 kB
>> Percpu:           219648 kB
>> Percpu:           219648 kB
>>
>> 5.12-rc6 + with patchset applied
>> # ./percpu_test.sh
>> Percpu:             2080 kB
>> Percpu:           219712 kB
>> Percpu:            72672 kB
>>
>> I'm able to see improvement comparable to that of what you're see too.
>>
>> However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
>>
>> POWER9 KVM 4CPU:4G
>> Vanilla 5.12-rc6
>> # ./percpu_test.sh
>> Percpu:             5888 kB
>> Percpu:           118272 kB
>> Percpu:           118272 kB
>>
>> 5.12-rc6 + with patchset applied
>> # ./percpu_test.sh
>> Percpu:             6144 kB
>> Percpu:           119040 kB
>> Percpu:           119040 kB
>>
>> I'm wondering if there's any architectural specific code that needs plumbing
>> here?
>>
> There shouldn't be. Can you send me the percpu_stats debug output before
> and after?

I'll paste the whole debug stats before and after here.
5.12-rc6 + patchset
-----BEFORE-----
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
   nr_alloc            :         9040
   nr_dealloc          :         6994
   nr_cur_alloc        :         2046
   nr_max_alloc        :         2208
   nr_chunks           :            3
   nr_max_chunks       :            3
   min_alloc_size      :            4
   max_alloc_size      :         1072
   empty_pop_pages     :           12

Per Chunk Stats:
----------------------------------------
Chunk: <- First Chunk
   nr_alloc            :          859
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :        16384
   free_bytes          :            0
   contig_bytes        :            0
   sum_frag            :            0
   max_frag            :            0
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :         1072
   memcg_aware         :            0

Chunk:
   nr_alloc            :          827
   max_alloc_size      :          992
   empty_pop_pages     :            8
   first_bit           :          692
   free_bytes          :       645012
   contig_bytes        :       460096
   sum_frag            :       466420
   max_frag            :       460096
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :          152
   memcg_aware         :            0

Chunk:
   nr_alloc            :          360
   max_alloc_size      :         1072
   empty_pop_pages     :            4
   first_bit           :        29207
   free_bytes          :       506640
   contig_bytes        :       506556
   sum_frag            :           84
   max_frag            :           32
   cur_min_alloc       :            4
   cur_med_alloc       :          156
   cur_max_alloc       :         1072
   memcg_aware         :            1

-----AFTER-----
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
   nr_alloc            :        97048
   nr_dealloc          :        95002
   nr_cur_alloc        :         2046
   nr_max_alloc        :        90054
   nr_chunks           :           48
   nr_max_chunks       :           48
   min_alloc_size      :            4
   max_alloc_size      :         1072
   empty_pop_pages     :           61

Per Chunk Stats:
----------------------------------------
Chunk: <- First Chunk
   nr_alloc            :          859
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :        16384
   free_bytes          :            0
   contig_bytes        :            0
   sum_frag            :            0
   max_frag            :            0
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :         1072
   memcg_aware         :            0

Chunk:
   nr_alloc            :          827
   max_alloc_size      :         1072
   empty_pop_pages     :            8
   first_bit           :          692
   free_bytes          :       645012
   contig_bytes        :       460096
   sum_frag            :       466420
   max_frag            :       460096
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :          152
   memcg_aware         :            0

Chunk:
   nr_alloc            :            0
   max_alloc_size      :            0
   empty_pop_pages     :            1
   first_bit           :            0
   free_bytes          :       655360
   contig_bytes        :       655360
   sum_frag            :            0
   max_frag            :            0
   cur_min_alloc       :            0
   cur_med_alloc       :            0
   cur_max_alloc       :            0
   memcg_aware         :            0

Chunk:
   nr_alloc            :          360
   max_alloc_size      :         1072
   empty_pop_pages     :            7
   first_bit           :        29207
   free_bytes          :       506640
   contig_bytes        :       506556
   sum_frag            :           84
   max_frag            :           32
   cur_min_alloc       :            4
   cur_med_alloc       :          156
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :            0
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :            0
   free_bytes          :       655360
   contig_bytes        :       655360
   sum_frag            :            0
   max_frag            :            0
   cur_min_alloc       :            0
   cur_med_alloc       :            0
   cur_max_alloc       :            0
   memcg_aware         :            1


I'm also pasting the logs before and after in a vanilla kernel too
There are considerably higher number of chunks in the vanilla kernel, than with
the patches though.

5.12-rc6 vanilla
-----BEFORE-----
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
   nr_max_alloc        :         2178
   nr_chunks           :            3
   nr_max_chunks       :            3
   min_alloc_size      :            4
   max_alloc_size      :         1072
   empty_pop_pages     :            5

Per Chunk Stats:
----------------------------------------
Chunk: <- First Chunk
   nr_alloc            :         1088
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :        16384
   free_bytes          :            0
   contig_bytes        :            0
   sum_frag            :            0
   max_frag            :            0
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :         1072
   memcg_aware         :            0

Chunk:
   nr_alloc            :          598
   max_alloc_size      :          992
   empty_pop_pages     :            5
   first_bit           :          642
   free_bytes          :       645012
   contig_bytes        :       504292
   sum_frag            :       140720
   max_frag            :       116456
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :          424
   memcg_aware         :            0

Chunk:
   nr_alloc            :          360
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :        27909
   free_bytes          :       506640
   contig_bytes        :       506556
   sum_frag            :           84
   max_frag            :           36
   cur_min_alloc       :            4
   cur_med_alloc       :          156
   cur_max_alloc       :         1072
   memcg_aware         :            1

-----AFTER-----
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
   nr_dealloc          :        94237
   nr_cur_alloc        :         2809
   nr_max_alloc        :        90054
   nr_chunks           :           11
   nr_max_chunks       :           47
   min_alloc_size      :            4
   max_alloc_size      :         1072
   empty_pop_pages     :           29

Per Chunk Stats:
----------------------------------------
Chunk: <- First Chunk
   nr_alloc            :         1088
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :        16384
   free_bytes          :            0
   contig_bytes        :            0
   sum_frag            :            0
   max_frag            :            0
   cur_min_alloc       :            4
   cur_med_alloc       :            8
   cur_max_alloc       :         1072
   memcg_aware         :            0

Chunk:
   nr_alloc            :          865
   max_alloc_size      :         1072
   empty_pop_pages     :            6
   first_bit           :          789
   free_bytes          :       640296
   contig_bytes        :       290672
   sum_frag            :       349624
   max_frag            :       169956
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
   nr_alloc            :           90
   max_alloc_size      :         1072
   empty_pop_pages     :            0
   first_bit           :            0
   free_bytes          :       595752
   contig_bytes        :        26164
   sum_frag            :       577748
   max_frag            :        26164
   cur_min_alloc       :          156
   cur_med_alloc       :         1072
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :           30
   max_alloc_size      :         1072
   empty_pop_pages     :            6
   first_bit           :            0
   free_bytes          :       636608
   contig_bytes        :       397944
   sum_frag            :       636500
   max_frag            :       426720
   cur_min_alloc       :          156
   cur_med_alloc       :          312
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :          360
   max_alloc_size      :         1072
   empty_pop_pages     :            7
   first_bit           :        27909
   free_bytes          :       506640
   contig_bytes        :       506556
   sum_frag            :           84
   max_frag            :           36
   cur_min_alloc       :            4
   cur_med_alloc       :          156
   cur_max_alloc       :         1072
   memcg_aware         :            1

Chunk:
   nr_alloc            :           12
   max_alloc_size      :         1072
   empty_pop_pages     :            0
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
   empty_pop_pages     :           10
   first_bit           :            0
   free_bytes          :       655360
   contig_bytes        :       655360
   sum_frag            :            0
   max_frag            :            0
   cur_min_alloc       :            0
   cur_med_alloc       :            0
   cur_max_alloc       :            0
   memcg_aware         :            1

>> I will also look through the code to find the reason why POWER isn't
>> depopulating pages.
>>
>> Thank you,
>> Pratik
>>
>> On 08/04/21 9:27 am, Roman Gushchin wrote:
>>> In our production experience the percpu memory allocator is sometimes struggling
>>> with returning the memory to the system. A typical example is a creation of
>>> several thousands memory cgroups (each has several chunks of the percpu data
>>> used for vmstats, vmevents, ref counters etc). Deletion and complete releasing
>>> of these cgroups doesn't always lead to a shrinkage of the percpu memory,
>>> so that sometimes there are several GB's of memory wasted.
>>>
>>> The underlying problem is the fragmentation: to release an underlying chunk
>>> all percpu allocations should be released first. The percpu allocator tends
>>> to top up chunks to improve the utilization. It means new small-ish allocations
>>> (e.g. percpu ref counters) are placed onto almost filled old-ish chunks,
>>> effectively pinning them in memory.
>>>
>>> This patchset solves this problem by implementing a partial depopulation
>>> of percpu chunks: chunks with many empty pages are being asynchronously
>>> depopulated and the pages are returned to the system.
>>>
>>> To illustrate the problem the following script can be used:
>>>
>>> --
>>> #!/bin/bash
>>>
>>> cd /sys/fs/cgroup
>>>
>>> mkdir percpu_test
>>> echo "+memory" > percpu_test/cgroup.subtree_control
>>>
>>> cat /proc/meminfo | grep Percpu
>>>
>>> for i in `seq 1 1000`; do
>>>       mkdir percpu_test/cg_"${i}"
>>>       for j in `seq 1 10`; do
>>> 	mkdir percpu_test/cg_"${i}"_"${j}"
>>>       done
>>> done
>>>
>>> cat /proc/meminfo | grep Percpu
>>>
>>> for i in `seq 1 1000`; do
>>>       for j in `seq 1 10`; do
>>> 	rmdir percpu_test/cg_"${i}"_"${j}"
>>>       done
>>> done
>>>
>>> sleep 10
>>>
>>> cat /proc/meminfo | grep Percpu
>>>
>>> for i in `seq 1 1000`; do
>>>       rmdir percpu_test/cg_"${i}"
>>> done
>>>
>>> rmdir percpu_test
>>> --
>>>
>>> It creates 11000 memory cgroups and removes every 10 out of 11.
>>> It prints the initial size of the percpu memory, the size after
>>> creating all cgroups and the size after deleting most of them.
>>>
>>> Results:
>>>     vanilla:
>>>       ./percpu_test.sh
>>>       Percpu:             7488 kB
>>>       Percpu:           481152 kB
>>>       Percpu:           481152 kB
>>>
>>>     with this patchset applied:
>>>       ./percpu_test.sh
>>>       Percpu:             7488 kB
>>>       Percpu:           481408 kB
>>>       Percpu:           135552 kB
>>>
>>> So the total size of the percpu memory was reduced by more than 3.5 times.
>>>
>>> v3:
>>>     - introduced pcpu_check_chunk_hint()
>>>     - fixed a bug related to the hint check
>>>     - minor cosmetic changes
>>>     - s/pretends/fixes (cc Vlastimil)
>>>
>>> v2:
>>>     - depopulated chunks are sidelined
>>>     - depopulation happens in the reverse order
>>>     - depopulate list made per-chunk type
>>>     - better results due to better heuristics
>>>
>>> v1:
>>>     - depopulation heuristics changed and optimized
>>>     - chunks are put into a separate list, depopulation scan this list
>>>     - chunk->isolated is introduced, chunk->depopulate is dropped
>>>     - rearranged patches a bit
>>>     - fixed a panic discovered by krobot
>>>     - made pcpu_nr_empty_pop_pages per chunk type
>>>     - minor fixes
>>>
>>> rfc:
>>>     https://lwn.net/Articles/850508/
>>>
>>>
>>> Roman Gushchin (6):
>>>     percpu: fix a comment about the chunks ordering
>>>     percpu: split __pcpu_balance_workfn()
>>>     percpu: make pcpu_nr_empty_pop_pages per chunk type
>>>     percpu: generalize pcpu_balance_populated()
>>>     percpu: factor out pcpu_check_chunk_hint()
>>>     percpu: implement partial chunk depopulation
>>>
>>>    mm/percpu-internal.h |   4 +-
>>>    mm/percpu-stats.c    |   9 +-
>>>    mm/percpu.c          | 306 +++++++++++++++++++++++++++++++++++--------
>>>    3 files changed, 261 insertions(+), 58 deletions(-)
>>>
> Roman, sorry for the delay. I'm looking to apply this today to for-5.14.
>
> Thanks,
> Dennis
Thanks
Pratik
