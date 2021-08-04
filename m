Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B883E07A6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhHDScI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbhHDScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:32:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C090C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:31:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b1-20020a17090a8001b029017700de3903so6399899pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iGx5p3aQChPJIQhMdo8aKZl5ghyjuHecEVyYYzUivRs=;
        b=efJHz/Y3Jy4KsSTdpFXfGSDbUVe0hCRitRjueisH/hzjmGrjqCwU8lKL3rRkfrE/uw
         tNoNH8SBVLu9DFDg+E1Un70xYceJiGdy330zneseyoloJ+4oTyNP1Qp6mqL7Rry9RVQb
         Nbb3FuzFGuAZLNhnKecAwyXvjtHVC3x299HyMv6BBPM/EaWfjay2RKUtYk0QJkKtENM7
         unnfC0UjFi7Ilq7dNq6+soEqMD1iTiT0HRqyfULowthD6fM4QD39+QnnM+7x3oOyclPa
         b2j/4O0tLVG7YvGYGH0stmMwBMAbIP2nIa93gR0n5THA4z34+TQCy82LAV0yqJl0oRB4
         W9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGx5p3aQChPJIQhMdo8aKZl5ghyjuHecEVyYYzUivRs=;
        b=ARiSC+Ag3yE6N6SV5C29MxWq2k6X7mVK/JqIobK9w6XEgklMYyACPMXjFZMLPyZWFx
         O4lb6RH9VwgBvE3HsD4yNvwg1fZx9q2UJPwikHXYbCAoGKZDicq0uufZ+nmyOo0EGpmP
         QiFrnkI1G3ppAwBK7/2C6DhcH6HB3EMBFa0aepFnwbzaPDM6mORSfRilhEw8Kxr33Ed4
         hyFEMgXB/tmlcIiRc5TGNg9ZJSKr6/j1EQL/nN2XsdRl7Xq8Oioxe/Ap7dIzieCmvgE9
         6VcBY4Ak1ZLPIavE6x4W+hUR+GusinhDoikNwzWnWHYUoMXi6gwJIhqloTINU8AoZzjT
         7zWQ==
X-Gm-Message-State: AOAM531d8PRIOcqvmBXEG/h13uLa7M6UNcpNSwehfDbetPKNPkrgJ9Qu
        Gz9s+Gv8dDLhzvEkJHoGfF5tlQ==
X-Google-Smtp-Source: ABdhPJxdfXSiCjPsVyrn5C5JYZd0GoZYexQfcsuHjdkgGBQMh4MJT4bR0sBEmIDhOgrVXubsVVxi3Q==
X-Received: by 2002:a65:55c9:: with SMTP id k9mr167609pgs.262.1628101912769;
        Wed, 04 Aug 2021 11:31:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e3sm3750368pfi.189.2021.08.04.11.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 11:31:52 -0700 (PDT)
Date:   Wed, 4 Aug 2021 18:31:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/12] x86/tdx: Don't write CSTAR MSR on Intel
Message-ID: <YQrdFLPaUnC8Q5bn@google.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-12-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-12-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021, Kuppuswamy Sathyanarayanan wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> On Intel CPUs writing the CSTAR MSR is not really needed. Syscalls
> from 32bit work using SYSENTER and 32bit SYSCALL is an illegal opcode.
> But the kernel did write it anyways even though it was ignored by
> the CPU. Inside a TDX guest this actually leads to a #GP. While the #GP
> is caught and recovered from, it prints an ugly message at boot.
> Do not write the CSTAR MSR on Intel CPUs.

Not that it really matters, but...

Is #GP the actual TDX-Module behavior?  If so, isn't that a contradiction with
respect to the TDX-Module architecture?  It says:

  guest TD access violations to MSRs can cause a #GP(0) in most cases where the
  MSR is enumerated as inaccessible by the Intel TDX module via CPUID
  virtualization.  In other cases, guest TD access violations to MSRs can cause
  a #VE.

Given that there is no dedicated CPUID flag for CSTAR and CSTAR obviously exists
on Intel CPUs, I don't see how the TDX-Module can possible enumerate CSTAR as
being inaccessible.

Regardless of #GP versus #VE, "Table 16.2 MSR Virtualization" needs to state the
actual behavior.
