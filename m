Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AAE3104BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 06:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBEFug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 00:50:36 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10543 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBEFuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:50:35 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601cdc830000>; Thu, 04 Feb 2021 21:49:55 -0800
Received: from [10.2.60.31] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 05:49:55 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
 <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
Date:   Thu, 4 Feb 2021 21:49:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YBzU5uUbwa+QIwBQ@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612504195; bh=IanrqRGxo10dCYdhSvV2QI9Ox25wHsXN8TeVjaQgFfk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ghlePawoEp/fnScOv8JFmuWqsJeUrg37wmsKYBDQM9xiRs8EUH+hG7Pq5KY0a9CmO
         Bq+7pAhQfF7it8KUMsSLK6KPbJqajK99WrMidj+7NCk8znkaS1HQMT9VaFM9+LFbi6
         WqZCM3teA/TQdEVoYlvbmi9dcK9elGIdKJn+6UnMGkzetEd4kv1uTMksR5n3+bb7fD
         zQn7yEtJJ5wZIAAWrXKDsUiRFEkXoSxceweJJK3lECoHPI1ftOmUmMKmXQBNn1JuLL
         QtnoxEGK0cF2pyGUJQW6Wk0PipInqrTqwxZ+PSSuDqyj5L61d3yeClqDQ88D8wWd92
         FhqtagG/YPHGg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 9:17 PM, Minchan Kim wrote:
...
>>>> Presumably, having the source code, you can easily deduce that a bluetooth
>>>> allocation failure goes directly to a CMA allocation failure, right?
>>
>> Still wondering about this...
> 
> It would work if we have full source code and stack are not complicated for
> every usecases. Having said, having a good central place automatically
> popped up is also beneficial for not to add similar statistics for each
> call sites.
> 
> Why do we have too many item in slab sysfs instead of creating each call
> site inventing on each own?
> 

I'm not sure I understand that question fully, but I don't think we need to
invent anything unique here. So far we've discussed debugfs, sysfs, and /proc,
none of which are new mechanisms.

...

>> It's actually easier to monitor one or two simpler items than it is to monitor
>> a larger number of complicated items. And I get the impression that this is
>> sort of a top-level, production software indicator.
> 
> Let me clarify one more time.
> 
> What I'd like to get ultimately is per-CMA statistics instead of
> global vmstat for the usecase at this moment. Global vmstat
> could help the decision whether I should go deeper but it ends up
> needing per-CMA statistics. And I'd like to keep them in sysfs,
> not debugfs since it should be stable as a telemetric.
> 
> What points do you disagree in this view?


No huge disagreements, I just want to get us down to the true essential elements
of what is required--and find a good home for the data. Initial debugging always
has excesses, and those should not end up in the more carefully vetted production
code.

If I were doing this, I'd probably consider HugeTLB pages as an example to follow,
because they have a lot in common with CMA: it's another memory allocation pool, and
people also want to monitor it.

HugeTLB pages and THP pages are monitored in /proc:
	/proc/meminfo and /proc/vmstat:

# cat meminfo |grep -i huge
AnonHugePages:     88064 kB
ShmemHugePages:        0 kB
FileHugePages:         0 kB
HugePages_Total:     500
HugePages_Free:      500
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:         1024000 kB

# cat vmstat | grep -i huge
nr_shmem_hugepages 0
nr_file_hugepages 0
nr_anon_transparent_hugepages 43
numa_huge_pte_updates 0

...aha, so is CMA:

# cat vmstat | grep -i cma
nr_free_cma 261718

# cat meminfo | grep -i cma
CmaTotal:        1048576 kB
CmaFree:         1046872 kB

OK, given that CMA is already in those two locations, maybe we should put
this information in one or both of those, yes?


thanks,
-- 
John Hubbard
NVIDIA
