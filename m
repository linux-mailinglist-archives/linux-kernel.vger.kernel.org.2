Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD81F423FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhJFN4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238716AbhJFN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633528464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SUoxOb//3TH/xMoqrFKXCtQoVmxHUsUFva7/RQKSUug=;
        b=B6Bsuxl3YXUMNb0sb0wyYaD2CfTsF/7Z/bxzvhHsO23ANp+Q6DbSRg0eEWjM4JH07HnPkw
        jzE09IISn0TxSPnorCDiYSGyFg+5XLkO9y+mlWPjbI2Vo3541D/hd1nfYFkLPPR+imYM1D
        fEwY+NeaXhGajsgZtfgx2bRVeb88PcQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-ZDufvsvqPs-X8sOA5bKdgQ-1; Wed, 06 Oct 2021 09:54:22 -0400
X-MC-Unique: ZDufvsvqPs-X8sOA5bKdgQ-1
Received: by mail-oo1-f69.google.com with SMTP id p82-20020a4a2f55000000b002b584670618so1786365oop.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 06:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUoxOb//3TH/xMoqrFKXCtQoVmxHUsUFva7/RQKSUug=;
        b=nn1eKTe3BdXRtuP0ABe/XF2VJbgTVrfHNlZ9pgUmt56185vbBHxVGTJWxrm4Idb6K9
         TCDPBTaTtlI/Qcr5obKuXpDQGZJuwNkyCZRRNcCn27ealdJ+9Ix1MgBwpOITz3Hxf23Z
         /ikimVQS1zXaSDMAzhd9qmSNW0ORqeITITDI5qMgt73EkOZ8bweJCimyLcP3k/ht32k+
         mi0A3JAvmBCrok3z8qG2rpHNBvVjF3lq8hlXrntxmgMYuUy5SROCZW/WY1ba/pjC+A1/
         oMneqDv62uQlr0jgYsIRogoy7CgCzMuS7JJ2ylw1sgp9U7eYwpdCORcw+5gubHhKOCJF
         OYyg==
X-Gm-Message-State: AOAM530EaEMzYlkLB6cvpbmvPa2Ou2bxZ/v3xn1clq12h36D9MJ1hsZH
        4hmdacK3HXfe+POSRpUiQBTX2b33Z3eIWgt7nhkW23CKycDULmESL1JydLg8viC4cpdcA1mPSu3
        RIu+xH6rU+eDdFMe+gB4yqQhI
X-Received: by 2002:a54:4f0e:: with SMTP id e14mr7500173oiy.73.1633528461112;
        Wed, 06 Oct 2021 06:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDO4di3VOt+xJP1xAbbGCbGjPY6Am+ulVkpZnWgsgHk16Sl/FM4xHh8vjh8enqfYZsYV6nfQ==
X-Received: by 2002:a54:4f0e:: with SMTP id e14mr7500157oiy.73.1633528460868;
        Wed, 06 Oct 2021 06:54:20 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id l8sm3980645oii.57.2021.10.06.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:54:20 -0700 (PDT)
Date:   Wed, 6 Oct 2021 06:54:17 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 06/15] ftrace: Use an opaque type for functions not
 callable from C
Message-ID: <20211006135417.tvdns3ykpgupi47q@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-7-samitolvanen@google.com>
 <20211006032945.axlqh3vehgar6adr@treble>
 <20211006090249.248c65b0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211006090249.248c65b0@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 09:02:49AM -0400, Steven Rostedt wrote:
> On Tue, 5 Oct 2021 20:29:45 -0700
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> Thanks for Cc'ing me, as I should have been Cc'd on the original patch.
> 
> > On Thu, Sep 30, 2021 at 11:05:22AM -0700, Sami Tolvanen wrote:
> > > With CONFIG_CFI_CLANG, the compiler changes function references to point
> > > to the CFI jump table. As ftrace_call, ftrace_regs_call, and mcount_call
> > > are not called from C, use DECLARE_ASM_FUNC_SYMBOL to declare them.
> 
> "not called from C" is a bit confusing.
> 
> > > 
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > ---
> > >  include/linux/ftrace.h | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index 832e65f06754..67de28464aeb 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -578,9 +578,10 @@ extern void ftrace_replace_code(int enable);
> > >  extern int ftrace_update_ftrace_func(ftrace_func_t func);
> > >  extern void ftrace_caller(void);
> > >  extern void ftrace_regs_caller(void);
> > > -extern void ftrace_call(void);
> > > -extern void ftrace_regs_call(void);
> > > -extern void mcount_call(void);
> > > +
> > > +DECLARE_ASM_FUNC_SYMBOL(ftrace_call);
> > > +DECLARE_ASM_FUNC_SYMBOL(ftrace_regs_call);
> > > +DECLARE_ASM_FUNC_SYMBOL(mcount_call);  
> > 
> > I'm thinking DECLARE_ASM_FUNC_SYMBOL needs a better name. It's not clear
> > from reading it why some asm symbols need the macro and others don't.
> > 
> > I guess it means "an asm text symbol which isn't callable from C code
> > (not including alternatives)"?
> > 
> > DECLARE_UNCALLED_SYMBOL() maybe?
> > 
> 
> That's even worse ;-) Because "called" is an assembler command in x86, and
> it is "called" from assembly (when you look at an objdump, it is most
> definitely "called").
> 
> Perhaps DECLARE_ASM_INTERNAL_SYMBOL() ?
> 
> Or call it "DECLARE_ASM_MCOUNT_SYMBOL()" as "mcount" is the original name
> of what a compiler does when passed the -pg option, and that's exactly what
> those functions are.

But this macro is used in other places as well:

  https://lkml.kernel.org/r/20210930180531.1190642-10-samitolvanen@google.com

And many of them aren't internal to a function like the above symbols,
they're actual functions that are called in other ways.

DECLARE_UNCALLED_FROM_C() ?

-- 
Josh

