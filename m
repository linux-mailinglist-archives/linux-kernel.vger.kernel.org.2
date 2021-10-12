Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6914299FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 01:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhJKXv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 19:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJKXv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 19:51:26 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA2C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 16:49:25 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v195so42766543ybb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 16:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIlaK/YKnka5lqAR8o/2WOyRNgNX+LO0oFeQoS0ZKQs=;
        b=Rs+rPN62L6YQ5/LTt4gcCOXUqs4VnXDzS1w4uBHU4F39dwjFs+rOs8nYOWYUkHvt3G
         dcsPnU/eV9AX/AEpLHtmXhIlqVOAykSkcQJqAUbUjSnyilfjgJREHWPawMD7RZ9lAF39
         xrbWrd/hlbgjNR2FV690LBhOLZ/UFfmOCy+ANAYfU9zum6bETX361GP3yEk9LkhENyDf
         LZoxG1PVyuWDTXGamRy2MhjpatCn8j3cJHmV3M81nb36URM+C9ATB8Z2JPOWHxh1c7tb
         DDUQvRVkqs1QEgV4R+kEoXOtKF+JRAXcgFEiwl3kGiwyibqvnU0hlyqCQ1+nBMMFDDlY
         iKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIlaK/YKnka5lqAR8o/2WOyRNgNX+LO0oFeQoS0ZKQs=;
        b=eNwqerd/tgRy+Vn3ZkeXAToqAB9eY5vZQ0fEVKQ42l/mlXx9Bo+br4Np+f3Vetxt6N
         xu2sZEKcvkSscWJ+qn8KhMmgxqn+nAZDs8A4bdKHn6hy4l0p8gToFyTsK4kaltGDu51h
         x7i2jL/O4bRgogS0EFV/9bRAicvH2sdxMHn4Lc1Mg970s5fwSWcWNE6xe56hCNSCOkMB
         i+ciJEpz5iV47MWll7qwzyFk7IZK+22nAzUANnNlznbbA/u4w8XKkFD+5YuvqtINnbSx
         cr1b9oeDmNbBi+rPHvHYLuAfoL1TGtulCHfq9TLoqpCYLnieWxr1o5etd2xhWxMUO9j7
         Kw1A==
X-Gm-Message-State: AOAM532BUCZDcLCtLxZ6b8tk1V3QAN8ysSgM3Sam2I66ObJeL7gTNXxW
        UMDB7A+g3mctko+zPkwoYEGb/0+sbyXlee0Lpu705w==
X-Google-Smtp-Source: ABdhPJwLPj5LJF8f/xGNOoO15pOVjquIOa4aRF6nns8yL4F+/Ye5fNMDOYGO0YR4FRb6BC7BPslAln6Mz5nQoIJQOZc=
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr26177724ybk.403.1633996164765;
 Mon, 11 Oct 2021 16:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211011232446.250195-1-irogers@google.com> <20211011232446.250195-2-irogers@google.com>
 <CAP-5=fX9czHvqwj9DGABe8M59Rck17U9kDMhAgwxHn_L=D04zw@mail.gmail.com>
In-Reply-To: <CAP-5=fX9czHvqwj9DGABe8M59Rck17U9kDMhAgwxHn_L=D04zw@mail.gmail.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 11 Oct 2021 16:49:13 -0700
Message-ID: <CAFP8O3Km7dDR5i=aOiEAH6kM_jXA0uAvo4hZvPgm43UR3MdYYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf clang: Fixes for more recent LLVM/clang
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 4:35 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Oct 11, 2021 at 4:24 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The parameters to two functions and the location of a variable have
> > changed in more recent LLVM/clang releases.
> >
> > Tested with LLVM 6, 8, 9, 10 and 11.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/c++/clang.cpp | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
> > index c8885dfa3667..756200cb80b1 100644
> > --- a/tools/perf/util/c++/clang.cpp
> > +++ b/tools/perf/util/c++/clang.cpp
> > @@ -44,7 +44,6 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
> >                 "-triple", "bpf-pc-linux",
> >                 "-fsyntax-only",
> >                 "-ferror-limit", "19",
> > -               "-fmessage-length", "127",
>
> Sorry, missed from the commit message. I removed this flag to format
> output down to 127 columns as with clang 11 I see in perf test:
>
> 58: builtin clang support                                           :
> 58.1: builtin clang compile C source to IR                          :
> --- start ---
> test child forked, pid 279307
> error: unknown argument: '-fmessage-length'
> 1 error generated.
> test child finished with -1
>
> The flag isn't necessary for correct operation.

Right, I changed the -cc1 option from Separate-form -fmessage-length
to -fmessage-length= in 2020-03.
-ferror-limit can be deleted as well.

> Thanks,
> Ian
>
> >                 "-O2",
> >                 "-nostdsysteminc",
> >                 "-nobuiltininc",
> > @@ -55,7 +54,11 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
> >                 "-x", "c"};
> >
> >         CCArgs.append(CFlags.begin(), CFlags.end());
> > -       CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs);
> > +       CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs
> > +#if CLANG_VERSION_MAJOR >= 11
> > +                                                        ,/*BinaryName=*/nullptr
> > +#endif
> > +                                                        );
> >
> >         FrontendOptions& Opts = CI->getFrontendOpts();
> >         Opts.Inputs.clear();
> > @@ -151,13 +154,16 @@ getBPFObjectFromModule(llvm::Module *Module)
> >
> >         legacy::PassManager PM;
> >         bool NotAdded;
> > -#if CLANG_VERSION_MAJOR < 7
> > -       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
> > -                                                     TargetMachine::CGFT_ObjectFile);
> > +       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream
> > +#if CLANG_VERSION_MAJOR >= 7
> > +                                                      , /*DwoOut=*/nullptr
> > +#endif
> > +#if CLANG_VERSION_MAJOR < 10
> > +                                                      , TargetMachine::CGFT_ObjectFile
> >  #else
> > -       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
> > -                                                     TargetMachine::CGFT_ObjectFile);
> > +                                                      , llvm::CGFT_ObjectFile
> >  #endif
> > +                                                      );
> >         if (NotAdded) {
> >                 llvm::errs() << "TargetMachine can't emit a file of this type\n";
> >                 return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
> > --
> > 2.33.0.882.g93a45727a2-goog
> >

Related, does it make sense to drop CLANG_VERSION_MAJOR<7 support?
