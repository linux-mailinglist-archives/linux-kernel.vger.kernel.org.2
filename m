Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0880334A34B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCZIjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCZIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:38:33 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A16C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 01:38:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z3so4593564ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=GuhNBMfb4hYHF8Dvll8qk+/OkL+kGWlRUKt4MNqIm78=;
        b=pQlYGB7i1fTagrQL8ZahXbuVoa7nLYSNqXV2OgpmXfdez2GKWFDsc8WlGD7ecsBtTX
         eBDobmPP/I0bYWXgogvHq1OBAxKaEyaCYFaXkD3sindpc9CNIV4hZmhIrc+hPnTtHWA0
         JWFEegJOg6BSKlfxlTP8pQlqZXhQN2Few6iH5x6V3LQ+6LN79qin646nZ3BlTxGu1Iqa
         FqvVTwcKrTsyYIgcPPa1dsojUHYZ63P4augntBXJDNWCujD897lk1sUHPuweOQgFwPNI
         ImYixt74gHJAInlTwDpanxxVKIjfWN9nO/WagRR5vXCl/p3fJew6YI8aHxVRSTukJrch
         5qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=GuhNBMfb4hYHF8Dvll8qk+/OkL+kGWlRUKt4MNqIm78=;
        b=qgNDHyxWdPGZGo96yI4/HOt4hwLrJmlqGLsNdjMyOKOanVk9bn0m/OyZvRz2OE0ec0
         Eq8HPSwDAie16X2u5SHuY6w+RxbU5rTMAj7hW7J2N704WV5PMy3MVzf8wmYGKJzG344w
         CRzwNVJKCEPBkbSRia1Cu70KAFGWSBgqhfGD8dz0iiQT/vpa0u+sGQnLNSJO5zzBmtrN
         Npa9hwJtCWBK2+QlSVE+pFIjKswVDpHBL5GKDSbJnvcqq4EY36C4BTIdGHH6K5btYEaL
         Ofb0ds4Y147NpMBPxXSLMk3Y29Us03ocjwH5iMeKh1uxKjzVmDClztyHY1szSXh9YaWI
         0g6A==
X-Gm-Message-State: AOAM532iPD7M1JCd6yyxpJa3iCTlE22BojBEkyP1igH/ltSimUWSfuC0
        Al5Ir/gOGJ8ly9dD8HSeauWZPj10jF36NYUBMkywx0ka89Y=
X-Google-Smtp-Source: ABdhPJzFLpEIBJOC5vBSPe8rAMg+aO/wThi0+tlUhyN/NoXs4BbB5whXFHrDSEWyoiii52lEQn3Dbr8onwTQzN8P3VI=
X-Received: by 2002:a05:6638:1388:: with SMTP id w8mr5089745jad.30.1616747911961;
 Fri, 26 Mar 2021 01:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210325223807.2423265-1-nathan@kernel.org>
In-Reply-To: <20210325223807.2423265-1-nathan@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 26 Mar 2021 09:37:55 +0100
Message-ID: <CA+icZUWgxmrtM=oj-aJi1KXxZx0YUZDiUPK42MjHvqS96aazYQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix CONFIG_FUNCTION_TRACER with clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 11:38 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi all,
>
> This series fixes function tracing with clang.
>
> Patch 1 adjusts the mcount regex in scripts/recordmcount.pl to handle
> the presence of PLT relocations, which happen with clang. Without this,
> the mcount_loc section will not be created properly.
>
> Patch 2 adds a workaround for clang less than 13.0.0 in relation to the
> mcount symbol name, which was "mcount" rather than "_mcount". This was
> written as a separate patch so that it can be reverted when the minimum
> clang version is bumped to clang 13.0.0.
>
> Patch 3 avoids a build error when -fpatchable-function-entry is not
> available, which is the case with clang less than 13.0.0. This will make
> dynamic ftrace unavailable but all of the other function tracing should
> work due to the prescence of the previous patch.
>
> I am hoping this series can go in as fixes for 5.12, due to patch 3, but
> if not, they can always be backported (patches 1 and 2 are already
> marked for stable).
>
> This series has been build tested with gcc-8 through gcc-10 and clang-11
> through clang-13 with defconfig and nommu_virt_defconfig plus
> CONFIG_FTRACE=y and CONFIG_FUNCTION_TRACER=y then boot tested under
> QEMU.
>
> Cheers,
> Nathan
>
> Nathan Chancellor (3):
>   scripts/recordmcount.pl: Fix RISC-V regex for clang
>   riscv: Workaround mcount name prior to clang-13
>   riscv: Select HAVE_DYNAMIC_FTRACE when -fpatchable-function-entry is
>     available
>

Does this only fixes stuff for clang + riscv?
If so, please put a label "riscv" also in the cover-letter.

- Sedat -

>  arch/riscv/Kconfig              |  2 +-
>  arch/riscv/include/asm/ftrace.h | 14 ++++++++++++--
>  arch/riscv/kernel/mcount.S      | 10 +++++-----
>  scripts/recordmcount.pl         |  2 +-
>  4 files changed, 19 insertions(+), 9 deletions(-)
>
> --
> 2.31.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210325223807.2423265-1-nathan%40kernel.org.
