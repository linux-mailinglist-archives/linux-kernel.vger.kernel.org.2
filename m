Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65737045A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 02:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhEAAYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 20:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhEAAYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:24:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB15C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:23:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z13so31688444lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 17:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVLNT3W+pl6I0XltrmL8EoY5HYXwqNz1G5YBmw1lrjM=;
        b=QnbdpOIiL+Wx63dWMjs3T0xwgF9xUMknZpk83NWFCvFAuAB4WjdLQYrShh45R4I7Cl
         W3fUFPnbmEklfWLTzAYqQROGnxgkDC3QcVJwWIUxRr57Ef1EzEmMw+R1G+4YVVtiQ2iy
         jhAoXmiWFXm7aGv8r0uVzISEtF5DjR9BPSOa1bFDRtbU3TkDWexPoeYKdkLTbu9FpgNQ
         yRalgj3JafNuYOLIU4ZJWIquMHerDJmy4Yz9Pj5/omjHExP2Zz/XHrYJ8wVoQ9bekKpV
         p9Mfq7ty0bNfTkqqNNRMiFDSskaYkUbzD0ysSKcJNSFUoKDuP8asBuf/SwZFlfiNz3Qm
         IK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVLNT3W+pl6I0XltrmL8EoY5HYXwqNz1G5YBmw1lrjM=;
        b=oqDItf/FNJ/3sJ11WpEEKgiCKZToQHznvACSdGZ5wXi03ITPsSupR2lZfAJREUgQ+G
         71j5ZS6A4Rhg0SDU/lmfUTHa9Wb+7HdxDpL88t8swQ7P0XPeVIbcXY4tJuOWYuF+jVSy
         OyKMzJUzQx1+O/0kNxm3Gd6vOBjOPK92Tz7Jml12zol8n2+UHsPtGRhlEEZO0IiLFsAh
         9xLmtR+e27p2hdWWipBA49Ch9Ch8Z8XL5LTcNWvO2oa8WuMOQtqLjBeRnKG8n01De3n5
         B3yEcT5L7dr7EDjCKEWBzZyNX28XmOxLBPjr3asYe4fQBH3lSKLnXv73lNtOxHMmwq2o
         Wluw==
X-Gm-Message-State: AOAM532iSqZCz19UU70M1p5lUWzwUhLGXTYmTZmufaIpnla2kufME8J1
        EmFXirHlsJKC6DOuAKARitYssOJFE6qC5sC3T/sCIg==
X-Google-Smtp-Source: ABdhPJwCAsbL0cMTPY3WmC0LihDrNqp+6gvyh+PpFc7K9d+4n1Hjw/0GE7fBpMxFn82Ki8Ied6SwlO9OTyRZldTTya8=
X-Received: by 2002:ac2:5979:: with SMTP id h25mr5078255lfp.297.1619828631049;
 Fri, 30 Apr 2021 17:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com> <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
In-Reply-To: <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Apr 2021 17:23:40 -0700
Message-ID: <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
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

On Fri, Apr 30, 2021 at 5:19 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> A quick:
> $ perf record -e cycles:pp --call-graph lbr make LLVM=1 LLVM_IAS=1
> -j72 allmodconfig
> $ perf report --no-children --sort=dso,symbol
> shows:
>      2.35%  [unknown]                [k] 0xffffffffabc00fc7
> +    2.29%  libc-2.31.so             [.] _int_malloc
>      1.24%  libc-2.31.so             [.] _int_free
> +    1.23%  ld-2.31.so               [.] do_lookup_x

^ bfd

> +    1.14%  libc-2.31.so             [.] __strlen_avx2
> +    1.06%  libc-2.31.so             [.] malloc
> +    1.03%  clang-13                 [.] llvm::StringMapImpl::LookupBucketFor
>      1.01%  libc-2.31.so             [.] __memmove_avx_unaligned_erms
> +    0.76%  conf                     [.] yylex

^ kconfig

> +    0.68%  clang-13                 [.] llvm::Instruction::getNumSuccessors
> +    0.63%  libbfd-2.35.2-system.so  [.] bfd_hash_lookup

^ bfd

> +    0.63%  clang-13                 [.] llvm::PMDataManager::findAnalysisPass

^ this is another suspect one to me, though perhaps I should isolate
out the HOSTCC invocations vs cc-option checks. Should retest with
just CC=clang rather than HOSTCC=clang set via LLVM=1.

> +    0.63%  ld-2.31.so               [.] _dl_lookup_symbol_x

^ bfd

>      0.62%  libc-2.31.so             [.] __memcmp_avx2_movbe
>      0.60%  libc-2.31.so             [.] __strcmp_avx2
> +    0.56%  clang-13                 [.] llvm::ValueHandleBase::AddToUseList
> +    0.56%  clang-13                 [.]
> llvm::operator==<llvm::DenseMap<llvm::BasicBlock const*, unsigned int,
> llvm::DenseMapInfo<llvm::BasicBlock const*>, llvm::detail::Dense
>      0.53%  clang-13                 [.]
> llvm::SmallPtrSetImplBase::insert_imp_big


-- 
Thanks,
~Nick Desaulniers
