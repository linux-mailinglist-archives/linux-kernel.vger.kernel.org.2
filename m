Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBBA31F5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBSIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:32922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhBSIbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:31:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 172AB64D5D;
        Fri, 19 Feb 2021 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613723421;
        bh=4uu0gNzwTseegLPeh2iXdcKxfYm/OeqwPyRxyV58Igs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lg9TqfHKoH+Lw4jL/Dxn/rOOxR+cKsbbp8S9CUYXqgn2P2M05FaK9BBZ39tvLIWS9
         B2rR2VT2Cy715nJpZdTreYumUVjtlFdLqFEUJkpWcdrCmAK5OD2hyExu13/nn3pgfO
         Ab96tgGjXp4xwR4LiFY12ql9xIlqMt3YpXkaI1rs=
Date:   Fri, 19 Feb 2021 09:30:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ondrej Zary <linux@zary.sk>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Willy Tarreau <w@1wt.eu>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC93GmcBnJwVYKG7@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YC55t1vkRuC9uXcx@kroah.com>
 <20210218205534.GA10201@duo.ucw.cz>
 <202102182343.36276.linux@zary.sk>
 <20210219080027.GA12434@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219080027.GA12434@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 09:00:27AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > For me
> > > > > only way to get properly working WiFi on my laptop computer is to
> > > > > compile that Intel out-of-tree version. Sad, but true.
> > > > 
> > > > Why use 4.19.y on a laptop in the firstplace?  That feels very wrong and
> > > > is not the recommended thing to use the LTS kernels for.
> > > 
> > > Well, that's actually what distributions are doing, for example Debian
> > > 10.8 is on 4.19...
> > 
> > There's 5.10 in buster-backports. That's probably the easiest way to get support for new HW.
> >  
> 
> I can compile my own kernel, too. But if you go up the thread, it is
> about iwlwifi becoming broken in 4.19, and Greg saying it is wrong
> to put -stable on laptop. And -stable on laptop is norm, not the
> exception.

If distros want to "camp out" on an old kernel version, that's fine, as
I describe in:
	http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/
many years ago.

But for someone using a device where they want to use "new" hardware,
that was made _after_ the kernel version was released, that's just
someone who needs to pick a better distro :)

thanks,

greg k-h
