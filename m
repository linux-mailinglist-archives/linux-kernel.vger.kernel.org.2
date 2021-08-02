Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24AC3DE14B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhHBVPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhHBVPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:15:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C43C061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:15:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z2so36229196lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GKUZPtIuouVJE0jwShWzFKLTFn+mFU5OXAbT55ufFlc=;
        b=fQuUBXMnnlpnfqCWTtEkIebNSJjuLUVgQ0uhLBdkGzjQX0N0tWgTLp0Q0a2yKPPqyL
         7KFWoHkgXe6tGzcbTB8muuCTZFEQK/GIcefAf+QjAXwdOLduUf22Vi4p60yER5qpovK5
         DNt9sTIQb8/XS0/4AaxlIsDS5jqrtl9r6HmXo3aELgcqV4oqvv3SF02F7buHq5iYFAw6
         x2fckS4Xaog5wbncCflDQ6Smifq1gD1IjCiPitqvUlQp8MsZ9Bwm0y6BhVr0qX85oIBT
         kR+AfAN4uWAlXTjv6WE5yNWqHtGsC1oCrdh+YCobrZ+i+4F2vBCvn9FHyHhaIRD+wjSN
         x/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GKUZPtIuouVJE0jwShWzFKLTFn+mFU5OXAbT55ufFlc=;
        b=MPk0kw0cI3K8zruiOdyy4S8XeT4EGYfuFOp6/kU/O2aG58Keb12a81LhtmiMHzw18V
         acD/01bd7QYyw6etGYzwwXILt+XdPB60fxM0onI62EjrRvudwb9oASmERJPPJlBa05xn
         /cT8agM/JrOCoB0zefb10tUb4uxT3xkm99dXDEzdq7DRVGrwznJApXwNh5MjgyRa39Ya
         qWdCLx0yFvI/ekR1oGJTXOIS2n4lR0Hbd1zAmN7YbJjRxLYuxPELwHfi7dt5DQ9Jgtz8
         C7Y30c4rKghCB/N+5myqc9cbyo/62b7354DlmDcNmpdRAzYfhDq3aJc0a5yARtDS/l1D
         2+bw==
X-Gm-Message-State: AOAM533kR5Non4L4BzSva/hNPebcug+8pinInW6uIrGzpTaKuDKDR+kt
        0nwPKIL5WQrvflzROHwdwWT+xYFiJ2Qev6JkyeIcMw==
X-Google-Smtp-Source: ABdhPJzMk2ixr8LoBUa9C8T3a04USJp3cZ17Uq+IBX1hQrK7WrsTSKqCwwpg7ZEEmwZdrbrnqjcCLBoHZ6i+/DTWCp0=
X-Received: by 2002:a05:6512:3041:: with SMTP id b1mr1255638lfb.122.1627938907382;
 Mon, 02 Aug 2021 14:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210802183910.1802120-1-ndesaulniers@google.com>
 <20210802183910.1802120-2-ndesaulniers@google.com> <CAFP8O3Jc=iwzAQojgBZZzdT8iVBY9TO6GLTq+0vkXoo6L5JJ-A@mail.gmail.com>
In-Reply-To: <CAFP8O3Jc=iwzAQojgBZZzdT8iVBY9TO6GLTq+0vkXoo6L5JJ-A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Aug 2021 14:14:55 -0700
Message-ID: <CAKwvOdkSzuMpjwP=_vPfs0QFAytA9=fZ00Aw4dn8fk7=P5WhLA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] Makefile: move initial clang flag handling into scripts/Makefile.clang
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 2:06 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@google=
.com> wrote:
>
> On Mon, Aug 2, 2021 at 11:39 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > new file mode 100644
> > index 000000000000..297932e973d4
> > --- /dev/null
> > +++ b/scripts/Makefile.clang
> > @@ -0,0 +1,14 @@
> > +ifneq ($(CROSS_COMPILE),)
> > +CLANG_FLAGS    +=3D --target=3D$(notdir $(CROSS_COMPILE:%-=3D%))
> > +endif
> > +ifeq ($(LLVM_IAS),1)
> > +CLANG_FLAGS    +=3D -integrated-as
>
> -i* options are for includes. -fintegrated-as is the canonical spelling.
> Since -fintegrated-as is the default (for most llvm/lib/Target/
> targets and the ones clang builds actually support),
> it can even be deleted.

It was made explicit by Masahiro in
git.kernel.org/linus/ba64beb17493a4bfec563100c86a462a15926f24
So I don't think we need to go back to the implicit default.

It's definitely nicer to use groupings rather than these raw prefixed
flags IMO.  If you sent a patch for that I would approve of it.
Otherwise we don't really need to change this as this is how it's
worked in LLVM for as long as we've been able to build the kernel with
LLVM.
--=20
Thanks,
~Nick Desaulniers
