Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7936C400CF6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhIDUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhIDUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 16:49:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88210C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 13:48:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z2so5417861lft.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zHHc5Ft3Ok6Z3pRnyZ85tV26jItKpe9ZasjrvP2F9MQ=;
        b=fLS/Wwf8Pg9aIz7w9/dZITjC1PCxmO/MKANDa1mRx1+Fwm3hX1ZJ8O3+Omdy4oKpCz
         8waa+KCSeiDwz5XSqEyiN9FxWNMJ+3+n5mWTGVJK6lvg8LJ+JONBA5I8Pmo8Pcmdu0Ak
         M9Qkp9DUbKWuiYEqSg2ZNPMzpiFcDyRRUWRS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zHHc5Ft3Ok6Z3pRnyZ85tV26jItKpe9ZasjrvP2F9MQ=;
        b=czzwDIxQdnvR1outt29M5l3WtpEgOdpTJPp3jluJy7L476dS84/wh6VAx1lSIBK0O5
         R/3+tayDbGo6MAUbdHka+0BCv9A1qjDJAufb5bNygxoc8u2lLlkas0yVSCrmqpU8LyQC
         3yuKUtVEG9hPobvBW04BmielWJhYCm1lDo5ku0EsSym3iQnc62jqElg4Bcunu+7B6nU/
         vTsSXhv5WD95jC2KOA/Kv+0+6qIMCayckp3N6lMUjLW1GhmivIhX65NvFCDX08hBhAHM
         QW+vBZYuEL+TsZWfGQp46J08bnACe4JEz1TA4MXFKPoUtYYRfXysOvXYz95Op/DBdILO
         ZPPg==
X-Gm-Message-State: AOAM533etIP4gZQhEQWToGwopAfdJHGT0aF5KdwphFFXeLFhRfhBpZpf
        iU/Qpbu0UYR0i2Y/i0ygOT3uUIQ6zLsKkJbH
X-Google-Smtp-Source: ABdhPJyzf4A06ckt0HBCOPFndqS4FvdZMOFHY/R7wKvE/7ANOL5ze3MqQBnHmTdbOOqPlh1RhfMSdA==
X-Received: by 2002:a05:6512:1289:: with SMTP id u9mr4033872lfs.296.1630788492725;
        Sat, 04 Sep 2021 13:48:12 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id bu1sm325704lfb.306.2021.09.04.13.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 13:48:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id y6so4352934lje.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 13:48:11 -0700 (PDT)
X-Received: by 2002:a05:651c:158f:: with SMTP id h15mr4190618ljq.249.1630788491026;
 Sat, 04 Sep 2021 13:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <202109022012.756B6B5B79@keescook>
In-Reply-To: <202109022012.756B6B5B79@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Sep 2021 13:47:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
Message-ID: <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
Subject: Re: [GIT PULL] overflow updates for v5.15-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 8:22 PM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these overflow updates for v5.15-rc1.

I pulled and then immediately unpulled again.

You can't add new warnings without fixing them, and this adds some
HORRENDOUSLY ugly new warnings that would most definitely hide other
warnings.

It doesn't matter one whit if the new warnings are from some
test-file, they are not acceptable for a build.

Make any tests separate from a real kernel build, because if "make
allmodconfig" results in hundreds of lines of warning crud, it's
useless garbage.

             Linus

---

warning: unsafe memchr() usage lacked '__read_overflow' warning in
lib/test_fortify/read_overflow-memchr.c
lib/test_fortify/test_fortify.h: In function =E2=80=98do_fortify_tests=E2=
=80=99:
lib/test_fortify/read_overflow-memchr.c:3:9: error: statement with no
effect [-Werror=3Dunused-value]
    3 |         memchr(small, 0x7A, sizeof(small) + 1)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/test_fortify/test_fortify.h:34:9: note: in expansion of macro =E2=80=98=
TEST=E2=80=99
   34 |         TEST;
      |         ^~~~
In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:10,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
.. lots of noise ..

In function =E2=80=98strncpy=E2=80=99,
    inlined from =E2=80=98do_fortify_tests=E2=80=99 at lib/test_fortify/tes=
t_fortify.h:34:2:
./include/linux/fortify-string.h:56:17: error: call to
=E2=80=98__write_overflow=E2=80=99 declared with attribute error: detected =
write
beyond size of object (1st parameter)
   56 |                 __write_overflow();
      |                 ^~~~~~~~~~~~~~~~~~
warning: unsafe strncpy() usage lacked '__write_overflow' warning in
lib/test_fortify/write_overflow-strncpy.c
In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:10,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:60,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:55,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/slab.h:15,
                 from lib/test_fortify/test_fortify.h:4,
                 from lib/test_fortify/write_overflow-strncpy.c:5:
