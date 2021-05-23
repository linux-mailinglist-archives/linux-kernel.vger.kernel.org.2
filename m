Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DE038DA27
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhEWIUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 04:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhEWIUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 04:20:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AB4961168;
        Sun, 23 May 2021 08:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621757928;
        bh=U0YAvZaLR8WDB/++plZoqCKo3gtUlnYXHKAqLTt8gr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPc0pz0dEPacRLTt9eTBIWButqRYE/XQ+Jy1WcfgbyZgnRYks466piY9L5/bR52ca
         9aXd7M4YiLY3Kqs8xRoBZOX/3BZugaXSjcXKvDS1gWuHbJgppKflry2/6cqDsLRqEU
         Ji7yLOOTjyrg4dX+q2G94vmxfyVBi5Q22MQ+UtEs=
Date:   Sun, 23 May 2021 10:18:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] MAINTAINERS: TTY LAYER: add some
 ./include/linux/ header files
Message-ID: <YKoP5BHxXnww8d6k@kroah.com>
References: <20210518052117.14819-1-lukas.bulwahn@gmail.com>
 <20210518052117.14819-2-lukas.bulwahn@gmail.com>
 <69da627e-91c5-66f0-c0c9-75fbaaba6782@kernel.org>
 <CAKXUXMw21Up0WhSX0V=h5oYcw-ocLT0Bv=tUaekA1beoo6u+aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMw21Up0WhSX0V=h5oYcw-ocLT0Bv=tUaekA1beoo6u+aA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 09:05:48AM +0200, Lukas Bulwahn wrote:
> On Tue, May 18, 2021 at 7:37 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > On 18. 05. 21, 7:21, Lukas Bulwahn wrote:
> > > An early prototypical automated code analysis of headers and the
> > > existing MAINTAINERS sections identified some header files in
> > > ./include/linux/ to be probably included into the TTY LAYER section.
> > >
> > > I further checked those suggestions by this analysis and identified a
> > > subset of files that I am rather certain to belong to the TTY LAYER.
> > >
> > > Add these ./include/linux/ header files to TTY LAYER in MAINTAINERS.
> > >
> > > The patterns include/linux/tty*.h and include/linux/vt_*.h currently cover:
> > >
> > >    include/linux/tty.h
> > >    include/linux/tty_driver.h
> > >    include/linux/tty_flip.h
> > >    include/linux/tty_ldisc.h
> > >
> > >    include/linux/vt_buffer.h
> > >    include/linux/vt_kern.h
> >
> > Yes, that looks good.
> >
> > Can you extend the tool to include/uapi too?
> >
> > For example this is missing too:
> > include/uapi/linux/tty*.h
> >
> > It expands to:
> > include/uapi/linux/tty_flags.h
> > include/uapi/linux/tty.h
> >
> 
> Jiri,
> 
> Greg already picked this patch up; so I will keep this patch as-is and move on.

This patch was fine as-is, but sending an additional patch with that
information added would be most welcome.  No need for your tool to
create it, you can do it by hand :)

thanks,

greg k-h
