Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC24233E859
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCQERh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQERa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:17:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C193CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:17:29 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 16so17606424pgo.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mBi1vr1EBCIfBIYiqhthLzLXu/cz4f2HWo3O6rM8TpQ=;
        b=SQWeDYYWjxpwsPtJKs41W8Za5PxW8JF3E/k0FAMCUg/3DA8DX0UZgNz+4VLqQWUMGQ
         oUfBPe4w/yL4cVSrMM/rHqcGG+O4RhH40unsusPfVKN78N6B11yFuQ2J27sip22EAeFk
         w23ha8MsHDQt7XJsvrptipooOO+A2sHtbFZ0ieJ1buq9XF4ax5urr4EB4ylBGRp7OuYy
         QCq6uIQwokhAAutZWgNcDql6EUB6PTZ0n2TdTqaT3H2f6Mk4srNmkQLO1v/aIAG7B7AN
         J1eMqPXzcC1yYiUhIrBuLawdpHXfMIXisChOTnUxmMy7GZjqGijgGT7oWCQKZMf/qAUT
         obTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mBi1vr1EBCIfBIYiqhthLzLXu/cz4f2HWo3O6rM8TpQ=;
        b=H7/GtDd4iZudqaQm8rMUK92i5TA8WgFcx4dJNYVnBqIU1xzdTAmVyCRPL0a5Z6ApDA
         4Up6l4XT0N5Ld+8bK/+F5X7FuApiMWzxZnqq2YYdB9TOlRSIMF++EmBNUNZz/bbR1TKR
         QFqo/Egsxa/ixUwCRvt7FZBv49q5rvWiQR91y1BcntvSczdR2/eBbDBKQQ3X2wCakX03
         xeTD6FB/B4JHUraKhGHpX+/kr5KGpu9KPYdivmscDAtmeLPdfSk+rUsHJcLGakhAI2KQ
         LA+3CvSKdYUJlU0D7plxwlz+te4lCP0s4ooadROyGPtCYyZcZEonfI48ssTM25CHnfhA
         YUOA==
X-Gm-Message-State: AOAM531jXCT/1jNZuCAZVi94Osw9vqYNFJZNkW++FaGFit+tIM2jUTAW
        zmzObXVYDlaXu+b/So0T904QAQ==
X-Google-Smtp-Source: ABdhPJxj8obCDelxJOmnY4EgTEt6uvOFjBGq+dd/ysZB8WNS7PW+umevbjKLPNZ4YaUeVcZbw0Z+iQ==
X-Received: by 2002:a65:428b:: with SMTP id j11mr969021pgp.47.1615954649202;
        Tue, 16 Mar 2021 21:17:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a24sm18405944pff.18.2021.03.16.21.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 21:17:27 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:17:27 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 21:17:23 PDT (-0700)
Subject:     Re: [PATCH] Insert SFENCE.VMA in function set_pte_at for RISCV
In-Reply-To: <20210310062250.74583-1-liu@jiuyang.me>
CC:     waterman@eecs.berkeley.edu, liu@jiuyang.me,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, akpm@linux-foundation.org,
        rppt@kernel.org, wangkefeng.wang@huawei.com,
        greentime.hu@sifive.com, zong.li@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     liu@jiuyang.me
Message-ID: <mhng-875f43ab-ca1e-4b18-a12d-1a0dc8519b53@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2021 22:22:46 PST (-0800), liu@jiuyang.me wrote:
> From: Jiuyang Liu <liu@jiuyang.me>
>
> This patch inserts SFENCE.VMA after modifying PTE based on RISC-V
> specification.
>
> arch/riscv/include/asm/pgtable.h:
> 1. implement pte_user, pte_global and pte_leaf to check correspond
> attribute of a pte_t.
>
> 2. insert SFENCE.VMA in set_pte_at based on RISC-V Volume 2, Privileged
> Spec v. 20190608 page 66 and 67:
> If software modifies a non-leaf PTE, it should execute SFENCE.VMA with
> rs1=x0. If any PTE along the traversal path had its G bit set, rs2 must
> be x0; otherwise, rs2 should be set to the ASID for which the
> translation is being modified.
> If software modifies a leaf PTE, it should execute SFENCE.VMA with rs1
> set to a virtual address within the page. If any PTE along the traversal
> path had its G bit set, rs2 must be x0; otherwise, rs2 should be set to
> the ASID for which the translation is being modified.
>
> arch/riscv/include/asm/tlbflush.h:
> 1. implement local_flush_tlb_asid to flush tlb with asid.
>
> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> ---
>  arch/riscv/include/asm/pgtable.h  | 28 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/tlbflush.h |  8 ++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index ebf817c1bdf4..95f6546ddb5b 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -222,6 +222,16 @@ static inline int pte_write(pte_t pte)
>  	return pte_val(pte) & _PAGE_WRITE;
>  }
>
> +static inline int pte_user(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_USER;
> +}
> +
> +static inline int pte_global(pte_t pte)
> +{
> +	return pte_val(pte) & _PAGE_GLOBAL;
> +}
> +
>  static inline int pte_exec(pte_t pte)
>  {
>  	return pte_val(pte) & _PAGE_EXEC;
> @@ -248,6 +258,11 @@ static inline int pte_special(pte_t pte)
>  	return pte_val(pte) & _PAGE_SPECIAL;
>  }
>
> +static inline int pte_leaf(pte_t pte)
> +{
> +	return pte_val(pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC);
> +}
> +
>  /* static inline pte_t pte_rdprotect(pte_t pte) */
>
>  static inline pte_t pte_wrprotect(pte_t pte)
> @@ -358,6 +370,18 @@ static inline void set_pte_at(struct mm_struct *mm,
>  		flush_icache_pte(pteval);
>
>  	set_pte(ptep, pteval);
> +
> +	if (pte_present(pteval)) {
> +		if (pte_leaf(pteval)) {
> +			local_flush_tlb_page(addr);
> +		} else {
> +			if (pte_global(pteval))
> +				local_flush_tlb_all();
> +			else
> +				local_flush_tlb_asid();
> +
> +		}
> +	}
>  }
>
>  static inline void pte_clear(struct mm_struct *mm,
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 394cfbccdcd9..4b25f51f163d 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -21,6 +21,14 @@ static inline void local_flush_tlb_page(unsigned long addr)
>  {
>  	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
>  }
> +
> +static unsigned long asid;
> +static inline void local_flush_tlb_asid(void)
> +{
> +	asid = csr_read(CSR_SATP) | (SATP_ASID_MASK << SATP_ASID_SHIFT);
> +	__asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
> +}
> +
>  #else /* CONFIG_MMU */
>  #define local_flush_tlb_all()			do { } while (0)
>  #define local_flush_tlb_page(addr)		do { } while (0)

We're trying to avoid this sort of thing, instead relying on the generic kernel
functionality to batch up page table modifications before we issue the fences.
If you're seeing some specific issue then I'd be happy to try and sort out a
fix for it, but this is a bit heavy-handed to use as anything but a last
resort.
