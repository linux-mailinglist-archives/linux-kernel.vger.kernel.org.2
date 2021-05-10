Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C19377D32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhEJHfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhEJHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:35:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6539C061573
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 00:34:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s20so8681225plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 00:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bKX1iAhL026RIW26ni3nCFDs+gWYu/2Q1T4k5OzSYXI=;
        b=dN5Xhp/3uGjXXiJlWIZbGF+zf6i59+tuqauG3wYpTMQpvLDs1V9F9Z9nG/Cz7//DIc
         yUqUJlGc14DfritK8hpgqAtUIkAawxeUxz5bSDqoA/DnolDeQJ0K9ah4PAmFwnwWkGDI
         9eXuL+rp1blLDKQ/nvRR3sVfls/d/3/MN8Q7gyW3BB1LHixKUysrT+5UMyfz7TEifXjC
         hhyL9tAmGvGPaJBtT0QReSdrQzhPI7pjJL855yg8CWLyBBR+Ht2FNUIlwaWzSd/L1i93
         LbCKCzzRWABm7zCN7+iLJj5Fe9O8b4r4h6gSUXF2St5EvWgloWtsI75TGVcc2JrJeg7U
         4bRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bKX1iAhL026RIW26ni3nCFDs+gWYu/2Q1T4k5OzSYXI=;
        b=aUUr9TGRevsFd9WpUQSZEQXLEOAesHqNBogIdT0u1cPQy3ifWoXPi45bRzp/XyKAUx
         ecwQbQ4Qz+mjLNWG24mDebx8JrDJHrRE35cw5B0JmMUsUdxX2bWNAbXPYGIQOptBQzjl
         nSZ4HyhsOwTWwnjO0S7zxRWQbfs1WWZTfitDMV6cWDfjAyxGLi4dzFap8PpLG4mWIEZa
         CwqUCir9oU4EyHDuUeKiyy+dW/sPQfko31p9l5EbNsEuczRZ7uI0g0tB7lw8COnUFw/b
         erca4+F8550X9yaAqivu5757dA6x84fjHk+oXLVQpqZ3P0TuPf7/0jDGB7JQF9bxpJo0
         yn8A==
X-Gm-Message-State: AOAM533n9N1RhFMHJ5shHaqg97kZH8KVm6yciuwHeL+uLc29DLVT2q9c
        veyB/YU85aXwO0nRu/ZDS2M2Vw==
X-Google-Smtp-Source: ABdhPJy2Wj7PcR6+Ff2g+vjTh6+/zHhVxxIJkhOB4LWPw8NGYeixmQTCtJYNUW/1HeFtB3G99Edcnw==
X-Received: by 2002:a17:90a:72cb:: with SMTP id l11mr38167641pjk.57.1620632073496;
        Mon, 10 May 2021 00:34:33 -0700 (PDT)
Received: from localhost (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.gmail.com with UTF8SMTPSA id v130sm10500310pfc.25.2021.05.10.00.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 00:34:32 -0700 (PDT)
Message-ID: <19cb4d73-f11b-345b-fb3c-e903a963247f@ozlabs.ru>
Date:   Mon, 10 May 2021 17:34:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH v4 06/11] powerpc/pseries/iommu: Add ddw_property_create()
 and refactor enable_ddw()
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
 <20210430163145.146984-7-leobras.c@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210430163145.146984-7-leobras.c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/21 02:31, Leonardo Bras wrote:
> Code used to create a ddw property that was previously scattered in
> enable_ddw() is now gathered in ddw_property_create(), which deals with
> allocation and filling the property, letting it ready for
> of_property_add(), which now occurs in sequence.
> 
> This created an opportunity to reorganize the second part of enable_ddw():
> 
> Without this patch enable_ddw() does, in order:
> kzalloc() property & members, create_ddw(), fill ddwprop inside property,
> ddw_list_new_entry(), do tce_setrange_multi_pSeriesLP_walk in all memory,
> of_add_property(), and list_add().
> 
> With this patch enable_ddw() does, in order:
> create_ddw(), ddw_property_create(), of_add_property(),
> ddw_list_new_entry(), do tce_setrange_multi_pSeriesLP_walk in all memory,
> and list_add().
> 
> This change requires of_remove_property() in case anything fails after
> of_add_property(), but we get to do tce_setrange_multi_pSeriesLP_walk
> in all memory, which looks the most expensive operation, only if
> everything else succeeds.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>   arch/powerpc/platforms/pseries/iommu.c | 93 ++++++++++++++++----------
>   1 file changed, 57 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 955cf095416c..5a70ecd579b8 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1122,6 +1122,35 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
>   			 ret);
>   }
>   
> +static struct property *ddw_property_create(const char *propname, u32 liobn, u64 dma_addr,
> +					    u32 page_shift, u32 window_shift)
> +{
> +	struct dynamic_dma_window_prop *ddwprop;
> +	struct property *win64;
> +
> +	win64 = kzalloc(sizeof(*win64), GFP_KERNEL);
> +	if (!win64)
> +		return NULL;
> +
> +	win64->name = kstrdup(propname, GFP_KERNEL);
> +	ddwprop = kzalloc(sizeof(*ddwprop), GFP_KERNEL);
> +	win64->value = ddwprop;
> +	win64->length = sizeof(*ddwprop);
> +	if (!win64->name || !win64->value) {
> +		kfree(win64->name);
> +		kfree(win64->value);
> +		kfree(win64);
> +		return NULL;
> +	}
> +
> +	ddwprop->liobn = cpu_to_be32(liobn);
> +	ddwprop->dma_base = cpu_to_be64(dma_addr);
> +	ddwprop->tce_shift = cpu_to_be32(page_shift);
> +	ddwprop->window_shift = cpu_to_be32(window_shift);
> +
> +	return win64;
> +}
> +
>   /* Return largest page shift based on "IO Page Sizes" output of ibm,query-pe-dma-window. */
>   static int iommu_get_page_shift(u32 query_page_size)
>   {
> @@ -1167,11 +1196,11 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   	struct ddw_query_response query;
>   	struct ddw_create_response create;
>   	int page_shift;
> +	u64 win_addr;
>   	struct device_node *dn;
>   	u32 ddw_avail[DDW_APPLICABLE_SIZE];
>   	struct direct_window *window;
>   	struct property *win64 = NULL;
> -	struct dynamic_dma_window_prop *ddwprop;
>   	struct failed_ddw_pdn *fpdn;
>   	bool default_win_removed = false;
>   	bool pmem_present;
> @@ -1286,65 +1315,54 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   			1ULL << page_shift);
>   		goto out_failed;
>   	}
> -	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
> -	if (!win64) {
> -		dev_info(&dev->dev,
> -			"couldn't allocate property for 64bit dma window\n");
> -		goto out_failed;
> -	}
> -	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
> -	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
> -	win64->length = sizeof(*ddwprop);
> -	if (!win64->name || !win64->value) {
> -		dev_info(&dev->dev,
> -			"couldn't allocate property name and value\n");
> -		goto out_free_prop;
> -	}
>   
>   	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
>   	if (ret != 0)
> -		goto out_free_prop;
> -
> -	ddwprop->liobn = cpu_to_be32(create.liobn);
> -	ddwprop->dma_base = cpu_to_be64(((u64)create.addr_hi << 32) |
> -			create.addr_lo);
> -	ddwprop->tce_shift = cpu_to_be32(page_shift);
> -	ddwprop->window_shift = cpu_to_be32(len);
> +		goto out_failed;
>   
>   	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
>   		  create.liobn, dn);
>   
> -	window = ddw_list_new_entry(pdn, ddwprop);
> +	win_addr = ((u64)create.addr_hi << 32) | create.addr_lo;
> +	win64 = ddw_property_create(DIRECT64_PROPNAME, create.liobn, win_addr,
> +				    page_shift, len);
> +	if (!win64) {
> +		dev_info(&dev->dev,
> +			 "couldn't allocate property, property name, or value\n");
> +		goto out_remove_win;
> +	}
> +
> +	ret = of_add_property(pdn, win64);
> +	if (ret) {
> +		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
> +			pdn, ret);
> +		goto out_free_prop;
> +	}
> +
> +	window = ddw_list_new_entry(pdn, win64->value);
>   	if (!window)
> -		goto out_clear_window;
> +		goto out_del_prop;
>   
>   	ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
>   			win64->value, tce_setrange_multi_pSeriesLP_walk);
>   	if (ret) {
>   		dev_info(&dev->dev, "failed to map direct window for %pOF: %d\n",
>   			 dn, ret);
> -		goto out_free_window;
> -	}
> -
> -	ret = of_add_property(pdn, win64);
> -	if (ret) {
> -		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
> -			 pdn, ret);
> -		goto out_free_window;
> +		goto out_del_list;
>   	}
>   
>   	spin_lock(&direct_window_list_lock);
>   	list_add(&window->list, &direct_window_list);
>   	spin_unlock(&direct_window_list_lock);
>   
> -	dev->dev.archdata.dma_offset = be64_to_cpu(ddwprop->dma_base);
> +	dev->dev.archdata.dma_offset = win_addr;
>   	goto out_unlock;
>   
> -out_free_window:
> +out_del_list:
>   	kfree(window);
>   
> -out_clear_window:
> -	remove_ddw(pdn, true);
> +out_del_prop:
> +	of_remove_property(pdn, win64);
>   
>   out_free_prop:
>   	kfree(win64->name);
> @@ -1352,6 +1370,9 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   	kfree(win64);
>   	win64 = NULL;
>   
> +out_remove_win:
> +	remove_ddw(pdn, true);
> +
>   out_failed:
>   	if (default_win_removed)
>   		reset_dma_window(dev, pdn);
> 

-- 
Alexey
