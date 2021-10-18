Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41054431A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJRNDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:03:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29905 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhJRNDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:03:16 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HXxhZ6XbWzbnFc;
        Mon, 18 Oct 2021 20:56:30 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 21:01:02 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 21:01:02 +0800
Message-ID: <6e310e59-c0b6-5ba2-f927-7754c3e9e941@huawei.com>
Date:   Mon, 18 Oct 2021 21:01:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2 1/2] mm/vmalloc: fix numa spreading for large hash
 tables
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>, <shakeelb@google.com>, <urezki@gmail.com>
References: <20211018123710.1540996-1-chenwandun@huawei.com>
 <20211018123710.1540996-2-chenwandun@huawei.com>
 <YW1rEt0u2CSCYgnJ@casper.infradead.org>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <YW1rEt0u2CSCYgnJ@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/10/18 20:39, Matthew Wilcox 写道:
> On Mon, Oct 18, 2021 at 08:37:09PM +0800, Chen Wandun wrote:
>> Eric Dumazet reported a strange numa spreading info in [1], and found
>> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
>> this issue [2].
> 
> I think the root problem here is that we have two meanings for
> NUMA_NO_NODE.  I tend to read it as "The memory can be allocated from
> any node", but here it's used to mean "The memory should be spread over
> every node".  Should we split those out as -1 and -2?
Yes, the intent of NUMA_NO_NODE some time is confused.

Besides，I think NUMA_NO_NODE should consider mempolicy in
most cases in the kernel unless it point out explicitly memory
can be allocated without considering mempolicy.

> .
> 
