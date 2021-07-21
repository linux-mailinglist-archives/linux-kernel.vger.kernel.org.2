Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4663D0AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhGUIBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbhGUH7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:59:12 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2CC061766
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 01:38:35 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id i11-20020a4adf0b0000b0290263e1ba7ff9so399179oou.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjk9wYDN8kF50l88X0tsNPFKkVLnNkYeT23mxxv/7SU=;
        b=hfZh63wEsME9LvocLpRlEw6rVj1VQ/v2IP8BtPmf0LPzZCTj2bN5J3t708OsoRiTeT
         05sBX9PNxg98AWKgt1OiqvVFL3v6P5xH3fXY0zrTZXW+BcdR+xAT6CsFcdTgZHMghUb1
         wI76eJkMMogT83dSC+fvHNUwsZDEiBaGIBCk9noNDVYjDyoxlJMEgh4EH8mvMQW+2goj
         cSB+zyC1L4CjC0WmVP5Nl0grIimlVFIiRuS0h209pZOjYNth9pVSWS62D35mhmDXIgZ5
         lf1GZX7lZLb5zANyF51wURmgOtTSXCumIGGj2X8RuM+kbpiZddh4CgUlVdKh+AxLiDpJ
         t57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjk9wYDN8kF50l88X0tsNPFKkVLnNkYeT23mxxv/7SU=;
        b=G/JrbIrRgOk9oWuoo393a4/eHakrIu58//WnAMMFjxC2F076Y9EUeg1CDWczJCS514
         k+qduPCrytkhl+BgGbxuxIcLQPyehPC4rxAwu5qeQXmXY7yC/fwzTHvj5DcbdXcyL3OW
         00c8vO/446cOoCLBiV8bzK/tjIcVYhIjJe7BC3ZkgIpmHFYFhGM7COXnki4/JcxZlSVJ
         ulTyiQx1WepmD4Roe2QBKEpRMMuo0Ut4u6OGcKbW9fO5U7j5GmdWxEMJhtlm78xWY7Vr
         q8wEdqkeXxkVv666cmspNZYpzt4NLrgjOFCjZGywXEukUBL4hgw4DGL5qlQJIpAPvO5w
         fLwg==
X-Gm-Message-State: AOAM5338cSYuq/ek/S0OP9o8cnQfpjlcrOLIvBBS98nnG4fawgurMDve
        ZMHzQLrzIl+7KxYi8n6+QjczRB2QmxpSa69vD5ympw==
X-Google-Smtp-Source: ABdhPJy//VB1TOY10+y4WgHDnbceTtCEaCsqZmkKqh7tjjUE/NPaPwrvOM7CfoskWl8rUmKPhGYBa3HPSWiZvxL9j2Q=
X-Received: by 2002:a4a:e14f:: with SMTP id p15mr6493966oot.42.1626856714449;
 Wed, 21 Jul 2021 01:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com> <20210719104735.3681732-13-qperret@google.com>
In-Reply-To: <20210719104735.3681732-13-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Wed, 21 Jul 2021 09:37:58 +0100
Message-ID: <CA+EHjTxnkhDJTAokEA7PsaL9VAZ296Gp3B8CAu4cMSqp67MNwA@mail.gmail.com>
Subject: Re: [PATCH 12/14] KVM: arm64: Refactor pkvm_pgtable locking
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

On Mon, Jul 19, 2021 at 11:48 AM Quentin Perret <qperret@google.com> wrote:
>
> Refactor the hypervisor stage-1 locking in nVHE protected mode to expose
> a new pkvm_create_mappings_locked() function. This will be used in later
> patches to allow walking and changing the hypervisor stage-1 without
> releasing the lock.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mm.h |  1 +
>  arch/arm64/kvm/hyp/nvhe/mm.c         | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index 8ec3a5a7744b..c76d7136ed9b 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -23,6 +23,7 @@ int hyp_map_vectors(void);
>  int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
>  int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
>  int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> +int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
>  int __pkvm_create_mappings(unsigned long start, unsigned long size,
>                            unsigned long phys, enum kvm_pgtable_prot prot);
>  unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,

The locking logic seems to be consistent, with pkvm_create_mappings()
holding the lock for the whole duration of the operation rather than
per-iteration.

It would be nice though to document which lock should be held for the
_locked versions.

Thanks,
/fuad




> diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> index a8efdf0f9003..dde22e2a322a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> @@ -67,7 +67,7 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
>         return addr;
>  }
>
> -int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> +int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
>  {
>         unsigned long start = (unsigned long)from;
>         unsigned long end = (unsigned long)to;
> @@ -81,7 +81,8 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
>                 int err;
>
>                 phys = hyp_virt_to_phys((void *)virt_addr);
> -               err = __pkvm_create_mappings(virt_addr, PAGE_SIZE, phys, prot);
> +               err = kvm_pgtable_hyp_map(&pkvm_pgtable, virt_addr, PAGE_SIZE,
> +                                         phys, prot);
>                 if (err)
>                         return err;
>         }
> @@ -89,6 +90,17 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
>         return 0;
>  }
>
> +int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> +{
> +       int ret;
> +
> +       hyp_spin_lock(&pkvm_pgd_lock);
> +       ret = pkvm_create_mappings_locked(from, to, prot);
> +       hyp_spin_unlock(&pkvm_pgd_lock);
> +
> +       return ret;
> +}
> +
>  int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back)
>  {
>         unsigned long start, end;
> --
> 2.32.0.402.g57bb445576-goog
>
