Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A901D3A081D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhFIAIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:08:18 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:38875 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhFIAIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:08:17 -0400
Received: by mail-pf1-f173.google.com with SMTP id z26so16988990pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=R/k0myT1X7Ewv76TA+iGRlCsIF04l49PA1ocz9s7kkU=;
        b=XFN6hEgeyL7VQ+lHXBNI1EMYNmWB3f2IbRNINoLGZ172p543bg08XWPuy1GOY1A/V+
         c4pd5fRkMfw3LXXTbefHrusAgpEyveNdHOpolFk1RMHTgyzrqqo87xnD6c9CxWUbh6kx
         VrkT6+PrPmUxg22oc53mnOFbRullxEc4NWtvttdTnMM7ICsaeOMri+J5E5Lt1bc8d8Ys
         4Ph1g40MhZ8zJMuSa0btSNQC8GlI40efsxBv3O76d5ywlhO/F29Zy2bPbuwtooNFw/oz
         jk49UmYy/gLaFPkVC4xNNi29/pVffLZy9I2DTmZyUPDaTlwgWvn9iW/evP7pBU/EA/Xr
         x7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=R/k0myT1X7Ewv76TA+iGRlCsIF04l49PA1ocz9s7kkU=;
        b=CyybDDMymAQwCQPBJfI/tnGgupztSayPfZAqPua2ItPaouyHjIfq7wUIVR/Okav5D0
         oaQsjLEkHv8T7lD5kiJ4SHMO0UzexS9iF6uRMdYNCUWggCvh8PiHOM7lhiWQUSbjXhv8
         ekDKVVPd/krzQCZ9SSqunFT5U2VIsB0A70+jCPI/2kyEIi6xZOAg6UvYExqs9+QpoaRR
         EiUps5oirGbKnsZCdcFehh9Apip7sonxpFTVnN5eIOjBftzJsdhIwHCDl65ahRjSq0sc
         K74wtU8ChV30mF42Oow662Sz8hvzi4zRMRasDHcrCuaGUx0EQfnq48NMPHpn+Qo/ef7B
         gkOA==
X-Gm-Message-State: AOAM533d6xaxNITAv9zK9muLANGcZxIFhd7K5u4dEcNNOK0UvgS62a2W
        RJPPbjyi9qSa0mex15j483QhUg==
X-Google-Smtp-Source: ABdhPJye+W8VRhoqCXDkNa2Q2xQUuGVDU122+jgT3y0Vuv9BLAvkAVIfht2VcK8SrIzNgFC/bgc2Sg==
X-Received: by 2002:a63:1542:: with SMTP id 2mr827496pgv.329.1623197113206;
        Tue, 08 Jun 2021 17:05:13 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w125sm11361134pfw.214.2021.06.08.17.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:05:12 -0700 (PDT)
Date:   Tue, 08 Jun 2021 17:05:12 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Jun 2021 17:05:10 PDT (-0700)
Subject:     Re: [PATCH -next v3] riscv: fix build error when CONFIG_SMP is disabled
In-Reply-To: <20210529080657.18997-1-cuibixuan@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        vincent.chen@sifive.com, sunnanyong@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        cuibixuan@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     cuibixuan@huawei.com
Message-ID: <mhng-ce62a50e-85c7-4fc2-9dc0-7b8a9105ab4b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2021 01:06:57 PDT (-0700), cuibixuan@huawei.com wrote:
> Fix build error when disable CONFIG_SMP:
> mm/pgtable-generic.o: In function `.L19':
> pgtable-generic.c:(.text+0x42): undefined reference to `flush_pmd_tlb_range'
> mm/pgtable-generic.o: In function `pmdp_huge_clear_flush':
> pgtable-generic.c:(.text+0x6c): undefined reference to `flush_pmd_tlb_range'
> mm/pgtable-generic.o: In function `pmdp_invalidate':
> pgtable-generic.c:(.text+0x162): undefined reference to `flush_pmd_tlb_range'
>
> Fixes: e88b333142e4 ("riscv: mm: add THP support on 64-bit")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> Acked-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
> Changes in v3:
> Deleted the declaration of the flush_pmd_tlb_range() in the patch
>
> Changes in v2:
> Move the declaration of flush_pmd_tlb_rang to tlbflush.h
>
>  arch/riscv/include/asm/pgtable.h  | 5 -----
>  arch/riscv/include/asm/tlbflush.h | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 29e2c836848d..eda31002c4b1 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -622,11 +622,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  {
>  	return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
>  }
> -
> -#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> -void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> -			unsigned long end);
> -
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  /*
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index c84218ad7afc..801019381dea 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -33,6 +33,11 @@ void flush_tlb_mm(struct mm_struct *mm);
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> +void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> +			unsigned long end);
> +#endif
>  #else /* CONFIG_SMP && CONFIG_MMU */
>
>  #define flush_tlb_all() local_flush_tlb_all()

Thanks, this is on for-next.
