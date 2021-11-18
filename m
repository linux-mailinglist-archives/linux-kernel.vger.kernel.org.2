Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B738E45561C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 08:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbhKRH4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 02:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244094AbhKRH4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 02:56:31 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD3C061767
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:53:31 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v138so15477619ybb.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDKkX88+RykK6wFZB2EhLlhOTISSe/7PLhp9ZnITJ4w=;
        b=GBPf3ujyvv0e/Ary9Bbgc77cgsmIbFvTE/JT0m3GhcdkloU/Wx58qnaZxMsMdDo/j5
         zULXuXv7FVQ+wyLH2mAwWPKqFg8oyOivakS302gBbrEjwB91SfYILsj1VGIzHtsF95mv
         V1hHkbRcGqxcjOiKYGOlDUQC+HYO+mI0kqlHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDKkX88+RykK6wFZB2EhLlhOTISSe/7PLhp9ZnITJ4w=;
        b=3T19/qR/BeoEVXCtLnEwTTa1PZSs6MgEN0zIKG6jKEWKKX9SThT624X1Q9XoLj81db
         UpYB8lfjO3odSwURC+mLE1vzxi0SXKd1p3YGMSOd1FWHSvZ27IBgyZ5hnpVf7RAW2zF9
         i6qwfpG2VnSfut2MwZplD6qMnmYBWVCygVb9HH8rmmnZgxssmkSCUcmX0u5kpqgUkTME
         114j2ES/yuL2+Ot0YXk3c9XUCL+TwDFvT+DSktAEzXwunNFPBc6o9apZgmdsWCrDGig1
         dOj4FO4Npb/ELmO181jdByAZ8cBb8fXcCYDUguHIhXfP8Y8BVQH6fOERFGBtkvvrZJ+w
         4tTA==
X-Gm-Message-State: AOAM532yPHWo7pX3rWEas32kGfs72C2v7P/kG2zWkM3KpSeKtOj8/15X
        Y8PfN0whH0isq8ef6fL/OfG6x+mlsFLThZLG/R9n
X-Google-Smtp-Source: ABdhPJxYS+1xnfc4pBR9/P4FZ+QxojJsLGzE4XFFT6z5qm2enZAwYkcIxqwk5PMY7nbGklDq2K2ZjW8EyyQ8O/QyOTo=
X-Received: by 2002:a25:5f4c:: with SMTP id h12mr25017780ybm.169.1637222010841;
 Wed, 17 Nov 2021 23:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20211117060241.611391-1-anup.patel@wdc.com>
In-Reply-To: <20211117060241.611391-1-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 17 Nov 2021 23:53:20 -0800
Message-ID: <CAOnJCU+KZn2JnZg-FZcJ7PXRpGo5SyOmdUYFeJgBenPO9xxE1w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix incorrect KVM_MAX_VCPUS value
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 10:03 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> The KVM_MAX_VCPUS value is supposed to be aligned with number of
> VMID bits in the hgatp CSR but the current KVM_MAX_VCPUS value
> is aligned with number of ASID bits in the satp CSR.
>
> Fixes: 99cdc6c18c2d ("RISC-V: Add initial skeletal KVM support")
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/kvm_host.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 25ba21f98504..2639b9ee48f9 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -12,14 +12,12 @@
>  #include <linux/types.h>
>  #include <linux/kvm.h>
>  #include <linux/kvm_types.h>
> +#include <asm/csr.h>
>  #include <asm/kvm_vcpu_fp.h>
>  #include <asm/kvm_vcpu_timer.h>
>
> -#ifdef CONFIG_64BIT
> -#define KVM_MAX_VCPUS                  (1U << 16)
> -#else
> -#define KVM_MAX_VCPUS                  (1U << 9)
> -#endif
> +#define KVM_MAX_VCPUS                  \
> +       ((HGATP_VMID_MASK >> HGATP_VMID_SHIFT) + 1)
>
>  #define KVM_HALT_POLL_NS_DEFAULT       500000
>
> --
> 2.25.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
