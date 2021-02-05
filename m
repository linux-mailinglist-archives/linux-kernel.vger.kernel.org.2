Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8C311B08
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhBFEnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:43:05 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4853 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhBFDXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:23:44 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601dbf6f0000>; Fri, 05 Feb 2021 13:58:07 -0800
Received: from MacBook-Pro-10.local (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 21:58:07 +0000
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
 <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com>
 <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com>
 <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
 <YB1vIrgI9S/5CDxL@google.com>
 <269689b7-3b6d-55dc-9044-fbf2984089ab@nvidia.com>
 <YB24YXMJOjwokDb5@google.com>
 <CAJuCfpEaQqgsyGtzRvovpuLOELR0iRNvNF0rnih1bq0HQCTuww@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <cbd30192-6f9f-845c-6b1c-e21ed737781d@nvidia.com>
Date:   Fri, 5 Feb 2021 13:58:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEaQqgsyGtzRvovpuLOELR0iRNvNF0rnih1bq0HQCTuww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612562287; bh=TZac0H6IstOdYjffdGKHHDVGEFmbQ7hZGZcMNcV+pPM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=GV4zHoCH8XokZmyQqI1szC928lThgkfy3KmH5EvHhUZcx/d3boGoCWvI8uF1Oo1Qo
         0lWEMoQ/6J+ljAHxVK3WbNNKw66PNHmF4FQT4ID11LeadB0Uf9egYQNEwedU/Uepsz
         Dw55iHFBKMOI/M0o7NrloO4RIbsI3Q/7LmAmD/9z6wP9vtM1+ZEu3HJkU4RjmrXa4y
         xSy5mXIRMvHhKx0pfdcY7cIsGeMfbRPgeBujeVzjpbuMoAeiJRjrUj2A0pgiWv8FOO
         7lXecEbzimxVOECzNHp6qT/bSjFo7NGZcHwgglvAMX8xaCNpjsG7U5ktEn7E9a4Wcl
         EvvZqQ2mOJdSA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 1:52 PM, Suren Baghdasaryan wrote:
>>>> I takes your suggestion something like this.
>>>>
>>>> [alloc_range] could be order or range by interval
>>>>
>>>> /sys/kernel/mm/cma/cma-A/[alloc_range]/success
>>>> /sys/kernel/mm/cma/cma-A/[alloc_range]/fail
>>>> ..
>>>> ..
>>>> /sys/kernel/mm/cma/cma-Z/[alloc_range]/success
>>>> /sys/kernel/mm/cma/cma-Z/[alloc_range]/fail
> 
> The interface above seems to me the most useful actually, if by
> [alloc_range] you mean the different allocation orders. This would
> cover Minchan's per-CMA failure tracking and would also allow us to
> understand what kind of allocations are failing and therefore if the
> problem is caused by pinning/fragmentation or by over-utilization.
> 

I agree. That seems about right, now that we've established that
cma areas are a must-have.

thanks,
-- 
John Hubbard
NVIDIA
