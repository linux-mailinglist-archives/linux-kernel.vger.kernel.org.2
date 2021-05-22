Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0C238D66B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhEVQAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 12:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhEVQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 12:00:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53E0C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 08:58:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ot16so10572390pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YC0AUzrulbfXTPGUc6+Eo3yjtdbpbQr1DON/2cAmC8k=;
        b=1ZCdw+5jYXoni4Z20fd02wMjFgDKuQCeYYsbZZlGNgrYaRso7G25McVG5/j9Ndp2qo
         Lho+FiPX1jtz5f9pPWo60WCw+rqoDJ6QbZVZven1A94SEOUQMb/7CFtHD0swUVfA/92F
         20gSHXAxKWkl5jON7/R1ufJPwir5GZcNWfbJkbdZ86POZIs9+ozjV6dY+pQuYPRU4/h6
         dN7hwg44G1JYfxQBeJp+KfW0HtJlb1TNmQChe9iylgPUbokhBuQzO5oYQz8Oo5/5YUMb
         fcyJNkG9v4o+La6OM/y3QIcsh9XPLWWP00zC/HTQXD350unyXbpCVE422Di5OkqhHJ7c
         heGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YC0AUzrulbfXTPGUc6+Eo3yjtdbpbQr1DON/2cAmC8k=;
        b=YDr5uqnlchRWBgKEwA0A5zjQ24/qEcnMp4sJ2N3sp5MaAwXa+clbY5InjkvcnsUfaB
         rDMfI66Et6Pc8KlKw188rQcv1JR02JbG43e0P9AADNqRUKdJQf7+jrJ+2020Xb9wxINJ
         1Jd7M6DIob2NqPzeH/T0A1Y+I6dYUmdqqPhDMLK3OUjQ5mcJuR7+ZRLCz7gOVbv1WLzT
         8/6EBDVV74hyQRVfYcJho4x3dDvs1rcf0np6SakniJIxmRAVFbVhb6xEOLUPU8jwI0+U
         wN3lEZGGZu3K16DgAtzWOJUiJwXoTaZ9Gq1dF8gbi67OnL4BMtPoGrfg1etV4TSKK8GW
         2//g==
X-Gm-Message-State: AOAM531ZK9qy0TGzb8FAJoH2QClJLZAbJCd7F/vtdmXGqJ9rF0BkX2R2
        m6cEuls2ph8N1mV9F75+u5/rbw==
X-Google-Smtp-Source: ABdhPJzfD3lIGj2z7tMu9To9+LZC4m6Mitb2IPcsL/WvC7j2QUJD7RgGKOvA5D1D4ItV67bS5B5CWA==
X-Received: by 2002:a17:90a:aa14:: with SMTP id k20mr16800134pjq.88.1621699131009;
        Sat, 22 May 2021 08:58:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n69sm636105pfd.132.2021.05.22.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 08:58:50 -0700 (PDT)
Date:   Sat, 22 May 2021 08:58:50 -0700 (PDT)
X-Google-Original-Date: Sat, 22 May 2021 08:58:47 PDT (-0700)
Subject:     Re: [RFT PATCH] riscv: mremap speedup - enable HAVE_MOVE_PUD and HAVE_MOVE_PMD
In-Reply-To: <20210417003539.5bceabc2@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-5de139d5-ac6e-4f73-9d63-721790b30c26@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 09:37:22 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> HAVE_MOVE_PUD enables remapping pages at the PUD level if both the source
> and destination addresses are PUD-aligned.
> HAVE_MOVE_PMD does similar speedup on the PMD level.
>
> With HAVE_MOVE_PUD enabled, there is about a 143x improvement on qemu
> With HAVE_MOVE_PMD enabled, there is about a 5x improvement on qemu
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> Hi all,
>
> After reading the risc-v privileged spec, I think it's safe to support
> the HAVE_MOVE_PUD and HAVE_MOVE_PMD optimization on riscv. The patch passed
> the mremap_test on QEMU. However this can't be tested on real HW due to lack
> of HW boards, this is the reason why I mark this patch as RFT. I hope I can
> buy a sipeed Allwiner D1 SoC powered SBC soon, at least I can test
> HAVE_MOVE_PMD. Helping me to test on real HW is appreciated!
>
> Thanks
>
>  arch/riscv/Kconfig               |  2 ++
>  arch/riscv/include/asm/pgtable.h | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e8074d248457..37660de68b00 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -80,6 +80,8 @@ config RISCV
>  	select HAVE_KPROBES
>  	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_KRETPROBES
> +	select HAVE_MOVE_PMD
> +	select HAVE_MOVE_PUD
>  	select HAVE_PCI
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index ebf817c1bdf4..287733b95d10 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -360,6 +360,18 @@ static inline void set_pte_at(struct mm_struct *mm,
>  	set_pte(ptep, pteval);
>  }
>
> +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +			      pmd_t *pmdp, pmd_t pmd)
> +{
> +	set_pmd(pmdp, pmd);
> +}
> +
> +static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
> +			      pud_t *pudp, pud_t pud)
> +{
> +	set_pud(pudp, pud);
> +}
> +
>  static inline void pte_clear(struct mm_struct *mm,
>  	unsigned long addr, pte_t *ptep)
>  {

Thanks, this is on for-next.
