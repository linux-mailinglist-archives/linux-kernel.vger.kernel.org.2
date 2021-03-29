Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386ED34D780
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhC2Sl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhC2SlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:41:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC736C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:41:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j25so10456629pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aYL/dbQ14QTXXMSkWSQ/z+qzj6yL6Ve3lzeO159+/Vc=;
        b=ILRNFBaUrvYS27aWFLaYXO8LPj6pKTA2SBD59ksr9Fpfa7kG44gHIoQIIeiA0uW0DT
         INDEJxHCxLo9mNI1mXPwmIRMdAheSsDUl9E7dL0goqI8aLORifPfviS8NWFxCGPsRDpU
         h2HExNb2DqeqeKKnXrybXZvXygAADq2smXaJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aYL/dbQ14QTXXMSkWSQ/z+qzj6yL6Ve3lzeO159+/Vc=;
        b=al22hv0KCA0NX4/byGJzQi5PDtzBSJk1Mwg8fN3thoOM5+kZNkhq388V+aypEQaFbu
         CusPchPv5DBCnDcAFYpaFpbUBmZl9150ToVb9zKhf+TbJ/TFZkff1+F0Z3hzS3rm/aGq
         Fhp3CkOZJqPOWN5amlxwq3Hnt4UhzeGHex+irYAsftpe1s0NWhr9SMcDVWr9ZdoNJDrE
         qIJZhr/ZW6hSSNnIfM43XOvW4K/uFOwmKXCG95fl46tCrD1mEBfOaTAjcEeXL9Bb9BHn
         HORiafagMXihFFXUPXhKnFUasqjxRPZ6wYW4aXKa0V9V39HF9mWFm+IMUinNV/DPQE+G
         Mokw==
X-Gm-Message-State: AOAM533VPZkJNL1CJUs0I1/hysSq9v++QqP3WqvJcNJvZyh+hef3WKLj
        PXhs9Lvd2gvSCIPp9VhaV9LlZQ==
X-Google-Smtp-Source: ABdhPJxjjtBRwQY4aFK1R1QLvwpTRJ9D0T4m5/43mE5p+szS6JXZVD5wBPAm/iQ4MzX4uEt8W4cEIA==
X-Received: by 2002:aa7:8a19:0:b029:1f6:6839:7211 with SMTP id m25-20020aa78a190000b02901f668397211mr25877536pfa.40.1617043281318;
        Mon, 29 Mar 2021 11:41:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mm12sm196929pjb.49.2021.03.29.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 11:41:20 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:41:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <202103291139.54AA7CDE@keescook>
References: <20210319212835.3928492-1-keescook@chromium.org>
 <20210319212835.3928492-4-keescook@chromium.org>
 <87eefzcpc4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eefzcpc4.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 04:42:03PM +0200, Thomas Gleixner wrote:
> On Fri, Mar 19 2021 at 14:28, Kees Cook wrote:
> > +/*
> > + * Do not use this anywhere else in the kernel. This is used here because
> > + * it provides an arch-agnostic way to grow the stack with correct
> > + * alignment. Also, since this use is being explicitly masked to a max of
> > + * 10 bits, stack-clash style attacks are unlikely. For more details see
> > + * "VLAs" in Documentation/process/deprecated.rst
> 
> VLAs are bad, VLAs to the rescue! :)

I'm aware of the irony, but luto's idea really makes things easy. As
documented there, though, this has a hard-coded (low) upper bound, so
it's not like "regular" VLA use.

> 
> > + * The asm statement is designed to convince the compiler to keep the
> > + * allocation around even after "ptr" goes out of scope.
> > + */
> > +void *__builtin_alloca(size_t size);
> > +
> > +#define add_random_kstack_offset() do {					\
> > +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> > +				&randomize_kstack_offset)) {		\
> > +		u32 offset = this_cpu_read(kstack_offset);              \
> 
> Not that it matters on x86, but as this has to be called in the
> interrupt disabled region of the syscall entry, shouldn't this be a
> raw_cpu_read(). The asm-generic version has a preempt_disable/enable
> pair around the raw read for native wordsize reads, otherwise a
> irqsave/restore pair.
> 
> __this_cpu_read() is fine as well, but that has an sanity check before
> the raw read when CONFIG_DEBUG_PREEMPT is on, which is harmless but
> also pointless in this case.
> 
> Probably the same for the counterpart this_cpu_write().

Oh! Excellent point. I think this will make a big difference on arm64. I
will adjust and test.

-- 
Kees Cook
