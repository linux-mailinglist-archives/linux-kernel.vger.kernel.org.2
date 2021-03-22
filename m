Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B18E344EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCVSgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCVSfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:35:21 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE8BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:35:21 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y18so11628834qky.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ty7sAVs+UNafvjH6QynuwOmpwAWFADfLSWscYpexmW4=;
        b=10COgiJvzqPsA9rvMaiYoVJAwuBKsknTLcxcJ3o71g/vp7aNWTbH7cNYpleFgOw0dM
         Q2YDotgAsWJ34bBzNbkj/jWpFc498pBUouqJjx99tSFgXtkBlCo/YvDL3Spre/H5MAok
         bmuEoQsSc1w1yakV/la3mZdgFTrxc+8D5Om6T/mjEBhPg6bCjRkR1qm7Sr5gHkZABkZ8
         9sIzpPQrA+YBgGEdkGSxklPZaAVT7bZkucX52dWB1I1fXZOOrLDZ4DYY25AysVd8pa9c
         +ifOSacAMJJ+nug8V3Vyki7LpVO1Cwh/ErCtaMCv5F2REwT5+22Y9rEFoYJyGy4eCqfu
         H3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ty7sAVs+UNafvjH6QynuwOmpwAWFADfLSWscYpexmW4=;
        b=adsMalH1qaIuScpXeVLNjt3SBdwAe5D6PkN1BhQvJ/oyWwphOpsDLOvyg8gn9lxAs5
         khWRp2pyZiiE/Pw7Ik9svSShy0eI1A88KZfdSUlzKbzYsIlRWBQBk5r96GfuokN21Fsu
         OHooR6W4Y/YCzODkbex9X5RNYfalzgfHqyDzgMc2uIHNazv7+kz0W2xBmYuMKEnsO1dS
         MAYD2BwetOnfrXKcaAJ4GKQOHKD2GieXvYMWYycYhxkHOb9rdLfJ13zlR6pj/vL5/nzy
         jhuDX8CZfrUJRaB17EglDo5xRTr4YSXj0faP/QLigqTBsYfdgf67v4IqvN3Olg42ucw/
         Xnwg==
X-Gm-Message-State: AOAM531y5EPU12c5pMa3eRdLOPQ0M+zS6565iAaD2sM3HYqvgK7kWy2H
        dFniFPgjdJqf7WuT7ubJRauOHg==
X-Google-Smtp-Source: ABdhPJyZD6r4Sa0DfiDV40Jb0cH0o1l73DCoXB3n8uBU+cy5CkRoivOu1GOTk+W52nx36ADl6XZ07A==
X-Received: by 2002:a37:e110:: with SMTP id c16mr1444098qkm.67.1616438120672;
        Mon, 22 Mar 2021 11:35:20 -0700 (PDT)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id b17sm9442287qtp.73.2021.03.22.11.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 11:35:20 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] arm64: mm: reserve CMA and crashkernel in
 ZONE_DMA32
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191107095611.18429-1-nsaenzjulienne@suse.de>
 <20191107095611.18429-3-nsaenzjulienne@suse.de>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <4f094513-507d-566d-a0e2-a30ea36f64c9@jonmasters.org>
Date:   Mon, 22 Mar 2021 14:34:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191107095611.18429-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 11/7/19 4:56 AM, Nicolas Saenz Julienne wrote:
> With the introduction of ZONE_DMA in arm64 we moved the default CMA and
> crashkernel reservation into that area. This caused a regression on big
> machines that need big CMA and crashkernel reservations. Note that
> ZONE_DMA is only 1GB big.
> 
> Restore the previous behavior as the wide majority of devices are OK
> with reserving these in ZONE_DMA32. The ones that need them in ZONE_DMA
> will configure it explicitly.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>   arch/arm64/mm/init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 580d1052ac34..8385d3c0733f 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -88,7 +88,7 @@ static void __init reserve_crashkernel(void)
>   
>   	if (crash_base == 0) {
>   		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> +		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
>   				crash_size, SZ_2M);
>   		if (crash_base == 0) {
>   			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> @@ -454,7 +454,7 @@ void __init arm64_memblock_init(void)
>   
>   	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>   
> -	dma_contiguous_reserve(arm64_dma_phys_limit ? : arm64_dma32_phys_limit);
> +	dma_contiguous_reserve(arm64_dma32_phys_limit);
>   }
>   
>   void __init bootmem_init(void)

Can we get a bit more of a backstory about what the regression was on 
larger machines? If the 32-bit DMA region is too small, but the machine 
otherwise has plenty of memory, the crashkernel reservation will fail. 
Most e.g. enterprise users aren't going to respond to that situation by 
determining the placement manually, they'll just not have a crashkernel.

Jon.

-- 
Computer Architect
