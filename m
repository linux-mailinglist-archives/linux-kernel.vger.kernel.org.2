Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65EA36205A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbhDPM45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 08:56:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242375AbhDPM44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:56:56 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GCYSIt041933;
        Fri, 16 Apr 2021 08:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=v3McqcvTMC+odTXkZKJnHA65XOrOIdg3EQFQ0uRxuGc=;
 b=R2ceyeoGBqelnPEMffSqmjdQM6gfhNAhEFLwHyWtIyeU2sA6TgCZwgEgfDrq1xLg9rqX
 LKPQN0mPx2xPXpMmkPZF+sYtgogkaWpSdlcpgDZXaNZi8trig8GPXyDIIpeZu6XjCJFa
 Mh91Ngylvu25BLI9HOU9QYLuJyP4njg3122WwHhA0m3i6TPYdrKb+kSnrmO12Bxj3+hm
 TllEnKRqiODYUrlwNCWQn+U+mO3M2g2Q0sqFAHosBuMwNOK0YVRYcs+6kWPdoqO7S3d/
 sXfTTM4SVJ03Tda3c/hyq+u1XwQ5uVXMrDUAuvoKZEyAfyKenGogpM8DzBorw8Hf5WbW Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xbpud94c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 08:56:24 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13GCZ8P2045109;
        Fri, 16 Apr 2021 08:56:23 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xbpud937-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 08:56:23 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13GCqhWM002168;
        Fri, 16 Apr 2021 12:56:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 37u3n8vfft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 12:56:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13GCtuou34144536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 12:55:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FC8D5204E;
        Fri, 16 Apr 2021 12:56:18 +0000 (GMT)
Received: from [9.85.93.147] (unknown [9.85.93.147])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3AC855204F;
        Fri, 16 Apr 2021 12:56:16 +0000 (GMT)
Subject: Re: [PATCH v3 0/6] percpu: partial chunk depopulation
To:     Roman Gushchin <guro@fb.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pratik.r.sampat@gmail.com
References: <20210408035736.883861-1-guro@fb.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <25c78660-9f4c-34b3-3a05-68c313661a46@linux.ibm.com>
Date:   Fri, 16 Apr 2021 18:26:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210408035736.883861-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XdCsG1Q_h6Sezonu6LuyfsQzueSmTccX
X-Proofpoint-GUID: HNh6dHjQ4oiUHgPKeGeb1X9Y5SRuHiBI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_07:2021-04-15,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roman,

I've tried the v3 patch series on a POWER9 and an x86 KVM setup.

My results of the percpu_test are as follows:
Intel KVM 4CPU:4G
Vanilla 5.12-rc6
# ./percpu_test.sh
Percpu:             1952 kB
Percpu:           219648 kB
Percpu:           219648 kB

5.12-rc6 + with patchset applied
# ./percpu_test.sh
Percpu:             2080 kB
Percpu:           219712 kB
Percpu:            72672 kB

I'm able to see improvement comparable to that of what you're see too.

However, on POWERPC I'm unable to reproduce these improvements with the patchset in the same configuration

POWER9 KVM 4CPU:4G
Vanilla 5.12-rc6
# ./percpu_test.sh
Percpu:             5888 kB
Percpu:           118272 kB
Percpu:           118272 kB

5.12-rc6 + with patchset applied
# ./percpu_test.sh
Percpu:             6144 kB
Percpu:           119040 kB
Percpu:           119040 kB

I'm wondering if there's any architectural specific code that needs plumbing
here?

I will also look through the code to find the reason why POWER isn't
depopulating pages.

Thank you,
Pratik

On 08/04/21 9:27 am, Roman Gushchin wrote:
> In our production experience the percpu memory allocator is sometimes struggling
> with returning the memory to the system. A typical example is a creation of
> several thousands memory cgroups (each has several chunks of the percpu data
> used for vmstats, vmevents, ref counters etc). Deletion and complete releasing
> of these cgroups doesn't always lead to a shrinkage of the percpu memory,
> so that sometimes there are several GB's of memory wasted.
>
> The underlying problem is the fragmentation: to release an underlying chunk
> all percpu allocations should be released first. The percpu allocator tends
> to top up chunks to improve the utilization. It means new small-ish allocations
> (e.g. percpu ref counters) are placed onto almost filled old-ish chunks,
> effectively pinning them in memory.
>
> This patchset solves this problem by implementing a partial depopulation
> of percpu chunks: chunks with many empty pages are being asynchronously
> depopulated and the pages are returned to the system.
>
> To illustrate the problem the following script can be used:
>
> --
> #!/bin/bash
>
> cd /sys/fs/cgroup
>
> mkdir percpu_test
> echo "+memory" > percpu_test/cgroup.subtree_control
>
> cat /proc/meminfo | grep Percpu
>
> for i in `seq 1 1000`; do
>      mkdir percpu_test/cg_"${i}"
>      for j in `seq 1 10`; do
> 	mkdir percpu_test/cg_"${i}"_"${j}"
>      done
> done
>
> cat /proc/meminfo | grep Percpu
>
> for i in `seq 1 1000`; do
>      for j in `seq 1 10`; do
> 	rmdir percpu_test/cg_"${i}"_"${j}"
>      done
> done
>
> sleep 10
>
> cat /proc/meminfo | grep Percpu
>
> for i in `seq 1 1000`; do
>      rmdir percpu_test/cg_"${i}"
> done
>
> rmdir percpu_test
> --
>
> It creates 11000 memory cgroups and removes every 10 out of 11.
> It prints the initial size of the percpu memory, the size after
> creating all cgroups and the size after deleting most of them.
>
> Results:
>    vanilla:
>      ./percpu_test.sh
>      Percpu:             7488 kB
>      Percpu:           481152 kB
>      Percpu:           481152 kB
>
>    with this patchset applied:
>      ./percpu_test.sh
>      Percpu:             7488 kB
>      Percpu:           481408 kB
>      Percpu:           135552 kB
>
> So the total size of the percpu memory was reduced by more than 3.5 times.
>
> v3:
>    - introduced pcpu_check_chunk_hint()
>    - fixed a bug related to the hint check
>    - minor cosmetic changes
>    - s/pretends/fixes (cc Vlastimil)
>
> v2:
>    - depopulated chunks are sidelined
>    - depopulation happens in the reverse order
>    - depopulate list made per-chunk type
>    - better results due to better heuristics
>
> v1:
>    - depopulation heuristics changed and optimized
>    - chunks are put into a separate list, depopulation scan this list
>    - chunk->isolated is introduced, chunk->depopulate is dropped
>    - rearranged patches a bit
>    - fixed a panic discovered by krobot
>    - made pcpu_nr_empty_pop_pages per chunk type
>    - minor fixes
>
> rfc:
>    https://lwn.net/Articles/850508/
>
>
> Roman Gushchin (6):
>    percpu: fix a comment about the chunks ordering
>    percpu: split __pcpu_balance_workfn()
>    percpu: make pcpu_nr_empty_pop_pages per chunk type
>    percpu: generalize pcpu_balance_populated()
>    percpu: factor out pcpu_check_chunk_hint()
>    percpu: implement partial chunk depopulation
>
>   mm/percpu-internal.h |   4 +-
>   mm/percpu-stats.c    |   9 +-
>   mm/percpu.c          | 306 +++++++++++++++++++++++++++++++++++--------
>   3 files changed, 261 insertions(+), 58 deletions(-)
>

