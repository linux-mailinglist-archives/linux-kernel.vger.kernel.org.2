Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8E3E06EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhHDRtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbhHDRtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:49:15 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F1CC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 10:49:01 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id f11so3370126ioj.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1tRU+J2S/v/0zLqyOv0CCFlndM1M4TGM5gcBC/vm+0=;
        b=GlX1ALSN4f0vfkJKqRqMbUQdHO26ZIndx1otBchxqB0ghfcbd/ry7GBXKjawh6LIWZ
         Y0LKv9YvdxMIgm1GutrA9vPOZa5j/4p8NgRRIbIJN6msB9MAuL/wQe5+Zw8C6+z9ORfY
         ty1MSG2iCzaqyjZGoBNO1NYtP7B8+EHT1kwAUHg8xoEHFud5ADLTiLHbQwkfkX5v6jZs
         lUIEK7fGCNTvXmfHyxkgdQyGiJAZZJb5xwel+GZdPmdx/Ztv4vPhsdD3IKLw6nziYcbD
         ZWSLgbvd1TPx6+4jpiYu7kBGAX+VE3BKRpNqhExlThdUF63MjNN0VHzKzHvG9PceVPoY
         cUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1tRU+J2S/v/0zLqyOv0CCFlndM1M4TGM5gcBC/vm+0=;
        b=bkQ3Aff0/yvL3oSNyI4sZOZhr+ul0Bil/gHi/8HWiG8pNEDiQ8vg4k329wBm7qsmmz
         0OcE3jyeGRaAWf7OOMzGF9mnOD9c0EX3Yc8i6qvdMPoVmWuyGc1Fyspv2H42jQbtS48R
         JsC4GPqhsZ9tmeNV6tLyAt06OeqOU3fBLknVdHsWY0XqxTf/R/zIWl/NcV6JkQnxp0SS
         ziKy9onRY6h5cKbrK4aaTg0nGnF+h5G25XOBI5L13eutAAapZExCuKo9fHJMIstLylr6
         FzKBAcLhO5vMivePf5RHX9VLOjpAub8z3Y2J1jvVcDYjn8HjiHfTtKRdxJ4AWd5cUN43
         vQtA==
X-Gm-Message-State: AOAM533hgzgOIIu+4I7znc/ObfIk/jqpKW1QojzqPMaLhSlx5/eGl/kP
        PNuNfx9+hpagEb+Mup9laNczagXcxw0nKTFEjN2UO2hl
X-Google-Smtp-Source: ABdhPJxf/QWvlhpFK2bjBaeO5A6mZubKIwn02+vAWFzWu5gkqKjxoSMx71k0MjxdNXr+proX/TRhnN+3Q1HHYIBEWmc=
X-Received: by 2002:a05:6602:2bc9:: with SMTP id s9mr445272iov.64.1628099340837;
 Wed, 04 Aug 2021 10:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210802202326.1817503-1-ndesaulniers@google.com>
 <1847b77a-093a-ce59-5c3b-1a21d3bb66c7@kernel.org> <CAKwvOd=F_OexmHctcW6x7d6up8+zOb5-iLWU9-Ji1dv9-S3F+A@mail.gmail.com>
In-Reply-To: <CAKwvOd=F_OexmHctcW6x7d6up8+zOb5-iLWU9-Ji1dv9-S3F+A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 Aug 2021 19:48:49 +0200
Message-ID: <CANiq72mGnjy50kd4gMrOsWwmnM3YFp01qO5JzSyZyPGwCL0CwA@mail.gmail.com>
Subject: Re: [PATCH v2] compiler_attributes.h: move __compiletime_{error|warning}
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 7:44 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Ah, I forgot the release/13.x branch was cut before I sent this.  I'd
> rather this feature "ride the trains" so that it gets more soak time.
>
> Miguel, would you like a v3 updating the comment above (and the
> comment below) to s/13.0/14.0/g, or can you simply fold that change
> into this one when applying it?

I can do the replacements on my side, no worries!

Cheers,
Miguel
