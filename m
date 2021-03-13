Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA3D339E02
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 13:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhCMMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 07:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhCMMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 07:11:06 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D94C061574;
        Sat, 13 Mar 2021 04:11:06 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d5so5090722iln.6;
        Sat, 13 Mar 2021 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=b8kDPYuqhpqPQJc9sIGZbfI4Oa00XZ79BrTFoqYhmYY=;
        b=KQfnGChddQQtsg6MKKJlQYu7P3b56LrwMOu80Wq5LScQPb+dB47nZXB0k86AKffFFl
         e7JyGaz/rLgWQZ8W4j+s9zJnhpFYOrz4m/TRb3wA/bzSufyxm7KkDYCxg2Ze7Yo65AbK
         iwVQQoEftPXFCjv8SxyzZRFDtF2lsohHgY34dNv3tb1nvnErXWhFamKJelsFLgOLbtfO
         1pd/bxHmP9q00R3E1M5ok1G25RL5nH08gK1u/zPzta8q0TC43heZHXFYL3zwI7Fvg+0w
         fWK/YVAfW34ztSl1hYh3/HTq1bka+VsjsWyDVN8ExndHYIV0SFQC2VLvsXVes+1NyeN0
         XKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=b8kDPYuqhpqPQJc9sIGZbfI4Oa00XZ79BrTFoqYhmYY=;
        b=Cig+1N9dw214wHTEx+lQ+pa5XOMnq2uST65vqiMZ1Fa04LSuGchiTHVkgJUvnjIxuT
         qs9KuiMQx7ssoPWLzAyN7vNkjHn6EZVzN8arrQ5rJqMeyRp4mWE84FjyyNJHTpS2XkJb
         0aIUDcc49oe1EooT+CKv7kGXWz+6f/8O58P1Y2unBWrg8gcic2wmTtKJxxlsMrYPGhC/
         5VVuTv451d6b5MnGgnEbQIBqognK+cyxW4z2BsF++i1RbhSuy8mOgndKUJ34+UShYO8+
         dgBp/F+NT+fU4C+P6dFgxg43YrD2uYcHy3XZIOAC63dF6bawCSo6v3tus3aL1vXCMWFd
         LuUQ==
X-Gm-Message-State: AOAM532ZkyL+p+wP7Aw425d1cYEHOPjCONzgpe9hbtv9TDntdvifjZDe
        H2cFAQ1uqJ4PEg3it8Ci/oVfmZKpj92P0rQna/s=
X-Google-Smtp-Source: ABdhPJxZLAxacYuiONUul6dYNxGKeyH/WOx+pGX6KksuWB9xxTqM53So/LiXfTrJq41rtncljz+TcMpAITfuHRVpn78=
X-Received: by 2002:a92:c145:: with SMTP id b5mr5895132ilh.186.1615637464992;
 Sat, 13 Mar 2021 04:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org> <20210312205914.GG22098@zn.tnic>
 <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com> <20210313084923.GA16144@zn.tnic>
In-Reply-To: <20210313084923.GA16144@zn.tnic>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 13 Mar 2021 13:10:29 +0100
Message-ID: <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 9:51 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Mar 13, 2021 at 06:26:15AM +0100, Sedat Dilek wrote:
> > x86/jump_label: Mark arguments as const to satisfy asm constraints
>
> Where do I find this patch?
>

Here we go:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=864b435514b286c0be2a38a02f487aa28d990ef8

> > x86: Remove dynamic NOP selection
> > objtool,x86: Use asm/nops.h
> >
> > My benchmark was to build a Linux-kernel with LLVM/Clang v12.0.0-rc3
> > on Debian/testing AMD64.
> >
> > Patchset applied for a first build:
> >
> >  Performance counter stats for 'make V=1 -j4 LLVM=1 LLVM_IAS=1
> > PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-7-amd64-clang12-cfi
> > KBUILD_VERBOSE=1 KBUILD_BUILD_HOST=iniza
>
> There's a reason I have -s for silent in the build - printing output
> during the build creates a *lot* of variance. And you have excessive
> printing with V=1 and KBUILD_VERBOSE=1.
>
> Also, you need to repeat those workloads a couple of times - one is not
> enough. That's why I have --repeat 5 in there.
>
> Also, you need --pre=/root/bin/pre-build-kernel.sh where that script is:
>
> ---
> #!/bin/bash
> echo $0
>
> make -s clean
> echo 3 > /proc/sys/vm/drop_caches
> ---
>
> so that you can avoid pagecache influence.
>

OK, I see.

- Sedat -

> Lemme rerun here with clang.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
