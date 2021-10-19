Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D63433382
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhJSKcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:32:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:41566 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhJSKcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=foWliLIfpQWzapm4jJyfpBLdUGM8c6MljuN+v8bBOMc=; b=HdOLW0+VUbhUAxYyo
        xFMPtfsWVBp7UcoRg/Zyv+rg7ln267R85lA7sDQe4R3blKbiQDbiviad9ir7keWF83BPjZ9eXkR5a
        bfXlJDPi5jOXZ9Kh+XwmYPvarrYj3wU4HWh9bCk1K/JcHXJQiSdnyiJkUl6iPplUlxMovK5UQCd24
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mcmO3-006Sfx-3x; Tue, 19 Oct 2021 13:30:27 +0300
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited
 task
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
 <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz>
 <339ae4b5-6efd-8fc2-33f1-2eb3aee71cb2@virtuozzo.com>
 <YW6GoZhFUJc1uLYr@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <687bf489-f7a7-5604-25c5-0c1a09e0905b@virtuozzo.com>
Date:   Tue, 19 Oct 2021 13:30:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW6GoZhFUJc1uLYr@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.2021 11:49, Michal Hocko wrote:
> On Tue 19-10-21 09:30:18, Vasily Averin wrote:
> [...]
>> With my patch ("memcg: prohibit unconditional exceeding the limit of dying tasks") try_charge_memcg() can fail:
>> a) due to fatal signal
>> b) when mem_cgroup_oom -> mem_cgroup_out_of_memory -> out_of_memory() returns false (when select_bad_process() found nothing)
>>
>> To handle a) we can follow to your suggestion and skip excution of out_of_memory() in pagefault_out_of memory()
>> To handle b) we can go to retry: if mem_cgroup_oom() return OOM_FAILED.

> How is b) possible without current being killed? Do we allow remote
> charging?

out_of_memory for memcg_oom
 select_bad_process
  mem_cgroup_scan_tasks
   oom_evaluate_task
    oom_badness

        /*
         * Do not even consider tasks which are explicitly marked oom
         * unkillable or have been already oom reaped or the are in
         * the middle of vfork
         */
        adj = (long)p->signal->oom_score_adj;
        if (adj == OOM_SCORE_ADJ_MIN ||
                        test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
                        in_vfork(p)) {
                task_unlock(p);
                return LONG_MIN;
        }

This time we handle userspace page fault, so we cannot be kenrel thread,
and cannot be in_vfork().
However task can be marked as oom unkillable, 
i.e. have p->signal->oom_score_adj == OOM_SCORE_ADJ_MIN

It can be set via oom_score_adj_write().

Thank you,
	Vasily Averin
