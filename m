Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2580317061
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhBJTjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:39:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhBJThL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:37:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34B1B64DA1;
        Wed, 10 Feb 2021 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612985787;
        bh=x54ZabpyxNtHweYLCJv/rL8elgjOpBrpIHhKUVAamQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcUNW1IaRCMcRzVAB3A6ug1xlPUYrogwD2BQDlRvyeaBoc+MbxIjOtRKGgS7KxT9v
         88NjINx0zGNcinzWcxLPz5kqMDD+3pXYLIODNbA7hHcAySfcVK+5/flguMcVzKeFcJ
         tQ8OtP3EVINLL/OQrJ6bbZ9Hz5LN8PpxJnUGM6YM=
Date:   Wed, 10 Feb 2021 20:36:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, luk@wybcz.pl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: cleanup macros within
 include/rtw_debug.h
Message-ID: <YCQ1uQoNigBySa8i@kroah.com>
References: <20210210170003.100880-1-phil@philpotter.co.uk>
 <20210210184027.GZ2696@kadam>
 <20210210185544.GA1786@kernelvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210185544.GA1786@kernelvm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 06:55:44PM +0000, Phillip Potter wrote:
> On Wed, Feb 10, 2021 at 09:40:27PM +0300, Dan Carpenter wrote:
> > On Wed, Feb 10, 2021 at 05:00:03PM +0000, Phillip Potter wrote:
> > > Remove do/while loops from DBG_871X, MSG_8192C and DBG_8192C.
> > 
> > I'm pretty hip to checkpatch.pl warnings, but I had forgotten what the
> > warning was for this:
> > 
> > WARNING: Single statement macros should not use a do {} while (0) loop
> > 
> > Please, include it for people who are forgetful like I am.
> > 
> > > Also
> > > fix opening brace placements and trailing single statement layout within
> > > RT_PRINT_DATA, as well as making newline character placement more
> > > consistent and removing camel case where possible. Finally, add
> > > parentheses for DBG_COUNTER definition.
> > > 
> > > This fixes 3 checkpatch warnings, 5 checkpatch errors and 3 checkpatch
> > > checks.
> > 
> > This patch would be easier to review if it were split into multiple
> > patches.
> > 
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
> > 
> > This can fit on one line:
> > 
> > 	#define DBG_871X(...) _dbgdump(DRIVER_PREFIX __VA_ARGS__)
> > 
> > It's tough with staging code to know how much to change at one time
> > because even after you change the code then it still looks rubbish.
> > This define shouldn't be indented.  The _dbgdump() macro is just
> > 
> > #define _dbgdump printk
> > 
> > so you know, no printk level.  Wow.  etc.  This code is crap.
> 
> So I'm in the process of stripping out _dbgdump entirely as per Greg
> K-H's suggestion - am I to understand raw printk is frowned upon though,
> even with the correct KERN_x level specified?
> 
> > 
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
> > >  #endif /* defined(_dbgdump) */
> > >  #endif /* DEBUG */
> > >  
> > 
> > Yeah.  Do all the above as one patch.
> > 
> > > @@ -235,25 +232,26 @@
> > >  
> > >  #if	defined(_dbgdump)
> > >  	#undef RT_PRINT_DATA
> > > -	#define RT_PRINT_DATA(_Comp, _Level, _TitleString, _HexData, _HexDataLen)			\
> > > -		if (((_Comp) & GlobalDebugComponents) && (_Level <= GlobalDebugLevel))	\
> > > -		{									\
> > > +	#define RT_PRINT_DATA(_comp, _level, _title_string, _hex_data, _hex_data_len)		\
> > > +	do {											\
> > > +		if (((_comp) & GlobalDebugComponents) && ((_level) <= GlobalDebugLevel)) {	\
> > >  			int __i;								\
> > > -			u8 *ptr = (u8 *)_HexData;				\
> > > +			u8 *ptr = (u8 *)_hex_data;						\
> > >  			_dbgdump("%s", DRIVER_PREFIX);						\
> > > -			_dbgdump(_TitleString);						\
> > > -			for (__i = 0; __i < (int)_HexDataLen; __i++)				\
> > > -			{								\
> > > +			_dbgdump(_title_string);						\
> > > +			for (__i = 0; __i < (int)_hex_data_len; __i++) {			\
> > >  				_dbgdump("%02X%s", ptr[__i], (((__i + 1) % 4) == 0)?"  ":" ");	\
> > > -				if (((__i + 1) % 16) == 0)	_dbgdump("\n");			\
> > > -			}								\
> > > -			_dbgdump("\n");							\
> > > -		}
> > > +				if (((__i + 1) % 16) == 0)					\
> > > +					_dbgdump("\n");						\
> > > +			}									\
> > > +			_dbgdump("\n");								\
> > > +		}										\
> > > +	} while (0)
> > 
> > This is okay, I suppose but we have functions to dump hex data.  I can't
> > remember what they are...  One patch for this.
> > 
> > >  #endif /* defined(_dbgdump) */
> > >  #endif /* DEBUG_RTL871X */
> > >  
> > >  #ifdef CONFIG_DBG_COUNTER
> > > -#define DBG_COUNTER(counter) counter++
> > > +#define DBG_COUNTER(counter) ((counter)++)
> > 
> > Heh...  I think these counters are write only variables.  Double check
> > and then just delete everything to do with CONFIG_DBG_COUNTER.
> > (In a separate patch).
> > 
> > regards,
> > dan carpenter
> > 
> 
> Thank you for your feedback (and thank you Greg for yours also). I
> hugely appreciate it as a novice/newb.
> 
> One query I have is that individual patches I'm working on for this file are
> generating an awful lot of checkpatch warnings themselves due to the
> nature of the existing violations on the relevant lines. Is it
> considered acceptable for me to still submit these, providing I do so in
> a series which cleans up the other violations in separate patches?

Yes, that is fine, and expected in many of these files :(

thanks,

greg k-h
