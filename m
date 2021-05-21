Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0ED38CD71
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhEUSbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhEUSbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:31:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79991C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:29:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d78so14648683pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVAGOFSF6YX4fzp5t4usqdETybMxUdDVT7cktnfAI1E=;
        b=eIPGpenNUYifYX2MzGp80iLDc2oVvPM4AkJDVqXaQEi7AhxOTflxEBuGFKP4Lb4OOp
         1G37lVFX/nY4USIfupDhiCBdpEN7mLcidCQD7VaTAUNF4EM1mIFVw4L6s2IJkhs9q/Z2
         KWkUcJd/WR+C1j5T/s//s2bGiM1f4ArX7Cke56o5MwD5j/lwlryx9p7WhNqVY6sPTxMK
         +2ugPcHBygeIj82IF5alXjTswXDYE0Gt05bxU7qAMkiJDOnv3r79x9WAcBTpATCw4bhy
         qT5Bt4Y3RdAOnbTcTPeSY5nHmW7PGVDyHwDFgVcuMkqIN8meF9DPuY92ttBoutskySLP
         u48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVAGOFSF6YX4fzp5t4usqdETybMxUdDVT7cktnfAI1E=;
        b=E5WqRll2Iv6qD8m6Yi1pQMMoCktwqwHddLhv9dFxzXaNutzgUwbmrnq3533ZUFLZRN
         5QuHZZmbVWHc/A0qUfdfiSrCcIPI0AP4EstC7WZrUlDrUCMzjdYvoZXUfrEYv/rV39+W
         kGO3Rxk3Fnhny/ENIze7l+aYGmlR/8VM1zi2kPdN8VETjjq06DZSEzpaKLd+d1Ig/F1e
         BHa0Srzp2CwhDi8yyS71jun935WktewOkIM7z4JQh+BASqnk3//j1k5wmqNgk9bcUdJH
         LI1TBmavOAjInhCQ8T7nYNg3ejk7lVLH1IslCndEAvWrQsPHFIrwxsefqwAnEzKWLF5y
         4NuA==
X-Gm-Message-State: AOAM532hO1xelLoyg5TlIlm+bl4TMbcDmHJ8M8Kab1vo65MKkTImp4Zq
        iSLZdO0s/ZlW6riqJnUSGCjKtyJd+7Ycz5AFSPzcBw==
X-Google-Smtp-Source: ABdhPJxPEsRfQ6FKB4a762tbEjDfInR7vR27LkIDpB2h/IuUK9HNfdPNBZuSfVevzINESEOT1xkCavG5rFa7uB1TvuI=
X-Received: by 2002:a05:6a00:2308:b029:28e:d370:d435 with SMTP id
 h8-20020a056a002308b029028ed370d435mr11538983pfh.31.1621621791961; Fri, 21
 May 2021 11:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <2977129b-c568-8ce5-9a85-31473096719f@linux.intel.com> <20210521143941.2528475-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210521143941.2528475-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 May 2021 11:29:42 -0700
Message-ID: <CAPcyv4gYjkL6kO0ZY+a_ehMz__yyr_VgMwfZOkQranqfuA4n7Q@mail.gmail.com>
Subject: Re: [RFC v2-fix-v2 1/1] x86/boot: Add a trampoline for APs booting in
 64-bit mode
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

On Fri, May 21, 2021 at 7:40 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Add a trampoline for booting APs in 64-bit mode via a software handoff
> with BIOS, and use the new trampoline for the ACPI MP wake protocol used
> by TDX. You can find MADT MP wake protocol details in ACPI specification
> r6.4, sec 5.2.12.19.
>
> Extend the real mode IDT pointer by four bytes to support LIDT in 64-bit
> mode.  For the GDT pointer, create a new entry as the existing storage
> for the pointer occupies the zero entry in the GDT itself.
>
> Reported-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>
> Changes since RFC v2-fix:
>  * Passed rmh as argument to get_trampoline_start_ip().
>  * Added a comment line for get_trampoline_start_ip().
>  * Moved X86_CR0_NE change from pa_trampoline_compat() to patch
>    "x86/boot: Avoid #VE during boot for TDX platforms".
>  * Fixed comments for tr_idt as per Dan's comments.
>  * Moved TRAMPOLINE_32BIT_CODE_SIZE change to "x86/boot: Avoid #VE
>    during boot for TDX platforms" patch.

Thanks, looks good, no more comments from me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
