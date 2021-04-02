Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD91A352F4A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhDBSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBSbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:31:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAA0A60C3E;
        Fri,  2 Apr 2021 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617388275;
        bh=G+2nOl79scLD+kYdNuqIJhgA2fdneiBHVrqYHJ5YnWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYEa4qrp5E7BqwGIREzQa6QHMIL62RC9GWaA80fg3V4ptxUyN5E9ivdbUp7PzKSAj
         8tJ6/X6feN03DIszVWhcnok4d4vAkAruK6Baas9VjJNHfd62UJlL2nN7k1Ijg/nQgi
         Gt5xfII83qwxYPeHoUQr56kElNWZCa7LdD23Z3KQNxB7qbYNk1L4YwAPDK/DQlHNvO
         iUNUmMlNkk2HlDDDwekwezuYbqyNko5sQDNH7uDtEuZM6XjMNEDbqO/uNBPboX6o9o
         XBZq1zbLOfWBmy5N1fCyzzBZOeeFFnHNejl6Ww4r1mYuc8QvUERX64B7+N0tfDfp7d
         1H5M+N8YsdQDw==
Date:   Fri, 2 Apr 2021 11:31:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        qemu-devel@nongnu.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
Message-ID: <20210402183110.zmnuoc74mzil3tml@archlinux-ax161>
References: <20210211194258.4137998-1-nathan@kernel.org>
 <161428829728.2305454.15456455443457551559.b4-ty@chromium.org>
 <CA+icZUWdeWSy52bU4cjHau1hn5NiFAozaHgDb=geaaCYOET9+w@mail.gmail.com>
 <202104021125.53164550A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104021125.53164550A@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 11:25:42AM -0700, Kees Cook wrote:
> On Fri, Apr 02, 2021 at 08:42:07AM +0200, Sedat Dilek wrote:
> > On Thu, Feb 25, 2021 at 10:25 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, 11 Feb 2021 12:42:58 -0700, Nathan Chancellor wrote:
> > > > fw_cfg_showrev() is called by an indirect call in kobj_attr_show(),
> > > > which violates clang's CFI checking because fw_cfg_showrev()'s second
> > > > parameter is 'struct attribute', whereas the ->show() member of 'struct
> > > > kobj_structure' expects the second parameter to be of type 'struct
> > > > kobj_attribute'.
> > > >
> > > > $ cat /sys/firmware/qemu_fw_cfg/rev
> > > > 3
> > > >
> > > > [...]
> > >
> > > Applied to kspp/cfi/cleanups, thanks!
> > >
> > > [1/1] qemu_fw_cfg: Make fw_cfg_rev_attr a proper kobj_attribute
> > >       https://git.kernel.org/kees/c/f5c4679d6c49
> > >
> > 
> > I have queued this up in my custom patchset
> > (for-5.12/kspp-cfi-cleanups-20210225).
> > 
> > What is the plan to get this upstream?
> 
> I haven't sent it to Linus yet -- I was expecting to batch more of these
> and send them for v5.13. (But if the kvm folks snag it, that's good
> too.)

I am going to be putting the CFI series through its paces on both arm64
and x86_64 over the next week or so on several different machines (in
fact, I am writing up a report right now) so I will probably have some
more of these as I find them.

Cheers,
Nathan
