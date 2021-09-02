Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B072D3FE937
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbhIBG0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 02:26:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9393 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbhIBG0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 02:26:34 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H0W5q39J2z8xdS;
        Thu,  2 Sep 2021 14:21:19 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 2 Sep 2021 14:25:34 +0800
Subject: Re: [PATCH 3/6] mm/page_alloc.c: remove obsolete comment in
 free_pcppages_bulk()
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-4-linmiaohe@huawei.com>
 <20210831133830.GE4128@techsingularity.net>
 <884a4b72-95ab-0fca-6c74-d67535048736@huawei.com>
 <20210901151411.GH4128@techsingularity.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3cff22e0-760b-1a11-6f28-f257317eba7e@huawei.com>
Date:   Thu, 2 Sep 2021 14:25:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210901151411.GH4128@techsingularity.net>
Content-Type: text/plain; charset="iso-8859-15"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.75]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/1 23:14, Mel Gorman wrote:
> On Wed, Sep 01, 2021 at 03:49:03PM +0800, Miaohe Lin wrote:
>> On 2021/8/31 21:38, Mel Gorman wrote:
>>> On Mon, Aug 30, 2021 at 10:10:48PM +0800, Miaohe Lin wrote:
>>>> It's also confusing now. Remove it.
>>>>
>>>
>>> Why is the whole comment obsolete?
>>>
>>> The second two paragraphs about "all pages pinned" and pages_scanned is
>>> obsolete and can go but the first paragraph is valid.
>>>
>>
>> I think the first paragraph is invalid due to the below statement:
>> "Assumes all pages on list are in same zone, and of same order."
>> There are NR_PCP_LISTS lists and PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP
>> orders in pcp. So I think it's obsolete.
>>
> 
> Ah.
> 
>> Should I delete this statement in the first paragraph only?
>>
> 
> Remove ", and of same order"

Will do this in v2. Thanks.

> 

