Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0912B4256C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbhJGPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:40:29 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51431 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241276AbhJGPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:40:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UqqzqC._1633621112;
Received: from 30.15.247.23(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UqqzqC._1633621112)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Oct 2021 23:38:33 +0800
Subject: Re: [PATCH 0/2] Support hugetlb charge moving at task migration
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1632843268.git.baolin.wang@linux.alibaba.com>
 <YVWVk559nm2xZ98R@dhcp22.suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <e52a85c4-e4b4-b91a-b5b4-4da6c44c5959@linux.alibaba.com>
Date:   Thu, 7 Oct 2021 23:39:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVWVk559nm2xZ98R@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

(Sorry for late reply due to my holidays)
On 2021/9/30 18:46, Michal Hocko wrote:
> On Wed 29-09-21 18:19:26, Baolin Wang wrote:
>> Hi,
>>
>> Now in the hugetlb cgroup, charges associated with a task aren't moved
>> to the new hugetlb cgroup at task migration, which is odd for hugetlb
>> cgroup usage.
> 
> Could you elaborate some more about the usecase and/or problems you see
> with the existing semantic?

The problems is that, it did not check if the tasks can move to the new 
hugetlb cgroup if the new hugetlb cgroup has a limitation, and the 
hugetlb cgroup usage is incorrect when moving tasks among hugetlb cgroups.

> 
>> This patch set adds hugetlb cgroup charge moving when
>> migrate tasks among cgroups, which are based on the memcg charge moving.
> 
> Memcg charge moving has shown some problems over time and hence this is
> not part of cgroup v2 interface anymore. Even for cgroup v1 this has

Sorry, I missed this part, could you elaborate on the issues? I can have 
a close look about the problems of memcg charge moving.

> been an opt-in. I do not see anything like that in this patch series.
> Why should all existing workloads follow a different semantic during
> task migration now?

But I think it is reasonable for some cases moving the old charging to 
the new cgroup when task migration. Maybe I can add a new hugetlb cgroup 
file to control if need this or not?

Thanks for your comments.
