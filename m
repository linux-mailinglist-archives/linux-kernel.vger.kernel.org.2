Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9578C436CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhJUVi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhJUVi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:38:58 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A4C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:36:41 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id y145-20020a4a4597000000b002b7d49905acso552878ooa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRNtTwwPnxjXoQKUj+SOZiqPnRhwPZWLN+iG47NsqoQ=;
        b=GyQrxCrHkZjNqMu9FcCVqxCJ4grSTrmG2WatNM95IOm1iZaYMMxt9I3WkrnX95tghz
         7Gdt4nw5XfNnSmJJmGf/oaYTMDs2ulS6jaBcck2h2HbH3ACR2VC5fapfYuWqjdFt5uBa
         +3d0X0eF9o0Nf7ctfpnQ8KGwi0+MHs3uP/S5hyVuVwAkedzYBjUAofFOxbeKyn9jBlfP
         v3auahUbaIxxvYXE2cSOvti3CmJiJTes9cqp3Qf4zeT2bB07dXX+6iI+JZ5tTcF+zzxD
         4CwFGUcKnkyEzrUHOVXygx065s5k6XZ4KFb/h5wcz8bEYR5/js8d+UHeaA2JFzWa1vvz
         be8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRNtTwwPnxjXoQKUj+SOZiqPnRhwPZWLN+iG47NsqoQ=;
        b=qHUGFPA4+IyrCyvRnv4zF8IeYT5+C1DMazKFd1zG60ASAJRhCjcSYKpoXULhxMaPUT
         17Levjh/9iSSWGbG17qUu1RqgxvZ/AvtNFvy/ImY1k96n5l84mXxhFT7vxV+Zne5PdNL
         H3pIMTzyUXy4xOT1cGOZ2MSeMTiUoMIgIuhD4zb0BncWY2xfmwrcT6PjtW9btZFQw/vT
         T/KX2kaI4zDbDvy4ipPUcdhHs1mR7HwKDAGZeuMY6PHhFR+cxB77NWt2NMkKYE30G5dx
         C9dvHcEeOphssqjHGdiIY8rPMBRNNpejaU7IJl4gVc81r042ShsjGb20rfeBuNTj/nDF
         KnTw==
X-Gm-Message-State: AOAM531vXjcfcEXFrnBIgqQ7w0SMkZ7efz5jVS5LBCUjUtCwhJgvSlCt
        jmWLCLquMckl5qLlBHiIIeXV1xGdUPuwzSpTejxdbA==
X-Google-Smtp-Source: ABdhPJzQIkWNtHR+fiye6/Mx3U/zLToUe8e8vjWreFjttnwbmcDKNhN4UXqDSMApa18ICdyVklwhyLlQY4UVmK9Lfik=
X-Received: by 2002:a4a:d099:: with SMTP id i25mr6337635oor.86.1634852200860;
 Thu, 21 Oct 2021 14:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211021211958.1531754-1-pbonzini@redhat.com>
In-Reply-To: <20211021211958.1531754-1-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 21 Oct 2021 14:36:29 -0700
Message-ID: <CALMp9eR3bt5P_+ZTJqcckL1pbZCyS6dCNK8o2OQR-atU_A_jtQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: advertise absence of X86_BUG_NULL_SEG via CPUID
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, dgilbert@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 2:20 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Guests have X86_BUG_NULL_SEG if and only if the host have it.  Use
> the info from static_cpu_has_bug to form the 0x80000021 CPUID leaf that
> was defined for Zen3.  Userspace can then set the bit even on older
> CPUs that do not have the bug, such as Zen2.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/cpuid.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 2d70edb0f323..b51398e1727b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -902,7 +902,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>                 entry->edx = 0;
>                 break;
>         case 0x80000000:
> -               entry->eax = min(entry->eax, 0x8000001f);
> +               entry->eax = min(entry->eax, 0x80000021);
> +               /*
> +                * X86_BUG_NULL_SEG is not reported in CPUID on Zen2; in
> +                * that case, provide the CPUID leaf ourselves.
> +                */

I think this is backwards. !X86_BUG_NULL_SEG isn't reported in CPUID on Zen2.

> +               if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
> +                       entry->eax = max(entry->eax, 0x80000021);
>                 break;
>         case 0x80000001:
>                 cpuid_entry_override(entry, CPUID_8000_0001_EDX);
> @@ -973,6 +979,15 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>                         entry->ebx &= ~GENMASK(11, 6);
>                 }
>                 break;
> +       case 0x80000020:
> +               entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +               break;
> +       case 0x80000021:
> +               entry->ebx = entry->ecx = entry->edx = 0;
> +               entry->eax &= BIT(6);

While we're here, shouldn't bit 0 (Processor ignores nested data
breakpoints) and bit 2 (LFENCE is always dispatch serializing) also
match the hardware?

> +               if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
> +                       entry->eax |= BIT(6);
> +               break;
>         /*Add support for Centaur's CPUID instruction*/
>         case 0xC0000000:
>                 /*Just support up to 0xC0000004 now*/
> --
> 2.27.0
>
