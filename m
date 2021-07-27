Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F223D7015
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhG0HMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235331AbhG0HMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:12:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C3B461185;
        Tue, 27 Jul 2021 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627369973;
        bh=ELu8b54h7QxDDdu/h0cAI3K7N4hvkm2fTJljw43CNPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrCXm0J9p7txD5OuxZbkGOWbshV/l4LO7XYRb/OCEhWMya1eAuCIbpNU+gWg1RdEU
         fsr8C1CAt+NFLM1j9jqZ+doNT4lUnS0L8CgF8DL4L6TSo9rLcKRmWHlZUwZfASq6pO
         b9YUGv2wrLqlxCo+JMc90c4IECdcoIlGRjBEbem0=
Date:   Tue, 27 Jul 2021 09:12:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
Message-ID: <YP+x8y6MoPNHh58q@kroah.com>
References: <20210714091747.2814370-1-morbo@google.com>
 <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com>
 <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com>
 <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com>
 <CAGG=3QVc_OZoKi2J8tqRoBKcPekgAMMi=6Uphg1hNGNDK1qJUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QVc_OZoKi2J8tqRoBKcPekgAMMi=6Uphg1hNGNDK1qJUA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:08:37AM -0700, Bill Wendling wrote:
> On Mon, Jul 26, 2021 at 11:41 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Jul 26, 2021 at 11:15:52PM -0700, Bill Wendling wrote:
> > > On Mon, Jul 26, 2021 at 10:27 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Mon, Jul 26, 2021 at 01:47:33PM -0700, Nathan Chancellor wrote:
> > > > > + Greg and Rafael as the maintainer and reviewer of drivers/base/module.c
> > > > > respectively, drop everyone else.
> > > >
> > > > Odd no one cc:ed us originally, I guess they didn't want the patch ever
> > > > merged?  :(
> > > >
> I don't believe I saw you or Rafael listed in the
> "script/get_maintainers" output. I tried to copy everyone who showed
> up.

$ ./scripts/get_maintainer.pl --file drivers/base/module.c
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS)
"Rafael J. Wysocki" <rafael@kernel.org> (reviewer:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS)
linux-kernel@vger.kernel.org (open list)

{sigh}

