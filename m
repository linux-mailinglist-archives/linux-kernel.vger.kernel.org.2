Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6AD3EDCD3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhHPSHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhHPSHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:07:40 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895AC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:07:08 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id w17so34458972ybl.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33dTcPj9L2G+RiKdxFTGDEqQpLqBfKgRb9SoQPYPLpo=;
        b=VSWUay3SY15/4NGBWoTChPwDd8ujDO9Higioy3JypbcqKCd0muev0p6XdXyxEwUZVn
         uKgSYwgM98pbBN/5NVqZHMNTXDUsa7Om5jGYlpjssksxGrct/ihvltgP/uL0wRiXihQh
         utTideL2Ooc5wfnb9Fv6fzQAYvwAJBGaiZavVhZBU1xWmkFShJhyVxaIfm2JAvt6sdsJ
         q7IQoqe2TSV/f5zZRF3lDoOAcsNIFkxaBNce0kP1iZDah/5TxMk1N1Ejzb65voAamF47
         +jYW6wz2jrCtI+fAwY5Yvec9iKYgFyUwT1Q1wNUuJiWZG2zzLkn2lL88MfYUykOmPpC9
         JJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33dTcPj9L2G+RiKdxFTGDEqQpLqBfKgRb9SoQPYPLpo=;
        b=b5osGaLGAbVX+StT/xyt46V04fqV0FNzxr/i/aCbHPXEAx+sQM3LohMLGku6sVvoEb
         gWWrNeBSzRguSetXATmj6i/YqvBElKtYotqIMxsgVRfxenHGewZQmzHf90RGBjjxDh3z
         1XcIzZSvqJO1rnphyWx/ExfcroeXfHZsZr85x/5EtEpUNjPEF/GACwSD9IZ1IRD6dhwj
         6VuBAIhEX34ZduBJ2iLdxFJS7X6/2sulHNLEW03Wdfjmem3/tvrWzkVL0gNihUW09b+4
         JDqv9SoowTcpLeIuIAAl3Mm4VVYBy8uNRulfGQWycSzl4T6h8YTgNlh8j5xU6gUSkjZy
         HXxw==
X-Gm-Message-State: AOAM5333/A7wji+T3YC+Yxa9rTT7c0aUSvfMmtVf/MVhKxjEkSWt4AL/
        j455gpayFx4R/Jds8dsQLKPeCZmSRqrN09AEBpdjfw==
X-Google-Smtp-Source: ABdhPJyVkuwrdgobTNu4kxdPgWfK7qHvFVtdQhFN9x12wS3JBVRcN+l90XrQT/bDKLNpqJbOomcXymVHho5i6gjKmOE=
X-Received: by 2002:a25:c4:: with SMTP id 187mr24437571yba.498.1629137227399;
 Mon, 16 Aug 2021 11:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214614.1797845-1-samitolvanen@google.com> <CAK7LNAQ8Ucg=ZrEtMUCMkq3wonZqaijtrqbeUBod6DLERrp=zw@mail.gmail.com>
In-Reply-To: <CAK7LNAQ8Ucg=ZrEtMUCMkq3wonZqaijtrqbeUBod6DLERrp=zw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 Aug 2021 11:06:56 -0700
Message-ID: <CABCJKucbKVFvOmo6AsJBQfxL0zO3N9R2ydoCvZKpTwPSbOvbkA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Fix TRIM_UNUSED_KSYMS with LTO_CLANG
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Alexander Lobakin <alobakin@pm.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 4:27 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Aug 13, 2021 at 6:46 AM 'Sami Tolvanen' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > With CONFIG_LTO_CLANG, we currently link modules into native
> > code just before modpost, which means with TRIM_UNUSED_KSYMS
> > enabled, we still look at the LLVM bitcode in the .o files when
> > generating the list of used symbols. As the bitcode doesn't
> > yet have calls to compiler intrinsics and llvm-nm doesn't see
> > function references that only exist in function-level inline
> > assembly, we currently need a whitelist for TRIM_UNUSED_KSYMS to
> > work with LTO.
> >
> > This change moves module LTO linking to happen earlier, and
> > thus avoids the issue with LLVM bitcode and TRIM_UNUSED_KSYMS
> > entirely, allowing us to also drop the whitelist from
> > gen_autoksyms.sh.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1369
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Alexander Lobakin <alobakin@pm.me>
> > Tested-by: Alexander Lobakin <alobakin@pm.me>
> > ---
> > Changes in v3:
> > - Added missing FORCE.
>
>
>
> All the modules are recompiled every time.

Oops, .lto.o is missing from targets still, which breaks if_changed.
Fixed in v4. Thanks for testing!

Sami
