Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969E039814B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhFBGoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:44:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3505 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhFBGny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:43:54 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fvzs90JyszYs96;
        Wed,  2 Jun 2021 14:39:25 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:42:07 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 14:42:07 +0800
Subject: Re: [PATCH 1/2] ARM: mm: Refactor __do_page_fault()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
References: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
 <20210529034138.83384-2-wangkefeng.wang@huawei.com>
 <20210601143125.GB30436@shell.armlinux.org.uk>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <8b528367-3636-d05b-84d3-754876ff1e6a@huawei.com>
Date:   Wed, 2 Jun 2021 14:42:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210601143125.GB30436@shell.armlinux.org.uk>
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


On 2021/6/1 22:31, Russell King (Oracle) wrote:
> On Sat, May 29, 2021 at 11:41:37AM +0800, Kefeng Wang wrote:
>> 1. cleanup access_error(), make vma flags set and check into
>>     __do_page_fault() and do_page_fault() directly.
>>
>> 2. drop fsr and task argument, instead, using vm_flags in
>>     __do_page_fault().
>>
>> 3. cleans up the multiple goto statements in __do_page_fault().
>>
>> 4. use current->mm directly in do_page_fault().
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> This patch is a really good example of something that is very difficult
> to review and see that there are no unintended changes.
>
> Many people have complained about my patches, where I create a series of
> many patches where each patch does exactly _one_ simple transformation to
> the code. This is a good example _why_ I do that - a step by step single
> transformation approach is way easier to review.
>
> Sorry, but I'm not able to sensibly review this patch, and therefore
> I won't apply it. Please split it into smaller changes.
Ok, will split it and send v2, thanks.
>
