Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9B3CF18C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhGTBBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:01:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7036 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbhGTAzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:55:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GTLjt6nwFzYcrx;
        Tue, 20 Jul 2021 09:29:54 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 20 Jul 2021 09:35:40 +0800
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 20 Jul
 2021 09:35:39 +0800
Subject: Re: [PATCH v2] irqchip/irq-gic-v3-its: Add the checking of ITS
 version for KVM
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, wangwudi <wangwudi@hisilicon.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
References: <1624342353-24595-1-git-send-email-zhangshaokun@hisilicon.com>
 <6a2aaa52-ef36-f462-5108-6ac53bc497d9@hisilicon.com>
 <87mtqik2o9.wl-maz@kernel.org>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <16aebf04-dab3-8fc1-22b8-f0c61e01bda9@hisilicon.com>
Date:   Tue, 20 Jul 2021 09:35:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87mtqik2o9.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2021/7/19 18:39, Marc Zyngier wrote:
> On Mon, 19 Jul 2021 06:39:50 +0100,
> Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
>>
>> Hi Marc,
>>
>> A gentle ping.
>>
>> Thanks,
>> Shaokun
>>
>> On 2021/6/22 14:12, Shaokun Zhang wrote:
>>> From: wangwudi <wangwudi@hisilicon.com>
>>>
>>> The version of GIC used by KVM is provided by gic_v3_kvm_info. The
>>> KVM that supports GICv4 or GICv4.1 only checks GIC version. Actually,
>>> the GIC and ITS need to work together. If we have multiple ITSs and
>>> GIC supports v4, there are two cases:
>>> 1. None of the ITS supports GICv4, gic_v3_kvm_info.has_v4is false,
>>> so the KVM will use GICv3;
>>> 2. At least one ITS supports GICv4, gic_v3_kvm_info has_v4 is true,
>>> so the KVM can use GICv4;
>>>
>>> It is the same as GICv4.1. For the first case that the KVM can use
>>> GICv4, it seems non-sensible. If we do check the ITS version, it
>>> will give correct version for KVM. So add the checking of ITS
>>> version for KVM: If and only if both GIC & ITS support GICv4,
>>> gic_kvm_info.has_v4 is true. If and only if both GIC & ITS support
>>> GICv4.1, gic_kvm_info.has_v4_1 is true.
> 
> What you don't explain here is what goes wrong. If there is no ITS

That's not completely wrong, we only want to make it more reasonable as
we said that in commit log.

> that supports GICv4.1 while the CPU interfaces and the RDs are
> advertising this support, so be it.
> 
> So please explain what goes wrong, and whether there is any platform
> in the wild that is showing this problem.

To be honest, I'm not sure that some platform has this issue. It is
detected by code reading.

Thanks,
Shaokun

> 
> Thanks,
> 
> 	M.
> 
