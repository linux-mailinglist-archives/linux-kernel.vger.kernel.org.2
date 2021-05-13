Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0483F37F1A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhEMDYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhEMDYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:24:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 20:23:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gx5so37930347ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 20:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOTtCFE4miDi+5fncDOfVSlD7bjQEK3Z3ArMZP2iSeM=;
        b=kZkfCYmavR33G/p4Ql3d7WDm5fW3zJgrbuH7k7woTbuQZlpOVluzZDZvamncIEMbVT
         XDfvmsbGE5K04V5PNkTSShPP3XnxjyhIpHq/0FpG/NBpeR90LYDifVM90zG7aQtuwytX
         J0AoLDwZ2UMM7LfmuM/BX2aID8sbTYUrAgpTBXVADZIYmOx8NJCz9wnfxvzmI0xUooRu
         dxjbt5Z9KpfPKOtHv2FdE9Y8aiZreEJo1MhtHfUnGRCQUt2xemZTu9GE/9cG0qrvHzg3
         RmIEAYt5ycmHImN4x2xi/nEKy2gTAxXt5bCmimL2h9Pgx1dqMcpUAvt9+oDisqa7F8MT
         5Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOTtCFE4miDi+5fncDOfVSlD7bjQEK3Z3ArMZP2iSeM=;
        b=jQ7Axiyba2mB9rALabkqbIGoZaPQJxcc2ANWiLp8AtOlwcxzxs0jT5w1a4W98oIrmB
         STDGYuAM5IWekKgpJY5AZhjW531+BPKQ9Hza96zsuEv20fHKTo3IcjzeYiCUdSGYC0W7
         Wf467htO4OAUPCj7lkhcaM01tub0Fyr4G0K6bPGl+Pf1kRxTzewIpepI4mXgHS95MZOP
         SLGcduBeR24zPbTMvcKyOqNgf4KEpKt2JCXIc2OtJBvM89aXVBs5lD1HuXQ+mNq1Bm1e
         muKZEEq3ZLUs7HKT2F1fM7HkQfef+gtQy53WPgVftXvMPEgeuAlmMMsWsgPbYwFz3XMq
         EjRQ==
X-Gm-Message-State: AOAM5312n9trRWNuaV/F6CDBvouLsU2nc8oNprzSS10VNDHti4uyP7Hp
        7IUU+n8QuOKRP0atH8tOwZddC+KOtWsvR1Xys1Nkg9gTT9M=
X-Google-Smtp-Source: ABdhPJyuhGtn7XvNr7325TeuIvsrXb6VewjoS5qnhf1wy1MjBOQR+97PfzRPhb6vClO4VpXbz6HZhoYzd0BiuW9xSSA=
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr41598995ejy.323.1620876206549;
 Wed, 12 May 2021 20:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com> <b6e4ea3dfe6648e111e0d9dfcce4174672f8b823.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <b6e4ea3dfe6648e111e0d9dfcce4174672f8b823.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 May 2021 20:23:17 -0700
Message-ID: <CAPcyv4jqr8vyh7BwYxW3QJ_ui_yH+iGniJYuUMEnTLWjiYsvPQ@mail.gmail.com>
Subject: Re: [RFC v2 23/32] x86/boot: Avoid unnecessary #VE during boot process
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:03 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Skip writing EFER during secondary_startup_64() if the current value is
> also the desired value. This avoids a #VE when running as a TDX guest,
> as the TDX-Module does not allow writes to EFER (even when writing the
> current, fixed value).
>
> Also, preserve CR4.MCE instead of clearing it during boot to avoid a #VE
> when running as a TDX guest. The TDX-Module (effectively part of the
> hypervisor) requires CR4.MCE to be set at all times and injects a #VE
> if the guest attempts to clear CR4.MCE.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/boot/compressed/head_64.S |  5 ++++-
>  arch/x86/kernel/head_64.S          | 13 +++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 37c2f37d4a0d..2d79e5f97360 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -622,7 +622,10 @@ SYM_CODE_START(trampoline_32bit_src)
>         popl    %ecx
>
>         /* Enable PAE and LA57 (if required) paging modes */
> -       movl    $X86_CR4_PAE, %eax
> +       movl    %cr4, %eax
> +       /* Clearing CR4.MCE will #VE on TDX guests.  Leave it alone. */
> +       andl    $X86_CR4_MCE, %eax
> +       orl     $X86_CR4_PAE, %eax
>         testl   %edx, %edx
>         jz      1f
>         orl     $X86_CR4_LA57, %eax
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 04bddaaba8e2..92c77cf75542 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -141,7 +141,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  1:
>
>         /* Enable PAE mode, PGE and LA57 */
> -       movl    $(X86_CR4_PAE | X86_CR4_PGE), %ecx
> +       movq    %cr4, %rcx
> +       /* Clearing CR4.MCE will #VE on TDX guests.  Leave it alone. */
> +       andl    $X86_CR4_MCE, %ecx
> +       orl     $(X86_CR4_PAE | X86_CR4_PGE), %ecx
>  #ifdef CONFIG_X86_5LEVEL
>         testl   $1, __pgtable_l5_enabled(%rip)
>         jz      1f
> @@ -229,13 +232,19 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>         /* Setup EFER (Extended Feature Enable Register) */
>         movl    $MSR_EFER, %ecx
>         rdmsr
> +       movl    %eax, %edx

Maybe comment that EFER is being saved here to check if the following
enables are nops, but not a big deal.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...modulo whether the EFER wrmsr avoidance in PATCH 21 should move here.

>         btsl    $_EFER_SCE, %eax        /* Enable System Call */
>         btl     $20,%edi                /* No Execute supported? */
>         jnc     1f
>         btsl    $_EFER_NX, %eax
>         btsq    $_PAGE_BIT_NX,early_pmd_flags(%rip)
> -1:     wrmsr                           /* Make changes effective */
>
> +       /* Skip the WRMSR if the current value matches the desired value. */
> +1:     cmpl    %edx, %eax
> +       je      1f
> +       xor     %edx, %edx
> +       wrmsr                           /* Make changes effective */
> +1:
>         /* Setup cr0 */
>         movl    $CR0_STATE, %eax
>         /* Make changes effective */
> --
> 2.25.1
>
