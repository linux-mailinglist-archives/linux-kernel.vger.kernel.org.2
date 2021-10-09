Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9447427ACF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhJIOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:25:59 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35455 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234203AbhJIOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:25:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ur8TwzA_1633789438;
Received: from 30.39.195.203(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ur8TwzA_1633789438)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 Oct 2021 22:23:59 +0800
Subject: Re: [PATCH 0/2] Support hugetlb charge moving at task migration
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
 <YVWVk559nm2xZ98R@dhcp22.suse.cz>
 <e52a85c4-e4b4-b91a-b5b4-4da6c44c5959@linux.alibaba.com>
 <YV/vUIzx6RBPZJ1I@dhcp22.suse.cz>
 <d20cbaa5-d510-2039-4a3c-1f1cc8acd2d1@linux.alibaba.com>
 <YWAxqxvXBvjZrWsO@dhcp22.suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <63f50032-9df6-44aa-4b69-9b7882ee416d@linux.alibaba.com>
Date:   Sat, 9 Oct 2021 22:24:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWAxqxvXBvjZrWsO@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/8 19:55, Michal Hocko wrote:
> On Fri 08-10-21 17:17:12, Baolin Wang wrote:
>>
>>
>> On 2021/10/8 15:12, Michal Hocko wrote:
>>> On Thu 07-10-21 23:39:15, Baolin Wang wrote:
>>>> Hi Michal,
>>>>
>>>> (Sorry for late reply due to my holidays)
>>>> On 2021/9/30 18:46, Michal Hocko wrote:
>>>>> On Wed 29-09-21 18:19:26, Baolin Wang wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Now in the hugetlb cgroup, charges associated with a task aren't moved
>>>>>> to the new hugetlb cgroup at task migration, which is odd for hugetlb
>>>>>> cgroup usage.
>>>>>
>>>>> Could you elaborate some more about the usecase and/or problems you see
>>>>> with the existing semantic?
>>>>
>>>> The problems is that, it did not check if the tasks can move to the new
>>>> hugetlb cgroup if the new hugetlb cgroup has a limitation, and the hugetlb
>>>> cgroup usage is incorrect when moving tasks among hugetlb cgroups.
>>>
>>> Could you be more specific please? What do you mean by cgroup usage is
>>> incorrect? Ideally could you describe your usecase?
>>
>> Sorry for confusing, what I mean is, when tasks from one hugetlb cgroup are
>> migrated to a new hugetlb cgroup, the new hugetlb cgroup's hugetlb page
>> usage is not increased accordingly.
> 
> Which is a perferctly reasonable behavior as the memory has been
> consumed from the original cgroup and it will be freed there as well.
> Migrating to a new cgroup doesn't imply all the resources to be migrated
> as well.

OK.

>> The issue I found is just from my
>> testing for the hugetlb cgroup, and I think this is not resonable if we've
>> already set a hugetlb limitation for a cgroup, but we always ignore it when
>> tasks migration among hugetlb cgroups.
> 
> I would like to learn more about why you consider this unreasonable.
> This will likely depend on the reason why you want/need to migrate task.
> If you want to move a task to completely new resource domain (read a

Yes.

> completely different cgroup subtree) then I can imagine you want to
> leave all the resources but this will have problems with other resource
> controllers - e.g. memory cgroup v2 which doesn't allow charge migration
> either.

OK. I see. Thanks.
