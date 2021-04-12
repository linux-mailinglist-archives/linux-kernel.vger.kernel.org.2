Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE63F35C5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbhDLMFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240815AbhDLMFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5C5561278;
        Mon, 12 Apr 2021 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618229098;
        bh=xdrYUH4/jDF35cvZx/pzEQSYElhm/upOwIxaqWCv2pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Td6fSxOD8m8yQFA5BaZK/zIeZlOVgo3bJtV3gcLx1GEdMel67+RM9dBrPYoOJXyzg
         jbWAAVLNXpt8SNaBPdUMWTvokXP/cpvnUJuOi5dNhMSoR9nvtPIYYRgsaqeuQbDmcD
         xE1j2OjiAuyOzgNJATV00TwUOIll5aFoXAyCUnnA=
Date:   Mon, 12 Apr 2021 14:04:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Samo Pogacnik <samo_pogacnik@t-2.net>,
        Petr Mladek <pmladek@suse.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: How to handle concurrent access to /dev/ttyprintk ?
Message-ID: <YHQ3Zy9gRdZsu77w@kroah.com>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
 <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
 <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
 <YG24F9Kx+tjxhh8G@kroah.com>
 <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
 <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
 <YHQkeZVs3pmyie9e@kroah.com>
 <32e75be6-6e9f-b33f-d585-13db220519da@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e75be6-6e9f-b33f-d585-13db220519da@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 08:25:27PM +0900, Tetsuo Handa wrote:
> On 2021/04/12 19:44, Greg Kroah-Hartman wrote:
> > And trying to "open exclusive only" just does not work, the kernel can
> > not enforce that at all, sorry.  Any driver that you see trying to do
> > that is trivial to work around in userspace, making the kernel code
> > pointless.
> 
> You mean something like below cannot be used?
> 
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 6a0059e508e3..57200569918a 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -84,14 +84,26 @@ static int tpk_printk(const unsigned char *buf, int count)
>  	return count;
>  }
>  
> +static DEFINE_MUTEX(open_close_lock);

Hah, nope, does not work at all!

Think about sending an open file descriptor all around the system, or
through a pipe, your "open only once" check does not prevent that at
all.

> > Like any tty port, if you have multiple accesses, all bets are off and
> > hilarity ensues.  Just don't do that and expect things to be working
> > well.
> 
> Since syzkaller is a fuzzer, syzkaller happily opens /dev/ttyprintk from
> multiple threads. Should we update syzkaller to use CONFIG_TTY_PRINTK=n ?

Why?  Can you not hit the same tty code paths from any other tty driver
being open multiple times?  Why is ttyprintk somehow "special" here?

thanks,

greg k-h
