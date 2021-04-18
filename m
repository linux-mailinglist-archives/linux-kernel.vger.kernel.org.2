Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FBC36372D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhDRShq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 14:37:46 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:51860 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229783AbhDRSho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 14:37:44 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 13IIaxro022446;
        Sun, 18 Apr 2021 20:36:59 +0200
Date:   Sun, 18 Apr 2021 20:36:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
Message-ID: <20210418183659.GA22430@1wt.eu>
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
 <YGFeQUuAaKgeaqCA@kroah.com>
 <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
 <CAK8P3a24aFvCUeZiDE6jCTKm0hrPVc34sNYOPpZJkh_5HpgDSw@mail.gmail.com>
 <CAGgoGu5xT6sADCpj7J7tJMfsw1WU4BA=3YB8SGS-+kf+P4xyNw@mail.gmail.com>
 <YGMqVc+DyVyT9DtW@kroah.com>
 <CAGgoGu4EzSKE68pva74Pdhdf+ssZddhFLzFTOFxMKiJOBaW8aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgoGu4EzSKE68pva74Pdhdf+ssZddhFLzFTOFxMKiJOBaW8aw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 07:25:08PM +0200, Fawad Lateef wrote:
> I tried booting the userspace compiled with gcc-9.1 and kernel
> compiled with gcc-5.5. But seems like the kernel 3.4.111 is not
> compatible with user-space compiled with gcc-9.1.
> During boot getting error: "FATAL: kernel too old." (from init I
> believe) and then kernel Panics. Log (part) below:

That's not a compiler issue, it's a libc issue. When you built your
toolchain you have likely (or accidently) selected a minimum kernel
version that is more recent than this one. The init code in the linker
checks the kernel version and refuses to start in such a case. If your
init depends on this libc, you simply cannot boot.

I don't know how far recent libcs can go on kernel support, but
you may possibly need to rebuild an older one, and sometimes older
libc will not build with modern gcc. So you should use the most
recent libc that still claims to support that kernel, and use the
most recent compiler your libc can be built with (maybe yours is
OK but I don't know).

Hoping this helps,
Willy
