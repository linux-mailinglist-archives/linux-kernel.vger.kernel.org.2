Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5584E379BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhEKBZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhEKBY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:24:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771E5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:23:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y26so20897436eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 18:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J28mPo9DNF18j/+f6hlKhGa2yEK6TEh7aaZPgHVPtQk=;
        b=gRtY3S0H5TcKX2xWpOIeFdkU3pcN5eQIaDqdkaHGx3vdNWdDcqspfzYTj0aTP4MCWP
         4oWbpDa+pxbZA3GC7+wFH9Y994gdG33nhl/fFnB5F3JmvtO4QSox4xZA2XLzGPUJsI4q
         DZTiyuBRsMH08IWwuGBxwkUD3NPKmFAz7NSYsFLMkYdGlc0CslddRbpLAJusQZldWtzN
         3tTrmwybOCigf4EV+qoV+/5O+d42RvsqLLyKpFrWfZR35eutvT6HzqBQD1bAlx6EtW0/
         0Zi2PXJrvn02NMEvlQmjXt6JdiiC+Gzd8UmfBpcj3BHQcAWC7msBQoOCksJi07J8TkUG
         XJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J28mPo9DNF18j/+f6hlKhGa2yEK6TEh7aaZPgHVPtQk=;
        b=tQN4uOfGogXBMiSaLYN9qTpII8iY+iw6WBLUD2xx6HM6nKdcl0zjpYEhzM6qwvyy86
         DTSHLJTjW4ltrClFzc4MaXU7dlijEqJjD+tPGOCdsWXbjVgJLztmwrKCHo0ySFjvFRng
         uzaHnRtmAcSlly+V/chSgO1pkCBe6TPZ6b2r3rmQ2BEUFd6xLH7G0c4AwA/P0m1+2tTs
         LFmARiA1L8NftQM0T9TVA98lBLufXTrNTmYS89CD98JjeBFSWwsjFfsREVpOwDHbTjjK
         7O8u0vfDIOoOjKGC7NyrS4fozgOfgRJ+qcMBWxpb8PyTWXVHoXnRH6r9O7fAik5eTA83
         ia7Q==
X-Gm-Message-State: AOAM533e/b7YLKBSTJ1lqilvWJlNDQrlI+R4UWPq47r1e3AML3RqIU0T
        ejrQjn8yLjBhvEx7FTeoxz5EAKzNED86xUrwu4I24jKQ+sY=
X-Google-Smtp-Source: ABdhPJw3xZRT/rmUmX0W020rx9yEqMBoGNRPI2ytx1kDMn2AnEn/d/UQQ4w8lLZwadL+iEAyCpcLdroAeuhZUdsuLMk=
X-Received: by 2002:a50:ff13:: with SMTP id a19mr32802570edu.300.1620696232121;
 Mon, 10 May 2021 18:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com> <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 May 2021 18:23:41 -0700
Message-ID: <CAPcyv4jGmhkrd+Zr4RNcZ5qfXkYO-416Bw2_idVbrgij41yvYg@mail.gmail.com>
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:02 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> When running as a TDX guest, there are a number of existing,
> privileged instructions that do not work. If the guest kernel
> uses these instructions, the hardware generates a #VE.
>
> You can find the list of unsupported instructions in Intel
> Trust Domain Extensions (Intel=C2=AE TDX) Module specification,
> sec 9.2.2 and in Guest-Host Communication Interface (GHCI)
> Specification for Intel TDX, sec 2.4.1.
>

Ah, better than the "handle port io" patch, these details at least
give the reader a chance.

> To prevent TD guest from using MWAIT/MONITOR instructions,
> support for these instructions are already disabled by TDX
> module (SEAM). So CPUID flags for these instructions should
> be in disabled state.

Why does this not result in a #UD if the instruction is disabled by
SEAM? How is it possible to execute a disabled instruction (one
precluded by CPUID) to the point where it triggers #VE instead of #UD?

> After the above mentioned preventive measures, if TD guests still
> execute these instructions, add appropriate warning messages in #VE
> handler. For WBIND instruction, since it's related to memory writeback
> and cache flushes, it's mainly used in context of IO devices. Since
> TDX 1.0 does not support non-virtual I/O devices, skipping it should
> not cause any fatal issues.

WBINVD is in a different class than MWAIT/MONITOR since it is not
identified by CPUID, it can't possibly have the same #UD behaviour.
It's not clear why WBINVD is included in the same patch as
MWAIT/MONITOR?

I disagree with the assertion that WBINVD is mainly used in the
context of I/O devices, it's also used for ACPI power management
paths. WBINVD dependent functionality should be dynamically disabled
rather than warned about.

Does a TDX guest support out-of-tree modules?  The kernel is already
tainted when out-of-tree modules are loaded. In other words in-tree
modules preclude forbidden instructions because they can just be
audited, and out-of-tree modules are ok to trigger abrupt failure if
they attempt to use forbidden instructions.

> But to let users know about its usage, use
> WARN() to report about it.. For MWAIT/MONITOR instruction, since its
> unsupported use WARN() to report unsupported usage.

I'm not sure how useful warning is outside of a kernel developer's
debug environment. The kernel should know what instructions are
disabled and which are available. WBINVD in particular has potential
data integrity implications. Code that might lead to a WBINVD usage
should be disabled, not run all the way up to where WBINVD is
attempted and then trigger an after-the-fact WARN_ONCE().

The WBINVD change deserves to be split off from MWAIT/MONITOR, and
more thought needs to be put into where these spurious instruction
usages are arising.

>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/kernel/tdx.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 3fe617978fc4..294dda5bf3f6 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -371,6 +371,21 @@ int tdg_handle_virtualization_exception(struct pt_re=
gs *regs,
>         case EXIT_REASON_EPT_VIOLATION:
>                 ve->instr_len =3D tdg_handle_mmio(regs, ve);
>                 break;
> +       case EXIT_REASON_WBINVD:
> +               /*
> +                * WBINVD is not supported inside TDX guests. All in-
> +                * kernel uses should have been disabled.
> +                */
> +               WARN_ONCE(1, "TD Guest used unsupported WBINVD instructio=
n\n");
> +               break;
> +       case EXIT_REASON_MONITOR_INSTRUCTION:
> +       case EXIT_REASON_MWAIT_INSTRUCTION:
> +               /*
> +                * Something in the kernel used MONITOR or MWAIT despite
> +                * X86_FEATURE_MWAIT being cleared for TDX guests.
> +                */
> +               WARN_ONCE(1, "TD Guest used unsupported MWAIT/MONITOR ins=
truction\n");
> +               break;
>         default:
>                 pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>                 return -EFAULT;
> --
> 2.25.1
>
