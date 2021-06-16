Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13A63A8E62
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhFPBdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:33:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6385 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhFPBdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:33:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G4SGH28MGz6y5V;
        Wed, 16 Jun 2021 09:27:03 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 09:31:02 +0800
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 09:31:01 +0800
Subject: Re: [PATCH] irqchip/irq-gic-v3-its: Add the checking of ITS version
 for KVM
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Wudi Wang <wangwudi@hisilicon.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
References: <1623390746-54627-1-git-send-email-zhangshaokun@hisilicon.com>
 <87fsxorfrv.wl-maz@kernel.org>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <5820b7a1-d8fb-b81b-e77f-b251aa84079c@hisilicon.com>
Date:   Wed, 16 Jun 2021 09:31:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87fsxorfrv.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Apologies for reply so slow because of a short holiday in China.

On 2021/6/11 16:01, Marc Zyngier wrote:
> On Fri, 11 Jun 2021 06:52:26 +0100,
> Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
>>
>> From: Wudi Wang <wangwudi@hisilicon.com>
>>
>> The version of GIC used by KVM is provided by gic_v3_kvm_info.
>> The KVM that supports GICv4 or GICv4.1 only checks GIC
>> version. Actually, the GIC and ITS need to work together.
>> So we add the checking of ITS version for KVM: If and only if
>> both GIC & ITS support GICv4, gic_kvm_info.has_v4 is true.
>> If and only if both GIC & ITS support GICv4.1,
>> gic_kvm_info.has_v4_1 is true.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Wudi Wang <wangwudi@hisilicon.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  drivers/irqchip/irq-gic-common.h |  2 ++
>>  drivers/irqchip/irq-gic-v3-its.c |  3 +++
>>  drivers/irqchip/irq-gic-v3.c     | 10 +++++-----
>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
>> index ccba8b0fe0f5..e5d44998445a 100644
>> --- a/drivers/irqchip/irq-gic-common.h
>> +++ b/drivers/irqchip/irq-gic-common.h
>> @@ -10,6 +10,8 @@
>>  #include <linux/irqdomain.h>
>>  #include <linux/irqchip/arm-gic-common.h>
>>  
>> +extern struct gic_kvm_info gic_v3_kvm_info;
>> +
>>  struct gic_quirk {
>>  	const char *desc;
>>  	const char *compatible;
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 2e6923c2c8a8..45d6163c14d5 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -5419,6 +5419,9 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>>  		has_v4_1 |= is_v4_1(its);
>>  	}
>>  
>> +	gic_v3_kvm_info.has_v4 = has_v4;
>> +	gic_v3_kvm_info.has_v4_1 = has_v4_1;
> 
> If you are going down that road: what if you have multiple ITSs,
> implementing a variety of v3, v4, v4.1? We currently support this to
> some extent, but this is breaking it.

If we have multiple ITSs and GIC supports v4, there are two cases:
1. None of the ITS supports GICv4(GICv4.1), gic_v3_kvm_info.has_v4(has_v4_1) is false,
so the KVM will use GICv3;
2. At least one ITS supports GICv4(GICv4.1), gic_v3_kvm_info.has_v4(has_v4_1) is true,
so the KVM will use GICv4(GICv4.1);
Variable has_v4(has_v4_1) can do this.

> 
> What case are you exactly trying to fix?
> 

The first case that the KVM can use GICv4, it seem non-sensible. If we do check the
ITS version, it will give correct version for KVM.

>> +
>>  	/* Don't bother with inconsistent systems */
>>  	if (WARN_ON(!has_v4_1 && rdists->has_rvpeid))
>>  		rdists->has_rvpeid = false;
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 37a23aa6de37..7454f99bf580 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -103,7 +103,7 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
>>  /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
>>  static refcount_t *ppi_nmi_refs;
>>  
>> -static struct gic_kvm_info gic_v3_kvm_info;
>> +struct gic_kvm_info gic_v3_kvm_info;
> 
> This will conflict with the rework that is in -next, and maybe cause
> some lifetime issue (see how the structure is now tagged __initdata).
> 

OOPS, I didn't check the -next branch, if you are happy about this patch and
I will rebase the newest -next and repost.

Thanks,
Shaokun

>>  static DEFINE_PER_CPU(bool, has_rss);
>>  
>>  #define MPIDR_RS(mpidr)			(((mpidr) & 0xF0UL) >> 4)
>> @@ -1850,8 +1850,8 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
>>  	if (!ret)
>>  		gic_v3_kvm_info.vcpu = r;
>>  
>> -	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
>> -	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
>> +	gic_v3_kvm_info.has_v4 &= gic_data.rdists.has_vlpis;
>> +	gic_v3_kvm_info.has_v4_1 &= gic_data.rdists.has_rvpeid;
>>  	gic_set_kvm_info(&gic_v3_kvm_info);
>>  }
>>  
>> @@ -2166,8 +2166,8 @@ static void __init gic_acpi_setup_kvm_info(void)
>>  		vcpu->end = vcpu->start + ACPI_GICV2_VCPU_MEM_SIZE - 1;
>>  	}
>>  
>> -	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
>> -	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
>> +	gic_v3_kvm_info.has_v4 &= gic_data.rdists.has_vlpis;
>> +	gic_v3_kvm_info.has_v4_1 &= gic_data.rdists.has_rvpeid;
>>  	gic_set_kvm_info(&gic_v3_kvm_info);
>>  }
> 
> Thanks,
> 
> 	M.
> 
