Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF93458F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhCWHld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhCWHlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:41:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D941C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:41:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h25so10830943pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gcmI11wouIpDwxdi+NStOdrVppM7cT0Mia1ThanzCd0=;
        b=UE5+wbRmZdYUdQ0G8bX362ijyRwJ9biLMH7je5sLG9tnGEthPDD8cms1zmPguoF2Vz
         PdJgmfHFxwX09TuzdZ6OiVb5rBOwbl6JvTiwYJ4ZpFQGLsCHU5fms4JjJqtMYnQ5J+h+
         0ryMxlh8oqxok6IQtckoXOeiOaGx77B4tbt11zmPUMa2vX+O9NFx7zXvpTw1HrFwBztz
         NPeXe/t0wUwM/uI0Mx8vQuL1oKQIQQhXDwlPgESgSrKwScDtQ3ErlHqczwAUiobBAjDv
         Y3WAeJwnHB3G8M+PonvwePYXgPUy82uDV+D3i6i9rRjiqTF9B7VfjIRofihNj13QksRB
         PVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gcmI11wouIpDwxdi+NStOdrVppM7cT0Mia1ThanzCd0=;
        b=iyjiK2m/KpDE+sO56jMEDCAtYEBm+GrckaTAR50arKcueGB1iOxubg1aF1TXFKzjv2
         OelsQBRd35gM3DeAcw/uvaNv7UjAhdlW41OkqVourTo3Krr1zejd+8M6LYFd70IRXMse
         jrw/dExERGMNo1XOjJ6x52mTQSizytJPcq2oz5mjgdLk2VQGfD8J6DQUjVj4Pp/rVn7y
         00K/JsnJYJ0jqzNQGr3p2yOhal1CN4BnZNclKCQ2adcbwJ2UjIFs2gmkwlE1Gu7dybz9
         EAL1xkotjRfKeLwpY6G4TpZMBq8eFcA4p8ElPD26t6C/RAPEcUtTyy0/rOhPleiIl/EC
         3leg==
X-Gm-Message-State: AOAM532UCo5vOlbOSQPVL8zrWyH5T0sYuN+VOYIba0gIfns4qWl0L17h
        edJX59h6YDZkrnJarhEl+Vl2L7f4GsEa91fm
X-Google-Smtp-Source: ABdhPJwErHiyQzkdLbopxkOHcUNRxbNwmPsMCMOGUe+a7whz50kbLU6xArS7p5n4wvFkqiQmxoY6wg==
X-Received: by 2002:a62:7ed2:0:b029:21d:1806:fe30 with SMTP id z201-20020a627ed20000b029021d1806fe30mr731380pfc.5.1616485277056;
        Tue, 23 Mar 2021 00:41:17 -0700 (PDT)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au. [124.171.107.241])
        by smtp.gmail.com with UTF8SMTPSA id 4sm1593011pjl.51.2021.03.23.00.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 00:41:16 -0700 (PDT)
Message-ID: <2088f84c-08fb-fecc-f5d4-5735357dc296@ozlabs.ru>
Date:   Tue, 23 Mar 2021 18:41:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Subject: Re: [PATCH 1/1] powerpc/iommu: Enable remaining IOMMU Pagesizes
 present in LoPAR
Content-Language: en-US
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>, brking@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210322190943.715368-1-leobras.c@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210322190943.715368-1-leobras.c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/03/2021 06:09, Leonardo Bras wrote:
> According to LoPAR, ibm,query-pe-dma-window output named "IO Page Sizes"
> will let the OS know all possible pagesizes that can be used for creating a
> new DDW.
> 
> Currently Linux will only try using 3 of the 8 available options:
> 4K, 64K and 16M. According to LoPAR, Hypervisor may also offer 32M, 64M,
> 128M, 256M and 16G.
> 
> Enabling bigger pages would be interesting for direct mapping systems
> with a lot of RAM, while using less TCE entries.
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>   arch/powerpc/include/asm/iommu.h       |  8 ++++++++
>   arch/powerpc/platforms/pseries/iommu.c | 28 +++++++++++++++++++-------
>   2 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> index deef7c94d7b6..c170048b7a1b 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -19,6 +19,14 @@
>   #include <asm/pci-bridge.h>
>   #include <asm/asm-const.h>
>   
> +#define IOMMU_PAGE_SHIFT_16G	34
> +#define IOMMU_PAGE_SHIFT_256M	28
> +#define IOMMU_PAGE_SHIFT_128M	27
> +#define IOMMU_PAGE_SHIFT_64M	26
> +#define IOMMU_PAGE_SHIFT_32M	25
> +#define IOMMU_PAGE_SHIFT_16M	24
> +#define IOMMU_PAGE_SHIFT_64K	16


These are not very descriptive, these are just normal shifts, could be 
as simple as __builtin_ctz(SZ_4K) (gcc will optimize this) and so on.

OTOH the PAPR page sizes need macros as they are the ones which are 
weird and screaming for macros.

I'd steal/rework spapr_page_mask_to_query_mask() from QEMU. Thanks,




> +
>   #define IOMMU_PAGE_SHIFT_4K      12
>   #define IOMMU_PAGE_SIZE_4K       (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K)
>   #define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 9fc5217f0c8e..02958e80aa91 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1099,6 +1099,24 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
>   			 ret);
>   }
>   
> +/* Returns page shift based on "IO Page Sizes" output at ibm,query-pe-dma-window. SeeL LoPAR */
> +static int iommu_get_page_shift(u32 query_page_size)
> +{
> +	const int shift[] = {IOMMU_PAGE_SHIFT_4K,   IOMMU_PAGE_SHIFT_64K,  IOMMU_PAGE_SHIFT_16M,
> +			     IOMMU_PAGE_SHIFT_32M,  IOMMU_PAGE_SHIFT_64M,  IOMMU_PAGE_SHIFT_128M,
> +			     IOMMU_PAGE_SHIFT_256M, IOMMU_PAGE_SHIFT_16G};
> +	int i = ARRAY_SIZE(shift) - 1;
> +
> +	/* Looks for the largest page size supported */
> +	for (; i >= 0; i--) {
> +		if (query_page_size & (1 << i))
> +			return shift[i];
> +	}
> +
> +	/* No valid page size found. */
> +	return 0;
> +}
> +
>   /*
>    * If the PE supports dynamic dma windows, and there is space for a table
>    * that can map all pages in a linear offset, then setup such a table,
> @@ -1206,13 +1224,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   			goto out_failed;
>   		}
>   	}
> -	if (query.page_size & 4) {
> -		page_shift = 24; /* 16MB */
> -	} else if (query.page_size & 2) {
> -		page_shift = 16; /* 64kB */
> -	} else if (query.page_size & 1) {
> -		page_shift = 12; /* 4kB */
> -	} else {
> +
> +	page_shift = iommu_get_page_shift(query.page_size);
> +	if (!page_shift) {
>   		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
>   			  query.page_size);
>   		goto out_failed;
> 

-- 
Alexey
