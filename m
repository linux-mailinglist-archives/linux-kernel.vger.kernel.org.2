Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC583FEF27
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345412AbhIBOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:09:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44154 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhIBOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:09:05 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630591685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9583Ir9jxkcwb8jl77epWwndW30GAM92xT+jNhDvW0g=;
        b=vG5Z3zVfKKQFoEGtxxosAoInZuGClTkCkgCLvC5yCjpfHzLAfZ0X9R2M8uNWsVNTv5SCjf
        HcdsizFedPOxFHZLPUf9TOHnwLMPfT/wHuctLCYukjspOb0y9dEfBqy0fGNgn4/NvZ2E9u
        NtNhGT1YsuteA4Lp7zrmjnOQTh5+I/fzxFO0A5Fj7C8jySegXKhVK7oxNqN4xvCZnC/USA
        T7GMOdQ+uj8yqzUj1rDfo0el9ur7OLgN409B78D+9SZUCb0JJNGIqCLAcsBK49UYGiCMSW
        XL7CHTGWXltFKtsqey04AHQ6PoQ+iVxxa/hecj4bme5JtFAHexRS0Jg3mlEoWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630591685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9583Ir9jxkcwb8jl77epWwndW30GAM92xT+jNhDvW0g=;
        b=CxQjJfpTbafmoZVx9Jc0K4nEpZDQgm8G1fsxmaegoY13rN6A2RJZaKKPlVRISz0OAufsCt
        KjaaGpn5GqerhuBg==
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
In-Reply-To: <84fd35193e293894c4e64704e18dc063995b62c0.camel@kernel.org>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de> <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx> <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <87r1e8cxp5.ffs@tglx> <87o89ccmyu.ffs@tglx> <YS+upEmTfpZub3s9@google.com>
 <84fd35193e293894c4e64704e18dc063995b62c0.camel@kernel.org>
Date:   Thu, 02 Sep 2021 16:08:05 +0200
Message-ID: <871r67cbp6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02 2021 at 16:08, Jarkko Sakkinen wrote:
> On Wed, 2021-09-01 at 16:47 +0000, Sean Christopherson wrote:
>> As for SGX consuming the trap number in general, it's correct.  For non-KVM usage,
>> it's nice to have but not strictly necessary.  Any fault except #PF on ENCLS is
>> guaranteed to be a kernel or hardware bug; SGX uses the trap number to WARN on a
>> !#PF exception, e.g. on #GP or #UD.  Not having the trap number would mean losing
>> those sanity checks, which have been useful in the past.
>
> AFAIK, we do not consider #UD as a bug. Agree with the conclusion that SGX
> should never #MC, I just did not get this part. #UD is something that is
> useful for SGX run-time.

I understood that storing the trap number is useful. I was just
questioning the #MC angle. I.e. pretending that the #MC caused by ENCLS
is recoverable.

Thanks,

        tglx
