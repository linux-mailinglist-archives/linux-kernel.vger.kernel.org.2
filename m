Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCAE3BBE9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhGEPHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhGEPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:07:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3C2C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 08:04:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t14-20020a05600c198eb029020c8aac53d4so4067126wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=At8qjqAN8f+W2do/QMp0ecm1lFUsBPDE6HfKaXVwDro=;
        b=v70/7r/s5wRbr8RuYY9kFjI9ukbImPIQ/c7UM51DPMnhqQ8aGT5Y5doykcqmdROjRp
         tPe0aDlCtGnP2mHC1BFVc56zsN1PN2nQK8+6Yt47G0MMLUBwH+o0TcgUqcCCi2k6g/pd
         q/wMTzyH0JhU7XDljO1Lvb85MQH1W/VkWc0gPHu/TxP1aefn26mA9czSSMMTUKwGwka2
         Lr+Sj/4BA6TbNQiACnCLr+dDBBVAGX5m0OqkkBdHdD3XfJ+vaVUgKWB+lydypAeZmrCD
         NjF0Zu5PLT4ihbdIqwFr/Zid9HY/ipmw778GpoNHtjrbGrf9f100X+Y9rlFxQCdSvPIf
         QMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=At8qjqAN8f+W2do/QMp0ecm1lFUsBPDE6HfKaXVwDro=;
        b=hHkQpFOuYKUB7A7IYF7nVXyp/F1pJzW0UVmX6VbY9U7eN1QAO+7pD14LkLdqa0a+Qe
         8qj094FQbLF5maMiAzrsHbhOPuJUozC/8s9wc9uVtw2Xqdhjiy8oOkkfTnrPReEzFdH0
         SD5iRc3teiqLrVjvOcwJzrvNMlEn8+g0e4K3vggeJdkPALILygX6+jMSIHh4QxB2XOXR
         fyes6uYahvaGLIMC/FL8PYBjAK2kzghT2RVf6XL7BrEc/k0Oe9olujkECdgxtej1uy/Z
         HqOCMTCnh+Ft0TsHK+qp51s7HBHVKrGabR4lR/CB9QHyQjNnBYvoF5i/MV6Rye5wYGo3
         0I6A==
X-Gm-Message-State: AOAM531I/Zr3Y6x/UQtL4eEDoN3fqvERGIJ+7MQrE/WmgLF+rcZr7OUp
        teb3x6UMhceefIAC2DFLTz8MTg==
X-Google-Smtp-Source: ABdhPJwzZh/4D5yDZ6JWELeJ85BkGi++TNbYqVr3hQUWFfFvywLWOhctBGjSFPQzNDxcQe5nTQ3xAA==
X-Received: by 2002:a7b:c15a:: with SMTP id z26mr15436389wmi.109.1625497462273;
        Mon, 05 Jul 2021 08:04:22 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:3207:330f:6162:ea09])
        by smtp.gmail.com with ESMTPSA id t9sm14493333wmq.14.2021.07.05.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 08:04:21 -0700 (PDT)
Date:   Mon, 5 Jul 2021 17:04:16 +0200
From:   Marco Elver <elver@google.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH -next 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash
 with KASAN_VMALLOC
Message-ID: <YOMfcE7V7lSE3N/z@elver.google.com>
References: <20210705111453.164230-1-wangkefeng.wang@huawei.com>
 <20210705111453.164230-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705111453.164230-4-wangkefeng.wang@huawei.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 07:14PM +0800, Kefeng Wang wrote:
[...]
> +#ifdef CONFIG_KASAN_VMALLOC
> +void __init __weak kasan_populate_early_vm_area_shadow(void *start,
> +						       unsigned long size)

This should probably not be __weak, otherwise you now have 2 __weak
functions.

> +{
> +	unsigned long shadow_start, shadow_end;
> +
> +	if (!is_vmalloc_or_module_addr(start))
> +		return;
> +
> +	shadow_start = (unsigned long)kasan_mem_to_shadow(start);
> +	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> +	shadow_end = (unsigned long)kasan_mem_to_shadow(start + size);
> +	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> +	kasan_map_populate(shadow_start, shadow_end,
> +			   early_pfn_to_nid(virt_to_pfn(start)));
> +}
> +#endif

This function looks quite generic -- would any of this also apply to
other architectures? I see that ppc and sparc at least also define
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK.

>  void __init kasan_init(void)
>  {
>  	kasan_init_shadow();
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5310e217bd74..79d3895b0240 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -49,6 +49,8 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>  int kasan_populate_early_shadow(const void *shadow_start,
>  				const void *shadow_end);
>  
> +void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> +
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
>  	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index cc64ed6858c6..d39577d088a1 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -279,6 +279,11 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>  	return 0;
>  }
>  
> +void __init __weak kasan_populate_early_vm_area_shadow(void *start,
> +						       unsigned long size)
> +{
> +}

I'm just wondering if this could be a generic function, perhaps with an
appropriate IS_ENABLED() check of a generic Kconfig option
(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK ?) to short-circuit it, if it's
not only an arm64 problem.

But I haven't looked much further, so would appeal to you to either
confirm or reject this idea.

Thanks,
-- Marco
