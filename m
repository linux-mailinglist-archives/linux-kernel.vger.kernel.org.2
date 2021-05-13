Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55E137F186
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhEMDEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhEMDEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:04:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D07C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 20:03:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t4so37998520ejo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 20:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGkvk2eWKEiy0tE6esOunetyMvazW1oydYC7p4qoYxM=;
        b=tATlxzTg4daeNomwHmlwqM3tKma+VsKzWw3rBz5Ou8Re6cyJS7WRsOKNa1LPB19XpQ
         zvsymi4trQion+LO8/2DDd6M6bWQo+VJiakrPevj7uBnnavmvLS9v5Xf9CpZ09AZXznc
         olr3HuM4sTd80YIyunjNTDtKfgjKhUY/onO/l5C0U2w6DPAwgwxLS8r0wDj0wIk+MNnS
         HghoD5SXmWk6HtE89+yW1hoXiBJxfVu+CnmDUNSeOk11n1mmepM52du172+6W+U/wwWY
         fa3xrDjhsbTVXaqlS2zLzZ7v0pxHr//W43hwEZ95Zzadc2aI1gN1IFcXj0BcJjQw1amQ
         215g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGkvk2eWKEiy0tE6esOunetyMvazW1oydYC7p4qoYxM=;
        b=CUnoYkI4I75eV1rTNeXhgeqtFypnydodBX5RzGErYUcfzPYJK0BtV1iDEGVdiryxzv
         vMVKSINnEmhhIMkV8A+CwZsKIW1DSK64X6j/wBZ0s5F7VNgy2ldkaD+/Ml8rroXl65/P
         NYuJjqZKP+VNf3rKVAGxPW4kJiTgEdgQ7FVfujgNHRkpwFHjVDTzA3AW82oD9pogSgDx
         CNIdy8XkIXbKrxsSPe9IupLxowzWrsdURxuZStwpIpcGylf87DFGVazl4s3Mt1igO+rG
         YpFeCTFkme4vvVss0PsxJBnKMqnv6QW40iXyQI4cHcTcI0cC0lG6OAEuJisFZmTJK2BL
         wADg==
X-Gm-Message-State: AOAM532XR5A2hIdvGVEw4uSg5f/cAB/hU3lZTHOweyBCxR8uzvwZvg29
        WMyNpberW+4J8PVfF+uo5LeDx76P9gG/QBy9m7lo4A==
X-Google-Smtp-Source: ABdhPJwofq5UbTQzMJWITDRC2jpvjRTpcamQZLw2Q9Iir8SgUFb0Q7owVjliISIxf6W2oubNyfy6mpF0nNe43jTTGYk=
X-Received: by 2002:a17:906:9381:: with SMTP id l1mr40536277ejx.45.1620874992961;
 Wed, 12 May 2021 20:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com> <5765f65857a4d78fd3fb1cbe7c82a6d455b401c4.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <5765f65857a4d78fd3fb1cbe7c82a6d455b401c4.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 May 2021 20:03:03 -0700
Message-ID: <CAPcyv4hi-dx4kd4SLtj+AdorubofCPw+9-Lyq+6dNw9cN_nhGA@mail.gmail.com>
Subject: Re: [RFC v2 22/32] x86/boot: Avoid #VE during compressed boot for TDX platforms
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:03 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Avoid operations which will inject #VE during compressed
> boot, which is obviously fatal for TDX platforms.
>
> Details are,
>
>  1. TDX module injects #VE if a TDX guest attempts to write
>     EFER. So skip the WRMSR to set EFER.LME=1 if it's already
>     set. TDX also forces EFER.LME=1, i.e. the branch will always
>     be taken and thus the #VE avoided.

Ah here's the justification for that hunk in the previous patch, are
you sure that hunk belongs in the trampoline patch?

>
>  2. TDX module also injects a #VE if the guest attempts to clear
>     CR0.NE. Ensure CR0.NE is set when loading CR0 during compressed
>     boot. The Setting CR0.NE should be a nop on all CPUs that
>     support 64-bit mode.

Ah, here's the justification for CR0.NE in the previous patch. Did
something go wrong in the patch splitting?

>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/boot/compressed/head_64.S | 5 +++--
>  arch/x86/boot/compressed/pgtable.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index e94874f4bbc1..37c2f37d4a0d 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -616,8 +616,9 @@ SYM_CODE_START(trampoline_32bit_src)
>         movl    $MSR_EFER, %ecx
>         rdmsr
>         btsl    $_EFER_LME, %eax
> +       jc      1f
>         wrmsr
> -       popl    %edx
> +1:     popl    %edx
>         popl    %ecx
>
>         /* Enable PAE and LA57 (if required) paging modes */
> @@ -636,7 +637,7 @@ SYM_CODE_START(trampoline_32bit_src)
>         pushl   %eax
>
>         /* Enable paging again */
> -       movl    $(X86_CR0_PG | X86_CR0_PE), %eax
> +       movl    $(X86_CR0_PG | X86_CR0_NE | X86_CR0_PE), %eax
>         movl    %eax, %cr0
>
>         lret
> diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
> index 6ff7e81b5628..cc9b2529a086 100644
> --- a/arch/x86/boot/compressed/pgtable.h
> +++ b/arch/x86/boot/compressed/pgtable.h
> @@ -6,7 +6,7 @@
>  #define TRAMPOLINE_32BIT_PGTABLE_OFFSET        0
>
>  #define TRAMPOLINE_32BIT_CODE_OFFSET   PAGE_SIZE
> -#define TRAMPOLINE_32BIT_CODE_SIZE     0x70
> +#define TRAMPOLINE_32BIT_CODE_SIZE     0x80
>
>  #define TRAMPOLINE_32BIT_STACK_END     TRAMPOLINE_32BIT_SIZE
>
> --
> 2.25.1
>
