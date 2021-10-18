Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA5431266
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhJRIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:48:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13764 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhJRIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:47:49 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HXr545lDSzZcdN;
        Mon, 18 Oct 2021 16:43:52 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 16:45:36 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 16:45:36 +0800
Message-ID: <12d49ccf-774e-ebbf-6629-3fb5d28b5ddd@huawei.com>
Date:   Mon, 18 Oct 2021 16:45:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
To:     Eric Dumazet <edumazet@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <guohanjun@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
 <CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com>
 <8fc5e1ae-a356-6225-2e50-cf0e5ee26208@huawei.com>
 <1634261360.fed2opbgxw.astroid@bobo.none>
 <d1f7249d-ffc2-7038-ed4c-f7fbb3e68eda@huawei.com>
 <1634281763.ecsq6l88ia.astroid@bobo.none>
 <CANn89i+RoCSBB=st4yDoWCHDkPCw2OTgbKUeXKRC8ixFLjx4TQ@mail.gmail.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <CANn89i+RoCSBB=st4yDoWCHDkPCw2OTgbKUeXKRC8ixFLjx4TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/15 19:51, Eric Dumazet 写道:
> On Fri, Oct 15, 2021 at 12:11 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> 
>> Okay. It would be better to do it as two patches. First the minimal fix
>> so it can be backported easily and have the Fixes: tag pointed at my
>> commit. Then the performance optimization.
>>
> 
> +2, we need a small fix for stable branches.
OK, I will send patch v2.

Thanks,
Wandun

> 
> Thanks
> 
>> Thanks,
>> Nick
> .
> 
