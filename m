Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4DA3BC4EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 04:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhGFCxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 22:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGFCxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:53:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8BC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 19:50:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y2so5081305pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 19:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=aAumG8loxWBg0YCddQ8wmZZlwLMJsBOBHpIVAqqaaHI=;
        b=uI+qlQC8Q7cUkNM0Ne6nIs5Bgn8RbRmM47Q7douT1F70vKi/8LtSAXR7G01yRIKt+L
         EsS4gtkZ5smlA0Rfhu0oaeZdWM/B9WLvkdxCix6VzQCUVBqMDJ1cKlfgsoz3bqpFvnUx
         oJD32G0amzaN/zDp3ZLSenOTYbcukOrxnLS09rZrcK9M7r6tZ7SQYADc8JaS+KfmLlq+
         Givg1ZD4eN75FUSMRneBUbbM55gtcs5iT3o1d1/iXPxifSqTS1t4m1zffIe4qn6moBRa
         qMyi8s7i2vH7zZPMpw6wvsnjyrrJczF/4SV+ws18YmV6vTsouLTDHXhpDgvr7hiMpigJ
         z1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=aAumG8loxWBg0YCddQ8wmZZlwLMJsBOBHpIVAqqaaHI=;
        b=gyhBMj7jTQHwVf0j37awzEzDeHTOW83hp4t0+WEUTTrJWDDtspx+ZGeqv2IF+lKa3b
         sqJHBVdiQHJBK/E+RvtIyQk4NXwTV+J/AZyGS8YfibJCZsHMfxC8NonzoqhQbTGkcmX3
         spFckMBFXpfjGEBBgMXHkggVe+lgDOFycE8WmelmNQCoqmRT3sRdAvSZGsYw/DXNajk4
         wjqQwSmOfz/YCyGugRBnGgNAcLbk68OUJaTiusCI/v49aQkp0eY2jF9Xot9tZmUi/XPO
         MY2VEoZMrbBMatB7uu1aRyHq+vQefEsXOOpHr3EeHMc8E8IIEQqOOWBcMYF/xwaixYpU
         4QXw==
X-Gm-Message-State: AOAM530ZJN1HmEEI6t9PtOcCFMjxGY/c2QjJkChypHEwoyFKpNvq9ahK
        MkdvsmfLlLIiB3SGKpxEnnrtaA==
X-Google-Smtp-Source: ABdhPJxLWWPlrfKlCz1SsK6JAmb63yvPAVRCWENawgnzp5NCG+ImxvO8x30bEQRsX6rJbw/j3IwRng==
X-Received: by 2002:a63:7d5:: with SMTP id 204mr18579496pgh.309.1625539854984;
        Mon, 05 Jul 2021 19:50:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 92sm831957pjv.29.2021.07.05.19.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 19:50:54 -0700 (PDT)
Date:   Mon, 05 Jul 2021 19:50:54 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Jul 2021 19:32:45 PDT (-0700)
Subject:     Re: [PATCH v2 -next] riscv: mm: fix build errors caused by mk_pmd()
In-Reply-To: <20210617095831.2398438-1-sunnanyong@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunnanyong@huawei.com
Message-ID: <mhng-baa33662-8457-4b94-8307-87f326fefe36@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 02:58:31 PDT (-0700), sunnanyong@huawei.com wrote:
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
> Move the definition of mk_pmd to pgtable-64.h to fix the first error.
> Use macro definition instead of inline function for mk_pmd
> to fix the second problem. It is similar to the mk_pte macro.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
> Changes in v2:
> - Move mk_pmd to pgtable-64.h
> ---
>  arch/riscv/include/asm/pgtable-64.h | 2 ++
>  arch/riscv/include/asm/pgtable.h    | 5 -----
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 1439017b16f8..228261aa9628 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -79,6 +79,8 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
>  	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
>  }
>
> +#define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
> +
>  #define pmd_ERROR(e) \
>  	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 5ae51e6bd5ab..6bc2582f82e9 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -516,11 +516,6 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
>  	return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
>  }
>
> -static inline pmd_t mk_pmd(struct page *page, pgprot_t prot)
> -{
> -	return pfn_pmd(page_to_pfn(page), prot);
> -}
> -
>  static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  {
>  	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));

Thanks, this is on for-next.
