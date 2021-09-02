Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7543FE940
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbhIBGdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 02:33:10 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15237 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbhIBGdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 02:33:08 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H0WKL6jyKz1DFPt;
        Thu,  2 Sep 2021 14:31:18 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 2 Sep 2021 14:32:01 +0800
Subject: Re: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro K()
To:     David Laight <David.Laight@ACULAB.COM>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <9161665.bUqNH3lxUD@natalenko.name>
 <52bbb8f2-db63-8c56-ea49-d982c13ba541@huawei.com>
 <9426505.MgecbftzqH@natalenko.name>
 <03653d41-abe0-46f0-9eee-28cad9f5edea@huawei.com>
 <f2f9754bef1b48b8b58718b2af21895f@AcuMS.aculab.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f94e8b6b-39cf-3aac-8cd1-c8859e820f84@huawei.com>
Date:   Thu, 2 Sep 2021 14:32:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f2f9754bef1b48b8b58718b2af21895f@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.75]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/2 5:25, David Laight wrote:
> From: Miaohe Lin
>> Sent: 01 September 2021 08:38
> ...
>>>>> Shouldn't this macro go to some header file instead to get rid of define
>>>>> repetitions?
>>>>
>>>> Many thanks for figuring this out. I think we should get rid of these
>>>> repetitions too. But I'am not sure where this definition should be. Any
>>>> suggestion? Thanks.
>>>
>>> I'm not sure what place suits best. At first I thought maybe linux/mm.h or
>>> linux/mm_inline.h, but since PAGE_SHIFT is declared in asm-generic/page.h,
>>> probably K(x) can also go there as well?
>>
>> K(x) is relevant with PAGE_SHIFT. So I think K(x) can also go asm-generic/page.h too.
>> Am I supposed to do this when free or will you kindly do this?
> 
> It is a bit of a short name to go in a public header file.
> 

It seems K(x) is a bit of short and it needs a more self-annotated name.
We can discuss this there:
https://lkml.org/lkml/2021/9/1/334

Thanks.

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

