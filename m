Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3023BA3ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 20:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhGBScR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 14:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 14:32:16 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E179C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 11:29:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u25so14475091ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uke8QP8jDT0ISFCLZ021BNSpKYLqzZN1MQPfd1lmORs=;
        b=Go8dlU4pYH27zAulQl0JEeWem+aLHmXx6lAAGJ5RX5Th1L0JIkmbQVShEOdiuVEDNe
         w5McMXyT7OkESj6bjNOMryjuUhU2GQF+fPvFWY1eHUaIvxmaNLXDsD/pbV7HRZAgw30w
         y6+fbNTxPudDQKN5uoia56HylE+fS2vPHOr9iOOoKN1rpFYdxoM4U5gNOZ2ze+F3C4v3
         9uC36SUCTgF+fD9Pkiz1s1vxUBCuIxF6x87F2z2W3jLZQjRdBrfV+Rw4pt6Tme03aX9E
         rH8yBm5gt/MbY1wQbj8f3CFMaWe8B6zwgsv7SVQybImoBY3Qtq2/TrhFk/xWza2nK/Mr
         pQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uke8QP8jDT0ISFCLZ021BNSpKYLqzZN1MQPfd1lmORs=;
        b=oftC4BgOPJWGwnDWTh8TAjFjQMaTAIlwmI/aTlyzWHfwqadQsliuLmssqSpcu/o1yi
         u2M6BZAgkpY9f5CerlJmhhvciOFaWvO1gIsje9Ja+5VaI7l7qkJJ6TcwgRpWS5+0meui
         A4RWcPVCPwlitg7L08qUmFZTrRAEi3EPQVVzp9AJe6mjCyOq6W0NplvL4+9l2chuo8sL
         QrYTWH9dce5FtB+kickNjIIh6nuhNN0JH7X1veYJdYW6annDqH+3LKjUAWvmMXwc5IGZ
         Bp9GpxPq6ZAqoRvDDOfrpHx9S0bot3nWkWSSaD/g/pM/Vran4FBSDhM/B9RpJWztReSR
         xRlg==
X-Gm-Message-State: AOAM532j99zo5rA2OSpOaeuCHQpyxPK3wCRLOEOOpHZ3DwztVIh1dtFi
        vldFB6rdk39JydJkSxwy/Kj5A1+kbyvOt3dpeVoiwQ==
X-Google-Smtp-Source: ABdhPJxo8xGnK3pq7PzatyX9aih8j04svJoEYfDiTkNvI1T83vRxvgJmwble7AKeQKXSG9W6O1uph3cP81m14NAYgdI=
X-Received: by 2002:a2e:5c03:: with SMTP id q3mr574881ljb.233.1625250582245;
 Fri, 02 Jul 2021 11:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210701235505.1792711-1-ndesaulniers@google.com> <CAK8P3a1EfBNxaMbsp+s2BiYHGKPK4NeRR+ugM82jfY43Pq7-Uw@mail.gmail.com>
In-Reply-To: <CAK8P3a1EfBNxaMbsp+s2BiYHGKPK4NeRR+ugM82jfY43Pq7-Uw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 2 Jul 2021 11:29:31 -0700
Message-ID: <CAKwvOdkgEeQktLgEN7CAh7bTjTN+TQNE27aETgvbXep9=xb1DQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: drop CROSS_COMPILE for LLVM=1 LLVM_IAS=1
To:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 4:59 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Jul 2, 2021 at 1:55 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > +ifneq ($(LLVM),)
> > +ifneq ($(LLVM_IAS),)
> > +ifeq ($(CROSS_COMPILE),)
> > +CLANG_TARGET   :=--target=aarch64-linux
> > +CLANG_FLAGS    += $(CLANG_TARGET)
> > +KBUILD_CFLAGS  += $(CLANG_TARGET)
> > +KBUILD_AFLAGS  += $(CLANG_TARGET)
> > +endif
> > +endif
> > +endif
>
> I think only the "CLANG_TARGET   :=--target=aarch64-linux" line should
> go into the
> per-architecture Makefile. It doesn't hurt to just set that
> unconditionally here,
> and then change the CLANG_FLAGS logic in the top-level Makefile to use this
> in place of $(notdir $(CROSS_COMPILE:%-=%)).

I don't think we can do that. Based on the order the arch/ specific
Makefiles are included, if we don't eagerly add --target to the
KBUILD_{C|A}FLAGS, then cc-option, as-option, and as-instr macros
(defined in scripts/Makefile.compiler) checks in per arch/ Makefiles
may fail erroneously because --target was not set for
KBUILD_{C|A}FLAGS yet.

Another issue is the order of operations between the top level
Makefile and the per arch/ Makefiles.  The `notdir` block you
reference occurs earlier than the per-arch includes:

 609 TENTATIVE_CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
...
 648 include $(srctree)/arch/$(SRCARCH)/Makefile

We would need the opposite order to do what you describe. Reordering
these would effectively be a revert of
commit ae6b289a3789 ("kbuild: Set KBUILD_CFLAGS before incl. arch Makefile")
which I'm not sure we want to do.  But maybe there's another way I'm
not seeing yet?
-- 
Thanks,
~Nick Desaulniers
