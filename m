Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6751F35452D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbhDEQc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbhDEQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:32:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2C8C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=WlZlrre6xzixEo2giGUl6pFbTjNx7pniG1L/BRwxIwU=; b=tDA3jodwCZQinL1j+mqzmDIbMI
        5x9ANZXMUUVi7C+9PvXqBExh+5JA5lXzeFMV3qWB/f+e1Hr51A3Y4LJ7GR4c2ydyce3q2z8siPx7X
        7ytVHJajPFoNofR1z7SAxarTPpdtMVxwA1xbH9ln5e953zaaalkGsPXW0lvBPe8dVLbbuz8NfsJ4L
        fOBu5fjjaLIn//r9LFSgMjg4PBUt3+KhLPUDij3prUeeFUS8Z7mm10RG4LpIwTof6d0cbaq6WOxrj
        weRUDDc3tx360RWB9BvDsjkbWc/EcQycrIqf9TKhspUCRtTEmKW/EP5xuWzsR63VcddqMXedVMj9X
        lyEvvBCA==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTS8c-00Bc7S-Uq; Mon, 05 Apr 2021 16:31:50 +0000
Subject: Re: [PATCH v2] powerpc: iommu: fix build when neither PCI or IBMVIO
 is set
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
        Anton Blanchard <anton@samba.org>
References: <20210404192623.10697-1-rdunlap@infradead.org>
 <135d33bc-5520-d49b-dd1c-582c7d8e3bac@csgroup.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dbe0b77b-df0b-8477-cc78-3e0c392680e8@infradead.org>
Date:   Mon, 5 Apr 2021 09:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <135d33bc-5520-d49b-dd1c-582c7d8e3bac@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/21 2:04 AM, Christophe Leroy wrote:
> 
> 
> Le 04/04/2021 à 21:26, Randy Dunlap a écrit :
>> When neither CONFIG_PCI nor CONFIG_IBMVIO is set/enabled, iommu.c has a
>> build error. The fault injection code is not useful in that kernel config,
>> so make the FAIL_IOMMU option depend on PCI || IBMVIO.
>>
>> Prevents this build error (warning escalated to error):
>> ../arch/powerpc/kernel/iommu.c:178:30: error: 'fail_iommu_bus_notifier' defined but not used [-Werror=unused-variable]
>>    178 | static struct notifier_block fail_iommu_bus_notifier = {
>>
>> Fixes: d6b9a81b2a45 ("powerpc: IOMMU fault injection")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Anton Blanchard <anton@samba.org>
>> ---
>> I was supposed to update this about one month ago, but then I lost
>> some email and also took a break for a few weeks, then I remembered,
>> so here it is.
>>
>>   arch/powerpc/Kconfig.debug |    1 +
>>   1 file changed, 1 insertion(+)
> 
> Wouldn't it be cleaner to get rid of those two horid #ifdefs ?
> Of course we can do both.

Sure, that works. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 216871414434..d691afa8acf8 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -180,12 +180,10 @@ static struct notifier_block fail_iommu_bus_notifier = {
> 
>  static int __init fail_iommu_setup(void)
>  {
> -#ifdef CONFIG_PCI
> -    bus_register_notifier(&pci_bus_type, &fail_iommu_bus_notifier);
> -#endif
> -#ifdef CONFIG_IBMVIO
> -    bus_register_notifier(&vio_bus_type, &fail_iommu_bus_notifier);
> -#endif
> +    if (IS_ENABLED(CONFIG_PCI))
> +        bus_register_notifier(&pci_bus_type, &fail_iommu_bus_notifier);
> +    if (IS_ENABLED(CONFIG_IBMVIO))
> +        bus_register_notifier(&vio_bus_type, &fail_iommu_bus_notifier);
> 
>      return 0;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 86c799c97b77..361f4f255911 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -964,6 +964,8 @@ enum {
>  #define PCI_IRQ_MSIX        (1 << 2) /* Allow MSI-X interrupts */
>  #define PCI_IRQ_AFFINITY    (1 << 3) /* Auto-assign affinity */
> 
> +extern struct bus_type pci_bus_type;
> +
>  /* These external functions are only available when PCI support is enabled */
>  #ifdef CONFIG_PCI
> 
> @@ -986,8 +988,6 @@ enum pcie_bus_config_types {
> 
>  extern enum pcie_bus_config_types pcie_bus_config;
> 
> -extern struct bus_type pci_bus_type;
> -
>  /* Do NOT directly access these two variables, unless you are arch-specific PCI
>   * code, or PCI core code. */
>  extern struct list_head pci_root_buses;    /* List of all known PCI buses */


-- 
~Randy

