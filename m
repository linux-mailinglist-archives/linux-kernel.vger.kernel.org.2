Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C3404DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348106AbhIIMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 08:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbhIIL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:59:31 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F7C08C5DA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:43:57 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v2so2093592oie.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ge0i4MysJLg7UB+Yx2AaDOSBAP1whBCQ4nJVOdEAFfQ=;
        b=AM0acIeRzwZOQ8ps3Z56Nt2NWs6+nlhrzsKcVFwKMDqqa7rDx5eL5KDD0h/BaJoTnn
         Yyyxu9wJG75huSLycWf8IDuT7DT0EULGp5e0DvypWYxR9B4SQfPU5j8Fn4XhfFEruwLE
         ClKvJyFIvmnV6Km2XZLLKRVpzmuk+CmtA15esdDv1bDunZyDxFsQlEfitpESUQeSYFJp
         8BTH19cQVldl2Q/Q/K063Hrw0iJTbEvdUS66oLsCqTbhNgBAq0kgnGI6EB+sd5gWro4q
         6u6ZSKDtWZTSrF4AorelJKBZfPAQkJjHlymjU+m1V7QiieTyxzEwYQ0qxBYlDgPTQOni
         8v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ge0i4MysJLg7UB+Yx2AaDOSBAP1whBCQ4nJVOdEAFfQ=;
        b=IstbKthFiozsiYweiVFQ+GoFKBqf8G+qmmJ4OvBi9qT4LhOzTMBwBcKUxNTLtRpkEO
         rk3rEqce15oeAH8VOM/TAMjPsJcAczqrqi463q6zpB1/vel6Q53dQQSxkEgc5ElsbJJH
         OOEXy2aezi+AITcJhX+ebobuRFl4Yotu/ROM0hLyh0o9aeWWYFQZQsmGQoB7kI21oSo9
         WljEj6ayNcqEyksQuMM+us3vSCACIGGK3BQQeMNx4QklYEBfhtcBxrG7VnFZZ1C+0MyB
         +1kqF1KQt7s/Xiv77YPEferZulF0opgjoWPpbBSUPcQupyaxDO2oDNrof0SJonj1XhUT
         kiGg==
X-Gm-Message-State: AOAM531Pv5TDeJwxVIZLrOFRHoR0J1vDi/mpUsKoR7kzjGjBltnP2/a8
        18UUk9zJwJe4RcgZoi0XX2g3lXswbJFjOLM3kAdA4A==
X-Google-Smtp-Source: ABdhPJz4Mhm5+vx6TwV+94c8TrEoyJnBnwuFZl9zQWVxFkMW7/1ms65QTzG16fCfVI4XNFxP1+08u3vCaxDOvTe4liM=
X-Received: by 2002:aca:4344:: with SMTP id q65mr1645122oia.70.1631187836164;
 Thu, 09 Sep 2021 04:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain> <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161> <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
 <CANpmjNNCVu8uyn=8=5_8rLeKM5t3h7-KzVg1aCJASxF8u_6tEQ@mail.gmail.com> <CAK8P3a1W-13f-qCykaaAiXAr+P_F+VhjsU-9Uu=kTPUeB4b26Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1W-13f-qCykaaAiXAr+P_F+VhjsU-9Uu=kTPUeB4b26Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Sep 2021 13:43:44 +0200
Message-ID: <CANpmjNPBdx4b7bp=reNJPMzSNetdyrk+503_1LLoxNMYwUhSHg@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sept 2021 at 13:00, Arnd Bergmann <arnd@kernel.org> wrote:
> On Thu, Sep 9, 2021 at 12:54 PM Marco Elver <elver@google.com> wrote:
> > On Thu, 9 Sept 2021 at 07:59, Christoph Hellwig <hch@infradead.org> wrote:
> > > On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
> > > > It'd be good to avoid. It has helped uncover build issues with KASAN in
> > > > the past. Or at least make it dependent on the problematic architecture.
> > > > For example if arm is a problem, something like this:
> > >
> > > I'm also seeing quite a few stack size warnings with KASAN on x86_64
> > > without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
> > > few warnings without KASAN, but with KASAN there are a lot more.
> > > I'll try to find some time to dig into them.
> >
> > Right, this reminded me that we actually at least double the real
> > stack size for KASAN builds, because it inherently requires more stack
> > space. I think we need Wframe-larger-than to match that, otherwise
> > we'll just keep having this problem:
> >
> > https://lkml.kernel.org/r/20210909104925.809674-1-elver@google.com
>
> The problem with this is that it completely defeats the point of the
> stack size warnings in allmodconfig kernels when they have KASAN
> enabled and end up missing obvious code bugs in drivers that put
> large structures on the stack. Let's not go there.

Sure, but the reality is that the real stack size is already doubled
for KASAN. And that should be reflected in Wframe-larger-than.

Either that, or we just have to live with the occasional warning (that
is likely benign). But with WERROR we're now forced to make the
defaults as sane as possible. If the worry is allmodconfig, maybe we
do have to make KASAN dependent on !COMPILE_TEST, even though that's
not great either because it has caught real issues in the past (it'll
also mean doing the same for all other instrumentation-based tools,
like KCSAN, UBSAN, etc.).
