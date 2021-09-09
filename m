Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3274048D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhIILBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234349AbhIILBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:01:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55ED561167
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631185243;
        bh=q0jaemKaNpxivtuHJVN3sxGi68MjVqL99mYlZXXeAZI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hHJKoNgkH8/igA8mIRS3lIuUeTLXcTZC+1DSY6sOpt50Cc3WpwUTvTnh/1FPRRi8r
         0Vs7f5vHfPoSG+fzyOuQDSrOnhcMNDF8ii4p0MHgdNIXgvwypuYO5MY8dXdOhWgNJO
         l41W2CHOYhIN7rTDJmhNdndV8iDc0k+71EnPXb4Hkxztk3ElYZlZZxS90P/9j7eX1A
         MTYrG7IPALgtwsZEPstcM/v9XSp1C68Dl2rC+4P4ZfEIaVaRPKNHRQHlovAPeodguH
         xTNQKbeXBfcqmwbLhkZj73EII8d3PTV+SM+lRFKaQxWFUDb4OD+t6maZjm1zDAHEBj
         FX9aW8KR4x/wA==
Received: by mail-wm1-f49.google.com with SMTP id i3so1045093wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 04:00:43 -0700 (PDT)
X-Gm-Message-State: AOAM5316EIB/ZjuEfIfWmpRJfFgVOj52tlNP1WFPbd139WzW7N1H8VNy
        Blj4bbH1VrZ26eY3Og5xjEfyDwIVYDf+2uEdDjA=
X-Google-Smtp-Source: ABdhPJzXwyBVTWsO83az+CnqYKTmuJ+96XVP1jSzK/fPZCcrRA2zux6YoBG2oM4L6KntsYaUUUA2GKpxx8IgphoRzAg=
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr2344349wmf.82.1631185241984;
 Thu, 09 Sep 2021 04:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain> <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161> <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org> <CANpmjNNCVu8uyn=8=5_8rLeKM5t3h7-KzVg1aCJASxF8u_6tEQ@mail.gmail.com>
In-Reply-To: <CANpmjNNCVu8uyn=8=5_8rLeKM5t3h7-KzVg1aCJASxF8u_6tEQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 9 Sep 2021 13:00:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1W-13f-qCykaaAiXAr+P_F+VhjsU-9Uu=kTPUeB4b26Q@mail.gmail.com>
Message-ID: <CAK8P3a1W-13f-qCykaaAiXAr+P_F+VhjsU-9Uu=kTPUeB4b26Q@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Marco Elver <elver@google.com>
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

On Thu, Sep 9, 2021 at 12:54 PM Marco Elver <elver@google.com> wrote:
> On Thu, 9 Sept 2021 at 07:59, Christoph Hellwig <hch@infradead.org> wrote:
> > On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
> > > It'd be good to avoid. It has helped uncover build issues with KASAN in
> > > the past. Or at least make it dependent on the problematic architecture.
> > > For example if arm is a problem, something like this:
> >
> > I'm also seeing quite a few stack size warnings with KASAN on x86_64
> > without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
> > few warnings without KASAN, but with KASAN there are a lot more.
> > I'll try to find some time to dig into them.
>
> Right, this reminded me that we actually at least double the real
> stack size for KASAN builds, because it inherently requires more stack
> space. I think we need Wframe-larger-than to match that, otherwise
> we'll just keep having this problem:
>
> https://lkml.kernel.org/r/20210909104925.809674-1-elver@google.com

The problem with this is that it completely defeats the point of the
stack size warnings in allmodconfig kernels when they have KASAN
enabled and end up missing obvious code bugs in drivers that put
large structures on the stack. Let's not go there.

        Arnd
