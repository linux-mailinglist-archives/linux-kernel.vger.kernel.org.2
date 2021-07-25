Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07823D4F61
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhGYR0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 13:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYR0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 13:26:02 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49700C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 11:06:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b21so8361518ljo.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAPnY52NkUEhJP1ysu37h1b5Od9GzDBqirdcbLd6kA0=;
        b=LiDcFvwhu0+GzJFSDiGRAHYIYv8PlXxK0h2rqEbywYEtVxyXMINlNsKMbtT6sM7jQ6
         5F8gcF+VDYRgazUlGyzBqJUrTYtOUiEs34x8O4YiTPuXCZR8g9osbavJUp7vttBwslJF
         NuQpzuD0bagKh4cx1ID6ey/kHw0GUXsGX6sjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAPnY52NkUEhJP1ysu37h1b5Od9GzDBqirdcbLd6kA0=;
        b=CNCYzxQBWdSjqUQscdW3OQ7pNh4fM79EKPW3xcft4xcZ7vZjoNvNlRIV42L7c26z3I
         4zMhG2kN68SOtoBp6sh2Y/7O5E89z9ychogDvaN0qseK3DZDFZgDqzSSYgmkB0BlVcVo
         itL4Y9UydDN/c80Ta8S/6e5w1VE4eq8jtx7FLqghG2s/hU48T9XogI0+XEqVFoVotwUf
         4QebhtpSYwKioqu1NnIK9wXNBWvWC9fd7O3PTepFbGv2MKCVEPV+RxWMHd1Q/xJXgPiw
         N5H+nmNEhgabPOz5b9LVn+HyiUQr/3vehKe7/wZ1D6drct22InBI9k1WgxIAm3i6C3Kk
         j8OQ==
X-Gm-Message-State: AOAM532DT5G/+F73Pp3b4O7BsUvTcqJWjB6L7iWUYcwckMKNqGxrcDax
        At0buMh3zdERHxxnZouloRINeYi170QJhrd/
X-Google-Smtp-Source: ABdhPJwExfJb6+y+gcGXI+hsCHgrrdkJ8FyGPmkoD0UkbHfgL/CXmP2OnJaEbDLODwyy4LLPAHPY4w==
X-Received: by 2002:a2e:904b:: with SMTP id n11mr9600272ljg.104.1627236389274;
        Sun, 25 Jul 2021 11:06:29 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z17sm2938137lji.113.2021.07.25.11.06.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 11:06:28 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u3so11188184lff.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 11:06:28 -0700 (PDT)
X-Received: by 2002:a05:6512:404:: with SMTP id u4mr9893885lfk.40.1627236388433;
 Sun, 25 Jul 2021 11:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <162720492071.8837.4047241618315201209.tglx@nanos>
In-Reply-To: <162720492071.8837.4047241618315201209.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Jul 2021 11:06:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5BnPvhmFkXuTJKHawi9kRQsFQDO44GQ4XzqJbwupSWw@mail.gmail.com>
Message-ID: <CAHk-=wj5BnPvhmFkXuTJKHawi9kRQsFQDO44GQ4XzqJbwupSWw@mail.gmail.com>
Subject: Re: [GIT pull] core/urgent for v5.14-rc3
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 2:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A single update for the boot code to prevent aggressive un-inlining which
> causes a section mismatch.

Argh, I did my usual allmodconfig build tests and this looked clean,
and I've already pushed it out.

But I do my clang builds separately, and that showed the bug:

> -static inline void idle_init(unsigned int cpu)
> +static inline void __always_inline idle_init(unsigned int cpu)

Yeah, that's a bit too many "inline"s, and clang quite reasonably
warns about it:

   kernel/smpboot.c:50:20: warning: duplicate 'inline' declaration
specifier [-Wduplicate-decl-specifier]

Plus now that I look at it, it also has that __always_inline misplaced
- we should put things like "static" and "inline" (and
"__always_inline") before the function type specifiers.

So that function definition _should_ have been

    static __always_inline void idle_init(unsigned int cpu)

instead.

Oh well. I'll fix it up as a separate patch. I wish I had done the
clang build before pushing it out - and I wish the -tip tree started
tested clang as well at least in _some_ configuration.

              Linus
