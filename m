Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26085441B36
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhKAMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232244AbhKAMf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:35:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2544260FE8;
        Mon,  1 Nov 2021 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635770004;
        bh=fJ2N7Af1US9AFx5AK8u3NxNtMAAXOEMwCQULc8BkPqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqVf1c/rg5CHuIWR0TiSZIlQ3bU47uVRxiuiX8fbmiw6BHHPR/UQisMXa861Q2mSZ
         WJS8CCIK3HWgPGeQ+FrPn/TRP+791ENzEANWXhgN9+9z6aBG0nQKTtgsONvCjqU235
         U082HuKBBJLxeijE7AcwS8AUjU0Zg4VsSUt+GCs4=
Date:   Mon, 1 Nov 2021 13:33:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Thorsten is tracking regression again and could need a little
 help (was: Re: Linux 5.15)
Message-ID: <YX/ekB+9F9xvHCB7@kroah.com>
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
 <a365ffb9-a4d2-b1d7-7cd7-dd9d7039e04e@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a365ffb9-a4d2-b1d7-7cd7-dd9d7039e04e@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 05:49:40AM +0100, Thorsten Leemhuis wrote:
> example by simply forwarding the mail to regressions@leemhuis.info or
> CCing that address on a reply. I'll handle everything else then and tell
> regzbot about it. But if you feel adventurous, you can also skip me as
> the man-in-the-middle and tell the bot directly. To do that, just send a
> reply to the report to the regressions mailing list
> (regressions@lists.linux.dev) either directly or by CCing it on a reply
> you would have written anyway; when doing so, place something like
> '#regzbot ^introduced v5.15..' (separated by blank lines) somewhere in
> the text, as outlined in regzbot's 'getting started guide' or its
> reference documentation:
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
> https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
> 
> That's it, regzbot then on its next run will add the report to the list
> of tracked regression. I'll keep an eye on things and try to fix any
> problems I notice, as there likely will be a few. But then doesn't need
> to bother you.
> 
> There is one thing that would really help: if one or two subsystem
> maintainers could give regzbot a shot for all the regression reports
> they get, even for easy fixes, as the bot really needs something to chew
> on. Any volunteers?

I'll try it for the USB subsystem this merge cycle.  Do you want a bug
report email redirected to that address or will a simple forward work
well enough?

thanks,

greg k-h
