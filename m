Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2323DD3B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhHBKbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhHBKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:31:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20616C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 03:31:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nd39so30113667ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 03:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGVEq9B5bByjRAfhMPs/aPNjzWR9vo1LM/IsDeZ/fw4=;
        b=NhuObWYcT4Ws0XBuXGzohVpUDGBsWLH4oX9MHLm87mGm0eyOzT5PsB+WKSYrCavXnr
         qPixW7MErBufFuWbaYkRUJLEeTDLjpSj7MFMfR1Xso+L8nRPbtdbfotRZGLumNl7gTJu
         R0K3BmV36cB5GI09hubxsKpuY4ThUI2+rMpsfE5o64afsQ72esreblTgFkjibXtlmMmC
         EOTGmpbqO5PirVRv9RmsdqwM9/ewHqzGMXXQIFHScsTHHJch8eRpXGFveDSELD035UZv
         ly9DrFt1gVzB0onpWLtIl7mzSfGMj9juv9pLca65D6xEx30TGFE6r4dxjouj1wJMNPkd
         48lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGVEq9B5bByjRAfhMPs/aPNjzWR9vo1LM/IsDeZ/fw4=;
        b=sH7blzMK1JiA3MIZE2VY/zWESxntGejHLs/Baj1u7b2C5A6ijxj5PXu0GUAgJYKRcV
         cgRBGzYbLyA869O71hMw44ZFg//H6iFr03k1DXZjDgRQ6C9sQzJAjZQMb3Vrd8zzPPBB
         g5Vg6Dgq4bBwrD1/L4bBSocgyqHxbyBHiteqc2IvgOY6Bt7F/ivyWzez3fN6FUQfp7UY
         nBzczc0A3KmMZw8oxJtB3QdI7z4fZfoORP3Y/aEBp/4CQgaBiwdaDsDWMUTBIfgk6gFi
         vG2KOUkS8KqLC06X+RxPNVNKKplzRi3SctlEvDAsX30VVltXsaaLnLP5lDklpWwX0len
         0UjA==
X-Gm-Message-State: AOAM531DNw8Y5qr6TLZgk9PAovGt2cEX2MMEI3CltRLkorwwJQeDix1q
        xlNKI8TRliQ4gatpw46eIz3DcyFXhvooTx/iBAtQfA==
X-Google-Smtp-Source: ABdhPJwELrHM8KMcxJgMtc2//RdcfHO0BBsraGRqwLVekJXAVvzXhMzTKx/LaOqiF+bS/C2fHPTkVM4G1T50Hhsf+GE=
X-Received: by 2002:a17:906:2441:: with SMTP id a1mr13848525ejb.550.1627900261494;
 Mon, 02 Aug 2021 03:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-13-qperret@google.com>
In-Reply-To: <20210729132818.4091769-13-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 2 Aug 2021 12:30:25 +0200
Message-ID: <CA+EHjTzT+aMGkc5cEwGT+05z6aGmbLi0DBetBGXLh3GFY2GXgQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/21] KVM: arm64: Add helpers to tag shared pages in
 SW bits
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,


On Thu, Jul 29, 2021 at 3:28 PM Quentin Perret <qperret@google.com> wrote:
>
> We will soon start annotating shared pages in page-tables in nVHE
> protected mode. Define all the states in which a page can be (owned,
> shared and owned, shared and borrowed), and provide helpers allowing to
> convert this into SW bits annotations using the matching prot
> attributes.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 9c227d87c36d..ae355bfd8c01 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -12,6 +12,32 @@
>  #include <asm/virt.h>
>  #include <nvhe/spinlock.h>
>
> +/*
> + * SW bits 0-1 are reserved to track the memory ownership state of each page:
> + *   00: The page is owned solely by the page-table owner.

nit: solely -> exclusively, because "exclusive" is the more common
term in context of shared resources

> + *   01: The page is owned by the page-table owner, but is shared
> + *       with another entity.
> + *   10: The page is shared with, but not owned by the page-table owner.
> + *   11: Reserved for future use (lending).
> + */
> +enum pkvm_page_state {
> +       PKVM_PAGE_OWNED                 = 0ULL,
> +       PKVM_PAGE_SHARED_OWNED          = KVM_PGTABLE_PROT_SW0,
> +       PKVM_PAGE_SHARED_BORROWED       = KVM_PGTABLE_PROT_SW1,
> +};
> +
> +#define PKVM_PAGE_STATE_PROT_MASK      (KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
> +static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
> +                                                enum pkvm_page_state state)
> +{
> +       return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
> +}
> +
> +static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
> +{
> +       return prot & PKVM_PAGE_STATE_PROT_MASK;
> +}
> +

I think that this encoding is pretty neat and easy to follow.

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

>  struct host_kvm {
>         struct kvm_arch arch;
>         struct kvm_pgtable pgt;
> --
> 2.32.0.432.gabb21c7263-goog
>
