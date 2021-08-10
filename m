Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C033E524D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhHJEi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbhHJEin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:38:43 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C67C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:38:21 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so20642505otu.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tnu+lsSrDSRPCYWeAaFux3QzDyGNUIeki6mMXLL1AQ8=;
        b=h1swO8aoNKX/XPUmGYeHzDkQRqO2JXJKQNYLluUM/Qv6reFjk6vzUTe/FWxM/I58Y1
         PUpqbklpKLpyrKBJLLP9tBjovMU948PuN8zDU5HtovPgIhrDgK4U6PsW0ezdxrSFa8BW
         6J7Dnp5TWFylH6JalMrSE497B0ykh2UewEPi6z21mFzV9LFrqA5Ua0LueZRBfNE9AJ32
         VLoTGnYUus/gsWvfVTWd3HISSrOiUyuGms08PvTcFefxv10mbAj66vhn2hsoOm4mEhoy
         H25yhfwHagSnXwYW9Pr6QDPJWOMraIoq5aeL5Wy2vZYcEECfMdb8UqXhW6pUeNtT/Y75
         dYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tnu+lsSrDSRPCYWeAaFux3QzDyGNUIeki6mMXLL1AQ8=;
        b=ijnppXECRlJeg3rp3pptuA21Ybjn4gObvUkES59437PKD9TbBPOGpYyGSwN5ndLMrA
         l4ktk9VOtPypsMHIIcVyoLr3qbkrqwKfPM56+AwxjXHteUhwneNLy9k8oKD8Gi777B4I
         e52rZHeHcRJzVhwefAsgHSzMFv4S6p3Mjhf7AP7FUOfNHAdM3S/ueel07ULEfCVNoVLD
         2nUdsHUE88qcsoVPLg8qqyf4XfVXD/7qhGTJecnfeQ2RPK7whv8tRGKkjVu3DNtVUtdW
         1RS8iln+X46w5i417YDlE7ygqDPZedWxyy0izgW/zaiaVjI7EY2Uky4uINihDVidivJe
         DEDw==
X-Gm-Message-State: AOAM533dfVhMza/tIMhrZJZIJ95mmBO8ERDUMUgQ9BaOg18/WEPUsGZE
        Ppob/5xfqvoLKVpIViyLvXhdYM+ttOST8rESHE6Idg==
X-Google-Smtp-Source: ABdhPJz7Ud6NbsIMc8xc/kkaEDx+aqAP+puu3PhhO67FNRYKCRw2jQ/s7n8Y3m0vAFImBSwUQMFFxWe6T/B3a56P0/0=
X-Received: by 2002:a05:6830:1095:: with SMTP id y21mr9442654oto.144.1628570299957;
 Mon, 09 Aug 2021 21:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-16-qperret@google.com>
In-Reply-To: <20210809152448.1810400-16-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:37:43 +0200
Message-ID: <CA+EHjTxTMQ1n2F_6i6Ep9JgJauRs1ez2OyT-3y26dkGS5p58Zw@mail.gmail.com>
Subject: Re: [PATCH v4 15/21] KVM: arm64: Introduce addr_is_memory()
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
> Introduce a helper usable in nVHE protected mode to check whether a
> physical address is in a RAM region or not.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 1 +
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 23316a021880..49db0ec5a606 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -51,6 +51,7 @@ extern const u8 pkvm_hyp_id;
>  int __pkvm_prot_finalize(void);
>  int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
>
> +bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
>  int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id);
>  int kvm_host_prepare_stage2(void *pgt_pool_base);
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index ee255171945c..cb023d31666e 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -197,6 +197,13 @@ static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
>         return false;
>  }
>
> +bool addr_is_memory(phys_addr_t phys)
> +{
> +       struct kvm_mem_range range;
> +
> +       return find_mem_range(phys, &range);
> +}
> +
>  static bool range_is_memory(u64 start, u64 end)
>  {
>         struct kvm_mem_range r1, r2;
> --
> 2.32.0.605.g8dce9f2422-goog
>
