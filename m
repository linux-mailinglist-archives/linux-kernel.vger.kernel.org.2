Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C4429BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhJLDI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhJLDIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:08:25 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D42C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:06:24 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g6so43453354ybb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJ0KAePC541aIFWPu+Qph3nd5pn2jLDyqAKx+t7Tp4o=;
        b=ip3uRvIOdVNMESQOX2/a7CEt9Jag9Yczb/UVEk/hSMBBk2B/TBXKa85Yz3ZATtEuIi
         okqzfUkd+xRuKb9BvEhRCJPrpZewaGE/gmB341grpZnJrOmLpPENegFykPASTaLYeWY5
         Bu3I05v2rVeO2jWbx5IZY9M25R/zmZMXatdsZTauau8mz3u81R6plfqmw6Wue92ee88U
         luUfVrKha5EJ20R7L5zsIjHvzY/UHRSzs4E38SvoGZB5VOTYeHSvCJblDefWjS4fWpg8
         Pa9o0E8MOH1tMiBcHNKOX4WKqTeur/m8AQrjSdJ+CKkwP76LlBs1mY8qDynjTRL2dSSG
         yrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJ0KAePC541aIFWPu+Qph3nd5pn2jLDyqAKx+t7Tp4o=;
        b=lpws7+IfsFU+nzW4k/0JeYMCkcgON9IQ3qV44W6DoyJgTtyN/Ftc+tgvzRfOZZi0Lm
         9Re/ohf0dts/whb0e6AIsBVr5RCh1NuRTs6+/g+ijeUiLTUH+ezV713aoJhe8JEIEKcn
         A//DAU2e/0vVEBw51rmuGdcgR6w98D703nS+x1DcmjD9p+Kt2CwrJGj5l5ycb5qoESpq
         g5vvvXSdbw30uqxv3QrlXTRiaRUOMG7iAl1xbZu8o9wy+yuxIrnzt2iEJ3dkUB4bHCIp
         2FISPBvoq9dGxnrgucJA7Ws0zdkZ5LDJSJasUc/E83KElJFnD+Eqe6JsO6igfa2Z0jxz
         F1sg==
X-Gm-Message-State: AOAM533qRQPSTOdeOJpj6HKHbjDTitdLZ4sYCljY4xW8zcrAy5piWu64
        yxwY+UqzJx+Lnc5NOuqZbgc1/CCxjf6UU7bhnJzWnQ==
X-Google-Smtp-Source: ABdhPJyCvPJnDReSx/9fAMemeVHUYBwuWOlOqJf3tf3/qsJ2Uy15pOKdfPd6dmnQpxo9o47ajP9U4QvYHvhbTXB2QNU=
X-Received: by 2002:a25:3212:: with SMTP id y18mr24979104yby.308.1634007982533;
 Mon, 11 Oct 2021 20:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211012021321.291635-1-irogers@google.com> <20211012021321.291635-2-irogers@google.com>
In-Reply-To: <20211012021321.291635-2-irogers@google.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 11 Oct 2021 20:06:11 -0700
Message-ID: <CAFP8O3KXocfMYhQBoBskg3VN0-xmUUEy2fA_SuzptWa1gAXbnQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf clang: Fixes for more recent LLVM/clang
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

On Mon, Oct 11, 2021 at 7:13 PM Ian Rogers <irogers@google.com> wrote:
>
> The parameters to two functions and the location of a variable have
> changed in more recent LLVM/clang releases.
>
> Remove the unneecessary -fmessage-length and -ferror-limit flags, the
> former causes failures like:
>
> 58: builtin clang support                                           :
> 58.1: builtin clang compile C source to IR                          :
> --- start ---
> test child forked, pid 279307
> error: unknown argument: '-fmessage-length'
> 1 error generated.
> test child finished with -1
>
> Tested with LLVM 6, 8, 9, 10 and 11.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/c++/clang.cpp | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
> index c8885dfa3667..df7b18fb6b6e 100644
> --- a/tools/perf/util/c++/clang.cpp
> +++ b/tools/perf/util/c++/clang.cpp
> @@ -43,8 +43,6 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
>                 "-cc1",
>                 "-triple", "bpf-pc-linux",
>                 "-fsyntax-only",
> -               "-ferror-limit", "19",
> -               "-fmessage-length", "127",
>                 "-O2",
>                 "-nostdsysteminc",
>                 "-nobuiltininc",
> @@ -55,7 +53,11 @@ createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
>                 "-x", "c"};
>
>         CCArgs.append(CFlags.begin(), CFlags.end());
> -       CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs);
> +       CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs
> +#if CLANG_VERSION_MAJOR >= 11
> +                                                        ,/*BinaryName=*/nullptr
> +#endif
> +                                                        );
>
>         FrontendOptions& Opts = CI->getFrontendOpts();
>         Opts.Inputs.clear();
> @@ -151,13 +153,16 @@ getBPFObjectFromModule(llvm::Module *Module)
>
>         legacy::PassManager PM;
>         bool NotAdded;
> -#if CLANG_VERSION_MAJOR < 7
> -       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
> -                                                     TargetMachine::CGFT_ObjectFile);
> +       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream
> +#if CLANG_VERSION_MAJOR >= 7
> +                                                      , /*DwoOut=*/nullptr
> +#endif
> +#if CLANG_VERSION_MAJOR < 10
> +                                                      , TargetMachine::CGFT_ObjectFile
>  #else
> -       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
> -                                                     TargetMachine::CGFT_ObjectFile);
> +                                                      , llvm::CGFT_ObjectFile
>  #endif
> +                                                      );
>         if (NotAdded) {
>                 llvm::errs() << "TargetMachine can't emit a file of this type\n";
>                 return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
> --
> 2.33.0.882.g93a45727a2-goog
>

Thanks for the change:)

Reviewed-by: Fangrui Song <maskray@google.com>
