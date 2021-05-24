Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF7238F5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhEXW6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXW6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:58:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95B4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:56:37 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k22so5025114ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cEafhBeggulCP4tVLid/0r5rCTxCDN0pAzRDdwpl0k=;
        b=rWYQ9s+sV0six3LsJ6FgGyEeC6A1jiy6gd0LOpZINvn3FFwju16v3Mpn6YIv+bSjkD
         oWc5qQwy0vcGx5szl0m7jN/7KSx50yeCjWoj0TKemqAUB5tc8CxtLm89gQhy1SE2drCl
         qeb2vLJgNdxM5KfXnZX6gc18n32R6ElqO8bn3EhBZoqpu9x8jAcLjUbKoCCp5GecLVf1
         KnCfTsR3FGp5qgMJ4lKMbz3t+PaZs8nbOhqPBco3w5Lv5kaQf+wDOF6oJgDvSrI1LT7T
         /jYxsm/vG4A34h6PpfOIShQ66pinC9qlaRsKhraKU7NiuFa0RaVWsvnExAE+VPgc3EF5
         7lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cEafhBeggulCP4tVLid/0r5rCTxCDN0pAzRDdwpl0k=;
        b=BnWqDDHnmShzyFLXljMv2sK1x1IYDVhZFWXy94+SE1Xo0CATscYDn4e8aScQdQW3aK
         EShSMu/D3T3oL/p41PWQMcFtKuGtB0khwSWChuvcgcpKuGCIQzdjXHXyOnjAoOBDIzD8
         gGAQBsQE4/FL+yQuLAyAd0bLOXYygoJnYCdZ4ecN6xZFxEgjtRfVG1qkZhXFeJb5nZ9k
         +oIocYTIt+wO3Qs8MDXIa/KshWoOT9Uiac/hg1coR+rOXOyHzoQRLiEZeG/SwbC/CeEP
         PictVCe93goMY99JNlfhvLwW88uUm8FTjbMQwX3pKmQ0nd9RBcgosWTjMw0ZEqVl9nH8
         3rRw==
X-Gm-Message-State: AOAM533y8c9FJr+Sy+1A1xdSUMSheVS5UtVyJxiTA7x3YVjlY7FTz+FB
        m/7LcPpT8J6BhJ8bx/VkmuSXzofWzERp0R8wol+aaOIUP8l1LQ==
X-Google-Smtp-Source: ABdhPJwA3j2s1nvFcmNzGnfTHr1OJMW9+cu8T2iGSpLJO8e3gM45CL3etkUmuWZW6zU5S2+IyG2y3fN2BXv8B38xsjs=
X-Received: by 2002:a6b:7714:: with SMTP id n20mr16097968iom.126.1621896996837;
 Mon, 24 May 2021 15:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210523001806.3927609-1-tpiepho@gmail.com> <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CAGS_qxoKTyNBxoezkEVVrACGsFuzJwteepVpDzp+4KH+CgbMsw@mail.gmail.com> <b5511f68-814b-1f8c-08d2-a7dbddce4e8d@infradead.org>
In-Reply-To: <b5511f68-814b-1f8c-08d2-a7dbddce4e8d@infradead.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 24 May 2021 15:56:25 -0700
Message-ID: <CAGS_qxrZAxvRD5Scvd-dMahnf-27npMjbzKKjG-+Bk7hZgZj5g@mail.gmail.com>
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Trent Piepho <tpiepho@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>, Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 3:04 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/24/21 9:55 AM, Daniel Latypov wrote:
> > diff --git a/lib/math/Kconfig b/lib/math/Kconfig
> > index f19bc9734fa7..20460b567493 100644
> > --- a/lib/math/Kconfig
> > +++ b/lib/math/Kconfig
> > @@ -15,3 +15,14 @@ config PRIME_NUMBERS
> >
> >  config RATIONAL
> >         bool
> > +
> > +config RATIONAL_KUNIT_TEST
> > +       tristate "KUnit test for rational number support" if !KUNIT_ALL_TESTS
> > +       # depends on KUNIT && RATIONAL  # this is how it should work, but
> > +       depends on KUNIT
> > +       select RATIONAL # I don't grok kconfig enough to know why this
>
> Only to set the symbol CONFIG_RATIONAL.
> Then when 'make' descends into the lib/math/ subdir and looks at its Makefile,
> it will decide to build the binary rational.o.
>
> obj-$(CONFIG_RATIONAL)          += rational.o
>

Ack, I understand that much.

My confusion is why this doesn't work:

$ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
CONFIG_KUNIT=y
CONFIG_RATIONAL=y
EOF
...
ERROR:root:Provided Kconfig is not contained in validated .config.
Following fields found in kunitconfig, but not in .config:
CONFIG_RATIONAL=y

What it's complaining about is that `make  ARCH=um olddefconfig` is
leaving CONFIG_RATIONAL=y unset.

Stripping out kunit.py, it's this:

$ echo -e 'CONFIG_KUNIT=y\nCONFIG_RATIONAL=y' > .kunit/.config
$ make ARCH=um olddefconfig O=.kunit
$ grep RATIONAL .kunit/.config

I'm not versed in Kconfig enough to know why CONFIG_RATIONAL=y is
getting removed.

>
> > is necessary
> > +       default KUNIT_ALL_TESTS
> > +       help
> > +               This builds unit tests for the rational number support.
> > +
> > +               If unsure, say N.
>
>
> --
> ~Randy
>
