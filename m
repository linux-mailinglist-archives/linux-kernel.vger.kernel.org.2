Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC6380D11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhENPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234742AbhENPbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:31:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2716E61458
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621006200;
        bh=xGai7ttixHArLWaEKNjFljSIugZAGn9JIkSoHZ0QmFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LxD8ghipIqCcHVLSpwCZwROLAnR8DCvNlSitrwUihFV5NCJpYfoyO5ZRQH2C1hNJN
         xXllU6/gs4UrjE0uLNBFt/I+9xEUXGWIW3N2q5OCyrVZBxzxs0cRozKueAV/aMgGSX
         sQVju29AyA8O56AifUhQ7r94tTB6NGuh3H/rXUTc8ls/Qox3dAJwkMMWdfxsL5alnn
         h3WSqileLiCiUuv7i6lHb8KF+vFqjr0HYRjln6rx5W9GyKnWX84+dFVPiXZd7E9Wpp
         jfmDRbw+Wr9Mbxsxus65n+A/2SsE6/m5zyiToS2dkSiMWVuvbDhR6D2TMYr/5jkvFU
         0r/c+89FTyuuw==
Received: by mail-wr1-f43.google.com with SMTP id v12so30374689wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:30:00 -0700 (PDT)
X-Gm-Message-State: AOAM5336N7ItTFzY5PukwWa478OVzucr4YN3e9HBbtC4+tLL/oIRK0xv
        MVP3IC1fJEiCBrXGrJ8owxYjZ8mvqFH9yjGbDlk=
X-Google-Smtp-Source: ABdhPJyfCtbeCLzPv4wjOA3jy4Jt8CX0FKI3RWylQ6DN54ypnEeoMQ3E90LNJqVibldI3XRqLOaSwM43Yipd+f1RaHM=
X-Received: by 2002:a05:6000:1b0b:: with SMTP id f11mr22232026wrz.165.1621006198659;
 Fri, 14 May 2021 08:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210514140015.2944744-1-arnd@kernel.org> <YJ6E1scEoTATEJav@kroah.com>
 <CANpmjNMgiVwNovVDASz1jrUFXOCaUY9SvC7hzbv2ix_CaaSvJA@mail.gmail.com>
In-Reply-To: <CANpmjNMgiVwNovVDASz1jrUFXOCaUY9SvC7hzbv2ix_CaaSvJA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 14 May 2021 17:28:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1bF1bLFGdD95OQ91GG0a2ZHWX+pp07N2px7RfCpWRUjg@mail.gmail.com>
Message-ID: <CAK8P3a1bF1bLFGdD95OQ91GG0a2ZHWX+pp07N2px7RfCpWRUjg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
To:     Marco Elver <elver@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 4:45 PM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> On Fri, 14 May 2021 at 16:10, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Fri, May 14, 2021 at 04:00:08PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > clang points out that an initcall funciton should return an 'int':
> > >
> > > kernel/kcsan/debugfs.c:274:15: error: returning 'void' from a function with incompatible result type 'int'
> > > late_initcall(kcsan_debugfs_init);
> > > ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > > include/linux/init.h:292:46: note: expanded from macro 'late_initcall'
> > >  #define late_initcall(fn)               __define_initcall(fn, 7)
> > >
> > > Fixes: e36299efe7d7 ("kcsan, debugfs: Move debugfs file creation out of early init")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [...]
> > >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> Thanks for catching this -- it boggles my mind why gcc nor clang
> wouldn't warn about this by default...
> Is this a new clang?

It was clang-13, not sure if that made a difference.

         Arnd
