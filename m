Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4593B396E40
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhFAHz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:55:29 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3366 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhFAHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:55:28 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FvPT662K0z630D;
        Tue,  1 Jun 2021 15:50:02 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:53:46 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:53:45 +0800
Subject: Re: [PATCH] genirq/msi: Fix unpaired calls in msi
To:     <maz@kernel.org>, <tglx@linutronix.de>
CC:     <john.wanghui@huawei.com>, <yangyingliang@huawei.com>,
        <dingtianhong@huawei.com>, <wangxiongfeng2@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20210518033117.78104-1-cuibixuan@huawei.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <70ac79fb-aa73-33fe-3ed5-f1d2b59ed7cb@huawei.com>
Date:   Tue, 1 Jun 2021 15:53:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210518033117.78104-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping :)

Thanks
Bixuan Cui

On 2021/5/18 11:31, Bixuan Cui wrote:
> There are unpaired calls in the msi:
> 
> msi_domain_alloc_irqs() {
>         ...
>         __irq_domain_alloc_irqs()
>         ...
>         irq_domain_activate_irq()
> }
> 
> msi_domain_free_irqs() {
>         ...
>         irq_domain_free_irqs()
> }
> 
> When msi_domain_alloc_irqs() and msi_domain_free_irqs() are called in
> pairs, the irq_domain_deactivate_irq() is missing calls.
> 
> This problem occurs during PCI initialization.After pci_msi_setup_msi_irqs
> is executed (invoke irq_domain_activate_irq to initialize the MSI irq),
> error_cleanup_irqs() of pcie_port_device_register() is executed.
> As follows:
> 
> pcie_port_device_register() {
> 	...
> 
> 	error_cleanup_irqs:
> 		pci_free_irq_vectors(dev);
> }
> 
> Invoking Procedure:
> 	pcie_port_device_register
> 	-> goto error_cleanup_irqs
> 	-> pci_free_irq_vectors(dev);
> 	    pci_disable_msi
> 	        free_msi_irqs
> 		    pci_msi_teardown_msi_irqs
> 		        msi_domain_free_irqs // no deactivate before free
> 			    irq_domain_free_irqs
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  kernel/irq/msi.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index c41965e348b5..8828d4863c5d 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -476,11 +476,6 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  	return 0;
>  
>  cleanup:
> -	for_each_msi_vector(desc, i, dev) {
> -		irq_data = irq_domain_get_irq_data(domain, i);
> -		if (irqd_is_activated(irq_data))
> -			irq_domain_deactivate_irq(irq_data);
> -	}
>  	msi_domain_free_irqs(domain, dev);
>  	return ret;
>  }
> @@ -506,6 +501,14 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
>  {
>  	struct msi_desc *desc;
> +	struct irq_data *irq_data;
> +	int i;
> +
> +	for_each_msi_vector(desc, i, dev) {
> +		irq_data = irq_domain_get_irq_data(domain, i);
> +		if (irqd_is_activated(irq_data))
> +			irq_domain_deactivate_irq(irq_data);
> +	}
>  
>  	for_each_msi_entry(desc, dev) {
>  		/*
> 
