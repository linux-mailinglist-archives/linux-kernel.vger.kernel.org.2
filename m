Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8EC3EA601
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhHLNwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:52:17 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13267 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhHLNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:52:15 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Glp4z5Xchz1CVcp;
        Thu, 12 Aug 2021 21:51:31 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 21:51:48 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 21:51:47 +0800
Subject: Re: [PATCH v3 0/6] ARM: mm: cleanup page fault and fix pxn process
 issue
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Will Deacon <will@kernel.org>
References: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
 <a0c4b967-0dba-24eb-1c8d-580de1948e1c@huawei.com>
Message-ID: <a0f57e1f-0777-b072-ac5f-4cc4789cee9f@huawei.com>
Date:   Thu, 12 Aug 2021 21:51:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a0c4b967-0dba-24eb-1c8d-580de1948e1c@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/7/31 14:42, Kefeng Wang wrote:
>
> On 2021/6/10 20:35, Kefeng Wang wrote:
>> The patchset cleanup ARM page fault handle to improve readability,
>> fix the page table entries printing and fix infinite loop in the
>> page fault handler when user code execution with privilege mode if
>> ARM_LPAE enabled.
>
> Hi  Russell， I make some changes according your advise, could you give 
> me
>
> some comments about this patchset, I want to make sure that whether they
>
> can be sent to  the ARM patch system,  many thanks.

Keep ping...

>
>> v3:
>> - drop the fix about page table printing
>> - kill page table base print instead of printing the physical address
>> - only die when permission fault both kernel-mode and user code 
>> execution
>>    with privilege mode
>> - drop LPAE specific
>>
