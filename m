Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF540EDD9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbhIPX2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbhIPX2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:28:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E8FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:26:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i25so25308482lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGW+TlqgmksvmhUEkFUHjtdzrHaBOdCApfV4N+CESfA=;
        b=iI1AB/uL5IKlwdLyO2RhbtZpmeHcOT7OX2ULVresTNDmhDk7gIub2LhVdRwBJcqLMh
         XiglApUPu0QaUlAIg3Y2Q/B/XfDAWJ8EwWq/x9pDJoySoMsCcG1PLPPEwJRItLFqgtgQ
         2Dcn6u5gso9HAm1IiaNkjCw2h+gSWvm1yETAxzuvKVvRKvBesxAXQPH05FjTvDbqoBQi
         jTRMpZzbRCe5EFJzplvt/uT9gKTFvtzpxBIst9k02ZJqRz1bTgiXUCmAmTDQcY7ULtdK
         rA814LQ1TmQI9v8bQ9U8FKSz+S8nc7jTfWmUqkuX1d1CjzocsbFRpFebjHhR+wPM8vxS
         P1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGW+TlqgmksvmhUEkFUHjtdzrHaBOdCApfV4N+CESfA=;
        b=cfCKqmUodm+XPfOse+/qmtpBfGmz2nEUpQFH58Yh0mPcX0kLg4o1b/5q/khMDvm2Ub
         vTUPyfAhZFWb2XwAmntQs2fIszmwIpvmeTRxmfHI8V/60E9L+fo6bBriqYxeIsW7/2Ic
         mcTzFgurKWobMtFcRPKdYb4qLTbeMgb+WJaLGdwBnfrzserOxnyLVGxSv5df9XNP6VyL
         /KfGu3ZdS0B1NjINhiaEdSxyfFnD/iw61xhpEr3G2lkp2r5h8G7f64lIJEUlcC/+XroR
         dH8NiwP8liOCQgQxmrDkHJ1r6mufVZCQKv2DZNho+6qjsSU060usV48gowXUy51Ps4of
         3fgw==
X-Gm-Message-State: AOAM530x0qEYegiqiNg1Dj3VszSZB5XSJyG+C2ZdBNcVUP7M0i5qwsRt
        IfeudHWRxCDrT6sIIHbpbx5/wADtBcRr3y/U72qg5g==
X-Google-Smtp-Source: ABdhPJy1ZYuYhqdlBzLoZg+vMF2Sg/WTKkh6TEdBxkvxcWnSTiA4cw7O+M0iwQlNphJQppOLamlPKpz35Q1eonR6kwE=
X-Received: by 2002:a05:6512:3b9e:: with SMTP id g30mr5707949lfv.651.1631834815384;
 Thu, 16 Sep 2021 16:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210830213846.2609349-1-ndesaulniers@google.com> <CACRpkdap==EPZpAggMmd0XN1J-DwK=OQu3oGn-V=zPOaq5XnHw@mail.gmail.com>
In-Reply-To: <CACRpkdap==EPZpAggMmd0XN1J-DwK=OQu3oGn-V=zPOaq5XnHw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 16 Sep 2021 16:26:44 -0700
Message-ID: <CAKwvOdmmrxs2eMqvUm+Zg6Lpin+9BoQRPh9CF3Tdnc-+9eeQSw@mail.gmail.com>
Subject: Re: [PATCH] ARM: select HAVE_FUTEX_CMPXCHG
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 3:40 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Aug 30, 2021 at 11:38 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>
> > tglx notes:
> >   This function [futex_detect_cmpxchg] is only needed when an
> >   architecture has to runtime discover whether the CPU supports it or
> >   not.  ARM has unconditional support for this, so the obvious thing to
> >   do is the below.
> >
> > Fixes linkage failure from Clang randconfigs:
> > kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> > and boot failures for CONFIG_THUMB2_KERNEL.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/325
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> LGTM
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please put this into Russell's patch tracker!

Done!
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9122/1
Thanks for the review!

-- 
Thanks,
~Nick Desaulniers
