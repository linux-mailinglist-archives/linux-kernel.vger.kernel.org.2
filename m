Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F6E3627B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbhDPS2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:28:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235735AbhDPS2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:28:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GI3axe063943;
        Fri, 16 Apr 2021 14:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Uivgcc3kp4ZXEFwE5Z3Es9h/FEQ0TfQRw0yn4ASPfB0=;
 b=ehr6QJLV8jxdj0LlBGhzm7ddQlsyIdxyQamvodJuWt4GggeOHBXDG88+HnYkA5GDthaf
 8PlHIKFFQ2pntnlPJAlmUxVUjxyWjuf2TcpM5H2dWZL4vVTv3HdskdygnLLaDeehFoj5
 H9af7Gk2kWMPWIVqp89yPS/rcS4n50Nmd0L7wosYL1XVcJeNjDlwqtFkumgTYnRG+5AW
 c5FBloPuh1y7CTuj5j47wej36gTrchYxuvLAX9qxL+Rb8vH7UynVHwT9kgMA4EzKPWhZ
 6WGK0GUIImMdCno84HZZtUoG72US77d/+9zfD52k4lrRuf1SPCIVKV9bMgAs/HDNtcC7 UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37yan19yuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 14:27:37 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13GI3fEH064451;
        Fri, 16 Apr 2021 14:27:37 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37yan19ytj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 14:27:36 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13GIJdoc007984;
        Fri, 16 Apr 2021 18:27:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 37u3n8afn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 18:27:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13GIRWM559441540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:27:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E3314C040;
        Fri, 16 Apr 2021 18:27:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FAA34C05A;
        Fri, 16 Apr 2021 18:27:24 +0000 (GMT)
Received: from [9.199.33.116] (unknown [9.199.33.116])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Apr 2021 18:27:21 +0000 (GMT)
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
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <8ea7c616-95e8-e391-5373-ebaf10836d2c@linux.ibm.com>
Date:   Fri, 16 Apr 2021 23:57:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHnFsL2G2bpOH8ML@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JKgSwVIu2aGkPea0sbrB_QpQjSc7j5xS
X-Proofpoint-ORIG-GUID: j-N2FHxUb_eLAw8c0ANgtWZF64ARIAej
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/04/21 10:43 pm, Roman Gushchin wrote:
> On Fri, Apr 16, 2021 at 08:58:33PM +0530, Pratik Sampat wrote:
>> Hello Dennis,
>>
>> I apologize for the clutter of logs before, I'm pasting the logs of before and
>> after the percpu test in the case of the patchset being applied on 5.12-rc6 and
>> the vanilla kernel 5.12-rc6.
>>
>> On 16/04/21 7:48 pm, Dennis Zhou wrote:
>>> Hello,
>>>
>>> On Fri, Apr 16, 2021 at 06:26:15PM +0530, Pratik Sampat wrote:
>>>> Hello Roman,
>>>>
>>>> I've tried the v3 patch series on a POWER9 and an x86 KVM setup.
>>>>
>>>> My results of the percpu_test are as follows:
>>>> Intel KVM 4CPU:4G
>>>> Vanilla 5.12-rc6
>>>> # ./percpu_test.sh
>>>> Percpu:             1952 kB
>>>> Percpu:           219648 kB
>>>> Percpu:           219648 kB
>>>>
>>>> 5.12-rc6 + with patchset applied
>>>> # ./percpu_test.sh
>>>> Percpu:             2080 kB
>>>> Percpu:           219712 kB
>>>> Percpu:            72672 kB
>>>>
>>>> I'm able to see improvement comparable to that of what you're see too.
>>>>
>>>> However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration
>>>>
>>>> POWER9 KVM 4CPU:4G
>>>> Vanilla 5.12-rc6
>>>> # ./percpu_test.sh
>>>> Percpu:             5888 kB
>>>> Percpu:           118272 kB
>>>> Percpu:           118272 kB
>>>>
>>>> 5.12-rc6 + with patchset applied
>>>> # ./percpu_test.sh
>>>> Percpu:             6144 kB
>>>> Percpu:           119040 kB
>>>> Percpu:           119040 kB
>>>>
>>>> I'm wondering if there's any architectural specific code that needs plumbing
>>>> here?
>>>>
>>> There shouldn't be. Can you send me the percpu_stats debug output before
>>> and after?
>> I'll paste the whole debug stats before and after here.
>> 5.12-rc6 + patchset
>> -----BEFORE-----
>> Percpu Memory Statistics
>> Allocation Info:
>
> Hm, this looks highly suspicious. Here is your stats in a more compact form:
>
> Vanilla
>
> nr_alloc            :         9038         nr_alloc            :        97046
> nr_dealloc          :         6992	   nr_dealloc          :        94237
> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2809
> nr_max_alloc        :         2178	   nr_max_alloc        :        90054
> nr_chunks           :            3	   nr_chunks           :           11
> nr_max_chunks       :            3	   nr_max_chunks       :           47
> min_alloc_size      :            4	   min_alloc_size      :            4
> max_alloc_size      :         1072	   max_alloc_size      :         1072
> empty_pop_pages     :            5	   empty_pop_pages     :           29
>
>
> Patched
>
> nr_alloc            :         9040         nr_alloc            :        97048
> nr_dealloc          :         6994	   nr_dealloc          :        95002
> nr_cur_alloc        :         2046	   nr_cur_alloc        :         2046
> nr_max_alloc        :         2208	   nr_max_alloc        :        90054
> nr_chunks           :            3	   nr_chunks           :           48
> nr_max_chunks       :            3	   nr_max_chunks       :           48
> min_alloc_size      :            4	   min_alloc_size      :            4
> max_alloc_size      :         1072	   max_alloc_size      :         1072
> empty_pop_pages     :           12	   empty_pop_pages     :           61
>
>
> So it looks like the number of chunks got bigger, as well as the number of
> empty_pop_pages? This contradicts to what you wrote, so can you, please, make
> sure that the data is correct and we're not messing two cases?
>
> So it looks like for some reason sidelined (depopulated) chunks are not getting
> freed completely. But I struggle to explain why the initial empty_pop_pages is
> bigger with the same amount of chunks.
>
> So, can you, please, apply the following patch and provide an updated statistics?

Unfortunately, I'm not completely well versed in this area, but yes the empty
pop pages number doesn't make sense to me either.

I re-ran the numbers trying to make sure my experiment setup is sane but
results remain the same.

Vanilla
nr_alloc            :         9040         nr_alloc            :        97048
nr_dealloc          :         6994	   nr_dealloc          :        94404
nr_cur_alloc        :         2046	   nr_cur_alloc        :         2644
nr_max_alloc        :         2169	   nr_max_alloc        :        90054
nr_chunks           :            3	   nr_chunks           :           10
nr_max_chunks       :            3	   nr_max_chunks       :           47
min_alloc_size      :            4	   min_alloc_size      :            4
max_alloc_size      :         1072	   max_alloc_size      :         1072
empty_pop_pages     :            4	   empty_pop_pages     :           32

With the patchset + debug patch the results are as follows:
Patched

nr_alloc            :         9040         nr_alloc            :        97048
nr_dealloc          :         6994	   nr_dealloc          :        94349
nr_cur_alloc        :         2046	   nr_cur_alloc        :         2699
nr_max_alloc        :         2194	   nr_max_alloc        :        90054
nr_chunks           :            3	   nr_chunks           :           48
nr_max_chunks       :            3	   nr_max_chunks       :           48
min_alloc_size      :            4	   min_alloc_size      :            4
max_alloc_size      :         1072	   max_alloc_size      :         1072
empty_pop_pages     :           12	   empty_pop_pages     :           54

With the extra tracing I can see 39 entries of "Chunk (sidelined)"
after the test was run. I don't see any entries for "Chunk (to depopulate)"

I've snipped the results of slidelined chunks because they went on for ~600
lines, if you need the full logs let me know.

Thank you,
Pratik

> --
>
>  From d0d2bfdb891afec6bd63790b3492b852db490640 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Fri, 16 Apr 2021 09:54:38 -0700
> Subject: [PATCH] percpu: include sidelined and depopulating chunks into debug
>   output
>
> Information about sidelined chunks and chunks in the depopulate queue
> could be extremely valuable for debugging different problems.
>
> Dump information about these chunks on pair with regular chunks
> in percpu slots via percpu stats interface.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>   mm/percpu-internal.h |  2 ++
>   mm/percpu-stats.c    | 10 ++++++++++
>   mm/percpu.c          |  4 ++--
>   3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
> index 8e432663c41e..c11f115ced5c 100644
> --- a/mm/percpu-internal.h
> +++ b/mm/percpu-internal.h
> @@ -90,6 +90,8 @@ extern spinlock_t pcpu_lock;
>   extern struct list_head *pcpu_chunk_lists;
>   extern int pcpu_nr_slots;
>   extern int pcpu_nr_empty_pop_pages[];
> +extern struct list_head pcpu_depopulate_list[];
> +extern struct list_head pcpu_sideline_list[];
>   
>   extern struct pcpu_chunk *pcpu_first_chunk;
>   extern struct pcpu_chunk *pcpu_reserved_chunk;
> diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
> index f6026dbcdf6b..af09ed1ea5f8 100644
> --- a/mm/percpu-stats.c
> +++ b/mm/percpu-stats.c
> @@ -228,6 +228,16 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>   				}
>   			}
>   		}
> +
> +		list_for_each_entry(chunk, &pcpu_sideline_list[type], list) {
> +			seq_puts(m, "Chunk (sidelined):\n");
> +			chunk_map_stats(m, chunk, buffer);
> +		}
> +
> +		list_for_each_entry(chunk, &pcpu_depopulate_list[type], list) {
> +			seq_puts(m, "Chunk (to depopulate):\n");
> +			chunk_map_stats(m, chunk, buffer);
> +		}
>   	}
>   
>   	spin_unlock_irq(&pcpu_lock);
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 5bb294e394b3..ded3a7541cb2 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -185,13 +185,13 @@ int pcpu_nr_empty_pop_pages[PCPU_NR_CHUNK_TYPES];
>    * List of chunks with a lot of free pages.  Used to depopulate them
>    * asynchronously.
>    */
> -static struct list_head pcpu_depopulate_list[PCPU_NR_CHUNK_TYPES];
> +struct list_head pcpu_depopulate_list[PCPU_NR_CHUNK_TYPES];
>   
>   /*
>    * List of previously depopulated chunks.  They are not usually used for new
>    * allocations, but can be returned back to service if a need arises.
>    */
> -static struct list_head pcpu_sideline_list[PCPU_NR_CHUNK_TYPES];
> +struct list_head pcpu_sideline_list[PCPU_NR_CHUNK_TYPES];
>   
>   
>   /*

