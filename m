Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF837A140
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhEKH7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhEKH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:59:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:57:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h127so15468603pfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d6hsuPDsQAazQkSlsEduUc+wi9WR9nxRSCBWyyuz5zo=;
        b=V4qwd66hEmbaIFNJMJh7N+AfzaVyFBKRfm96Ksv0yJQxxoHuuz37hEk6gxQNhC/D8Y
         /BSomxgT2kRs4muxyYzi2GFp0jAU0Z/cons0dWL1FidCeKrYKQzlUEPim7M7jM8AqrYW
         GAzKtSkrLMvdRo9qaQep6YpzHdiHtJ3vWG5Sy27Lhlfu/9A2p4EKcdPDFUA2hlu9F4B1
         kxrK4dJ14jQFMoScpsT147VgV/29GCBeVwsIAWLJXcM99LKutqARe134Qy6xgxEGAsz+
         /PIm85qd/wjpnq/Qb33CAmd8EtTDDP2ic6Xye0sprOERc//4Ad3ciUlxojHpmZvc6FRZ
         S/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d6hsuPDsQAazQkSlsEduUc+wi9WR9nxRSCBWyyuz5zo=;
        b=CqORMtu8F12Bf29KO6zUHKikuD3myT+XtKHsOTx73Jeisd/b0pvlblKPb1BA2Ak2oH
         tQEiSuyXqzb2EkYtAJfOfkCbaACaIG7Du2C9/H8vLLaEO/gpgnmw7rAXkRO/lT2LXWY7
         nNjoHq2+Fg1KnZyIRoff+/2oRJ6qnEOvWXCH0yGntT5WtT9BT9doKbTts8FQxSKYRrt1
         cJuM6uTTdO4a6MR0458SyZr/vmESGraEXKhccmYQEB1Dk2D5mjeE+sP9QAmtbcjbp2g8
         EfoS2U080OeDUcue9G0dcvbxdYZQwFLB6t1NJfpoN1lGpbkRbQrbh7jy51Oxspxfgq9F
         2Rhg==
X-Gm-Message-State: AOAM532tMqZG0gQ1kEZLS6DJvkJujbqWT+MpdneH8U7sQUMAKHAkQGSt
        r1RUn/DbK5jEsu2WCPcmNrpg6A==
X-Google-Smtp-Source: ABdhPJxgw5aiJt91VdbKdoSRoiZTSGpK4zQXPmQmaBE1wyHexKPE3ufM7lX+vC8QrpmZmS7mF9a3Wg==
X-Received: by 2002:a63:dc49:: with SMTP id f9mr28999951pgj.361.1620719878319;
        Tue, 11 May 2021 00:57:58 -0700 (PDT)
Received: from localhost (ppp121-45-194-51.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.194.51])
        by smtp.gmail.com with UTF8SMTPSA id c7sm6293623pga.4.2021.05.11.00.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 00:57:57 -0700 (PDT)
Message-ID: <a70c7674-5d90-b40d-7956-c21214f41b8b@ozlabs.ru>
Date:   Tue, 11 May 2021 17:57:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH v4 08/11] powerpc/pseries/iommu: Update
 remove_dma_window() to accept property name
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
 <20210430163145.146984-9-leobras.c@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210430163145.146984-9-leobras.c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/05/2021 02:31, Leonardo Bras wrote:
> Update remove_dma_window() so it can be used to remove DDW with a given
> property name.
> 
> This enables the creation of new property names for DDW, so we can
> have different usage for it, like indirect mapping.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/platforms/pseries/iommu.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 89cb6e9e9f31..f8922fcf34b6 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -823,31 +823,32 @@ static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
>   			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
>   }
>   
> -static void remove_ddw(struct device_node *np, bool remove_prop)
> +static int remove_ddw(struct device_node *np, bool remove_prop, const char *win_name)
>   {
>   	struct property *win;
>   	u32 ddw_avail[DDW_APPLICABLE_SIZE];
>   	int ret = 0;
>   
> +	win = of_find_property(np, win_name, NULL);
> +	if (!win)
> +		return -EINVAL;
> +
>   	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
>   					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
>   	if (ret)
> -		return;
> -
> -	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
> -	if (!win)
> -		return;
> +		return 0;
>   
>   	if (win->length >= sizeof(struct dynamic_dma_window_prop))
>   		remove_dma_window(np, ddw_avail, win);
>   
>   	if (!remove_prop)
> -		return;
> +		return 0;
>   
>   	ret = of_remove_property(np, win);
>   	if (ret)
>   		pr_warn("%pOF: failed to remove direct window property: %d\n",
>   			np, ret);
> +	return 0;
>   }
>   
>   static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
> @@ -900,7 +901,7 @@ static int find_existing_ddw_windows(void)
>   	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
>   		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
>   		if (!direct64 || len < sizeof(*direct64)) {
> -			remove_ddw(pdn, true);
> +			remove_ddw(pdn, true, DIRECT64_PROPNAME);
>   			continue;
>   		}
>   
> @@ -1372,7 +1373,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>   	win64 = NULL;
>   
>   out_remove_win:
> -	remove_ddw(pdn, true);
> +	remove_ddw(pdn, true, DIRECT64_PROPNAME);
>   
>   out_failed:
>   	if (default_win_removed)
> @@ -1536,7 +1537,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
>   		 * we have to remove the property when releasing
>   		 * the device node.
>   		 */
> -		remove_ddw(np, false);
> +		remove_ddw(np, false, DIRECT64_PROPNAME);
>   		if (pci && pci->table_group)
>   			iommu_pseries_free_group(pci->table_group,
>   					np->full_name);
> 

-- 
Alexey
