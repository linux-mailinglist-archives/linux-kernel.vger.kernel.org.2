Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2108430503
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 23:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244658AbhJPVOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 17:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244651AbhJPVOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 17:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634418726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjDNk6B/N6Q1irkDiWN3RyxwNrYWGdj8hgHHx1uvt14=;
        b=BuXiPspPwsAMdcZs2o7EHp8y5M1CGBolb0e+l8k7e3E/MJBgR7wBur5BIf3ddENmynWv0P
        LyagOhsnQuB2aUOvFXGQmLcOj19w37FWKcpSwkmwBTnU7VXrjhPqwJAek18DVX8p7188P1
        X0bWTPglFbDDWUG30Pem6g1b1cNjgtw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-dgT7VyewOyCb-QNUdRBXww-1; Sat, 16 Oct 2021 17:12:05 -0400
X-MC-Unique: dgT7VyewOyCb-QNUdRBXww-1
Received: by mail-qk1-f197.google.com with SMTP id e22-20020a05620a209600b0045f81b8f89cso9281593qka.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 14:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NjDNk6B/N6Q1irkDiWN3RyxwNrYWGdj8hgHHx1uvt14=;
        b=ooZp3wEwgqZibULWRAqdLnxzP/8gkPIN1OCQIOxdzX/YXfGGkxHD6y3PYOfNvp7fa7
         gvTVDOOvb6imOwBb0ScNitlQvhHk0eukn1Dj506qm10qJTescsucLS4MR/QymWzg0P2d
         uol3xXGqx//grkY0LQRK/13m369lMFv1DyNdK84lIxmUImLBEsNvcBH3KnPHZF3iuN8r
         WyjfcOxfhJovctwHWcsIQMQ/Ykb7e6mGS2cj6r76dy4b0POoDLOAGQSCyT+lDxyh0TpF
         PHS/A9bFs15F4GHPQ1Gxvrm2rMD0uWduReB1PbgWYMkk8hHoAjqY8rwke8wOXcffCEH/
         +EZg==
X-Gm-Message-State: AOAM532FOgXCXOh9m6UWZTsaZD+JLx1TG7agnP8TxOXyDrnpU8eWFl7f
        pdMCs8ems28hqInsVhm3R3pW8tNTmpfNBMOee4hICfORGiaVFSDxjJB5smlZYEVOEv9fiBP42Im
        +NwG2FzBDXIRjqi4X8OQMNtCJ
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr22223717qtc.266.1634418724704;
        Sat, 16 Oct 2021 14:12:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVGk5UnzfsoIArgonptC4VlypIIv1AYjcxHn9hf+CT+hjv4CCjkR/qLas5v6PvM1LoiiypmQ==
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr22223703qtc.266.1634418724447;
        Sat, 16 Oct 2021 14:12:04 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id z186sm4435014qke.59.2021.10.16.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 14:12:03 -0700 (PDT)
Date:   Sat, 16 Oct 2021 14:12:00 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
Message-ID: <20211016211200.umf7okyvtet5ayrd@treble>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
 <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
 <8735p25llh.ffs@tglx>
 <87zgra41dh.ffs@tglx>
 <CABCJKuc+mN4vw_sanZQKcb1=SyfT4h3JK2wpBuaB2qZH3Croxg@mail.gmail.com>
 <ecbe49c8-b30b-456c-931a-cc65647b0958@www.fastmail.com>
 <CABCJKucuun-n8w3=U6i43kVGkCgYL7kmz5wx8nYxsxUOCfzBFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKucuun-n8w3=U6i43kVGkCgYL7kmz5wx8nYxsxUOCfzBFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 01:37:02PM -0700, Sami Tolvanen wrote:
> > But we *also* have the read-the-address thing:
> >
> > void something(void)
> > {
> >   /* actual C body */
> > }
> > alternative_call(something, someotherthing, ...);
> >
> > That wants to expand to assembly code that does:
> >
> > CALL [target]
> >
> > where [target] is the actual first instruction of real code and not
> > a CFI prologue.
> 
> Yes, here we would ideally want to avoid the CFI stub for better
> performance, but nothing actually breaks even if we don't.

That's because there's no CFI involved in alternative_call().  It
doesn't use function pointers.  It uses direct calls.

So all the discussion about clear_page_*() is completely irrelevant.  It
has nothing to do with CFI.

Same for copy_user_enhanced_fast_string() and friends.

> > And this all wants to work both for asm-defined functions and
> > C-defined functions.  This really is orthogonal to the
> > is-it-asm-or-is-it-C things.  All four combinations are possible.
> >
> > Does this make any sense?

Not really, I think Sami debunked most of your theories :-)

I think you're misunderstanding how Clang CFI works.  It doesn't
instrument the target function.  It hooks into the caller's function
pointer relocation, so when I try to call func_ptr(), the compiler
hijacks the function pointer and forces me to call into a
func_ptr.cfi_jt() checking function instead.

> > I kind of thing we want the attributes and the builtin, along the lines of:
> >
> > asm("call %m", function_nocfi_address(something));
> >
> > or however else we wire it up.
> >
> > (And, of course, the things that aren't C functions at all, like
> > exception entries, should be opaque.)
> 
> I agree, there are cases where having a function attribute and/or a
> built-in to stop the compiler from interfering would be useful. I'll
> dust off my patch series and see how the LLVM folks feel about it.

With all the talk about function attributes I still haven't heard a
clear and specific case where one is needed.

If you take out the things that don't actually need the
DEFINE_NOT_CALLED_FROM_C() annotation then all you have left is the need
for opaque structs as far as I can tell.

-- 
Josh

