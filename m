Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5374640F286
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhIQGjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:39:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235165AbhIQGje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:39:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H6WBKO026707;
        Fri, 17 Sep 2021 02:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=q3utXwkW2U2ltS/BURD7rutV4U6JNK34trsTmZzHHCw=;
 b=padspnso290JTarM4TO15QJ4sgnGAlSxhAExLdsmCWxnFrZzlDflMTUHkgBqOfVbticm
 Wvsf3VoBeycAJ9NpOY/F/541eJNfUXaxnmYsPyV6bdMhF2vF1YAsXThzKxjH0vDa5Y+d
 EIi6frGwI9KYq5mSI/TKCGwEyX8CdDgS19HPzDEy38ml2zIim9JwqJ6un9qfO7lZGitx
 aGdgMIePQHZfX6AoYZwmWJoHhhDpKgXtoGSs9xNA7anLtIs4LQTbdQwbGoT2bUKFCeK/
 +LFisSndifYVRQS49+TVsyOf9mfatGbcdOkLZ5FG2BHLBYdwOeD/xigxquS7WhNVDo2D RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b4g66712d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 02:38:00 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18H5o1mx019974;
        Fri, 17 Sep 2021 02:38:00 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b4g66711p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 02:38:00 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18H6WXEr027827;
        Fri, 17 Sep 2021 06:37:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3b0kqkjugk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 06:37:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18H6btU643778458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 06:37:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ABC911C084;
        Fri, 17 Sep 2021 06:37:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6A6111C04C;
        Fri, 17 Sep 2021 06:37:51 +0000 (GMT)
Received: from Madhavan.PrimaryTP (unknown [9.43.58.158])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Sep 2021 06:37:51 +0000 (GMT)
Subject: Re: [PATCH v1 01/13] perf/core: add union to struct perf_branch_entry
To:     Stephane Eranian <eranian@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com,
        atrajeev@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-2-eranian@google.com>
 <20210909190342.GE4323@worktop.programming.kicks-ass.net>
 <878s04my3b.fsf@mpe.ellerman.id.au> <875yv8ms7f.fsf@mpe.ellerman.id.au>
 <CABPqkBQZ48b51vh1vqafOwVK2tBqYFNFGJT2x-a39Ma0TbS=tA@mail.gmail.com>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
Message-ID: <b21bf42e-377d-36d0-49c3-af1e4edf5496@linux.ibm.com>
Date:   Fri, 17 Sep 2021 12:07:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPqkBQZ48b51vh1vqafOwVK2tBqYFNFGJT2x-a39Ma0TbS=tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bc7qGFn4sAJKU2lRe4pVFGKEevsh-bgq
X-Proofpoint-GUID: 5BCmTemU-hTJpBQnaHU2b1e3CIR4m4Gq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_03,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1011 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/15/21 11:33 AM, Stephane Eranian wrote:
> Michael,
>
>
> On Fri, Sep 10, 2021 at 7:16 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>>> On Thu, Sep 09, 2021 at 12:56:48AM -0700, Stephane Eranian wrote:
>>>>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>>>>> index f92880a15645..eb11f383f4be 100644
>>>>> --- a/include/uapi/linux/perf_event.h
>>>>> +++ b/include/uapi/linux/perf_event.h
>>>>> @@ -1329,13 +1329,18 @@ union perf_mem_data_src {
>>>>>   struct perf_branch_entry {
>>>>>      __u64   from;
>>>>>      __u64   to;
>>>>> -   __u64   mispred:1,  /* target mispredicted */
>>>>> -           predicted:1,/* target predicted */
>>>>> -           in_tx:1,    /* in transaction */
>>>>> -           abort:1,    /* transaction abort */
>>>>> -           cycles:16,  /* cycle count to last branch */
>>>>> -           type:4,     /* branch type */
>>>>> -           reserved:40;
>>>>> +   union {
>>>>> +           __u64   val;        /* to make it easier to clear all fields */
>>>>> +           struct {
>>>>> +                   __u64   mispred:1,  /* target mispredicted */
>>>>> +                           predicted:1,/* target predicted */
>>>>> +                           in_tx:1,    /* in transaction */
>>>>> +                           abort:1,    /* transaction abort */
>>>>> +                           cycles:16,  /* cycle count to last branch */
>>>>> +                           type:4,     /* branch type */
>>>>> +                           reserved:40;
>>>>> +           };
>>>>> +   };
>>>>>   };
>>>>
>>>> Hurpmh... all other bitfields have ENDIAN_BITFIELD things except this
>>>> one. Power folks, could you please have a look?
>>> The bit number of each field changes between big and little endian, but
>>> as long as kernel and userspace are the same endian, and both only
>>> access values via the bitfields then it works.
>> ...
>>> It does look like we have a bug in perf tool though, if I take a
>>> perf.data from a big endian system to a little endian one I don't see
>>> any of the branch flags decoded. eg:
>>>
>>> BE:
>>>
>>> 2413132652524 0x1db8 [0x2d0]: PERF_RECORD_SAMPLE(IP, 0x1): 5279/5279: 0xc00000000045c028 period: 923003 addr: 0
>>> ... branch stack: nr:28
>>> .....  0: c00000000045c028 -> c00000000dce7604 0 cycles  P   0
>>>
>>> LE:
>>>
>>> 2413132652524 0x1db8 [0x2d0]: PERF_RECORD_SAMPLE(IP, 0x1): 5279/5279: 0xc00000000045c028 period: 923003 addr: 0
>>> ... branch stack: nr:28
>>> .....  0: c00000000045c028 -> c00000000dce7604 0 cycles      0
>>>                                                           ^
>>>                                                           missing P
>>>
>>> I guess we're missing a byte swap somewhere.
>> Ugh. We _do_ have a byte swap, but we also need a bit swap.
>>
>> That works for the single bit fields, not sure if it will for the
>> multi-bit fields.
>>
>> So that's a bit of a mess :/
>>
> Based on what I see in perf_event.h for other structures, I think I
> can make up what you would need for struct branch_entry. But Iit would
> be easier if you could send me a patch that you would have verified on
> your systems.
> Thanks.
Attached patch fixes the issue. Have tested both in both in BE and LE case.

Maddy

 From f816ba2e6ef8d5975f78442d7ecb50d66c3c4326 Mon Sep 17 00:00:00 2001
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Date: Wed, 15 Sep 2021 22:29:09 +0530
Subject: [RFC PATCH] tools/perf: Add reverse_64b macro

branch_stack struct has bit field definition
producing different bit ordering for big/little endian.
Because of this, when branch_stack sample collected
in a BE system viewed/reported in a LE system,
bit fields of the branch stack are not presented
properly. To address this issue, a reverse_64b
macro is defined and introduced in evsel__parse_sample.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
  tools/perf/util/evsel.c | 35 +++++++++++++++++++++++++++++++++--
  1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..3151606e516e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2221,6 +2221,9 @@ void __weak arch_perf_parse_sample_weight(struct 
perf_sample *data,
      data->weight = *array;
  }

+#define reverse_64b(src, pos, size)    \
+    (((src >> pos) & (( 1ull <<size) - 1)) << (63 - (pos + size - 1)))
+
  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
              struct perf_sample *data)
  {
@@ -2408,6 +2411,8 @@ int evsel__parse_sample(struct evsel *evsel, union 
perf_event *event,
      if (type & PERF_SAMPLE_BRANCH_STACK) {
          const u64 max_branch_nr = UINT64_MAX /
                        sizeof(struct branch_entry);
+        struct branch_entry *e;
+        unsigned i;

          OVERFLOW_CHECK_u64(array);
          data->branch_stack = (struct branch_stack *)array++;
@@ -2416,10 +2421,36 @@ int evsel__parse_sample(struct evsel *evsel, 
union perf_event *event,
              return -EFAULT;

          sz = data->branch_stack->nr * sizeof(struct branch_entry);
-        if (evsel__has_branch_hw_idx(evsel))
+        if (evsel__has_branch_hw_idx(evsel)) {
              sz += sizeof(u64);
-        else
+            e = &data->branch_stack->entries[0];
+        } else {
              data->no_hw_idx = true;
+            e = (struct branch_entry *)&data->branch_stack->hw_idx;
+        }
+
+        if (swapped) {
+            for (i = 0; i < data->branch_stack->nr; i++, e++) {
+                u64 new_val = 0;
+
+                /* mispred:1  target mispredicted */
+                new_val = reverse_64b(e->flags.value, 0, 1);
+                /* predicted:1  target predicted */
+                new_val |= reverse_64b(e->flags.value, 1, 1);
+                /* in_tx:1  in transaction */
+                new_val |= reverse_64b(e->flags.value, 2, 1);
+                /* abort:1  transaction abort */
+                new_val |= reverse_64b(e->flags.value, 3, 1);
+                /* cycles:16  cycle count to last branch */
+                new_val |= reverse_64b(e->flags.value, 4, 16);
+                /* type:4  branch type */
+                new_val |= reverse_64b(e->flags.value, 20, 4);
+                /* reserved:40 */
+                new_val |= reverse_64b(e->flags.value, 24, 40);
+                e->flags.value = new_val;
+            }
+        }
+
          OVERFLOW_CHECK(array, sz, max_size);
          array = (void *)array + sz;
      }
-- 
2.31.1


