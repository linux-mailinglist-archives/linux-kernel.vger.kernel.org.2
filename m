Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D93259F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhBYW4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhBYWzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:55:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F680C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tObK55uNqHsYeXJtMoccy//WcmAriOphb7i7YiyWzvA=; b=ROIlJN7avWCCBR42qDUUKfJD0m
        krQIfFtOqD7pbp75CL3qqygzrr3Pk6ZcXY3c7DseP/CVhdN6rAhfZ68puArFueGHzSSH2l4JUFMBt
        nN0SXMBnFUdl+zFsDBQ+lWD0e7698IlRQb/DxhZOtcPfYguXlUS//vVeVwf0pvMtBMfz2OKZH40Bj
        Y4D+nDhd4GZmYT499gTYfrO/Z9mSTxZtst48Gyq+hQw7rqvY9yMmnLZ1JXWoDSaiLCgrnLSszlsnK
        MFWhXg8nP+husA5b1B8Evh5QprPrnuo/2u3REwoEwOGe+PdPCFnkj27hKai2gEcN3yGQm8xyWePME
        WI9k22+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lFPWc-00BH62-KV; Thu, 25 Feb 2021 22:54:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE4579864D3; Thu, 25 Feb 2021 23:54:25 +0100 (CET)
Date:   Thu, 25 Feb 2021 23:54:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Arthur Eubanks <aeubanks@google.com>,
        Chandler Carruth <chandlerc@google.com>
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
Message-ID: <20210225225425.GH4746@worktop.programming.kicks-ass.net>
References: <20210225112247.2240389-1-arnd@kernel.org>
 <20210225114533.GA380@zn.tnic>
 <CAK8P3a0BN3p0F3UAxs9TKsHs--AiAPE0uf6126GVJNhmVTGCsw@mail.gmail.com>
 <20210225124218.GC380@zn.tnic>
 <CAK8P3a1ZiUHRxKr=SFgEFETLcSQeViPnR+XB2gBvbVk24vGvqQ@mail.gmail.com>
 <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=B=cHpp_XfPTtyVpQyrwQrFZX9SXKw=SJC1VC-VbEwFA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:31:33PM -0800, Nick Desaulniers wrote:

> Q: But I put the `inline` keyword on the callee?
> A: Probably deserves its own post, but the `inline` keyword doesn't
> mean what any rational initial impression would suppose. Language in
> the standard refers to "inline substitution" and grants a lot of
> leeway to implementations in terms of whether it's performed at all.

That's just weasle wording to do the wrong thing :/ GCC (and other
compilers) have been saying inline is a valid substitute for macros. You
then reading the spec and saying we can do this ass backwards and
screw everybody who's been expecting things to top-down is just not
acceptible.

The C spec is notoriously bad, because it fails to actually specify and
then we get shit like this :-( And if you then take that 'freedom' and
implement behaviour that 'doesn't mean what any rational initial
impression would suppose', then you're just being a twat.

Life is hard enough without compilers trying to screw you over on
purpose :/

> There are cases where even with "always_inline" fn attr is applied,
> and the compiler says "that's nice, but I still cannot perform inline
> substitution here, I'm sorry."

That's a hard fail from where I'm sitting. Can we please get a compiler
error when that happens? That is, we're relying on this for correctness,
if the compiler then goes and ignores it, we've got *serious* problems.

This really MUST NOT happen.

And I'm not joking, I can get you a non-booting kernel by removing just
a few __always_inline in the right place.

> There are no silver bullets here.  It's semantics have
> changed since its introduction,

That isn't our doing, if the compiler redefines its keywords, don't tell
us our program is broken. You're the ones that have been changing the
meaning of thigs.

> and I have seen rare uses that make my skin crawl.

Do tell...
