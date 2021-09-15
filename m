Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9740BDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhIODBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhIODBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:01:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F65C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:59:42 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq5so2909432lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbADmf0RfotFPk92OptkWggkubEXHwFuB6jYYoTJjjo=;
        b=Qhe9JZ+ZJ18xY02mFI4UlB1jQpdVQDRzQirW5vqP2RIgbNdCjhen7dYsCuzh5X2O8r
         VjlajUvy80zson73wivnbCYm7VyGI2ZDR0yYns+s54IFkWHDG355MWyGDMVhqFBm3FAE
         u0JN0MuNDZj316iZDvTrYS1xxa7Shsss8OsoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbADmf0RfotFPk92OptkWggkubEXHwFuB6jYYoTJjjo=;
        b=R32gYyzyKgA3N02vu2l6R8wl8vuyaOIrd/80AXkVEhL1w/f3y1qBJPaaEDo8OQklyO
         00LMORbRpi4N2pnns7m2m1e/k4USqDjlrOX1h7BUDjZThrdMwBreWHTn1XBW85fTFCV/
         6w4XPnR6WDdO3gyKNF9s2TjxVgf1gsNW8WLJC8Y45BtHrgDSDPyeN84dxdaSMw8HhNI7
         vJ7VsS/vS+RGEJecddx8c1uH76pp/5Ca3w5wohSrHyrbYaMrhx4Z9/I0qPSmi1lrG+Xp
         Grdbs8k+ETPZ7PY+mrbjhB1SjFC7zZcbafZaNSYJWn3Lyaz5jIdZ1iH61I/yoHqFQklW
         9jTg==
X-Gm-Message-State: AOAM5314h/OyoufvX2GaTHYIjQrjbqFNfOe2UCLOQyLVUYsQQz6h4c4T
        qQsPTYYJhmJnRBfhzMgOwuyReaABdQd/xVHHGaQ=
X-Google-Smtp-Source: ABdhPJy3IDqx37PzcJaUYD2nVYxldrHZg3rJID6IjZDmGML7EHENHLyQuM/mlJfpy+kYJ0yjDhOqug==
X-Received: by 2002:a05:6512:3b0f:: with SMTP id f15mr9359842lfv.169.1631674780522;
        Tue, 14 Sep 2021 19:59:40 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u24sm1507114ljg.64.2021.09.14.19.59.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 19:59:39 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id i4so2970426lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:59:39 -0700 (PDT)
X-Received: by 2002:a19:ae15:: with SMTP id f21mr5942103lfc.402.1631674779201;
 Tue, 14 Sep 2021 19:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <c1b1a299-c60d-28a4-07ab-1ecd211d6da9@i-love.sakura.ne.jp>
 <3bf6f4f4-9c96-6e0c-951d-5509175dddfe@kernel.org> <bb40c26c-dd0f-f7c2-59b7-d6ad361a0cdb@i-love.sakura.ne.jp>
In-Reply-To: <bb40c26c-dd0f-f7c2-59b7-d6ad361a0cdb@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 19:59:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiJ47YP7Q4AJC=YSfJdY-HK-8Bh7W=+hrZRqdM2UrAFg@mail.gmail.com>
Message-ID: <CAHk-=wiiJ47YP7Q4AJC=YSfJdY-HK-8Bh7W=+hrZRqdM2UrAFg@mail.gmail.com>
Subject: Re: linux: build failure: error: "__has_attribute" is not defined
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 6:05 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> It would be nice if Makefile can also check gcc version used for building tools.

I think the real problem is that the tool headers are cut-down from
the real kernel headers, but not cut down enough, so they are still
very complex, often with stuff that just isn't worth it in user space
at all.

And they _look_ like kernel headers - both in naming and in contents.
But they really aren't.

And it turns out there are two independent bugs here.

Bug #1 is that the tool header files look _so_ much like the main
kernel header files, that Nick thought that the

   #if GCC_VERSION >= 40300

was about the compiler we compile the kernel with.

But no, it's about the host compiler.

Easy mistake to make when the naming is so similar and the contents
are often also fairly closely related too.

But basically, commit 4e59869aa655 ("compiler-gcc.h: drop checks for
older GCC versions") was buggy, because it took the kernel compiler
version logic ("we require 5.1 to build the kernel") and applied it to
the tooling header files too (we do _not_ require the kernel compiler
for host tools).

Now, arguably, commit 4eb6bd55cfb2 ("compiler.h: drop fallback
overflow checkers") has the exact same problem: it too ends up
changing  both the kernel header files and the tooling header files.
But tooling really REALLY shouldn't be using those overflow macros, so
nobody should care.

Famous last words.

I think we should remove that "tools/include/linux/overflow.h" header
entirely. Yes, it is used - by tools/virtio/linux/kernel.h. But I
think that overflow handling code should be removed. It's just not
interesting in user tools.

Now, the _second_ bug was then that when Nathan fixed the tooling
header file in commit d0ee23f9d78b ("tools: compiler-gcc.h: Guard
error attribute use with __has_attribute"), he did it the wrong way.

The gcc docs are fairly clear about how to test for __has_attibute correctly:

    https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005fattribute.html

and a host build environment should probably have used

  #if defined __has_attribute
  #  if __has_attribute (error)
  ...

and not used any version checks at all.

Of course, I'm not convinced it should do that __compiletime_error()
at all, and again, I think it would be better to remove the complexity
rather than anything else.

Anybody want to tackle those issues in

   tools/include/linux/overflow.h
   tools/include/linux/compiler-gcc.h

and try to simplify the code?

              Linus
