Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4067737A13E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhEKH6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhEKH6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:58:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E234C061760
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:57:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t4so10437959plc.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rmIoYvEFvcCCyMBEm+UTE/hjUqLqYMY89aIrvAoP800=;
        b=lwCPRaw8TKta3r9TalasqnmEGt8Sg/19QPZPyclYVUUIJ3+dKxKav1OquOsXRQP1HV
         G7FjQQtvTBlV7EfchIY6bG9p6rHV5kKx9108f8AsqLS4xeZNBdFMTaTDrsl0fFqwZmN+
         Mwd6ct0/FdkKMYlC3+s0vuYapAM/CSsNr+2IImiUq94LNyCVXgK3Of5B9/CgznTG3aYt
         GI7VdSWJiDwsJlaqDqzUWVfuIkElsQxpe6yA1gOk3ZN7psBr4JAZSHxseYQyX0cFLEtl
         yJoFeeT9By3g44eOdI6HiiO/qVEJTqDv6usgWr4Nl8pE2z2YiYXscS1j6IXuH0VoYi7K
         /B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rmIoYvEFvcCCyMBEm+UTE/hjUqLqYMY89aIrvAoP800=;
        b=PkHTFk7ieVv9YdP4M1jDfp9DRV5VtAU4UItfhLhDkrdDP/FIkx4ZT1xVC7qgW9QLdv
         LHGOw1ZRCXuZ4rBxTuwmp3s/sKhSnhQk2sy6yi7IJyuguZmSAO56/utImhRYo2rr/PWz
         ImMfofyN4zsXDlFgLBMh0sejjxzTObCGI8oZwL77gRwj6n6x8dorFTFNgRq9IaiqwVOa
         47Xtp8Ayl77vnpOnGyBvDtpI3hSkwVhvSZWVXHdLarTTxqc9Vt8ymQ+8H5VlqpMSYZt1
         uhaVk6KzjNPaAc8/jF9c5PXhcya5DoG7pSqwPEjJf2d5yIaHquFhdWSaXJJKjrjNvOYS
         5wAA==
X-Gm-Message-State: AOAM530OkUasEo00KAQnRKvxV73uM2S2YFbN78FeZNmzXsPw+g1VA1qC
        QbTc3fI6uhQ2ISpYpBRAt6a+9g==
X-Google-Smtp-Source: ABdhPJxEcJpp/TKkRlPb+Oi5Gu41WEXvBlI2XFcUyAZdoSFjACqm7pe7/gV5MkK46Vav17MWkKOW0w==
X-Received: by 2002:a17:902:a9c1:b029:ef:d4:b296 with SMTP id b1-20020a170902a9c1b02900ef00d4b296mr25070734plr.20.1620719859679;
        Tue, 11 May 2021 00:57:39 -0700 (PDT)
Received: from localhost (ppp121-45-194-51.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.194.51])
        by smtp.gmail.com with UTF8SMTPSA id 66sm13636458pgj.9.2021.05.11.00.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 00:57:39 -0700 (PDT)
Message-ID: <8055abc8-ed12-b054-7683-cd80fe0d59de@ozlabs.ru>
Date:   Tue, 11 May 2021 17:57:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH v4 09/11] powerpc/pseries/iommu: Find existing DDW with
 given property name
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
 <20210430163145.146984-10-leobras.c@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210430163145.146984-10-leobras.c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/05/2021 02:31, Leonardo Bras wrote:
> At the moment pseries stores information about created directly mapped
> DDW window in DIRECT64_PROPNAME.
> 
> With the objective of implementing indirect DMA mapping with DDW, it's
> necessary to have another propriety name to make sure kexec'ing into older
> kernels does not break, as it would if we reuse DIRECT64_PROPNAME.
> 
> In order to have this, find_existing_ddw_windows() needs to be able to
> look for different property names.
> 
> Extract find_existing_ddw_windows() into find_existing_ddw_windows_named()
> and calls it with current property name.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>   arch/powerpc/platforms/pseries/iommu.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index f8922fcf34b6..de54ddd9decd 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -888,24 +888,21 @@ static struct direct_window *ddw_list_new_entry(struct device_node *pdn,
>   	return window;
>   }
>   
> -static int find_existing_ddw_windows(void)
> +static void find_existing_ddw_windows_named(const char *name)

I'd suggest find_existing_ddw_windows_by_name() but this is nitpicking.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


>   {
>   	int len;
>   	struct device_node *pdn;
>   	struct direct_window *window;
> -	const struct dynamic_dma_window_prop *direct64;
> -
> -	if (!firmware_has_feature(FW_FEATURE_LPAR))
> -		return 0;
> +	const struct dynamic_dma_window_prop *dma64;
>   
> -	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
> -		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
> -		if (!direct64 || len < sizeof(*direct64)) {
> -			remove_ddw(pdn, true, DIRECT64_PROPNAME);
> +	for_each_node_with_property(pdn, name) {
> +		dma64 = of_get_property(pdn, name, &len);
> +		if (!dma64 || len < sizeof(*dma64)) {
> +			remove_ddw(pdn, true, name);
>   			continue;
>   		}
>   
> -		window = ddw_list_new_entry(pdn, direct64);
> +		window = ddw_list_new_entry(pdn, dma64);
>   		if (!window)
>   			break;
>   
> @@ -913,6 +910,14 @@ static int find_existing_ddw_windows(void)
>   		list_add(&window->list, &direct_window_list);
>   		spin_unlock(&direct_window_list_lock);
>   	}
> +}
> +
> +static int find_existing_ddw_windows(void)
> +{
> +	if (!firmware_has_feature(FW_FEATURE_LPAR))
> +		return 0;
> +
> +	find_existing_ddw_windows_named(DIRECT64_PROPNAME);
>   
>   	return 0;
>   }
> 

-- 
Alexey
