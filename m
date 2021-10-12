Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515B7429AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhJLBUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:20:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14328 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhJLBUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:20:17 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HSyN505N2z8yMM;
        Tue, 12 Oct 2021 09:13:25 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 09:18:14 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 09:18:13 +0800
Subject: Re: [PATCH] regmap: Fix possible double-free in
 regcache_rbtree_exit()
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>
References: <20211011135526.282115-1-yangyingliang@huawei.com>
 <YWR2+CAtFuGl4cSz@sirena.org.uk>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <02aa09c9-e873-c741-dfb5-9ed439cc7cea@huawei.com>
Date:   Tue, 12 Oct 2021 09:18:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YWR2+CAtFuGl4cSz@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/10/12 1:40, Mark Brown wrote:
> On Mon, Oct 11, 2021 at 09:55:26PM +0800, Yang Yingliang wrote:
>> In regcache_rbtree_insert_to_block(), when 'present' realloc failed,
>> the 'blk' which is supposed to assign to 'rbnode->block' will be freed,
>> so 'rbnode->block' points a freed memory, in the error handling path of
>> regcache_rbtree_init(), 'rbnode->block' will be freed again in
>> regcache_rbtree_exit(), KASAN will report double-free as follows:
>>
>> BUG: KASAN: double-free or invalid-free in kfree+0xce/0x390
>> Call Trace:
>>   dump_stack_lvl+0xe2/0x152
>>   print_address_description.constprop.7+0x21/0x150
>>   kasan_report_invalid_free+0x6f/0xa0
>>   __kasan_slab_free+0x125/0x140
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.
OK
>
>> Set rbnode->block to NULL when the 'present' realloc failed to fix this.
> This is not a good fix, it will both leak block and corrupt the data
> structure since now there's a NULL pointer where there should be a data
> block.  We should instead be moving the assignment of rbnode->block up
> to immediately after the reallocation has succeeded so that the data
> structure stays valid even if the second reallocation fails.
I will send a v2 later.

Thanks,
Yang
