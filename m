Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F82242667A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbhJHJSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:18:32 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44325 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236335AbhJHJS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:18:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ur-5elq_1633684590;
Received: from 30.21.164.80(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ur-5elq_1633684590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Oct 2021 17:16:30 +0800
Subject: Re: [PATCH 0/2] Support hugetlb charge moving at task migration
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
 <YVWVk559nm2xZ98R@dhcp22.suse.cz>
 <e52a85c4-e4b4-b91a-b5b4-4da6c44c5959@linux.alibaba.com>
 <YV/vUIzx6RBPZJ1I@dhcp22.suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <d20cbaa5-d510-2039-4a3c-1f1cc8acd2d1@linux.alibaba.com>
Date:   Fri, 8 Oct 2021 17:17:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YV/vUIzx6RBPZJ1I@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/8 15:12, Michal Hocko wrote:
> On Thu 07-10-21 23:39:15, Baolin Wang wrote:
>> Hi Michal,
>>
>> (Sorry for late reply due to my holidays)
>> On 2021/9/30 18:46, Michal Hocko wrote:
>>> On Wed 29-09-21 18:19:26, Baolin Wang wrote:
>>>> Hi,
>>>>
>>>> Now in the hugetlb cgroup, charges associated with a task aren't moved
>>>> to the new hugetlb cgroup at task migration, which is odd for hugetlb
>>>> cgroup usage.
>>>
>>> Could you elaborate some more about the usecase and/or problems you see
>>> with the existing semantic?
>>
>> The problems is that, it did not check if the tasks can move to the new
>> hugetlb cgroup if the new hugetlb cgroup has a limitation, and the hugetlb
>> cgroup usage is incorrect when moving tasks among hugetlb cgroups.
> 
> Could you be more specific please? What do you mean by cgroup usage is
> incorrect? Ideally could you describe your usecase?

Sorry for confusing, what I mean is, when tasks from one hugetlb cgroup 
are migrated to a new hugetlb cgroup, the new hugetlb cgroup's hugetlb 
page usage is not increased accordingly. The issue I found is just from 
my testing for the hugetlb cgroup, and I think this is not resonable if 
we've already set a hugetlb limitation for a cgroup, but we always 
ignore it when tasks migration among hugetlb cgroups.

>>>> This patch set adds hugetlb cgroup charge moving when
>>>> migrate tasks among cgroups, which are based on the memcg charge moving.
>>>
>>> Memcg charge moving has shown some problems over time and hence this is
>>> not part of cgroup v2 interface anymore. Even for cgroup v1 this has
>>
>> Sorry, I missed this part, could you elaborate on the issues? I can have a
>> close look about the problems of memcg charge moving.
> 
> The operation is quite expensive. Synchronization with charging is not
> trivial. I do not have the full list handy but you can search the
> mm mailing list archives for more information.

Sure, thanks.

> 
>>> been an opt-in. I do not see anything like that in this patch series.
>>> Why should all existing workloads follow a different semantic during
>>> task migration now?
>>
>> But I think it is reasonable for some cases moving the old charging to the
>> new cgroup when task migration. Maybe I can add a new hugetlb cgroup file to
>> control if need this or not?
> 
> It would be good to describe those use cases and why they really need
> this. Because as things stand now, the charge migration is not supported
> in cgroup v2 for memory cgroup controller and there are no plans to add
> the support so it would be quite unexpected that hugetlb controller
> would behave differently. And cgroup v1 is considered legacy and new
> features are ususally not added as there is a hope to move users to v2.

OK, understood. Seems you have a strong opinion that it is unnecessary 
to introduce this feature for cgroup v1 now, then I will drop this patch 
set. Thanks for your input.
