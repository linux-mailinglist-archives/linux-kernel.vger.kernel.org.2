Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B453CCD7A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhGSFmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:42:53 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12226 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhGSFmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:42:52 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GSrB72wwnz1CLQh;
        Mon, 19 Jul 2021 13:34:07 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 13:39:51 +0800
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 13:39:51 +0800
Subject: Re: [PATCH v2] irqchip/irq-gic-v3-its: Add the checking of ITS
 version for KVM
To:     <linux-kernel@vger.kernel.org>
CC:     wangwudi <wangwudi@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <1624342353-24595-1-git-send-email-zhangshaokun@hisilicon.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <6a2aaa52-ef36-f462-5108-6ac53bc497d9@hisilicon.com>
Date:   Mon, 19 Jul 2021 13:39:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1624342353-24595-1-git-send-email-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

A gentle ping.

Thanks,
Shaokun

On 2021/6/22 14:12, Shaokun Zhang wrote:
> From: wangwudi <wangwudi@hisilicon.com>
> 
> The version of GIC used by KVM is provided by gic_v3_kvm_info. The
> KVM that supports GICv4 or GICv4.1 only checks GIC version. Actually,
> the GIC and ITS need to work together. If we have multiple ITSs and
> GIC supports v4, there are two cases:
> 1. None of the ITS supports GICv4, gic_v3_kvm_info.has_v4is false,
> so the KVM will use GICv3;
> 2. At least one ITS supports GICv4, gic_v3_kvm_info has_v4 is true,
> so the KVM can use GICv4;
> 
> It is the same as GICv4.1. For the first case that the KVM can use
> GICv4, it seems non-sensible. If we do check the ITS version, it
> will give correct version for KVM. So add the checking of ITS
> version for KVM: If and only if both GIC & ITS support GICv4,
> gic_kvm_info.has_v4 is true. If and only if both GIC & ITS support
> GICv4.1, gic_kvm_info.has_v4_1 is true.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Wudi Wang <wangwudi@hisilicon.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
> ChangeLog:
> v1-->v2:
>     1. Rebase to linux-next(Jun 21)
>     2. Rewrite the commit log
> 
>  drivers/irqchip/irq-gic-common.h |  2 ++
>  drivers/irqchip/irq-gic-v3-its.c |  3 +++
>  drivers/irqchip/irq-gic-v3.c     | 10 +++++-----
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> index 27e3d4ed4f32..7a360cb4a4c9 100644
> --- a/drivers/irqchip/irq-gic-common.h
> +++ b/drivers/irqchip/irq-gic-common.h
> @@ -28,4 +28,6 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>  void gic_enable_of_quirks(const struct device_node *np,
>  			  const struct gic_quirk *quirks, void *data);
>  
> +extern struct gic_kvm_info gic_v3_kvm_info;
> +
>  #endif /* _IRQ_GIC_COMMON_H */
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index ba39668c3e08..f65b13c4a08b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -5415,6 +5415,9 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>  		has_v4_1 |= is_v4_1(its);
>  	}
>  
> +	gic_v3_kvm_info.has_v4 = has_v4;
> +	gic_v3_kvm_info.has_v4_1 = has_v4_1;
> +
>  	/* Don't bother with inconsistent systems */
>  	if (WARN_ON(!has_v4_1 && rdists->has_rvpeid))
>  		rdists->has_rvpeid = false;
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index e0f4debe64e1..d4fa44d4765e 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -103,7 +103,7 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
>  /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
>  static refcount_t *ppi_nmi_refs;
>  
> -static struct gic_kvm_info gic_v3_kvm_info __initdata;
> +struct gic_kvm_info gic_v3_kvm_info __initdata;
>  static DEFINE_PER_CPU(bool, has_rss);
>  
>  #define MPIDR_RS(mpidr)			(((mpidr) & 0xF0UL) >> 4)
> @@ -1884,8 +1884,8 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
>  	if (!ret)
>  		gic_v3_kvm_info.vcpu = r;
>  
> -	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
> -	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
> +	gic_v3_kvm_info.has_v4 &= gic_data.rdists.has_vlpis;
> +	gic_v3_kvm_info.has_v4_1 &= gic_data.rdists.has_rvpeid;
>  	vgic_set_kvm_info(&gic_v3_kvm_info);
>  }
>  
> @@ -2200,8 +2200,8 @@ static void __init gic_acpi_setup_kvm_info(void)
>  		vcpu->end = vcpu->start + ACPI_GICV2_VCPU_MEM_SIZE - 1;
>  	}
>  
> -	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
> -	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
> +	gic_v3_kvm_info.has_v4 &= gic_data.rdists.has_vlpis;
> +	gic_v3_kvm_info.has_v4_1 &= gic_data.rdists.has_rvpeid;
>  	vgic_set_kvm_info(&gic_v3_kvm_info);
>  }
>  
> 
