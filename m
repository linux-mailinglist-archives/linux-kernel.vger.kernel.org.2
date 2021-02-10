Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B1B316D53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhBJRvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhBJRtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:49:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1A6264E79;
        Wed, 10 Feb 2021 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612979305;
        bh=2rLI9+Fe1Vb3IUxDFPYblq7Kdt+EU6Ggd3102F0ROkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RlnQmKlvLAMhSN+VCPErbjbmX1HPtonPjp1OZOFaBZPbtdBwZxkJUJLpP4F7vm5WM
         4fINKBISl2PK+LFjl97aoM3OvjVzkoxPtsRz8QXEJj9CTswc2QROtRE7tgiXHRYxV5
         ims/vqgpNHYicoonyXWFv7KtdQnBG0YlmOb+tXJ4=
Date:   Wed, 10 Feb 2021 18:48:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     devel@driverdev.osuosl.org, luk@wybcz.pl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: cleanup macros within
 include/rtw_debug.h
Message-ID: <YCQcZkmNGPuL4DBZ@kroah.com>
References: <20210210170003.100880-1-phil@philpotter.co.uk>
 <YCQUFvhKW7rSR6qy@kroah.com>
 <20210210173438.GA1349@kernelvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210173438.GA1349@kernelvm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 05:34:38PM +0000, Phillip Potter wrote:
> On Wed, Feb 10, 2021 at 06:12:54PM +0100, Greg KH wrote:
> > On Wed, Feb 10, 2021 at 05:00:03PM +0000, Phillip Potter wrote:
> > > Remove do/while loops from DBG_871X, MSG_8192C and DBG_8192C. Also
> > > fix opening brace placements and trailing single statement layout within
> > > RT_PRINT_DATA, as well as making newline character placement more
> > > consistent and removing camel case where possible. Finally, add
> > > parentheses for DBG_COUNTER definition.
> > > 
> > > This fixes 3 checkpatch warnings, 5 checkpatch errors and 3 checkpatch
> > > checks.
> > > 
> > > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > > ---
> > >  drivers/staging/rtl8723bs/include/rtw_debug.h | 40 +++++++++----------
> > >  1 file changed, 19 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > > index c90adfb87261..d06ac9540cf7 100644
> > > --- a/drivers/staging/rtl8723bs/include/rtw_debug.h
> > > +++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > > @@ -201,19 +201,16 @@
> > >  #ifdef DEBUG
> > >  #if	defined(_dbgdump)
> > >  	#undef DBG_871X
> > > -	#define DBG_871X(...)     do {\
> > > -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> > > -	} while (0)
> > > +	#define DBG_871X(...)\
> > > +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
> > >  
> > >  	#undef MSG_8192C
> > > -	#define MSG_8192C(...)     do {\
> > > -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> > > -	} while (0)
> > > +	#define MSG_8192C(...)\
> > > +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
> > >  
> > >  	#undef DBG_8192C
> > > -	#define DBG_8192C(...)     do {\
> > > -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> > > -	} while (0)
> > > +	#define DBG_8192C(...)\
> > > +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
> > 
> > Odd, the do/while is correct here, why is checkpatch complaining about
> > it?
> 
> The warning it gives me for these is:
> WARNING: Single statement macros should not use a do {} while (0) loop

Ah.

What a mess.

I would recommend starting to unwind the "debugging" macro mess here,
all that a driver should be using is the netdev_dbg() and friends
functions, not this mess of "printk or no printk" that it currently is.

If you replace _dbgdump with what it is defined with, then go from there
and replace the DBG_8192C and friends with what they should be, and so
on.  That's a much better overall solution than to just paper over this
with a checkpatch cleanup.

thanks,

greg k-h
