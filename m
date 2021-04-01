Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93453522DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhDAWmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbhDAWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:42:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB723C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:42:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h25so2499302pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHU/CSlbR0tXIQ7skc+D9M4sQ8Nf+DFxpytkWh85RTc=;
        b=Cdeb4TJryjuUvq0PZ22+p9aZ80XrqpLOQqZBbyxQf2b3KNvemF9hZdYHkWk2rvgvr9
         +SpPIdq+JMo2g9UMPmRHYMNVYDXvm5KREo94cbMizN1C/uol3pIjbIlmE2pjHUirEook
         l3tfPMZVPC0JP0fRuhcSZ92o1n77ukI4HC3SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHU/CSlbR0tXIQ7skc+D9M4sQ8Nf+DFxpytkWh85RTc=;
        b=NWV6Ppxna9T73vwNkgHV6xuPmMKIwmVAUtOfZrnX4Z8LdyOe9JE6Rkx2rqacdFJPyX
         XibarCcSqQPRfowMdlMQkCvbmFXmqWyaATeo8xdw13vgvYfEc7jwXTHdcFYuYmPAlMG4
         mzyoTJw26iBRwsXFpeBjdMS8t2etdzesVx6lrMND9ARBpchaO4Yzzi0MI8eRTjclDU+0
         tKWnJU9WkydNJz51AeJb3HmEGfAF0cTqVVYcU13crmPtUWwqcfck3msdHPkVgJ0rsyp4
         epbLVhKboOrS3b90PvICU1+qxRDXmz1nloXwMJ7Nkoyk9xTi386RkdXXJvwjr+u8F00V
         mfPw==
X-Gm-Message-State: AOAM533YvrT7D2ajonaCmjcRZOmEjsc0q8qMHUariQsg42MzNzvfbi/P
        haEPTf4x16FG3/CuSwHGq6Dduw==
X-Google-Smtp-Source: ABdhPJy5OYaYtgibg+iSJ6TbNgMEMp0Li4wFRje6LCbJMZHyUSADLtOfsJcpWv8pBVkoh3+T2eGIQA==
X-Received: by 2002:a65:56cc:: with SMTP id w12mr9470880pgs.354.1617316931239;
        Thu, 01 Apr 2021 15:42:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7sm6246426pfo.105.2021.04.01.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:42:10 -0700 (PDT)
Date:   Thu, 1 Apr 2021 15:42:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Will Deacon' <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/6] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <202104011447.2E7F543@keescook>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210330205750.428816-4-keescook@chromium.org>
 <20210401083034.GA8554@willie-the-truck>
 <61ae9398a03d4fe7868b68c9026d5998@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ae9398a03d4fe7868b68c9026d5998@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:15:43AM +0000, David Laight wrote:
> From: Will Deacon
> > Sent: 01 April 2021 09:31
> ...
> > > +/*
> > > + * These macros must be used during syscall entry when interrupts and
> > > + * preempt are disabled, and after user registers have been stored to
> > > + * the stack.
> > > + */
> > > +#define add_random_kstack_offset() do {					\
> > > +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> > > +				&randomize_kstack_offset)) {		\
> > > +		u32 offset = __this_cpu_read(kstack_offset);		\
> > > +		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
> > > +		asm volatile("" : "=m"(*ptr) :: "memory");		\
> > 
> > Using the "m" constraint here is dangerous if you don't actually evaluate it
> > inside the asm. For example, if the compiler decides to generate an
> > addressing mode relative to the stack but with writeback (autodecrement), then
> > the stack pointer will be off by 8 bytes. Can you use "o" instead?

I see other examples of empty asm, but it's true, none are using "=m" read
constraints. But, yes, using "o" appears to work happily.

> Is it allowed to use such a mode?
> It would have to know that the "m" was substituted exactly once.
> I think there are quite a few examples with 'strange' uses of memory
> asm arguments.
> 
> However, in this case, isn't it enough to ensure the address is 'saved'?
> So:
> 	asm volatile("" : "=r"(ptr) );
> should be enough.

It isn't, it seems.

Here's a comparison:

https://godbolt.org/z/xYGn9GfGY

So, I'll resend with "o", and with raw_cpu_*().

Thanks!

-- 
Kees Cook
