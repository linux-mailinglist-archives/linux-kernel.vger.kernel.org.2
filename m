Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DE1370458
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 02:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEAAVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 20:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhEAAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:21:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE672C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:20:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b23so30129110lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zabmtldstojRTyrvpu95m7nCjwuyjWVTvStP8C2VfyM=;
        b=jr0S0e1w7axDLPwaJw2Ket382b0kL6+bXfTPFA0r4MLHSMWtvt79KtHMJ2Xlnr4xKF
         cqSbfTFc/CG7Wi9G6RaWJKXOIv72kCf6DVXrInYso6unss7x/E2DSbKopoAYpfJ1iFvs
         4RMivEQ1aNGb51KOTY247R9OwhZavfXCCXDcE2UEs02zu4SgHih6sPatb4WBusTEWGS5
         R3yhcgzwCfPeAa9NmpC9ZBz1w040d8v2T0uIXH+45vXC6Jad51N+GMcCrRdclpGJO+qQ
         nXU3PPWhhO2dcHizkC6NM8eam5+si2Y0lMqbHU29i3CM/iTu5X3r2eQVrINqjMKf3u0R
         Z8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zabmtldstojRTyrvpu95m7nCjwuyjWVTvStP8C2VfyM=;
        b=aFYyOBQyFtOExQeloCVWoIk1i86URwVUKqBwJL+9bP1cQdQyPHCcuSDkaSMYZuzYfi
         RGUeBEpJLjpNB1ZugtjHnwSSFjivqWTroHGEyKmKVGSNiLcMBas4wjdnGQlKo4LQfu9P
         WoLvFxzfV8I9HDYCh2XXzfkKyZwe7+LbxLAz6dVgnSmHVNAVdGgI0cOHdzQdlji8+voZ
         UtunPGsMXsPexRJPScjUHJi2fnJ8q72jx91aBmko1L0nOuhbBU0q+O+PMKomRAA2YT0f
         vR369NomjEmtkSFTBc8ZzlhRCSootCQlo2oJW8+q9R1Zh/9LWqJxONsvjOeIlyo8BJwE
         BPeA==
X-Gm-Message-State: AOAM530sUAhISwdYRcNvAB/F+9/AS7hUwTaHdPfGbbYAJyTeboN3qsQn
        CX96Tb5kSD6DOnCiY1lwpIrDVhy66P3+Cvcngj+TFA==
X-Google-Smtp-Source: ABdhPJzWxMQx10OVX9N9luzIKAOmdlwzRNSF4yHWhIbsyUIJRJIhvmJ9WCqWnEj++/v814MUADbcYlOsQwL7i0nWTTU=
X-Received: by 2002:a05:6512:94d:: with SMTP id u13mr4783892lft.368.1619828409137;
 Fri, 30 Apr 2021 17:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com> <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
In-Reply-To: <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Apr 2021 17:19:57 -0700
Message-ID: <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 7:22 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Apr 29, 2021 at 5:19 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Thu, Apr 29, 2021 at 2:53 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > I haven't looked into why this is so slow with clang, but it really is
> > > painfully slow:
> > >
> > >    time make CC=clang allmodconfig
> > >    real 0m2.667s
> > >
> > > vs the gcc case:
> > >
> > >     time make CC=gcc allmodconfig
> > >     real 0m0.903s
> >
> > Can
> > you provide info about your clang build such as the version string,
> > and whether this was built locally perhaps?
>
> d'oh it was below.
>
> > > This is on my F34 machine:
> > >
> > >      clang version 12.0.0 (Fedora 12.0.0-0.3.rc1.fc34)

A quick:
$ perf record -e cycles:pp --call-graph lbr make LLVM=1 LLVM_IAS=1
-j72 allmodconfig
$ perf report --no-children --sort=dso,symbol
shows:
     2.35%  [unknown]                [k] 0xffffffffabc00fc7
+    2.29%  libc-2.31.so             [.] _int_malloc
     1.24%  libc-2.31.so             [.] _int_free
+    1.23%  ld-2.31.so               [.] do_lookup_x
+    1.14%  libc-2.31.so             [.] __strlen_avx2
+    1.06%  libc-2.31.so             [.] malloc
+    1.03%  clang-13                 [.] llvm::StringMapImpl::LookupBucketFor
     1.01%  libc-2.31.so             [.] __memmove_avx_unaligned_erms
+    0.76%  conf                     [.] yylex
+    0.68%  clang-13                 [.] llvm::Instruction::getNumSuccessors
+    0.63%  libbfd-2.35.2-system.so  [.] bfd_hash_lookup
+    0.63%  clang-13                 [.] llvm::PMDataManager::findAnalysisPass
+    0.63%  ld-2.31.so               [.] _dl_lookup_symbol_x
     0.62%  libc-2.31.so             [.] __memcmp_avx2_movbe
     0.60%  libc-2.31.so             [.] __strcmp_avx2
+    0.56%  clang-13                 [.] llvm::ValueHandleBase::AddToUseList
+    0.56%  clang-13                 [.]
llvm::operator==<llvm::DenseMap<llvm::BasicBlock const*, unsigned int,
llvm::DenseMapInfo<llvm::BasicBlock const*>, llvm::detail::Dense
     0.53%  clang-13                 [.]
llvm::SmallPtrSetImplBase::insert_imp_big

(yes, I know about kptr_restrict)(sorry if there's a better way to
share such perf data; don't you need to share perf.data and the same
binary, IIRC?)

The string map lookups look expected; the compiler flags are one very
large string map; though we've identified previously perhaps hashing
could be sped up.

llvm::Instruction::getNumSuccessors looks unexpectedly like codegen,
but this was a trace of `allmodconfig`; I wouldn't be surprised if
this is LLVM=1 setting HOSTCC=clang; might be good to try to isolate
those out.

Some other questions that came to mind thinking about this overnight:
- is Kbuild/make doing more work than is necessary when building with
clang (beyond perhaps a few more cc-option checks)? I don't think perf
is the right tool for profiling GNU make. V=1 to make hides a lot of
the work macros like cc-option are doing.
- is clang doing more work than necessary for just checking support of
command line flags? Probably. I'm not sure that has been optimized
before, but if we pursue that but the slowdown was more so the
previous point, that would potentially be a waste of time.
-- 
Thanks,
~Nick Desaulniers
