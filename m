Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7FE3FF337
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbhIBS1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbhIBS1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:27:21 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE6C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:26:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c8so6342824lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bAI7/az5oT+9KLtJNJ6ONhWWEIRpA4hVYuz5o04UH4=;
        b=ZD0GazsyXaKAE96usk6ZiM6fZMzpsBZXxt2XIZQMBQTwYc7rabtbOqix7wSgzZMy+O
         b0iV4pQ7nDEPJ7iYprW5c8Lfq/kIHiDHUhYEe4K0BNrd4gdaFQJSN7lVX0fE2nviICar
         jAfbRnuvj+TzW75phO6P9+PgaKxNrRZT66VLpiXCOxgMEZk+BnROQ15MUKZ444ST/k82
         OdoQSi2TfLTuzTUJa4gnySH5YkgMzXN3wpJedBb9z4GPYoqeJK+6cqhaRzUMLG+QbHjX
         2pMMPSY9P7TJsGwKvweMkTRcSyMNXzbXjutFgVF/fTiioa2V1owoGrL+CNy4aGMlmzcM
         Ye8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bAI7/az5oT+9KLtJNJ6ONhWWEIRpA4hVYuz5o04UH4=;
        b=HwqHinNtQrQSRYpvTrvI04UvbfGZsnk52EAHnQQD+2C046FfFs3Ar1tVnCG2xh7191
         tK+ZoUyUuQ26EOma8XdjolElLPq2pKzjnh8ywIbHkoWbw6tjzymYl0dm/2nGzg6sK3Ht
         I+BdOJ2+FPyj/dCILgOeeo6wSLll3dRt6irzCk9n1WEN4PoHwGOTnKTcBMms1zffZHse
         SjLg2eFHZVyvg9p2TrvP+x1QGPjF4kRGxkqbxRbCBgdFs033vKMCWiZE68RIVdF6TZ+i
         DV5fHib8EmZs4xuoHC1hKVcU99Nh3AE+l6VlcyYdzjfHn+S5HtSGi1H5YE99LFIKcIUV
         psmA==
X-Gm-Message-State: AOAM533pKDFSpzmwiaqUr0ARTjtAbo8sXmAL2XjFySQwBWgVHleggK8L
        7wAnLygMMrpZ1fcc2+vn8k/PQxCBpWqAGHJjpqWS4w==
X-Google-Smtp-Source: ABdhPJyjbxaJGgSIw3DkIXztNQJAtxmD0CuTFGEm/cPzhaonnrRIe1uMJSblQgOl3AJZwIsWsfxYto+l4TI35MaWEfU=
X-Received: by 2002:a05:6512:2296:: with SMTP id f22mr3517156lfu.547.1630607180568;
 Thu, 02 Sep 2021 11:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210802202326.1817503-1-ndesaulniers@google.com>
 <1847b77a-093a-ce59-5c3b-1a21d3bb66c7@kernel.org> <CAKwvOd=F_OexmHctcW6x7d6up8+zOb5-iLWU9-Ji1dv9-S3F+A@mail.gmail.com>
 <CANiq72mGnjy50kd4gMrOsWwmnM3YFp01qO5JzSyZyPGwCL0CwA@mail.gmail.com>
In-Reply-To: <CANiq72mGnjy50kd4gMrOsWwmnM3YFp01qO5JzSyZyPGwCL0CwA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Sep 2021 11:26:09 -0700
Message-ID: <CAKwvOd=e1jrzsW=-KFBdw2f3Q-ewZhRJ=rRCgYhDwJCrQo0efw@mail.gmail.com>
Subject: Re: [PATCH v2] compiler_attributes.h: move __compiletime_{error|warning}
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Wed, Aug 4, 2021 at 10:49 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Aug 4, 2021 at 7:44 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Ah, I forgot the release/13.x branch was cut before I sent this.  I'd
> > rather this feature "ride the trains" so that it gets more soak time.
> >
> > Miguel, would you like a v3 updating the comment above (and the
> > comment below) to s/13.0/14.0/g, or can you simply fold that change
> > into this one when applying it?
>
> I can do the replacements on my side, no worries!

Bump, this has landed in llvm 14 (so needs a fixup when applying locally).
-- 
Thanks,
~Nick Desaulniers
