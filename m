Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28893362B10
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhDPW2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhDPW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:28:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F1EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:28:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so17149658pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vx07AciKHM2KmcmsePok7O1V53X9SAytSNn10SMyMJk=;
        b=l57DSci8MV+qNfiHzwsyPIfmK94N1iGdmn7rFxhcTCHFfWJepKZeC5MyTm74+sYQUp
         bd8NBpssO4NaB3CvhmzvlVHemG3yTxFdQxDjFJttrtsiswwdoKFiMj/u2FmZRFp0wQer
         KbwBnnj+EQik/vtjEjsUfxUGXh/q9lee701dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vx07AciKHM2KmcmsePok7O1V53X9SAytSNn10SMyMJk=;
        b=ZYdn50yLyKXiiQBJwZcsAIS3CiDMnmS7+tZ1gi1I8AtbX/SuD7ScU7CqyiXxH+uETJ
         zVPpyKSjOyR0e5btHEfADZjyMq4mDSvPeTPtPrbM9NtSJQ9TgR2/9IncmSNaYuJksNyT
         dJxQjgFaIeqZQlJr5qsBRT+olrEddPECYmp6QmfphDph7dUgvLIvF6D77OACDIGe/dkb
         MccxOv37821/7EmLljU9tPARq+LrUTDI4cP2tzBcPZisF/fNl6ioZJT2s3EWMdoNC917
         igm1K7wqtQjUGAONKHqEh9G2TiBQK6uRBRIbtOErPBTBLYEm6WuutuQWu+a18c1N0w69
         yeTQ==
X-Gm-Message-State: AOAM531joENxfpOY6wvujus2+U+8K34JnEi/PGijGgrwXo6muUbnNNxF
        aDa+WgUWVbMJLQqrl6Tq3Gj/ww==
X-Google-Smtp-Source: ABdhPJz51MxDNCIklE4hX5vuxVgkliAtJTxlvk2sD4P3kNceF/lTiaWxEGcqhqfQ5kbeJgyEbOfzUg==
X-Received: by 2002:a17:902:8604:b029:e6:60ad:6921 with SMTP id f4-20020a1709028604b02900e660ad6921mr11836011plo.15.1618612097925;
        Fri, 16 Apr 2021 15:28:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x17sm1763643pjr.0.2021.04.16.15.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:28:17 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:28:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
Message-ID: <202104161519.1D37B6D26@keescook>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-6-samitolvanen@google.com>
 <20210416211855.GD22348@zn.tnic>
 <CABCJKud8TvzhcjHCpsrtCJ4B50ZUfaL48F42EhZ2zWKLteAc0Q@mail.gmail.com>
 <20210416220251.GE22348@zn.tnic>
 <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVTtKqD6fonUmT_qr0HJ0X9TWzLGq-wpm+A7XKyjn3W5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:06:17PM -0700, Andy Lutomirski wrote:
> On Fri, Apr 16, 2021 at 3:03 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Apr 16, 2021 at 02:49:23PM -0700, Sami Tolvanen wrote:
> > > __nocfi only disables CFI checking in a function, the compiler still
> > > changes function addresses to point to the CFI jump table, which is
> > > why we need function_nocfi().
> >
> > So call it __func_addr() or get_function_addr() or so, so that at least
> > it is clear what this does.
> >
> 
> This seems backwards to me.  If I do:
> 
> extern void foo(some signature);
> 
> then I would, perhaps naively, expect foo to be the actual symbol that
> gets called

Yes.

> and for the ABI to be changed to do the CFI checks.

Uh, no? There's no ABI change -- indirect calls are changed to do the
checking.

> The
> foo symbol would point to whatever magic is needed.

No, the symbol points to the jump table entry. Direct calls get minimal
overhead and indirect calls can add the "is this function in the right
table" checking.

> I assume I'm
> missing something.

Further symbol vs address stuff is discussed here:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/cfi&id=ff301ceb5299551c3650d0e07ba879b766da4cc0

But note that this shouldn't turn into a discussion of "maybe Clang could
do CFI differently"; this is what Clang has.

https://clang.llvm.org/docs/ControlFlowIntegrity.html

-- 
Kees Cook
