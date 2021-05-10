Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F123D377D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhEJHfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhEJHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:35:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 00:34:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id p12so12648303pgj.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 00:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vA3gf5U3qgSMXovfcB4UhmgzKIceIYSkZrJbqbnFQQs=;
        b=TnymSowGCl8At/Z5vJjiv6UkoDI9j2N2BTdVmLCLCOKMpsMJulNPkSWZYc6yDKrvXU
         yKbWB1niCmvzdg5oH7OBLZdRVTkvbkCTpoF0KeXI6Gi0a+ZJwcsXngGOJdw7IqLU+aJR
         95UFJcfONNQPxssqx66EH8m4kWwWi+iDJwaGDtGuN8Sk+rNHrBQ5KmrsE04RYRv3/VSG
         94INqG/VKbm96f5jrlb/FK6dyOX1CWATud+m/4qnve7TXFuVOkrDX6SEbRJ1gW6U+DRx
         Z/7fQRIGJ39jY75K/HWCaIByNhj+rNsIptw+lzY7WEc+Z60Nm3/Tp9qlHrhRmLhA+Xiv
         QiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vA3gf5U3qgSMXovfcB4UhmgzKIceIYSkZrJbqbnFQQs=;
        b=bzKmZw2aXgtITHFtJqFa+F4VwFXOdbUNUetXZND2KNUUKyI+wzNfL7XbdZksleJEVP
         bfaetqieayw6qFV4d5ySC6UVDTvnmuHmpr6zJ9J1O+jbRR5tpsIyjBx02EpOvC/47nXl
         Q+XUt5u/sN4S1MbG+0cUgXJOhVz7UDuAhpe0QrE3cRurknLqWwdWYd0BoGIPQ1FjKx8G
         62nDxK5AWjWDEP/nXLOnNW6+WqNpJ5eF+OoPA5f7Ss2X3RiJxJLiEu5VQ4ckXB1uv5sX
         eSyfeVcWLyeBn1CU3ZaYT3mA+5zlyybr95c8dzGdhO4BhtEBuuyDY9cAv8ojGoPxD/r8
         wXAA==
X-Gm-Message-State: AOAM532aEBQAjLceCv9DnHLepOuq8pTec8258cK+grz6CZpH77D7BXd+
        +u2WOyzAl1ZvSAiJMsq0gJNeDg==
X-Google-Smtp-Source: ABdhPJzoWupZxWPbVtYgLa+kmwmlg4iI4EhPt8v8lypgPYnkfkeQ/6SdyDSS7bmttVEVYeQvrgTTCA==
X-Received: by 2002:a63:2c92:: with SMTP id s140mr24065723pgs.39.1620632051387;
        Mon, 10 May 2021 00:34:11 -0700 (PDT)
Received: from localhost (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.gmail.com with UTF8SMTPSA id s6sm10396487pgv.48.2021.05.10.00.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 00:34:10 -0700 (PDT)
Message-ID: <e4984fa0-2afe-a987-4fb8-61b878431b1f@ozlabs.ru>
Date:   Mon, 10 May 2021 17:34:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH v4 07/11] powerpc/pseries/iommu: Reorganize
 iommu_table_setparms*() with new helper
Content-Language: en-US
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210430163145.146984-1-leobras.c@gmail.com>
 <20210430163145.146984-8-leobras.c@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210430163145.146984-8-leobras.c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/21 02:31, Leonardo Bras wrote:
> Add a new helper _iommu_table_setparms(), and use it in
> iommu_table_setparms() and iommu_table_setparms_lpar() to avoid duplicated
> code.
> 
> Also, setting tbl->it_ops was happening outsite iommu_table_setparms*(),
> so move it to the new helper. Since we need the iommu_table_ops to be
> declared before used, move iommu_table_lpar_multi_ops and
> iommu_table_pseries_ops to before their respective iommu_table_setparms*().
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>


This does not apply anymore as it conflicts with my 4be518d838809e2135.


> ---
>   arch/powerpc/platforms/pseries/iommu.c | 100 ++++++++++++-------------
>   1 file changed, 50 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 5a70ecd579b8..89cb6e9e9f31 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -53,6 +53,11 @@ enum {
>   	DDW_EXT_QUERY_OUT_SIZE = 2
>   };
>   
> +#ifdef CONFIG_IOMMU_API
> +static int tce_exchange_pseries(struct iommu_table *tbl, long index, unsigned long *tce,
> +				enum dma_data_direction *direction, bool realmode);
> +#endif


Instead of declaring this so far from the the code which needs it, may 
be add

struct iommu_table_ops iommu_table_lpar_multi_ops;

right before iommu_table_setparms() (as the sctruct is what you actually 
want there), and you won't need to move iommu_table_pseries_ops as well.


> +
>   static struct iommu_table *iommu_pseries_alloc_table(int node)
>   {
>   	struct iommu_table *tbl;
> @@ -501,6 +506,28 @@ static int tce_setrange_multi_pSeriesLP_walk(unsigned long start_pfn,
>   	return tce_setrange_multi_pSeriesLP(start_pfn, num_pfn, arg);
>   }
>   
> +static inline void _iommu_table_setparms(struct iommu_table *tbl, unsigned long busno,


The underscore is confusing, may be iommu_table_do_setparms()? 
iommu_table_setparms_common()? Not sure. I cannot recall a single 
function with just one leading underscore, I suspect I was pushed back 
when I tried adding one ages ago :) "inline" seems excessive, the 
compiler will probably figure it out anyway.



> +					 unsigned long liobn, unsigned long win_addr,
> +					 unsigned long window_size, unsigned long page_shift,
> +					 unsigned long base, struct iommu_table_ops *table_ops)


Make "base" a pointer. Or, better, just keep setting it directly in 
iommu_table_setparms() rather than passing 0 around.

The same comment about "liobn" - set it in iommu_table_setparms_lpar(). 
The reviewer will see what field atters in what situation imho.



> +{
> +	tbl->it_busno = busno;
> +	tbl->it_index = liobn;
> +	tbl->it_offset = win_addr >> page_shift;
> +	tbl->it_size = window_size >> page_shift;
> +	tbl->it_page_shift = page_shift;
> +	tbl->it_base = base;
> +	tbl->it_blocksize = 16;
> +	tbl->it_type = TCE_PCI;
> +	tbl->it_ops = table_ops;
> +}
> +
> +struct iommu_table_ops iommu_table_pseries_ops = {
> +	.set = tce_build_pSeries,
> +	.clear = tce_free_pSeries,
> +	.get = tce_get_pseries
> +};
> +
>   static void iommu_table_setparms(struct pci_controller *phb,
>   				 struct device_node *dn,
>   				 struct iommu_table *tbl)
> @@ -509,8 +536,13 @@ static void iommu_table_setparms(struct pci_controller *phb,
>   	const unsigned long *basep;
>   	const u32 *sizep;
>   
> -	node = phb->dn;
> +	/* Test if we are going over 2GB of DMA space */
> +	if (phb->dma_window_base_cur + phb->dma_window_size > SZ_2G) {
> +		udbg_printf("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
> +		panic("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
> +	}
>   
> +	node = phb->dn;
>   	basep = of_get_property(node, "linux,tce-base", NULL);
>   	sizep = of_get_property(node, "linux,tce-size", NULL);
>   	if (basep == NULL || sizep == NULL) {
> @@ -519,33 +551,25 @@ static void iommu_table_setparms(struct pci_controller *phb,
>   		return;
>   	}
>   
> -	tbl->it_base = (unsigned long)__va(*basep);
> +	_iommu_table_setparms(tbl, phb->bus->number, 0, phb->dma_window_base_cur,
> +			      phb->dma_window_size, IOMMU_PAGE_SHIFT_4K,
> +			      (unsigned long)__va(*basep), &iommu_table_pseries_ops);
>   
>   	if (!is_kdump_kernel())
>   		memset((void *)tbl->it_base, 0, *sizep);
>   
> -	tbl->it_busno = phb->bus->number;
> -	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
> -
> -	/* Units of tce entries */
> -	tbl->it_offset = phb->dma_window_base_cur >> tbl->it_page_shift;
> -
> -	/* Test if we are going over 2GB of DMA space */
> -	if (phb->dma_window_base_cur + phb->dma_window_size > 0x80000000ul) {
> -		udbg_printf("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
> -		panic("PCI_DMA: Unexpected number of IOAs under this PHB.\n");
> -	}
> -
>   	phb->dma_window_base_cur += phb->dma_window_size;
> -
> -	/* Set the tce table size - measured in entries */
> -	tbl->it_size = phb->dma_window_size >> tbl->it_page_shift;
> -
> -	tbl->it_index = 0;
> -	tbl->it_blocksize = 16;
> -	tbl->it_type = TCE_PCI;
>   }
>   
> +struct iommu_table_ops iommu_table_lpar_multi_ops = {
> +	.set = tce_buildmulti_pSeriesLP,
> +#ifdef CONFIG_IOMMU_API
> +	.xchg_no_kill = tce_exchange_pseries,
> +#endif
> +	.clear = tce_freemulti_pSeriesLP,
> +	.get = tce_get_pSeriesLP
> +};
> +
>   /*
>    * iommu_table_setparms_lpar
>    *
> @@ -557,28 +581,17 @@ static void iommu_table_setparms_lpar(struct pci_controller *phb,
>   				      struct iommu_table_group *table_group,
>   				      const __be32 *dma_window)
>   {
> -	unsigned long offset, size;
> +	unsigned long offset, size, liobn;
>   
> -	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
> +	of_parse_dma_window(dn, dma_window, &liobn, &offset, &size);
>   
> -	tbl->it_busno = phb->bus->number;
> -	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
> -	tbl->it_base   = 0;
> -	tbl->it_blocksize  = 16;
> -	tbl->it_type = TCE_PCI;
> -	tbl->it_offset = offset >> tbl->it_page_shift;
> -	tbl->it_size = size >> tbl->it_page_shift;
> +	_iommu_table_setparms(tbl, phb->bus->number, liobn, offset, size, IOMMU_PAGE_SHIFT_4K, 0,
> +			      &iommu_table_lpar_multi_ops);
>   
>   	table_group->tce32_start = offset;
>   	table_group->tce32_size = size;
>   }
>   
> -struct iommu_table_ops iommu_table_pseries_ops = {
> -	.set = tce_build_pSeries,
> -	.clear = tce_free_pSeries,
> -	.get = tce_get_pseries
> -};
> -
>   static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
>   {
>   	struct device_node *dn;
> @@ -647,7 +660,6 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
>   	tbl = pci->table_group->tables[0];
>   
>   	iommu_table_setparms(pci->phb, dn, tbl);
> -	tbl->it_ops = &iommu_table_pseries_ops;
>   	iommu_init_table(tbl, pci->phb->node, 0, 0);
>   
>   	/* Divide the rest (1.75GB) among the children */
> @@ -664,7 +676,7 @@ static int tce_exchange_pseries(struct iommu_table *tbl, long index, unsigned
>   				bool realmode)
>   {
>   	long rc;
> -	unsigned long ioba = (unsigned long) index << tbl->it_page_shift;
> +	unsigned long ioba = (unsigned long)index << tbl->it_page_shift;


Unrelated change, why, did checkpatch.pl complain?


>   	unsigned long flags, oldtce = 0;
>   	u64 proto_tce = iommu_direction_to_tce_perm(*direction);
>   	unsigned long newtce = *tce | proto_tce;
> @@ -686,15 +698,6 @@ static int tce_exchange_pseries(struct iommu_table *tbl, long index, unsigned
>   }
>   #endif
>   
> -struct iommu_table_ops iommu_table_lpar_multi_ops = {
> -	.set = tce_buildmulti_pSeriesLP,
> -#ifdef CONFIG_IOMMU_API
> -	.xchg_no_kill = tce_exchange_pseries,
> -#endif
> -	.clear = tce_freemulti_pSeriesLP,
> -	.get = tce_get_pSeriesLP
> -};
> -
>   static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
>   {
>   	struct iommu_table *tbl;
> @@ -729,7 +732,6 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
>   		tbl = ppci->table_group->tables[0];
>   		iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
>   				ppci->table_group, dma_window);
> -		tbl->it_ops = &iommu_table_lpar_multi_ops;
>   		iommu_init_table(tbl, ppci->phb->node, 0, 0);
>   		iommu_register_group(ppci->table_group,
>   				pci_domain_nr(bus), 0);
> @@ -758,7 +760,6 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
>   		PCI_DN(dn)->table_group = iommu_pseries_alloc_group(phb->node);
>   		tbl = PCI_DN(dn)->table_group->tables[0];
>   		iommu_table_setparms(phb, dn, tbl);
> -		tbl->it_ops = &iommu_table_pseries_ops;
>   		iommu_init_table(tbl, phb->node, 0, 0);
>   		set_iommu_table_base(&dev->dev, tbl);
>   		return;
> @@ -1436,7 +1437,6 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
>   		tbl = pci->table_group->tables[0];
>   		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
>   				pci->table_group, dma_window);
> -		tbl->it_ops = &iommu_table_lpar_multi_ops;
>   		iommu_init_table(tbl, pci->phb->node, 0, 0);
>   		iommu_register_group(pci->table_group,
>   				pci_domain_nr(pci->phb->bus), 0);
> 

-- 
Alexey
