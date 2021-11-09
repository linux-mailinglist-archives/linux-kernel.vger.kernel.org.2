Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4729644B27C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241768AbhKISMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:12:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhKISMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:12:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 165BE61078
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636481374;
        bh=fwZ+9DFgYhOz9JloIi5von5LP751Xa06A2vPFeZb8wg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SV/ItxRMN137UwwPpg1gNqwsHTr7p244S4sVhP5T7eNi+5Jg5jAB8odNUmWOocLm2
         8ryr0JSFKK20+8V/INhpiVSgWadoEocdc3em9eAfCXSQmxWyRfPSDju7HvbBnrxAED
         H3ba2eqloWpa8VKEHvmSuBekYesww7RnKa+dQftWvud+xdeD5uFN+FDbFAjS9J1Sc7
         CG6DwVQP3qtK5E2hW0wi6V1/08IUmzJXLgZZgBqSE0XseOpo8IyuPYlCUd7jTJ4SSn
         6AQP/edyXVPb8gzNFjXW/6nd1oZPvlYi9OE2g5LpmlhoBPRKn6SqEeNAkX5MxB3EEC
         C6eUJ7ceUSZFw==
Received: by mail-oi1-f174.google.com with SMTP id bk14so171550oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 10:09:34 -0800 (PST)
X-Gm-Message-State: AOAM532YDYSnVowN21StLXpPP7dqGfqyd7Gt0Gezw73Q0EbIpgq6PVT+
        yaAY4J/OXKlvf9rWH1R3b/h6mfnen1zGafWRuT4=
X-Google-Smtp-Source: ABdhPJwiYMdDHWuST6V7K8sfBXooK1EZjl8/fpTO5Alzh3cNI4GxNwjPYm53Z6HteXsgGe6yeK5wcy4Vx3Nq65CUud4=
X-Received: by 2002:aca:ad95:: with SMTP id w143mr6434770oie.47.1636481373229;
 Tue, 09 Nov 2021 10:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20211105145917.2828911-1-ardb@kernel.org> <20211105145917.2828911-3-ardb@kernel.org>
 <YYq1/a10XGBthteg@FVFF77S0Q05N>
In-Reply-To: <YYq1/a10XGBthteg@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 9 Nov 2021 19:09:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHrTjxWWX0cfF1Bx58aTR9Fp=xkfhizkWnQRjYtRm879w@mail.gmail.com>
Message-ID: <CAMj1kXHrTjxWWX0cfF1Bx58aTR9Fp=xkfhizkWnQRjYtRm879w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] arm64: implement support for static call trampolines
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2021 at 18:55, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Ard,
>
> On Fri, Nov 05, 2021 at 03:59:17PM +0100, Ard Biesheuvel wrote:
> > +static void *strip_cfi_jt(void *addr)
> > +{
> > +     if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> > +             void *p = addr;
> > +             u32 insn;
> > +
> > +             /*
> > +              * Taking the address of a function produces the address of the
> > +              * jump table entry when Clang CFI is enabled. Such entries are
> > +              * ordinary jump instructions, preceded by a BTI C instruction
> > +              * if BTI is enabled for the kernel.
> > +              */
> > +             if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> > +                     p += 4;
> > +
> > +             insn = le32_to_cpup(p);
> > +             if (aarch64_insn_is_b(insn))
> > +                     return p + aarch64_get_branch_offset(insn);
> > +
> > +             WARN_ON(1);
> > +     }
> > +     return addr;
> > +}
>
> I'm somewhat uncomfortable with this, because it seems like the compiler could
> easily violate our expectations in future, and then we're in for a massive
> headache. I assume clang doesn't provide any guarnatee as to the format of the
> jump table entries (and e.g. I can see scope for branch padding breaking this).
>
> In trying to sidestep that I ended up with:
>
>   https://lore.kernel.org/linux-arm-kernel/20211109172408.49641-1-mark.rutland@arm.com/
>
> ... which I think is a good option for PREEMPT_DYNAMIC, but I don't know if
> there were other places where we believe static calls would be critical for
> performance rather than a nice-to-have, and whether we truly need static calls
> on arm64. My mind is leaning towards "avoid if reasonable" at the moment (or at
> least make that mutually exclusive with CFI so we can avoid that specific fun).
>
> I see you had at least one other user in:
>
>   https://lore.kernel.org/r/20211109120336.3561463-1-ardb@kernel.org
>
> ... what were your thoughts on the criticality of that?
>

That particular use case does not rely on static calls being fast at
all, so there it doesn't really matter which variety we implement. The
reason I sent it out today is because it gives some test coverage for
static calls used in a way that the API as designed should support,
but which turned out to be slightly broken in practice.

> FWIW other than the above this looks good to me. My major concern here is
> fragility/maintenance, and secondly whether we're gaining much in practice. So
> if you think we really need this, I'm not going to stand in the way.
>

Android relies heavily on tracepoints for vendor hooks, and given the
performance impact of CFI on indirect calls, there has been interest
in enabling static calls to replace them.

Quentin, anything to add here?
