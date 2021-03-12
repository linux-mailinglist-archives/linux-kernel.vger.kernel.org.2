Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9F533959E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhCLRzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhCLRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:55:22 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6489CC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:55:22 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v2so34071223lft.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5w7ZZe4gkot9I65XhFVTJi33unNIut/Zvam2Whsvv4M=;
        b=QJkTONM+I8VxEs+vXdnwuPI187e+wusL0lxIGwbMHQ57b2M4SycZoxmCBto7SRgDXk
         zq7xGrp1UjRHTB4rXIIROFCc9HTB3YUiOb5HmiFu3E2uf9usgyL5TBF3H2SxHzO5cDEM
         pB9mLMZ1iZrMvjXY8WNQWhkeiVlvAsvcSkLUavaaZii0sLod+BaJz/bXYufhrG05yM6/
         rblJcduCiSXPDcK3MLVqcqX5WKdT/1skppeur9ObSNDw3aLp1MvlxHX2cmn1j1dN8/9Z
         A47NAJ3P8dz9OESbT2H3wRxHOxxcb3FHbZMIPVyiimGT6IUdqg2cYR14Z6u37Yf88s30
         LKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5w7ZZe4gkot9I65XhFVTJi33unNIut/Zvam2Whsvv4M=;
        b=rjb3A5r33uyTGOkz8FrBhPtRamikTOrb/BkXJIYXoOrxzPbazXHDK6Ms6CQw3B6qqL
         kW54/KHri8cUmWReRDPMJsMizRnzegZkBWsQktkmUtIkBYfl3lePg2ypYxh0bQIE4e+V
         PRW2MP0UrKavRPNj6SQtlfVAdp/QUbVZD/JZ2E23mS3i84CTqqxm1q9Oe1uIBkBlciQX
         Vwihkhtu3L30iAfclfCmya9JmW/wtVU0eedmH2j2RGtXKq1Hptb9wMG9FS8ZQGrT4I7D
         ou1RUdTU0I/FCmwYGrwKVbRKiF3Cqt1VMcZkkfpTgDOy8EhH5sHD17zrtB2IzIRV63Jm
         2OEw==
X-Gm-Message-State: AOAM531xTUp7FqCrkQBIWcSqVi2AKm/eYwgD8QJEmnVLiVP5SsOdnuXP
        Zij7wUU91BshStsdj24TC+zKhRS/l6krcuewI+ULRA==
X-Google-Smtp-Source: ABdhPJzW5vzqOBl0QKSu/W56cC6YZEMrvsQVw0dKwljpzSpNHlzEDZ/rbry1gk60PWPdlGpqP7Os8RylygEpnU6vv5c=
X-Received: by 2002:a05:6512:12c1:: with SMTP id p1mr256755lfg.374.1615571720669;
 Fri, 12 Mar 2021 09:55:20 -0800 (PST)
MIME-Version: 1.0
References: <20210312010942.1546679-1-ndesaulniers@google.com>
In-Reply-To: <20210312010942.1546679-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Mar 2021 09:55:09 -0800
Message-ID: <CAKwvOdnPhpKRs6SePCUCPs_2MUFbWgJiaf9F9J+aQZGESSQ9yA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: LTO: have linker check -Wframe-larger-than
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Candle Sun <candlesea@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 5:09 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> -Wframe-larger-than= requires stack frame information, which the
> frontend cannot provide. This diagnostic is emitted late during
> compilation once stack frame size is available.
>
> When building with LTO, the frontend simply lowers C to LLVM IR and does
> not have stack frame information, so it cannot emit this diagnostic.
> When the linker drives LTO, it restarts optimizations and lowers LLVM IR
> to object code. At that point, it has stack frame information but
> doesn't know to check for a specific max stack frame size.
>
> I consider this a bug in LLVM that we need to fix. There are some
> details we're working out related to LTO such as which value to use when
> there are multiple different values specified per TU, or how to
> propagate these to compiler synthesized routines properly, if at all.
>
> Until it's fixed, ensure we don't miss these. At that point we can wrap
> this in a compiler version guard or revert this based on the minimum
> support version of Clang.
>
> The error message is not generated during link:
>   LTO     vmlinux.o
> ld.lld: warning: stack size limit exceeded (8224) in foobarbaz
>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Reported-by: Candle Sun <candlesea@gmail.com>
> Suggested-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> LTO users might want to `make clean` or `rm -rf .thinlto-cache` to test
> this.
>
>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index f9b54da2fca0..74566b1417b8 100644
> --- a/Makefile
> +++ b/Makefile

Candle sent me a private message that we probably also want coverage
for kernel modules. Let me revise this and test/send a v2.

> @@ -910,6 +910,11 @@ CC_FLAGS_LTO       += -fvisibility=hidden
>
>  # Limit inlining across translation units to reduce binary size
>  KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
> +
> +# Check for frame size exceeding threshold during prolog/epilog insertion.
> +ifneq ($(CONFIG_FRAME_WARN),0)
> +KBUILD_LDFLAGS += -plugin-opt=-warn-stack-size=$(CONFIG_FRAME_WARN)
> +endif
>  endif
>
>  ifdef CONFIG_LTO
> --
> 2.31.0.rc2.261.g7f71774620-goog
>


-- 
Thanks,
~Nick Desaulniers
