Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867B53B6CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 04:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhF2Cvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 22:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhF2Cvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 22:51:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877F9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 19:49:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w11so8261827ljh.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 19:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEYEWsL6AYbcFkTNzTHp7v10JIwWkeD8uKj1umSmXwA=;
        b=Lpyx5Bj2FcftcCrXmBzDWUDVMi85k+alslccDNNzT2sy9TZr+o5YMzW49BCWGW0Pz8
         fV42wKrD4m7NjjN59cr/cZ+sfc+jIdmrAO/WA1Nbs9M/eomzbiRQ15jSyUQ6AsFtkb6d
         qImhg6ibpe3RcYDOx4i8j+f7Ydhv3wdQ6Gcbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEYEWsL6AYbcFkTNzTHp7v10JIwWkeD8uKj1umSmXwA=;
        b=c4BypsO6/H55jQce2R7ut2ek3VQkUgzsmWNIrPPKxs4LmRw0OVLYg3jkaUBqdMA+oA
         lEsw8V0gsMd2kjClqXoUrvBKjJYYkq1/wTcrZGACcgwFkWymuiDxPFtHvXh0BbPIZ/1J
         7uvpR21W0tv8q4sQUQ7qcNxV/83h1cKfZb8lzhsN9gb2x0THOKSUKdQbk8AWLCDJh4WT
         bQNUqfT/FEkhFs6Z+2awUZl4pXxfednXB9VS50xRfJGAre4u4Bm/Xed6YDg/VSeSbdj9
         FxF670tMoqIasBcAb3n3npE1EFXtec+QMxcPKXoftQYDSNCsCIlFwXTNXwwOjn5HLvEb
         hvZQ==
X-Gm-Message-State: AOAM533T75MrFrIjy/ClIe5FE3G+oXRmKpUxd7FaujAhwnouIIGxRwKO
        D26en5CffrX46cLCnv0dGhBzfoU0jOHw64xI
X-Google-Smtp-Source: ABdhPJxRRnBsIhmpfjUphS7yeu7F1gK5XEGz5h522ECaXmG6IMKTmUbD061DCZkyIyNCCVY1CMK//g==
X-Received: by 2002:a2e:9a8a:: with SMTP id p10mr1971593lji.221.1624934961640;
        Mon, 28 Jun 2021 19:49:21 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id h25sm1354768lfe.284.2021.06.28.19.49.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 19:49:20 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id u20so3150256ljo.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 19:49:20 -0700 (PDT)
X-Received: by 2002:a2e:a276:: with SMTP id k22mr1919160ljm.465.1624934959943;
 Mon, 28 Jun 2021 19:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <202106281231.E99B92BB13@keescook>
In-Reply-To: <202106281231.E99B92BB13@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jun 2021 19:49:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
Message-ID: <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <morbo@google.com>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:32 PM Kees Cook <keescook@chromium.org> wrote:
>
> The big addition for this merge window is the core support for Clang's
> Profile Guided Optimization, which lets Clang build the kernel for
> improved performance when running specific kernel workloads. This
> currently covers only vmlinux, but module support is under active
> development. (Sami Tolvanen, Bill Wendling, Kees Cook, Jarmo Tiitto,
> Lukas Bulwahn)

Am I misreading this?

The PGO data seems to be done by using clang instrumentation, instead
of done sanely using sample data from a regular "perf" run?

That odd decision seems to not be documented anywhere, and it seems
odd and counter-productive, and causes all that odd special buffer
handling and that vmlinux.profraw file etc.

And it causes the kernel to be bigger and run slower.

The actual link to the clang pgo documentation even says that there is
already support for converting regular "perf" profile output to pgo
data, yet that model isn't actually used even though it appears vastly
superior.

Why use an inferior compiler instructmentation profile when we have
the much better tools?

                  Linus
