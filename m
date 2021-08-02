Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B013DD30F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhHBJjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhHBJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:39:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B75C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 02:39:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so16926398ota.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 02:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIhuVO31AIHAnVi6gacSlctqNjiS0tDQNaPPnMjyEgs=;
        b=CkxP3OMXRT7rLbi/FFZl51CGbyjS+cUeycZ1yrPwAdMjmCFHeISe0JpzKij21Jchjq
         MvAe1d0WxwSfKYnIb1jc0xFIzN8HqVswmLgEE3YJRp38bPU8r/2UKvCmwqGGp0HiSgjX
         IGDqOxgIr3kU9YwrqodFq+cXJ+QSVM6kjGUWItG6KvmqMw3xDG+AzrRYcGkrkRjFK7rJ
         otiDrGnvky+wnLfJedyWkXTwUz48sxy111gyhJJe4Pd6c969o8ZixHKRWDLZi44yMv4L
         jF3jgEs07drqy5cd1Kb6azRN5jr3AN1qGAj3cq6dNxekSFxzjwTohMfMfJNtVNp8V+uU
         n/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIhuVO31AIHAnVi6gacSlctqNjiS0tDQNaPPnMjyEgs=;
        b=bolWWsRsD9RIYijsGRbfUprC8jxPjW353lJnf2YjgC+cK5Ca11aXnVftYZjmpF7Psd
         4BFf9q/hE72rsLFFOyS0fpGMmuPS+qcMDGdzfFO5uMY60fFILlxgvMQP0Ua0zCLmAORf
         XGek0OzQkwLzQ/JlAHo50pVRQR6s3nB4BTJV90fwK9X8H3qeuQxQi6e8f277I0JAZaEX
         JU8ZMahc9/kcwoJo0OgY2m7L2oFZGlcRpPCh+XwITHVBFN7yba66uaGZpqRJI+NRUdO4
         mBMauvZ8OTPrLjolSm8+MXWd7QrTV/BpKM43p+lFZtOfgvn0Peavpscra2oUXbv97pjj
         zpUA==
X-Gm-Message-State: AOAM532+rF0HNsntZcQ9qczpnFPZQjnmo4VvI0dmPCCcKk5d1cW2u1ys
        hmchUcvIXVEVcNCbO7lv1eIgs0Ei7elx4qBBirlpFw==
X-Google-Smtp-Source: ABdhPJzScvX5nNNMmBy1r7KuE//uE0B0IqSD3Z0D7k2I3N1Napre9QlekC99+TW4f+xqAoRYkCZnLm//v97AQVtdrbE=
X-Received: by 2002:a05:6830:1455:: with SMTP id w21mr11200078otp.365.1627897147542;
 Mon, 02 Aug 2021 02:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-9-qperret@google.com>
In-Reply-To: <20210729132818.4091769-9-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 2 Aug 2021 11:38:31 +0200
Message-ID: <CA+EHjTwSg8gZCoxkRu1HEiqhKQuAoascU208c19=-MYBuvf1nw@mail.gmail.com>
Subject: Re: [PATCH v3 08/21] KVM: arm64: Don't overwrite software bits with
 owner id
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
> We will soon start annotating page-tables with new flags to track shared
> pages and such, and we will do so in valid mappings using software bits
> in the PTEs, as provided by the architecture. However, it is possible
> that we will need to use those flags to annotate invalid mappings as
> well in the future, similar to what we do to track page ownership in the
> host stage-2.
>
> In order to facilitate the annotation of invalid mappings with such
> flags, it would be preferable to re-use the same bits as for valid
> mappings (bits [58-55]), but these are currently used for ownership
> encoding. Since we have plenty of bits left to use in invalid
> mappings, move the ownership bits further down the PTE to avoid the
> conflict.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 59a394d82de3..1ee1168ac32d 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -46,7 +46,7 @@
>                                          KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
>                                          KVM_PTE_LEAF_ATTR_HI_S2_XN)
>
> -#define KVM_INVALID_PTE_OWNER_MASK     GENMASK(63, 56)
> +#define KVM_INVALID_PTE_OWNER_MASK     GENMASK(9, 2)
>  #define KVM_MAX_OWNER_ID               1

This change makes sense so that the same bits can be used to track sharing.

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

>
>  struct kvm_pgtable_walk_data {

> --
> 2.32.0.432.gabb21c7263-goog
>
