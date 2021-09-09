Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CCE404543
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350970AbhIIGBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350955AbhIIGBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:01:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C92C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 23:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=EmyOmO4OA1vu17LO++qu8IgyrFImV3HoLCHV1XeAKXU=; b=m7G+7uozvp+6qWoVstSpXJCgaX
        UPOdR2T7SaQtREbiqpM6Jcsh5kaHXhhj3aflDl5LkolWq3yc27aonGNNrXtPKCr4tb5Uy2lVEExDP
        8zROfQNLR6zByM+dZokX6WIBi3FnjaCUChyLZmAkNIbZzSLhZMXNaOZN9r0BEyYXJttayMFKqt15c
        OS2R1emd8XY987B+kWdUPOJYTR0OjotOItygDpYek33SuKTY8EcDJkR4XmQRXyunwghdk/0L/QExf
        +xJ7HG7FkmIFERFpzkFMIdCo35aQxb8lqtvvw2CRQKyytkhukTWgTJu/D/V+arn0kWKLJ6xwR32Fo
        WvKtaFUQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOD4f-009WcX-Hg; Thu, 09 Sep 2021 05:58:27 +0000
Date:   Thu, 9 Sep 2021 06:58:13 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com,
        Christian =?unknown-8bit?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <YTmidYBdchAv/vpS@infradead.org>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161>
 <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTkyIAevt7XOd+8j@elver.google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 11:58:56PM +0200, Marco Elver wrote:
> It'd be good to avoid. It has helped uncover build issues with KASAN in
> the past. Or at least make it dependent on the problematic architecture.
> For example if arm is a problem, something like this:

I'm also seeing quite a few stack size warnings with KASAN on x86_64
without COMPILT_TEST using gcc 10.2.1 from Debian.  In fact there are a
few warnings without KASAN, but with KASAN there are a lot more.
I'll try to find some time to dig into them.

While we're at it, with -Werror something like this is really futile:

drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: In function ‘amdgpu_bo_support_uswc’:
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:493:2: warning: #warning
Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thanks to write-combining [-Wcpp
  493 | #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
      |  ^~~~~~~
