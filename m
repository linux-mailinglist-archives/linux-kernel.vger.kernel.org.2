Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10CC3DD30C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhHBJiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhHBJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:38:09 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77166C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 02:38:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id y18so23453479oiv.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 02:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qnd2EC9vITZLgMCS/eh0ytFlSZARisHdIkWr1reDb+g=;
        b=Cvc16oiWzGruwX0f0ktKnc1ZiyBzxwiqQhJ6zidI9O6soPlFBx0S/h8qiBq1giZ56R
         PLmLFPAKGf6XX1jfTnDi+CtnyBSyDI1LjXcdPSCj7WOhuUHZvjUAQ/cZS6RgpvKQ1FHz
         TufIGOxp4rJPwGDFLeJFThrkm/En8Il1VlcdRkyzsOSBHueCNo/+xiKF1yhSEMEWsYSp
         Aux21NZtYuiMwvPO+6MIZeReeC0zX2cPlz8ebAmvspErZuhEABpQCC+NS58haHIVsyrQ
         HcUOBpS0EsOFhpkNWgZFTYQC62C08pl6dgWCd8FH3fb/YproWIVcsLrfzz42r2uUO6to
         5N2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qnd2EC9vITZLgMCS/eh0ytFlSZARisHdIkWr1reDb+g=;
        b=KJebaSWBAIGBNpigGvvklYX35hmAMPMqJF0DkQOhWfNJtt0/+8p3JKCr5wl69JnM63
         /dc+zcAz5ir16vhFVCRP98Nwnx4RhdQ0KVre1626YhmlA3tZIUhFhjEfaJzhS6CbMbl2
         9VZkyLLcs+jweMJkdInrbspjxChsutg2+i6v02UvyFAYCBv2jVuL9wD9cnM++3W+g/Wu
         mj0/6I3tfmXmyf8DPtajXYO2wAzKIxaGdXxRk5lF83F6H3Kg8m0lmfOOmt7nng6T4zn+
         KAP0YfW8T39Sj/BJ7AEcjgdH65SliX5Wm2hWK6EdmJ9dvFsnqoMtpmpUlkXDbwJuBJm5
         AOrg==
X-Gm-Message-State: AOAM531Q51UskehJ6Yhrp/OWYj1LRJBTOZ4mJBfgI9dmjzKe2yJl/Ayk
        pUEu+FkVXL5RYNImvW79Tt7KD2G3ogSbYzxVDDp8Mw==
X-Google-Smtp-Source: ABdhPJxAZ2w+4Gmwl0Swj3Q7EhvFKuhBneyXqG8Tc52r4GVBIzVckQSJCz5xN0cudeXLur8PfIFHqP4V3T4Vzap4ILk=
X-Received: by 2002:a05:6808:1981:: with SMTP id bj1mr5627597oib.8.1627897079715;
 Mon, 02 Aug 2021 02:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-8-qperret@google.com>
In-Reply-To: <20210729132818.4091769-8-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 2 Aug 2021 11:37:23 +0200
Message-ID: <CA+EHjTyvMdjTAt3Q7ypniF10Qj3_1m_dos=EzxSSCe3Jeo3z4A@mail.gmail.com>
Subject: Re: [PATCH v3 07/21] KVM: arm64: Rename KVM_PTE_LEAF_ATTR_S2_IGNORED
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
> The ignored bits for both stage-1 and stage-2 page and block
> descriptors are in [55:58], so rename KVM_PTE_LEAF_ATTR_S2_IGNORED to
> make it applicable to both. And while at it, since these bits are more
> commonly known as 'software' bits, rename accordingly.

As in the Armv8-A Address Translation spec.

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad



> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 4dff2ad39ee4..59a394d82de3 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -36,6 +36,8 @@
>
>  #define KVM_PTE_LEAF_ATTR_HI           GENMASK(63, 51)
>
> +#define KVM_PTE_LEAF_ATTR_HI_SW                GENMASK(58, 55)
> +
>  #define KVM_PTE_LEAF_ATTR_HI_S1_XN     BIT(54)
>
>  #define KVM_PTE_LEAF_ATTR_HI_S2_XN     BIT(54)
> @@ -44,8 +46,6 @@
>                                          KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
>                                          KVM_PTE_LEAF_ATTR_HI_S2_XN)
>
> -#define KVM_PTE_LEAF_ATTR_S2_IGNORED   GENMASK(58, 55)
> -
>  #define KVM_INVALID_PTE_OWNER_MASK     GENMASK(63, 56)
>  #define KVM_MAX_OWNER_ID               1
>
> --
> 2.32.0.432.gabb21c7263-goog
>
