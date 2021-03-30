Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191E434DDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhC3BiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:38:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15812 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhC3Bhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:37:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8X825myHz9t7B;
        Tue, 30 Mar 2021 09:35:30 +0800 (CST)
Received: from [10.67.100.236] (10.67.100.236) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 09:37:28 +0800
Subject: Re: [PATCH v2 -next] arm64: smp: Add missing prototype for some smp.c
 functions
To:     Catalin Marinas <catalin.marinas@arm.com>,
        <wangkefeng.wang@huawei.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dbrazdil@google.com>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <valentin.schneider@arm.com>, <maz@kernel.org>
CC:     <johnny.chenyi@huawei.com>, <weiyongjun1@huawei.com>,
        <heying24@huawei.com>, <yuehaibing@huawei.com>
References: <20210328172147.GA19252@arm.com>
 <20210329034343.183974-1-chenlifu@huawei.com>
 <161702092523.22277.7957866135843338237.b4-ty@arm.com>
From:   chenlifu <chenlifu@huawei.com>
Message-ID: <f30834b9-2815-e576-93df-25dd8b43ebc2@huawei.com>
Date:   Tue, 30 Mar 2021 09:37:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <161702092523.22277.7957866135843338237.b4-ty@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.100.236]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/3/29 20:28, Catalin Marinas 写道:
> On Mon, 29 Mar 2021 11:43:43 +0800, Chen Lifu wrote:
>> In commit eb631bb5bf5b
>> ("arm64: Support arch_irq_work_raise() via self IPIs") a new
>> function "arch_irq_work_raise" was added without a prototype.
>>
>> In commit d914d4d49745
>> ("arm64: Implement panic_smp_self_stop()") a new
>> function "panic_smp_self_stop" was added without a prototype.
>>
>> [...]
> 
> Applied to arm64 (for-next/misc), thanks!
> 
> [1/1] arm64: smp: Add missing prototype for some smp.c functions
>        https://git.kernel.org/arm64/c/a52ef778ff28
> 

Thanks!

--
Chen Lifu
