Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54A2379AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 01:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhEJXfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 19:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhEJXfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 19:35:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF09C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 16:34:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s6so20655052edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GeNwXGJ5GdgXD7Pyup0jLFadLGcua51chfsDuEvshDI=;
        b=C+KPjiSDPWAW6yvrepcK0Z2BK86BN/hHGwt/5Z3hsSCpaENWAnoXi1Rc3ZEl8AKvu3
         MBfQC+lbtPollfuJbX7E9JdQmLYfEi0CkOliVjg2aUuFki4gpvLb+aDfEvEcNG8SAVzp
         MFKa5eE3MUYMhNNfMECK3SRC1gevKFwjx7l2MvgZEycBwbYD7hpmgSi6nMencY7RmZh7
         AUxyGhma3kv9XZS2S8Yfqe/L6HeB4+6xsNucQabsrPUDdB+ooja0RvQfuQ7sdKjBnmZj
         HXdT8cGdWENSnXPSMoyBpXc3Ch3g1fEez/EX2tcK1/SfQMm+aIHP/EQ8Ck0HSs04gNpt
         tucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GeNwXGJ5GdgXD7Pyup0jLFadLGcua51chfsDuEvshDI=;
        b=WMAOZ0g0D8z/tQ7G79NQM5t8CG521Clr8qggJdOIX5LvqCjaTO2TuG8ORPr66rjNsT
         pp7B0nvxLyjDJZO2KqbGGN1A1lxWzAALMSd5kWTUhzpYUXncQvEnf/gGtq6zc6c4Meji
         0jLzHwb+59L9pAA5Un+jcHdksGcy7N3/3nAWxsnBav8jgbvyt9Lo05g++06Udg5uypQi
         H+JOKUKtbiT043HmIRklyG1OmwzfFt8SbiqjQuJNdQX45k6FNz5wFmyZod0TKo6hwLFg
         eKEy5M11CEAKMp3ggDdDTLfcwfUjFr61ehlOBCuk0usDOfHao7+NpUpYX1qrLWJrkrnw
         ZgWA==
X-Gm-Message-State: AOAM533mNwUCI8RZVEu4ZHnNYTpZYaWZHt4AHJktlbsqG1MJzo68yWQn
        n+5jyd9gqFknNyfytKWScYmQSC7dfAASuzxA+wSkcA==
X-Google-Smtp-Source: ABdhPJxePz2dTKDbNLYxu7q6fLJR5XrUXSwy3NCVB0krCarJpCTNgc1hCGiXwii0AtGeSLX7UX5S65dIRl6znCpJo7M=
X-Received: by 2002:a50:f0d6:: with SMTP id a22mr33099218edm.354.1620689685337;
 Mon, 10 May 2021 16:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com> <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com>
In-Reply-To: <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 10 May 2021 16:34:34 -0700
Message-ID: <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 4:08 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 5/10/2021 2:57 PM, Dan Williams wrote:
> >
> > There is a mix of direct-TDVMCALL usage and handling #VE when and why
> > is either approached used?
>
> For the really early code in the decompressor or the main kernel we
> can't use #VE because the IDT needed for handling the exception is not
> set up, and some other infrastructure needed by the handler is missing.
> The early code needs to do port IO to be able to write the early serial
> console. To keep it all common it ended up that all port IO is paravirt.
> Actually for most the main kernel port IO calls we could just use #VE
> and it would result in smaller binaries, but then we would need to
> annotate all early portio with some special name. That's why port IO is
> all TDCALL.

Thanks Andi. Sathya, please include the above in the next posting.

>
> For some others the only thing that really has to be #VE is MMIO because
> we don't want to annotate every MMIO read*/write* with an alternative
> (which would result in incredible binary bloat) For the others they have
> mostly become now direct calls.
>
>
> >
> >> Decompression code uses port IO for earlyprintk. We must use
> >> paravirt calls there too if we want to allow earlyprintk.
> > What is the tradeoff between teaching the decompression code to handle
> > #VE (the implied assumption) vs teaching it to avoid #VE with direct
> > TDVMCALLs (the chosen direction)?
>
> The decompression code only really needs it to output something. But you
> couldn't debug anything until #VE is set up. Also the decompression code
> has a very basic environment that doesn't supply most kernel services,
> and the #VE handler is relatively complicated. It would probably need to
> be duplicated and the instruction decoder be ported to work in this
> environment. It would be all a lot of work, just to make the debug
> output work.
>
> >
> >> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> >> ---
> >>   arch/x86/boot/compressed/Makefile |   1 +
> >>   arch/x86/boot/compressed/tdcall.S |   9 ++
> >>   arch/x86/include/asm/io.h         |   5 +-
> >>   arch/x86/include/asm/tdx.h        |  46 ++++++++-
> >>   arch/x86/kernel/tdcall.S          | 154 ++++++++++++++++++++++++++++++
> > Why is this named "tdcall" when it is implementing tdvmcalls? I must
> > say those names don't really help me understand what they do. Can we
> > have Linux names that don't mandate keeping the spec terminology in my
> > brain's translation cache?
>
> The instruction is called TDCALL. It's always the same instruction
>
> TDVMCALL is the variant when the host processes it (as opposed to the
> TDX module), but it's just a different name space in the call number.
>
>

Ok.

>              \
>
> > Is there a unified Linux name these can be given to stop the
> > proliferation of poor vendor names for similar concepts?
>
> We could use protected_guest()

Looks good.

>
>
> >
> > Does it also not know how to handle #VE to keep it aligned with the
> > runtime code?
>
>
> Not sure I understand the question, but the decompression code supports
> neither alternatives nor #VE. It's a very limited environment.

Yes, that addresses the question.

>
> >
> > Outside the boot decompression code isn't this branch of the "ifdef
> > BOOT_COMPRESSED_MISC_H"  handled by #VE? I also don't see any usage of
> > __{in,out}() in this patch.
>
> I thought it was all alternative after decompression, so the #VE code
> shouldn't be called. We still have it for some reason though.

Right, I'm struggling to understand where these spurious in/out
instructions are coming from that are not replaced by the
alternative's code? Shouldn't those be dropped on the floor and warned
about rather than handled? I.e. shouldn't port-io instruction escapes
that would cause #VE be precluded at build-time?

>
>
> >
> > Perhaps "PAYLOAD_SIZE" since it is used for both input and output?
> >
> > If the ABI does not include the size of the payload then how would
> > code detect if even 80 bytes was violated in the future?
>
>
> The payload in memory is just a Linux concept. At the TDCALL level it's
> only registers.
>

If it's only a Linux concept why does this code need to "prepare for
the future"?


> >
> > 5
> > Surely there's an existing macro for this pattern? Would
> > PUSH_AND_CLEAR_REGS + POP_REGS be suitable? Besides code sharing it
> > would eliminate clearing of %r8.
>
>
> There used to be SAVE_ALL/SAVE_REGS, but they have been all removed in
> some past refactorings.

Not a huge deal, but at a minimum it seems a generic construct that
deserves to be declared centrally rather than tdx-guest-port-io local.
