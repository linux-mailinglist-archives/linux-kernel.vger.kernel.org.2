Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0BE3D5441
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhGZGsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:48:53 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:37768 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhGZGsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:48:52 -0400
Received: by mail-ua1-f46.google.com with SMTP id w11so3190505uar.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NG27AyXXZCjyF9qPFwESDtcNxflCSnT0u4Wh1DD8tKI=;
        b=WB7HK/3b5iwhkFEPtgHKIxRD9fUqveHGRHsk8D7kFJok3FUnETILrALdJXPXDsl3Rf
         X3aVEcrr+VUGqwqCGJjERChGiV6uadUqd73cxVCP9xzkvQgCD5I6FYoiJIN6HR41wHAZ
         SGqKIvQqqPKqHO+o07YiJlJ2Wxzd327VSHvFSZFoCEMrQqI9ogUGfD4XQyFDGky02j6b
         gn1ADOF73qiJnFoDEWLybDlJNhlszjFlZgyK8tPRdzvL/tPu446YyLiUHw1jbix/VPAA
         9F+RTHVWgbIQEhfVOk+xh5ildKCa/859fqEZpB7jNMCV3B6WwBP2speta+Nskygk3zVx
         ZSXA==
X-Gm-Message-State: AOAM5314c1s2SPDm27xICQCJ0dIfDNcoQYZIG0A5n+L2Wv/aWWkb7u/I
        q0DWW0mZ3eEkGoJCEXYZR6vrLiuPJ/7OHS0dJQ0=
X-Google-Smtp-Source: ABdhPJxLD4ikNVv07En0vqEiq9snN7hRwnpHZdlIycaLnBHc8MiULtoCWq/tCZCRcWxDgsRkki9Dc9AF3qfRocp1KNE=
X-Received: by 2002:ab0:6710:: with SMTP id q16mr11373970uam.106.1627284561331;
 Mon, 26 Jul 2021 00:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210725104618.365790-1-geert@linux-m68k.org> <87r1fm4gkc.fsf@igel.home>
In-Reply-To: <87r1fm4gkc.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Jul 2021 09:29:10 +0200
Message-ID: <CAMuHMdVbZtnOMsc0p84bTX5RJXeYN-hcW4=W0En04nf_b1WKGw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix asm register constraints for atomic ops
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Greg Ungerer <gerg@uclinux.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Sun, Jul 25, 2021 at 4:24 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Jul 25 2021, Geert Uytterhoeven wrote:
> > Depending on register assignment by the compiler:
> >
> >     {standard input}:3084: Error: operands mismatch -- statement `andl %a1,%d1' ignored
> >     {standard input}:3145: Error: operands mismatch -- statement `orl %a1,%d1' ignored
> >     {standard input}:3195: Error: operands mismatch -- statement `eorl %a1,%d1' ignored
> >
> > Indeed, the first operand must not be an address register.  Fix this by
> > adjusting the register constraint from "g" (general purpose register) to
> > "d" (data register).
>
> You should also allow immediate ("i").

Good point.

> There is the ASM_DI macro for that, but since CONFIG_RMW_INSNS is never
> defined for CONFIG_COLDFIRE, it probably doesn't matter.

As the second operand is a register, not memory, there is no need to
use ASM_DI, and "di" should be fine, right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
