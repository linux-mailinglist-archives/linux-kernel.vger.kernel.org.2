Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37323398842
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhFBL1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:27:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2850 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhFBL0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:26:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw6525WRnzWq9B;
        Wed,  2 Jun 2021 19:20:06 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:24:49 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:24:48 +0800
Subject: Re: [PATCH v2 4/7] ARM: mm: print out correct page table entries
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-5-wangkefeng.wang@huawei.com>
 <20210602104450.GH30436@shell.armlinux.org.uk>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <79a2aae4-834e-7ce1-e755-633d4073c088@huawei.com>
Date:   Wed, 2 Jun 2021 19:24:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210602104450.GH30436@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/2 18:44, Russell King (Oracle) wrote:
> On Wed, Jun 02, 2021 at 03:02:43PM +0800, Kefeng Wang wrote:
>> Like commit 67ce16ec15ce ("arm64: mm: print out correct page table entries")
>> does, drop the struct mm_struct argument of show_pte(), print the tables
>> based on the faulting address.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> This can be misleading on 32-bit ARM.
>
> The effective page tables for each thread are the threads *own* page
> tables. There is no hardware magic for addresses above PAGE_OFFSET being
> directed to the init_mm page tables.
>
> So, when we hit a fault in kernel space, we need to be printing the
> currently in-use page tables associated with the running thread.
>
> Hence:
>
>>   /*
>> - * This is useful to dump out the page tables associated with
>> - * 'addr' in mm 'mm'.
>> + * Dump out the page tables associated with 'addr' in the currently active mm
>>    */
>> -void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
>> +void show_pte(const char *lvl, unsigned long addr)
>>   {
>>   	pgd_t *pgd;
>> -
>> -	if (!mm)
>> +	struct mm_struct *mm;
>> +
>> +	if (addr < TASK_SIZE) {
>> +		mm = current->active_mm;
>> +		if (mm == &init_mm) {
>> +			printk("%s[%08lx] user address but active_mm is swapper\n",
>> +				lvl, addr);
>> +			return;
>> +		}
>> +	} else {
>>   		mm = &init_mm;
>> +	}
> is incorrect here.
>
> It's completely fine for architectures where kernel accesses always go
> to the init_mm page tables, but for 32-bit ARM that is not the case.
OK, I will drop this one, thanks
>
