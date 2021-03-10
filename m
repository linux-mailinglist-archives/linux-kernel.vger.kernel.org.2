Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F93334A41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhCJV62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhCJV6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:58:00 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:58:00 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id i18so17016930ilq.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Wt/aYrFcnMjEbcU8t+EUxk6Pl8rJHj95cuGNfpHyPQg=;
        b=eKpgHXtOwCTXHlE6jnD5soOkWX+t8weM3TAKlQWmWDsUk1Nd1BpZPhqTzkxO5ME0/3
         OzK4ZimSKeJW/g8X3OiyJtk/MoH0sSpblC680takH1PUDb8Jj6WSwDddEuGscfkMRQ9C
         rAhZfd3xz1E/Vw6xLyKeKAAQJd5oUgZsTJ+/a6u7fDyPDo+lRXhiZKVYszqdqYqd/i1l
         VISnVOZwC2IWO3vT9k7h8OI+UON/tSiT/0OHRV+lYk+pF4EKrN4bzqnsgHLBRGypcjjN
         XV2UGWg4SMhYZ7H5wFQr6oeLw05XudvIbJvx6tRmvM1Y9/obQQNphAaDBE3lxLleM1mQ
         M91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Wt/aYrFcnMjEbcU8t+EUxk6Pl8rJHj95cuGNfpHyPQg=;
        b=mM7eVnK9rxDVh4ZQKRkKjG77Zl8I42ebQZW8+uQB8/qR4xS1nsmEncZB/pMBHktlkz
         XckAAVh70iQXelx2WlV8yxeu+HuhSdtvgmvXhFVXgFbsDUIY9sJH3GTIDs6mtBLkAHub
         0o8H7RcdcGF4CEri/Ry15ZP7kaDZk67A1jFNXbKv6BaN36rvohG+y1dhsfEXU54deP6F
         ifrHWyem2bU4NYGhoSFbnN7P0Z8o1qs2rGyZ7A1XQyzrnV1pkeDZhavUG42LW9MGRa57
         rw9t5LkUsd35y/b5fyyPhwQdlzw0nu5nVhGpcbevg0R+RWKBa2VfHK/2qNYT1QNF71Sa
         8p9w==
X-Gm-Message-State: AOAM531jD7LLlmQfzz8RUj5PZPeElqCcy/Nr9s7I8GcEX649aTQXCMBL
        5oB3gdfQ0fSw4v2HoiF5WjxFgIubsveWVKp3QRQoVdFg75RIbg==
X-Google-Smtp-Source: ABdhPJzXImNMUM6WpYLBxvrwa4y5c2ASfdVCXpeoxRGEDmTq8hWPDGVNkCmbmo2jU10PGL3fcjVEPi6TmoItJyhFI6c=
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr4389474ilk.209.1615413480036;
 Wed, 10 Mar 2021 13:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <20210226211323.arkvjnr4hifxapqu@google.com>
 <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
 <1614559739.p25z5x88wl.astroid@bobo.none> <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
 <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com>
 <CA+icZUWk-9i8BSf70qE_9f=mekscQ063q+aUKzSNBymNLAbcTA@mail.gmail.com> <ros2o1p7-r65q-n4p-3o38-oo36rr58q041@syhkavp.arg>
In-Reply-To: <ros2o1p7-r65q-n4p-3o38-oo36rr58q041@syhkavp.arg>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 10 Mar 2021 22:57:23 +0100
Message-ID: <CA+icZUW8SqpTuANz7brtR+QSxKn+UnYOVve-C+TOMh9RqdQh+w@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:47 PM Nicolas Pitre <nico@fluxnic.net> wrote:
...
> > With CONFIG_TRIM_UNUSED_KSYMS=y I see a 3x-loops of building .version
> > and folowing steps - got no answer if this is intended.
>
> Yes it is intended. I explained it here:
>
> https://lkml.org/lkml/2021/3/9/1099
>

Ah, cool.
Thanks for that link.

> With CONFIG_TRIM_UNUSED_KSYMS some EXPORT_SYMBOL() are removed, which
> allows for optimizing away the corresponding code, which in turn opens
> the possibility for more EXPORT_SYMBOL() to be removed, etc. The process
> eventually converge to a stable build. Normally only 2 passes are needed
> to converge, but LTO opens the possibilities for extra passes.
>
> > Means longer build-time.
>
> Oh, absolutely.  LTO (at least when I played with it) is slow. Add the
> multi-pass from CONFIG_TRIM_UNUSED_KSYMS on top of that and your kernel
> build becomes agonizingly slow. This is not something you want when
> doing kernel development.
>

Thanks for the feedback.

> > I did not follow this anymore as both Kconfigs with Clang-LTO consume
> > more build-time and the resulting vmlinux is some MiB bigger than with
> > Clang-CFI.
>
> That's rather strange. At least with gcc LTO I always obtained smaller
> kernels.
>

I cannot say much to GCC-LTO - I never used it.

If you are interested in Clang-CFI (see [1]) - which requires
Clang-LTO enabled and LLVM/Clang >= 12.
Some hours ago version 12.0.0-rc3 was released, see [2].

- Sedat -

[1] https://github.com/samitolvanen/linux/commits/clang-cfi
[2] https://github.com/ClangBuiltLinux/linux/issues/1259
