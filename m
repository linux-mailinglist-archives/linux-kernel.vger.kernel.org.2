Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51566313E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhBHS52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbhBHRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:11:48 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21022C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:11:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 8so8142240plc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1s0Ho2tEE6Azt+CRXpAp6jv2PFVOlZBKNpqhSKKXhkE=;
        b=Y4FB8aKX84yxUrkXUOJmm9DtCjjZJjuObUeCZ3xFFStw/nvzj+OEnFuuRzGhLYJZ1X
         R9UDE3LkpZksHt6hd4Qv7GkhDm/TXQJmzNaeQnqlNKLeUZSus9pAuMPga+IaseLTCFVR
         NAZkPwhSlUdCK3k6Kz3nFcL6K4NFMduBBVXJWBG2n4SmHE657q7C3N3W7Q9kU7imZMUN
         0AjHMsYhhuIWSI3Sa8ZjEd6pwzjvazpmINrFtmaM2kkPEV+iVEoIGU/8rK1SJysdvrpE
         zNv6ATdMZBrkKyVD+w9xaFT3iyHRkBwTeOftSgAQeO6MV5xSvf5bnJl1aDCBzQJOHdCe
         qRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1s0Ho2tEE6Azt+CRXpAp6jv2PFVOlZBKNpqhSKKXhkE=;
        b=JjQ7bJ/mBfewGFykJA9hGdbxaIAaSyXixLkNRxJFx4Mw2mrHoEd488RojCP4k3DLSy
         ywtAemSlPorRi0XKR2OIuSLj+OdztsoN7RFO+JccAWb5Bz04C2uHfOaovJ1YYj+dR0z3
         8MpxDoGUUnvjOPL4fgr46bLyiVkb5qA2qoGfIR48ND8vJGjMJuf27nKzW1/ONcPHFR4c
         rWfULBNW8FQNdnZDJY4ugBZxdZj3OQ3TPp1aGqe4Eps79UEfnMWJjArV+i7hZCNL2rM5
         5WNhwYervPnxVk5m3tHCA5MXkDZ+OUYKjcK1+ykyRIcKNd7rRSlrcU5GLwOXtJrYp+b4
         Sfxw==
X-Gm-Message-State: AOAM531PdJzEv/CDKqBrOAPYt8/7zTRIbeIHBnVR1jgEI05FHUtpgkr3
        RUYT34u/tXtBBOrTX2iEyTkOdA==
X-Google-Smtp-Source: ABdhPJwMgr7wihXu0wL0GI+AoqvdnsplKkGTsDLcU6kwxqH81+X7Lga0CG06yATlBYaQiGylQHDbeQ==
X-Received: by 2002:a17:90b:e94:: with SMTP id fv20mr3955247pjb.207.1612804267403;
        Mon, 08 Feb 2021 09:11:07 -0800 (PST)
Received: from google.com ([2620:15c:f:10:e4db:abc1:a5c0:9dbc])
        by smtp.gmail.com with ESMTPSA id p15sm6093820pja.21.2021.02.08.09.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:11:06 -0800 (PST)
Date:   Mon, 8 Feb 2021 09:10:59 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1 09/26] x86/tdx: Handle CPUID via #VE
Message-ID: <YCFwo5tD3Jad6F69@google.com>
References: <f81afd12-91ed-27c9-58d6-e59e7e1178c0@intel.com>
 <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021, Andy Lutomirski wrote:
> 
> > On Feb 7, 2021, at 2:31 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> > 
> > ﻿On 2/7/21 12:29 PM, Kirill A. Shutemov wrote:
> >>> Couldn't you just have one big helper that takes *all* the registers
> >>> that get used in any TDVMCALL and sets all the rcx bits?  The users
> >>> could just pass 0's for the things they don't use.

IIRC, having exactly one helper is a big mess (my original code used a single
main helper).  CPUID has a large number of outputs, and because outputs are
handled as pointers, the assembly routine needs to check output params for NULL.

And if we want to write up port I/O directly to TDVMCALL to avoid the #VE, IN
and OUT need separate helpers to implement a non-standard register ABI in order
to play nice with ALTERANTIVES.

This also has my vote, mainly because gcc doesn't allow directly specifying
r8-r15 as register constraints to inline asm.  That creates a nasty hole where
a register can get corrupted if code is inserted between writing the local
variable and passing it to the inline asm.

Case in point, patch 08 has this exact bug.

> +static u64 tdx_read_msr_safe(unsigned int msr, int *err)
> +{
> +       register long r10 asm("r10") = TDVMCALL_STANDARD;
> +       register long r11 asm("r11") = EXIT_REASON_MSR_READ;
> +       register long r12 asm("r12") = msr;
> +       register long rcx asm("rcx");
> +       long ret;
> +
> +       WARN_ON_ONCE(tdx_is_context_switched_msr(msr));

This can corrupt r10, r11 and/or r12, e.g. if tdx_is_context_switched_msr() is
not inlined, it can use r10 and r11 as scratch registers, and gcc isn't smart
enough to know it needs to save registers before the call.

Even if the code as committed is guaranteed to work, IMO this approach is
hostile toward future debuggers/developers, e.g. adding a printk() in here to
debug can introduce a completely different failure.

> +
> +       if (msr == MSR_CSTAR)
> +               return 0;
> +
> +       /* Allow to pass R10, R11 and R12 down to the VMM */
> +       rcx = BIT(10) | BIT(11) | BIT(12);
> +
> +       asm volatile(TDCALL
> +                       : "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12)
> +                       : "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12)
> +                       : );
> +
> +       /* XXX: Better error handling needed? */
> +       *err = (ret || r10) ? -EIO : 0;
> +
> +       return r11;
> +}

> >>> Then you've got the ugly inline asm in one place.  It also makes it
> >>> harder to screw up the 'rcx' mask and end up passing registers you
> >>> didn't want into a malicious VMM.
> >> For now we only pass down R10-R15, but the interface allows to pass down
> >> much wider set of registers, including XMM. How far do we want to get it?
> > 
> > Just do what we immediately need: R10-R15
> > .
> > 
> 
> How much of the register state is revealed to the VMM when we do a TDVMCALL?
> Presumably we should fully sanitize all register state that shows up in
> cleartext on the other end, and we should treat all regs that can be modified
> by the VMM as clobbered.

The guest gets to choose, with a few restrictions.  RSP cannot be exposed to the
host.  RAX, RCX, R10, and R11 are always exposed as they hold mandatory info
about the TDVMCALL (TDCALL fn, GPR mask, GHCI vs. vendor, and TDVMCALL fn).  All
other GPRs are exposed and clobbered if their bit in RCX is set, otherwise they
are saved/restored by the TDX-Module.

I agree with Dave, pass everything required by the GHCI in the main routine, and
sanitize and save/restore all such GPRs.
