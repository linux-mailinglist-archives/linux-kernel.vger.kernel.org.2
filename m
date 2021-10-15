Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A363C42E5BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhJOBHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:07:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28944 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhJOBHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:07:49 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HVnyd18C6zbn8n;
        Fri, 15 Oct 2021 09:01:13 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 09:05:42 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 09:05:41 +0800
Message-ID: <62435ab2-fa0d-0bd7-6cd0-829fc30e4d0b@huawei.com>
Date:   Fri, 15 Oct 2021 09:05:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/6] ARM: mm: cleanup page fault and fix pxn process
 issue
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Will Deacon <will@kernel.org>
References: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
 <22320379-1905-d678-bfd7-2e5e118fa578@huawei.com>
 <YWhapJ4oiD2dJADk@shell.armlinux.org.uk>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YWhapJ4oiD2dJADk@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/15 0:28, Russell King (Oracle) wrote:
> On Tue, Oct 12, 2021 at 09:41:23AM +0800, Kefeng Wang wrote:
>>
>>
>> On 2021/6/10 20:35, Kefeng Wang wrote:
>>> The patchset cleanup ARM page fault handle to improve readability,
>>> fix the page table entries printing and fix infinite loop in the
>>> page fault handler when user code execution with privilege mode if
>>> ARM_LPAE enabled.
>>
>> Hi Russell, I send the v3(most patches were reviewed by you in v2[1]) to
>> ARM patch system due to no more comments, and this patchset is suspended
>> too long without any changes, looking forward to your reply and hope it
>> could be merged, many thanks.
> 
> I did explicitly ask for the first two patches to be sent to the patch
> system during the v2 review as a way to cut down on the amount of work
> to review the entire patch set each time a new version is posted. Sadly
> that didn't happen, which is demotivating for a reviewer.

Oh, I should send the patch(already asked) to patch system ASAP,
sorry for not delay.

> 
> Having looked through the v3 patch set, I think I'm happy with it.
> 

It's greet to see that v3 is accepted, many thanks!

> Thanks.
> 
