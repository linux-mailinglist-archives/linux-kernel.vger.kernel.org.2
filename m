Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4A316F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhBJS6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhBJS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:56:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403C5C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:55:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t142so2713129wmt.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AAePRhaYdh8IR3fav5qzi16yCJ4dvJcD8Hr4awo6sqg=;
        b=xzE1+Zfo6WjzIVQ6sQPRizZxaH8vtOoI8fCXALfGd1f4NR0zmslqKN0sdCDN1aaYMe
         mHu+1+q772zg5sruTt9S0Ue/8NYj8h3fUqgzRksH3sYffeYnDE4yDS9hJdPl3x3G/WkD
         Swp6Smn6D0rMrqd0v2X852p45xy+VBAfGm0FFwBliyS6SK+k0Jre0Dd7UU31YDP+njOe
         I2YUkI1K6M0EHNs2NVfzPJZyuDiR+OT9TeDJ0weNBKuzFOHUY1r5V+OjGdtpfjD7zlGX
         y2sHolQDeWDERnUcmDv3Du9t18KeC4BRula4wk+UfNuu/99K9LtUcZmQuFnreHLnatS2
         8byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AAePRhaYdh8IR3fav5qzi16yCJ4dvJcD8Hr4awo6sqg=;
        b=VUrc6cIaHe5JO2f14YnOfb4lkaOQEts+sRetyn5gZkhmZjQEVYnmPjga6DpRKQp5mb
         RURtrjMlPDsttBulObQsnrg002ra/3+iAJYU/A0CuE8E3EgvgySyIh5klfDB9wEN3ezZ
         YOQ53mnhEsNiPSFnulg2+T4J/tI9/A0KMweniTxZt/tlClCV0UR+UkzS0Id8FH3eeMKM
         YnbY++mmU5Ldjh0N0yqIeoMKeTTOs4lzCNykP2F0hAYRX8HV23TWHeA2ix8PFaas64nX
         kV3as3F2Xl1fOLHdZnulfyI3zzAunrbcEyIHGCUTeSC0icdQnH1+wnDHPcniYL4UthYN
         zPlw==
X-Gm-Message-State: AOAM532vlS1e8HB8qNQzSRHvqU3YfF4TyBzUoVa3ZUbVdtLOmszxPKja
        88uGebZl+3KV24NUXdew8YCtJg==
X-Google-Smtp-Source: ABdhPJypOD8g1AAXNkZV9oOdvxbuXUW5wGmn8pO4JVXtoSW08tacbgMuvcZ8UbiM5jtefiHXSXzsdA==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr338842wmb.21.1612983346932;
        Wed, 10 Feb 2021 10:55:46 -0800 (PST)
Received: from kernelvm (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id u142sm3812064wmu.3.2021.02.10.10.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 10:55:46 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:55:44 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        luk@wybcz.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: cleanup macros within
 include/rtw_debug.h
Message-ID: <20210210185544.GA1786@kernelvm>
References: <20210210170003.100880-1-phil@philpotter.co.uk>
 <20210210184027.GZ2696@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210184027.GZ2696@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:40:27PM +0300, Dan Carpenter wrote:
> On Wed, Feb 10, 2021 at 05:00:03PM +0000, Phillip Potter wrote:
> > Remove do/while loops from DBG_871X, MSG_8192C and DBG_8192C.
> 
> I'm pretty hip to checkpatch.pl warnings, but I had forgotten what the
> warning was for this:
> 
> WARNING: Single statement macros should not use a do {} while (0) loop
> 
> Please, include it for people who are forgetful like I am.
> 
> > Also
> > fix opening brace placements and trailing single statement layout within
> > RT_PRINT_DATA, as well as making newline character placement more
> > consistent and removing camel case where possible. Finally, add
> > parentheses for DBG_COUNTER definition.
> > 
> > This fixes 3 checkpatch warnings, 5 checkpatch errors and 3 checkpatch
> > checks.
> 
> This patch would be easier to review if it were split into multiple
> patches.
> 
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >  drivers/staging/rtl8723bs/include/rtw_debug.h | 40 +++++++++----------
> >  1 file changed, 19 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > index c90adfb87261..d06ac9540cf7 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_debug.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > @@ -201,19 +201,16 @@
> >  #ifdef DEBUG
> >  #if	defined(_dbgdump)
> >  	#undef DBG_871X
> > -	#define DBG_871X(...)     do {\
> > -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> > -	} while (0)
> > +	#define DBG_871X(...)\
> > +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
> 
> This can fit on one line:
> 
> 	#define DBG_871X(...) _dbgdump(DRIVER_PREFIX __VA_ARGS__)
> 
> It's tough with staging code to know how much to change at one time
> because even after you change the code then it still looks rubbish.
> This define shouldn't be indented.  The _dbgdump() macro is just
> 
> #define _dbgdump printk
> 
> so you know, no printk level.  Wow.  etc.  This code is crap.

So I'm in the process of stripping out _dbgdump entirely as per Greg
K-H's suggestion - am I to understand raw printk is frowned upon though,
even with the correct KERN_x level specified?

> 
> >  
> >  	#undef MSG_8192C
> > -	#define MSG_8192C(...)     do {\
> > -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> > -	} while (0)
> > +	#define MSG_8192C(...)\
> > +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
> >  
> >  	#undef DBG_8192C
> > -	#define DBG_8192C(...)     do {\
> > -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> > -	} while (0)
> > +	#define DBG_8192C(...)\
> > +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
> >  #endif /* defined(_dbgdump) */
> >  #endif /* DEBUG */
> >  
> 
> Yeah.  Do all the above as one patch.
> 
> > @@ -235,25 +232,26 @@
> >  
> >  #if	defined(_dbgdump)
> >  	#undef RT_PRINT_DATA
> > -	#define RT_PRINT_DATA(_Comp, _Level, _TitleString, _HexData, _HexDataLen)			\
> > -		if (((_Comp) & GlobalDebugComponents) && (_Level <= GlobalDebugLevel))	\
> > -		{									\
> > +	#define RT_PRINT_DATA(_comp, _level, _title_string, _hex_data, _hex_data_len)		\
> > +	do {											\
> > +		if (((_comp) & GlobalDebugComponents) && ((_level) <= GlobalDebugLevel)) {	\
> >  			int __i;								\
> > -			u8 *ptr = (u8 *)_HexData;				\
> > +			u8 *ptr = (u8 *)_hex_data;						\
> >  			_dbgdump("%s", DRIVER_PREFIX);						\
> > -			_dbgdump(_TitleString);						\
> > -			for (__i = 0; __i < (int)_HexDataLen; __i++)				\
> > -			{								\
> > +			_dbgdump(_title_string);						\
> > +			for (__i = 0; __i < (int)_hex_data_len; __i++) {			\
> >  				_dbgdump("%02X%s", ptr[__i], (((__i + 1) % 4) == 0)?"  ":" ");	\
> > -				if (((__i + 1) % 16) == 0)	_dbgdump("\n");			\
> > -			}								\
> > -			_dbgdump("\n");							\
> > -		}
> > +				if (((__i + 1) % 16) == 0)					\
> > +					_dbgdump("\n");						\
> > +			}									\
> > +			_dbgdump("\n");								\
> > +		}										\
> > +	} while (0)
> 
> This is okay, I suppose but we have functions to dump hex data.  I can't
> remember what they are...  One patch for this.
> 
> >  #endif /* defined(_dbgdump) */
> >  #endif /* DEBUG_RTL871X */
> >  
> >  #ifdef CONFIG_DBG_COUNTER
> > -#define DBG_COUNTER(counter) counter++
> > +#define DBG_COUNTER(counter) ((counter)++)
> 
> Heh...  I think these counters are write only variables.  Double check
> and then just delete everything to do with CONFIG_DBG_COUNTER.
> (In a separate patch).
> 
> regards,
> dan carpenter
> 

Thank you for your feedback (and thank you Greg for yours also). I
hugely appreciate it as a novice/newb.

One query I have is that individual patches I'm working on for this file are
generating an awful lot of checkpatch warnings themselves due to the
nature of the existing violations on the relevant lines. Is it
considered acceptable for me to still submit these, providing I do so in
a series which cleans up the other violations in separate patches?

Regards,
Phil
