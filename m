Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B53707E6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhEAQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 12:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhEAQdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 12:33:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D1AC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 09:32:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so1759548lfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZW1EyHy79UfqUVwrUmwZE+wtdLBfVdkxB4jvLroyEk=;
        b=eFriZnXe6wAI8zO+VW8KKD055WxxPNqYoov2j/At6g9drhJwYeJQ7xKbZeKV/RLlbf
         PE1RAhRXVs9Ej+sgAh6Q/MZpQ5AydWNgOvFHdr/dp8MfG8eHRrZYGFBKbi7sDMYlXRlL
         R2gUVRB1wHwHx3W6mZ6ZUqqNyXrMQlLHLNs+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZW1EyHy79UfqUVwrUmwZE+wtdLBfVdkxB4jvLroyEk=;
        b=KRv/D+QI1RwRZ3aH+raVMnytoFUTydxqYlkKkqWjP/5AS6ofQR3O8KyHflWU07QCYX
         h4Sr7PvTSF2zNT/I2qO+SlV6DaaiCqgnoyq0UMfAayDQuT34DORxnSAZVHMZUySPeRth
         JcwGvZGuizFh7Hb/aQWZleDf4u8Q6a3ey+K9hy4/eopukVyu13SFtUkiTgfRRshVHY5F
         zwGsdWpKoR+y7X1mf97F2UHUrjd1M6Uj5Ccl627outo/LxMwM4lWoRBromorY8hA61Rs
         ORd8ExRCn8GNmxOL6In+IgalmUPPdutsquFjY76c6EI3hFHg9WgQ/q7pfw3g8wovcvzy
         ed6A==
X-Gm-Message-State: AOAM533h/wI0le8A1VuC6yP1OOTp9nopzX1Ic5dcfPQDdjKJPD8m84//
        qIXZQp+MtbByvvgq0KJV+8owKd6hXTf1PcYq
X-Google-Smtp-Source: ABdhPJyfsXkq925ukDsdmkQMd1bNWugb8LlsULg7x8Fa7/vCPdq0poh5TmliLEhSbeUeUUkQNzFmBQ==
X-Received: by 2002:ac2:538b:: with SMTP id g11mr7095772lfh.108.1619886762316;
        Sat, 01 May 2021 09:32:42 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y22sm611387lfl.36.2021.05.01.09.32.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 09:32:41 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x20so1741208lfu.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 09:32:41 -0700 (PDT)
X-Received: by 2002:a05:6512:a90:: with SMTP id m16mr6986867lfu.201.1619886761106;
 Sat, 01 May 2021 09:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com> <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
In-Reply-To: <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 May 2021 09:32:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
Message-ID: <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Tom Stellard <tstellar@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 8:33 PM Tom Stellard <tstellar@redhat.com> wrote:
>
> Yes, it's intentional.  Dynamic linking libraries from other packages is
> the Fedora policy[1], and clang and llvm are separate packages (in Fedora).

Side note: I really wish Fedora stopped doing that.

Shared libraries are not a good thing in general. They add a lot of
overhead in this case, but more importantly they also add lots of
unnecessary dependencies and complexity, and almost no shared
libraries are actually version-safe, so it adds absolutely zero
upside.

Yes, it can save on disk use, but unless it's some very core library
used by a lot of things (ie particularly things like GUI libraries
like gnome or Qt or similar), the disk savings are often not all that
big - and disk is cheap. And the memory savings are often actually
negative (again, unless it's some big library that is typically used
by lots of different programs at the same time).

In this case, for example, it's true that a parallel build will be
running possibly hundreds of copies of clang at the same time - and
they'll all share the shared llvm library. But they'd share those same
pages even if it wasn't a shared library, because it's the same
executable! And the dynamic linking will actually cause a lot _less_
sharing because of all the fixups.

We hit this in the subsurface project too. We had a couple of
libraries that *nobody* else used. Literally *nobody*. But the Fedora
policy meant that a Fedora package had to go the extra mile to make
those other libraries be shared libraries, for actual negative gain,
and a much more fragile end result (since those libraries were in no
way compatible across different versions - so it all had to be updated
in lock-step).

I think people have this incorrect picture that "shared libraries are
inherently good". They really really aren't. They cause a lot of
problems, and the advantage really should always be weighed against
those (big) disadvantages.

Pretty much the only case shared libraries really make sense is for
truly standardized system libraries that are everywhere, and are part
of the base distro.

[ Or, for those very rare programs that end up dynamically loading
rare modules at run-time - not at startup - because that's their
extension model. But that's a different kind of "shared library"
entirely, even if ELF makes the technical distinction between
"loadable module" and "shared library" be a somewhat moot point ]

                        Linus
