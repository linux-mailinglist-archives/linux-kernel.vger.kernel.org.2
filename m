Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F356394E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 00:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhE2Wqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 18:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhE2Wqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 18:46:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4488CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 15:45:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e22so5379852pgv.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Lpdx0Um03jUzqWO4AaIxjC3bK1N0jnixW+8FFlMlqMA=;
        b=sj3hzKzorWG43QKLPPjBiiTmSiEUHi97unt/f9AoqvyIidgde3OSve5K7/wqfstvxo
         pPAH6blRfLa+LT3yh/0pPtiauFlxY2wUUg+OM+hpz5VQW+Jz+So6ac7mgCcTyq8/ZFpy
         ce7xp2jx4510guVZDywugXiuIgtaOCDSYLZhHKuQJ6aQWmjUBHTKxA5pzbxoKsPpWoHm
         7vZ+GF6EcItYzrz6yrR5VUBVDcRGycWIg+/XYVCfFobvFHKiq4gaX6iSqyAPZEBrFACx
         5MgndjKNyarKhotIx8MNj6LAbQdHYPTf07NgtgwS3gNuvTOIFWw+delANS0yVVqtOYHN
         n1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Lpdx0Um03jUzqWO4AaIxjC3bK1N0jnixW+8FFlMlqMA=;
        b=nrBZvUdHuVtNEJEe13yfk37Q5J4gqSuj9c3Pibhs/LRspbFXzCo5E8eUAJLgNFdnBZ
         HiqI0IlsGpS2CgRIu3wBHhcyDzHbWspmhTdJIwlUeu2ZyMhcQHXMkYMt0MzYez6bhX8t
         /d3RUfti5YiOC2gT5JSy4jwUr3VkxfVsnHCjNS4wwGzFgRHtX7QiHIkQKfYE9DWV3sJO
         u8d/cajHP/UQOsQEcpkNKctekiVKDzhv1k/NlnGjkh8BLNJFmgJlyjkSGJFfsrTziowl
         yrPe+KEvSOIq7ic/HBDaNuW7DT71cY+ihFHVxvRK4NqcnXKjqfJr4Recq4tc+QAqBwON
         MxRA==
X-Gm-Message-State: AOAM530agV6hwpdssemwFN7pcNv//ILB9H/DhPYyEC/IN9HACCX5iRXv
        qiOHWy2HyVNSedVXyitgry0MdUUq3Ot0IA==
X-Google-Smtp-Source: ABdhPJyWtP3MVhxRgO3jrnndKaQfJ0lHL6blo2oW0FRSpfHSJK4uH9cuYZsGnZQwwLYHURnmuoX7tA==
X-Received: by 2002:a05:6a00:16c9:b029:2df:c620:8156 with SMTP id l9-20020a056a0016c9b02902dfc6208156mr10214707pfc.40.1622328304768;
        Sat, 29 May 2021 15:45:04 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gg10sm7221762pjb.49.2021.05.29.15.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 15:45:04 -0700 (PDT)
Date:   Sat, 29 May 2021 15:45:04 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 15:38:54 PDT (-0700)
Subject:     Re: [PATCH -next] riscv: mm: fix build errors caused by mk_pmd()
In-Reply-To: <20210524070220.793082-1-sunnanyong@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunnanyong@huawei.com
Message-ID: <mhng-4fb5ea1f-084a-4010-b4a6-d19423511720@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 00:02:20 PDT (-0700), sunnanyong@huawei.com wrote:
> With "riscv: mm: add THP support on 64-bit", mk_pmd() function
> introduce build errors,
> 1.build with CONFIG_ARCH_RV32I=y:
> arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
> arch/riscv/include/asm/pgtable.h:513:9: error: implicit declaration of function 'pfn_pmd';
>  did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
>
> 2.build with CONFIG_SPARSEMEM=y && CONFIG_SPARSEMEM_VMEMMAP=n
> arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
> include/asm-generic/memory_model.h:64:14: error: implicit declaration of function 'page_to_section';
>  did you mean 'present_section'? [-Werror=implicit-function-declaration]
>
> Use macro definition instead of inline function for mk_pmd
> to fix the above problems.It is similar to the mk_pte macro.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 4b708ae08910..f35d9c90d4cb 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -508,10 +508,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
>  	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
>  }
>
> -static inline pmd_t mk_pmd(struct page *page, pgprot_t prot)
> -{
> -	return pfn_pmd(page_to_pfn(page), prot);
> -}
> +#define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
>
>  static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  {

Thanks, this is on for-next.
