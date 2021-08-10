Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C673E5243
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhHJEh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbhHJEh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:37:27 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAD7C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:37:05 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d10-20020a9d4f0a0000b02904f51c5004e3so16283458otl.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuMMsEGLKerJ5lRGm/ABGvekt+HABMuilZ78dGDMJFI=;
        b=ioEjI7POv1cOzJm+7aGtRJgUkHGN5G04oOdKw4Y5sPhvuQCMRhHIrbibStOLzToRRe
         dsgBt7ZtUDzC32C9wLFzsphd41QuTZOyW5GGh8u9N9U/YlvctKES0KYQNjK+Ifj6bbQL
         aXmwqH522XxzHPUTBLvNZAKG5azpSHKie775cWKhwwvBsIolmsvyvriYf/uJKG5oo6u+
         4V+N8uD5TAsA17K4PlcM0N1UpExhSWcY5XZDxYOyIRGNIfS71srC2VHAAaJp9bx7Yuah
         DHaWUC7tyXgI6EOeuzbOCtdEo50TLaq8/j7Lnn0CCcAstLoLg+qO08WcLw2v1x1apqre
         Obrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuMMsEGLKerJ5lRGm/ABGvekt+HABMuilZ78dGDMJFI=;
        b=PBOeieR4DKUR7luyy93fBhZNoZGIMjjFrpkKjK8UaOchI8tnQ5cRDsTDORX5m3gF2T
         Js0gGEmLK34IODYHeciW7tWzfYRNIsaHOhGKCL4bmkdx8+W8b2sqOn5CXfDYghtNo2Pg
         zzG+FCO9yyqdIMrt4kVMdyfj+uWQqbhfFqCkYqiKlVoMzQrZ58lcAFey6vSGJuW2sec6
         7948NTcB3srZDHlUljJ3HZHwf43cvZNDmmmbfPTZGAVlXCtOXg3j8wTDzoCPApVq18pd
         TU9kCZgxaLvZoGWBYORhb4mZ081LQMMiyRNoyVyuLMzMGESXMn7a6NedlAfO3kSUh3rL
         pskg==
X-Gm-Message-State: AOAM531L9YpNXO2en9qD3906geC8vCFdgMLuuUDAmT+sg+YfUqcx0kVB
        Nhwa9rpZPRzRJAGepLu+kM/V6ddd86fmNdCVXcYV4w==
X-Google-Smtp-Source: ABdhPJxh1ebQPLukCRAzo162yMxeyI9EjHD2CefBzJPEaYqBoaxTTKzCRsMUssS39EaR+fX2grAPznuKU9j+qgdfN6w=
X-Received: by 2002:a05:6830:1095:: with SMTP id y21mr9439797oto.144.1628570224785;
 Mon, 09 Aug 2021 21:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-14-qperret@google.com>
In-Reply-To: <20210809152448.1810400-14-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:36:27 +0200
Message-ID: <CA+EHjTyb2Ge1QBXyRaTmXfjB=2uy2y-EDxag-Oyy03paAt4tvg@mail.gmail.com>
Subject: Re: [PATCH v4 13/21] KVM: arm64: Expose host stage-2 manipulation helpers
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


On Mon, Aug 9, 2021 at 5:25 PM Quentin Perret <qperret@google.com> wrote:
>
> We will need to manipulate the host stage-2 page-table from outside
> mem_protect.c soon. Introduce two functions allowing this, and make
> them usable to users of mem_protect.h.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 ++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 18 +++++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 87b1690c439f..0849ee8fa260 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -49,6 +49,8 @@ extern struct host_kvm host_kvm;
>  int __pkvm_prot_finalize(void);
>  int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
>
> +int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> +int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id);
>  int kvm_host_prepare_stage2(void *pgt_pool_base);
>  void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 6fed6772c673..f95a5a4aa09c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -273,6 +273,22 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
>         return 0;
>  }
>
> +int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
> +                            enum kvm_pgtable_prot prot)
> +{
> +       hyp_assert_lock_held(&host_kvm.lock);
> +
> +       return host_stage2_try(__host_stage2_idmap, addr, addr + size, prot);
> +}
> +
> +int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
> +{
> +       hyp_assert_lock_held(&host_kvm.lock);
> +
> +       return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
> +                              addr, size, &host_s2_pool, owner_id);
> +}
> +
>  static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
>  {
>         /*
> @@ -309,7 +325,7 @@ static int host_stage2_idmap(u64 addr)
>         if (ret)
>                 goto unlock;
>
> -       ret = host_stage2_try(__host_stage2_idmap, range.start, range.end, prot);
> +       ret = host_stage2_idmap_locked(range.start, range.end - range.start, prot);
>  unlock:
>         hyp_spin_unlock(&host_kvm.lock);
>
> --
> 2.32.0.605.g8dce9f2422-goog
>
