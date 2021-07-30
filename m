Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661443DC082
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhG3VzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 17:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhG3VzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:55:03 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A3EC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:54:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h2so20666725lfu.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faoOQY/6RWuADuNoVKpvGyxjDEO3XlGf6d50QEfJC7g=;
        b=ZQTRYuq1mRX8347xP8HSAXAa4cJLeXraaLaLYL6GLXd30yRuEBjaeqrsy85g43yYk5
         qLCsVgwyL8FkDBESZHruuTsLAyBTkQnuT3Vdy2mjdnlfsgpDmGzMKFBRpwV2ygbNxOTf
         +CPnpcZehxcxeSZrCHIO7fHrA+bst+Q0S8ecOHsXa0Cek5/yA/tOB8OYSPZ4EybqyMBa
         8sVkfE+a6tPRFTb8Hhhn2z2Jwy7OuAQbIEre9GIbU2hh63V1UL0vvgeD57HAwbWobnHw
         ubnVRE8Yv7iQKp1rsRr4Owh7MlmsZHB0rd5yx6kr2++tj+LitwuPlmMR2YlKO78RnkkQ
         67AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faoOQY/6RWuADuNoVKpvGyxjDEO3XlGf6d50QEfJC7g=;
        b=nbZOfWFnjpDDoqtrJbOGscwIpEVNHfurZjPDgU2UsieRamBp6II9g9z0VhgebN724g
         xvhMlE2si9PDp1urp8e4Vtd3a9A1giS7rS3fJria07bZL2bD+XlURjCUkEQH3WdbmmZn
         1XopawReh9ko2fhNPcFLKK8mymWtZ4V4szMaACC4YK2mMpT2vWHxl4neOhqYfBZOB0xL
         NPa/tu1ltZTOb+X4E6W3+/XPBeanJ6cNwYDZ+fhNPECZ5WNOERJ86pYCv1PmXcOmBhJv
         n/f4etiMlk+BZOrBmmGdO+6p3KRqQ1ivOxfnqg5ptJMYEkHb1piXQiqJSf3P6AYFqng6
         jRSg==
X-Gm-Message-State: AOAM5329viRD9vw4060K21DuZXUUrwKGBIuM9Rhp7+gAD+YJOpa52ssk
        yphfFu+leyQs5+CwQQ1b628Uu2XOdvuBjRuunyrYMw==
X-Google-Smtp-Source: ABdhPJwNZcILhR4pmttwbOSL1t8zmWVjqLvvRkn0ZAkRoCwb18QBN4ePQhIpGSSwCZaexTshyitcDN707vjVtpzE27Q=
X-Received: by 2002:ac2:59c4:: with SMTP id x4mr2916374lfn.547.1627682096028;
 Fri, 30 Jul 2021 14:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210730201701.3146910-1-ndesaulniers@google.com>
In-Reply-To: <20210730201701.3146910-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Jul 2021 14:54:45 -0700
Message-ID: <CAKwvOdk7yxOd6gStOqaJMdf9RW+cDdX1M1ScFJA70y5GZmSwNw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] infer --target from SRCARCH for CC=clang
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 1:17 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> We get constant feedback that the command line invocation of make is too
> long. CROSS_COMPILE is helpful when a toolchain has a prefix of the
> target triple, or is an absolute path outside of $PATH, but it's mostly
> redundant for a given ARCH.
>
> Instead, let's infer it from SRCARCH, and move some flag handling into a
> new file included from the top level Makefile.
>
> Changes v3 -> v4:
> * Remove the requirement that LLVM_IAS=1 be set, as per Masahiro.
> * Remove the Documentation/ change from patch 2, as per Masahiro and
>   Nathan.
> * Add Documentation/ change as patch 3, from Masahiro.
> * Reword commit message of patch 2, as per Nathan.
> * Change patch 2 oneline to refer to --target and CC=clang (not
>   CROSS_COMPILE).
> * Carry Arnd's and Nathan's AB/RB/TB tags, confirmed ok on IRC+discord.
>
> Changes v2 -> v3:
> * Remove requirement that LLVM=1 be set. Instead, if building with just
>   CC=clang LLVM_IAS=1 instead of LLVM=1 LLVM_IAS=1, you should use
>   LD=ld.lld explicitly, or LD=aarch64-linux-gnu-ld. (As per Masahiro)
>   Example:
>
>   $ ARCH=arm64 make CC=clang LLVM_IAS=1 LD=ld.lld OBJCOPY=llvm-objcopy \
>     STRIP=llvm-strip -j72 defconfig all
>
>   (It's still preferable to use LLVM=1 IMO, but this is maximally
>   flexible.)
> * Change oneliner from LLVM=1 to CC=clang.
> * Update Docs slightly.
>
> Changes v1 -> v2:
> * patch 1/2 untouched.
> * Fix typos in commit message as per Geert and Masahiro.
> * Use SRCARCH instead of ARCH, simplifying x86 handling, as per
>   Masahiro. Add his sugguested by tag.
> * change commit oneline from 'drop' to 'infer.'
> * Add detail about explicit host --target and relationship of ARCH to
>   SRCARCH, as per Masahiro.
>
> *** BLURB HERE ***

Err, sorry, it looks like I did:
$ git format-patch HEAD~2 ...
when I meant to do HEAD~3 ..., will resend.

>
> Nick Desaulniers (2):
>   Makefile: infer --target from ARCH for CC=clang
>   Documentation/llvm: update CROSS_COMPILE inferencing
>
>  Documentation/kbuild/llvm.rst | 17 +++++++++++++++++
>  scripts/Makefile.clang        | 30 ++++++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
>
>
> base-commit: 27932b6a2088eac7a5afa5471963b926cfbb4de7
> prerequisite-patch-id: 0d3072ecb5fd06ff6fd6ea81fe601f6c54c23910
> --
> 2.32.0.554.ge1b32706d8-goog
>


-- 
Thanks,
~Nick Desaulniers
