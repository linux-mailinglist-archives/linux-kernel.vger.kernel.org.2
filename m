Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5DC3B0199
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFVKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVKne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:43:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A4336135F;
        Tue, 22 Jun 2021 10:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624358477;
        bh=2uRngl3kr6NCPqudG+WuTHSVV2u/aH4rU8+PXknpFp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AwC5o8S8CtB1yBpTEBD9R/sx74BmFWXS5WhN3uAjRZDycQy+ZQEWbjz30VuJouieX
         USQeybGb9++ah2WaKe92aULZc7bvCeYSlUDDmMeO7I33/S/kK0kjmscD7MVBGR6NOK
         YWcJzwh84LuwylmcljjRvnEGzkh6SrTCE8LVltXo=
Date:   Tue, 22 Jun 2021 12:40:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     nick black <dankamongmen@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: why were GIO_FONTX/PIO_FONTX dropped? i was using them
Message-ID: <YNG+CSsO0K5/WgT5@kroah.com>
References: <YNGOxMfGuxQfwtiJ@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNGOxMfGuxQfwtiJ@schwarzgerat.orthanc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 03:18:28AM -0400, nick black wrote:
> Jiri et al,
> 
> I'm the author of Notcurses, a library for "blingful terminal
> UIs". As part of this, I was using the GIO_FONTX and PIO_FONTX
> ioctl()s to reprogram the Linux console fonts. I proposed this
> functionality on 2019-12-22 in Notcurses bug #201:
> 
>  https://github.com/dankamongmen/notcurses/issues/201
> 
> On 2020-05-13, I began using these two ioctls (along with their
> _UNIMAP equivalents), as documented in console_ioctl(2), to
> recover the font, scan it for Unicode block- and line-drawing
> characters, and add them if absent:
> 
>  https://github.com/dankamongmen/notcurses/pull/795/files
>  https://github.com/dankamongmen/notcurses/pull/794/files
> 
> some happy initial results were saved for posterity; i've
> reproduced them here:
> 
>  https://nick-black.com/images/you-stole-my-ioctls.jpg
> 
> this worked perfectly, and I extended my Quadblitter to it, and
> cheerfully considered this a completed feature. You can see the
> results in this video from September 2020. it starts at 192s in,
> though you ought just watch the whole thing because it's
> awesome [0]:
> 
>  https://www.youtube.com/watch?v=cYhZ7myXyyg&t=192s
> 
> How sad, then, when a few weeks back I noticed that this
> working code was no longer working on newer kernels:
> 
>  https://github.com/dankamongmen/notcurses/issues/1726
> 
> I assumed it was my bug, having heard something over the years
> of Linux's commitment to APIs and not breaking working code. but
> today i went through the console_ioctl(2) man page (2017-09-15),
> and my code, and strace, and finally the kbd 2.3.3 source, where
> i found out about KDFONTOP. ok, but why weren't FONTX working?
> then i found ff2047fb755d4415ec3c70ac799889371151796d:
> 
>  "As was demonstrated by commit 90bfdeef83f1 (tty: make FONTX ioctl use
>   the tty pointer they were actually passed), these ioctls are not used
>   from userspace, as:
>   1) they used to be broken (set up font on current console, not the open
>      one) and racy (before the commit above)
>   2) KDFONTOP ioctl is used for years instead"
>     
> as hopefully demonstrated here, they *were* used from userspace.
> i'm happy to move to KDFONTOP (since it doesn't appear to be in
> the 5.11 man pages, maybe i'll write it up), but this was
> somewhat rude, and maybe the ioctls weren't as broken as you
> think?

They were still quite broken and racy and given that we could not find
any users in our search, we felt it was safe to remove them.

As you say, moving to KDFONTOP works, that's great, all is well, sorry
for breaking the existing code you had, but part of removing things is
seeing if there are valid users that can not change.  Sorry for missing
your usages.

> also, i notice the definitions weren't removed. if no userspace
> was using them, they could have been, right? that would have
> been better than the ioctl()s mysteriously failing with ENOTTY.

We can remove them, want to send a patch to do so?

thanks,

greg k-h
