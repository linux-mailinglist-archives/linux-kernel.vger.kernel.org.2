Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1097A38D7D6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 01:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhEVXwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 19:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhEVXwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 19:52:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286EDC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 16:51:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b17so27671305ede.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDYOCCf0w8h4trbY4PGM+YEr9dD9IiV0gScwVLCiGbY=;
        b=sh2wWvHDR9RjP0eqozl0HjnUgLSzS4G8MXsvMGTcS0yR7NZ91JPf+yJBouE1C/i8c5
         W8jkLF0Sxl5mBz5OIlWmSlgKKUhsYRF8uLTQMJ8Uurs/R9hZ3ZqqIia4aKMTfJrsZxCv
         IBt9TQGANbV1pCVR0liXlWqnUSq0rqu12SjqFNgyRgvA7VQ3Aad9Jx2QF3MQYBUdE53h
         SnddjqpKaJLL7ciqGxGiFqJxruwcF1fsE07aV/VpyHs8o9KNPEFP4GH08zySaQfVvcVk
         wPebyxLIpaGIyWIOujE8knbgQzbjd4A2yVD5BA/cqQjtmN58zLCqGCeiiCEVeGYnK+Bu
         CEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDYOCCf0w8h4trbY4PGM+YEr9dD9IiV0gScwVLCiGbY=;
        b=UO0nlmz/HBymxMwtEbehxuW9QaXT2KQWSYeP4FyyV5EVWUENsDp6T1E8W/BNl+VeY1
         gfxzE4fxuRNC2HPGJWf58HaYDkZ81lYNyXQ2S/EkEd91yj9mJtX9Ltpa00a7V6dLUL+T
         s3dhZxVJzhZHuIGfe2hNSA3x1yq2DiKTgp23nEnjWqp6W2jAC+2zNopub35qIZ1P4boJ
         0aO9sGenyP9TqIS9Ur+tiOPVXRuCFj2X9jHwb5/8oJShkws4WuaV4y9kLyTs1cdzXJGi
         S6GQZ54EhFn12zfYeAXPLyG5kc2iiK83DWepUaqVwj37c6LdNk/210OkeG+YC1f3W6k2
         yfjw==
X-Gm-Message-State: AOAM530eq7oG2tEAKAoQrJfT7oyf76NdpAEemTV3C56qiLa+98NiK1NJ
        EzkTr0Rke38/kGvspKIWaopsa8QkcwnGflMFBcy8
X-Google-Smtp-Source: ABdhPJym0f9zc3m+Iz9yqvvA8ZEDJcESzh33Fs5+ndzZSW0RbmVqYtnJbpkuVWYIWYsfgCQeq0NCNSulA6wlBF9Ln8Y=
X-Received: by 2002:a50:f689:: with SMTP id d9mr18289418edn.197.1621727473341;
 Sat, 22 May 2021 16:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210111081821.3041587-1-morbo@google.com> <20210407211704.367039-1-morbo@google.com>
 <202105191422.2E6748C4E0@keescook>
In-Reply-To: <202105191422.2E6748C4E0@keescook>
From:   Bill Wendling <morbo@google.com>
Date:   Sat, 22 May 2021 16:51:02 -0700
Message-ID: <CAGG=3QWJD3wDr=Eji-rMcD49Mi-SyP1Tn6B63qJFyi492YafNg@mail.gmail.com>
Subject: Re: [PATCH v9] pgo: add clang's Profile Guided Optimization infrastructure
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 2:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> I've added this to patch to my -next tree now:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/clang/pgo&id=e1af496cbe9b4517428601a4e44fee3602dd3c15
>
> Thanks!
> Kees Cook

Thank you!

-bw
