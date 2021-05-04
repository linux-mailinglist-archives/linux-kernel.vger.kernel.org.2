Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD8372F4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhEDR5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhEDR5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:57:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7416F61076;
        Tue,  4 May 2021 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620150997;
        bh=GEHj4bfA2qK0agu2/aTvuXZ4ztOXSkpgNUkIjTGXWgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmKwdX9CwO7xEZAkyD+O7KS465kxbRonWmYRid7adAVThMcZCeTBVe3CKFawBh7jm
         MNXOsAvYfqd2AjeE/iyHv7iQl8Yp+dt8uz7DBnOnQBeMht5mjmQWTmj1JKeg4Ozd88
         3NLzAFWlVMqbAtKzE12tVQCFsa889KATgUlA14Yc=
Date:   Tue, 4 May 2021 19:56:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: use generic kernel error codes
Message-ID: <YJGK06THHi5aGFGo@kroah.com>
References: <c94e5865e59d35fe0e39d5cd46d71ad4a752ddd4.1620144194.git-series.hello@bryanbrattlof.com>
 <YJFziyZHnbsWdTFn@kroah.com>
 <20210504174530.3kog7zq6tuk3wnlk@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210504174530.3kog7zq6tuk3wnlk@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 05:45:37PM +0000, Bryan Brattlof wrote:
> Sorry for the spam Greg I dropped the mailing lists from the first
> email.  :(
> 
> On Tue, May 04, 2021 at 06:17:15PM +0200, Greg Kroah-Hartman wrote:
> >On Tue, May 04, 2021 at 04:07:48PM +0000, Bryan Brattlof wrote:
> 
> <snip>
> 
> >> @@ -139,12 +139,11 @@ static u32 sdio_init(struct dvobj_priv *dvobj)
> >>  	psdio_data->tx_block_mode = 1;
> >>  	psdio_data->rx_block_mode = 1;
> >>
> >> +	return err;
> >> +
> >>  release:
> >>  	sdio_release_host(func);
> >> -
> >> -	if (err)
> >> -		return _FAIL;
> >> -	return _SUCCESS;
> >> +	return err;
> >>  }
> >
> >You just changed the logic here, are you SURE that was ok to do?
> >
> 
> I can't say my brain didn't bleed a little trying to keep this straight
> in my head while walking through this. (For what ever reason my brain
> sees negative integers as False) ¯\_(ツ)_/¯
> 
> Both the sdio_enable_func() and sdio_set_block_size() will return a
> negative integer if they fail, which we evaluate as True, allowing us to
> jump to release, free the card and propagate the error backwards.
> 
> If everything worked, we'll skip all the jumps until we get to the first
> 'return err;' statement, returning our 0 for success.
> 
> Inside sdio_dvobj_init() if we see 'anything below 0' (This probably
> should be changed to 'anything True') we jump to free_dvobj where we
> free the dvobj and return NULL
> 
> If I've looked at this long enough I don't thing I changed the logic.
> 
> Hopefully. :)

So you need to document this really well, showing that the function
whose error you changed, is being evaluated here now differently too.

> >>  static void sdio_deinit(struct dvobj_priv *dvobj)
> >> @@ -186,7 +185,7 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
> >>  	psdio = &dvobj->intf_data;
> >>  	psdio->func = func;
> >>
> >> -	if (sdio_init(dvobj) != _SUCCESS)
> >> +	if (sdio_init(dvobj) < 0)
> >>  		goto free_dvobj;
> >>
> >>  	rtw_reset_continual_io_error(dvobj);
> >>
> >> base-commit: 9ccce092fc64d19504fa54de4fd659e279cc92e7
> >> --
> >> git-series 0.9.1
> >>
> >>
> >
> >And that's all to remove the need for these crazy error values?  If so,
> >why not also remove the #defines for them as well?
> >
> 
> I might have over sold this patch. :)
> 
> There are quite a few functions like this still here that need to be
> converted before we can get rid of the _SUCCESS and _FAIL definitions.
> 
> Would it be better if I bundled these up in a series?

Do it one function "call-chain" at a time, and yes, a series would be
great.

thanks,

greg k-h
