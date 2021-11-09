Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B50244B300
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbhKITFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhKITFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:05:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA59EC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:02:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t30so34715720wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 11:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JmtPtX6YQCGEQxR5qcC95yni/wqtMg2Utq250ZHHwv4=;
        b=PMiYwt3pU4LCbvavADvBPZXhBHdxF31DEIWDbU1QpTquKjnQXz7nC+Zn8WGERcV30Q
         gGUqkjCg44xUyBUkAGuqd1Raj34SgBC2EhYTlGWb70CSjsudDK0JWEY0K9LCM4N44M56
         jIIHQrszXNEgOLkM0CLDy8xi45bd4VJMvT0kKdhSlj8AJxP16mBvfZeI6EnPPp9CbOrn
         9Hi2C0DwRWkdTl6AuuFdR9wT2RK49U4jDIkWsBhMs460NCVzVgFhqQ10tLstbvjVn+ja
         ZOTjsQaVxqVXdM3psST6Yv9gqEsnpa2CUDDO/uIZL11eZxih4JXg2XV31VKztuB7xB9A
         OD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JmtPtX6YQCGEQxR5qcC95yni/wqtMg2Utq250ZHHwv4=;
        b=MTKFZcb+Ro+TmmE63uNz/9DfIt/GofRtXOZKwGYC+LHrBgaLodTHSgmOwXkOQXjxPy
         2ny9PVhBq4fxeAGehtG0hvzdfEq4r6cgrV/bDe2JadxF2jrvgMBHutMCYFkZP2QZotZ8
         ML6JJdvQmO1+PmYf8WDN8aoqrL6f0tGRUU37dLd7RoMRL9hmgnLe5XMzP/9A4dE81sWT
         AayNv6BZqkma43mNNUVOL1a2l1+zNIPQV/lbwfvUUU9zSC2XpNghEDWknHLuJgOw9SfC
         YMAt0AU9+xwlrQLG0xXLqnslx96liB3avqj3t5eyBZHBWTEkKiF7ne7HKm2k4XMhz6Qc
         ipOg==
X-Gm-Message-State: AOAM532tUfNuNdLKXhmJ1OnK2aDFscKCAgPJ9Sa3OsHXM1F2cUnFCYf1
        i5jpZlnofO2+934T2c9InoGokQ==
X-Google-Smtp-Source: ABdhPJwfPdTHhxkeQm51gL08gTx3Y5bcDbcmb42YrwujLhE4YiEmO0ApVy5ayZWbDHpKESRcqyB7UQ==
X-Received: by 2002:a05:6000:1141:: with SMTP id d1mr12165854wrx.342.1636484544311;
        Tue, 09 Nov 2021 11:02:24 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:7159:ca65:97f2:ba4c])
        by smtp.gmail.com with ESMTPSA id o10sm12290161wri.15.2021.11.09.11.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 11:02:24 -0800 (PST)
Date:   Tue, 9 Nov 2021 19:02:21 +0000
From:   Quentin Perret <qperret@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v6 2/2] arm64: implement support for static call
 trampolines
Message-ID: <YYrFvXg12eANs0gz@google.com>
References: <20211105145917.2828911-1-ardb@kernel.org>
 <20211105145917.2828911-3-ardb@kernel.org>
 <YYq1/a10XGBthteg@FVFF77S0Q05N>
 <CAMj1kXHrTjxWWX0cfF1Bx58aTR9Fp=xkfhizkWnQRjYtRm879w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHrTjxWWX0cfF1Bx58aTR9Fp=xkfhizkWnQRjYtRm879w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 Nov 2021 at 19:09:21 (+0100), Ard Biesheuvel wrote:
> On Tue, 9 Nov 2021 at 18:55, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Hi Ard,
> >
> > On Fri, Nov 05, 2021 at 03:59:17PM +0100, Ard Biesheuvel wrote:
> > > +static void *strip_cfi_jt(void *addr)
> > > +{
> > > +     if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> > > +             void *p = addr;
> > > +             u32 insn;
> > > +
> > > +             /*
> > > +              * Taking the address of a function produces the address of the
> > > +              * jump table entry when Clang CFI is enabled. Such entries are
> > > +              * ordinary jump instructions, preceded by a BTI C instruction
> > > +              * if BTI is enabled for the kernel.
> > > +              */
> > > +             if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> > > +                     p += 4;
> > > +
> > > +             insn = le32_to_cpup(p);
> > > +             if (aarch64_insn_is_b(insn))
> > > +                     return p + aarch64_get_branch_offset(insn);
> > > +
> > > +             WARN_ON(1);
> > > +     }
> > > +     return addr;
> > > +}
> >
> > I'm somewhat uncomfortable with this, because it seems like the compiler could
> > easily violate our expectations in future, and then we're in for a massive
> > headache. I assume clang doesn't provide any guarnatee as to the format of the
> > jump table entries (and e.g. I can see scope for branch padding breaking this).
> >
> > In trying to sidestep that I ended up with:
> >
> >   https://lore.kernel.org/linux-arm-kernel/20211109172408.49641-1-mark.rutland@arm.com/
> >
> > ... which I think is a good option for PREEMPT_DYNAMIC, but I don't know if
> > there were other places where we believe static calls would be critical for
> > performance rather than a nice-to-have, and whether we truly need static calls
> > on arm64. My mind is leaning towards "avoid if reasonable" at the moment (or at
> > least make that mutually exclusive with CFI so we can avoid that specific fun).
> >
> > I see you had at least one other user in:
> >
> >   https://lore.kernel.org/r/20211109120336.3561463-1-ardb@kernel.org
> >
> > ... what were your thoughts on the criticality of that?
> >
> 
> That particular use case does not rely on static calls being fast at
> all, so there it doesn't really matter which variety we implement. The
> reason I sent it out today is because it gives some test coverage for
> static calls used in a way that the API as designed should support,
> but which turned out to be slightly broken in practice.
> 
> > FWIW other than the above this looks good to me. My major concern here is
> > fragility/maintenance, and secondly whether we're gaining much in practice. So
> > if you think we really need this, I'm not going to stand in the way.
> >
> 
> Android relies heavily on tracepoints for vendor hooks, and given the
> performance impact of CFI on indirect calls, there has been interest
> in enabling static calls to replace them.
> 
> Quentin, anything to add here?

Yes, Android should definitely benefit from static calls.

Modules attaching to tracepoints cause a measurable overhead w/ CFI as
the jump target is a bit harder to verify if it is not in-kernel. But
sadly that's a common pattern for GKI. The current 'workaround' in
Android has been to just plain disable CFI around all tracepoints in the
kernel, which is a bit sad from a security PoV. But there was really no
other option at the time, and we needed the performance back. Static
calls would be a far superior solution as they would avoid much of the
CFI overhead, and are not vulnerable in the CFI sense (that is, the
branch target can't be easily overridden with a random OOB write from a
dodgy driver). So yes, we'd really like to have those please :)

Thanks,
Quentin
