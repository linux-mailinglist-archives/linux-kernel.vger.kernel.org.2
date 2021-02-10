Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348BB316CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhBJRhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhBJRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:35:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D441C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:34:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m13so3459790wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=poliqhhZuPxsaL4gj+QoHSIxghPiK7BMrYkoz3UqiFY=;
        b=usSUoBdL1MYUKtb2WRbXs7zi+Hc/qvmDWP9Wk3QEs39ZhsA9LmwDebR6oNis3IPbJf
         xZ7qzJTR3YXhKVeimktSt4S9HPaCb2RjuU815f0aqBGOlVWTCQvVqroKLN13W9qOnAEf
         rFlJz8fYrtOWj6C6PUk3KaH0xoxKv2wZJ6nLvhhzO0d9sJk1CTz2b9/MQMhJXLVHeOvn
         CP03sJem2n73qVAYCAcjxDqI9qAhETwDiZzI8gLtl2kG5TUMJCSabMQCC+euZJvF6jZN
         oN4Ni1jyK/TxvHMi7aBIsVUH4G/M714ANfYaKh4xfWoareKddkyvDODiLsqMMEEr/Bw8
         OMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=poliqhhZuPxsaL4gj+QoHSIxghPiK7BMrYkoz3UqiFY=;
        b=J3sZhFXPSSzUX4yKCSEuKZQT62JsQqGYb1HRnmO9mjhqOY0bewSbQNO/dUltik2oqC
         aDwJY2qePiiCJVoks+zjyyKMd93xhTAeu8NDzwLelHHqKLgKsUlVm3gZ7+jWKJDrm1LV
         78XJWpBEjwYTO/6GqGg+zsETVm+vyfvKedqzx2xq1szzd5dEgJY4CjL7ssqj+CrJEm2U
         4q+cwIYzMz7xObKzXN23e27+TIAnU+AIYXLl5/CIAHiN+kAmHdag1zbn3Kn9LTmME04x
         gkzOHPeawLnVxQ9OX8fh6ew9kU5OJxpbK01FMEVI5/CxwDL3DvmDda06rk3KKOpYMsP4
         O+Xg==
X-Gm-Message-State: AOAM5305Gy79vJggZn3fRVpqaxNefPNezHrqHSiI6PgbLanSBDgEtpp+
        RZNrjI7Vaag4HypmN86PjLweEw==
X-Google-Smtp-Source: ABdhPJw2loeaen4WaZxpBe/spA/fVs+4ffRjHSze4eDridvB2az6VqCfxFD+ex7l2U2+TGVENJ7Bpw==
X-Received: by 2002:a5d:640c:: with SMTP id z12mr4861979wru.342.1612978480701;
        Wed, 10 Feb 2021 09:34:40 -0800 (PST)
Received: from kernelvm (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id o12sm3913030wrx.82.2021.02.10.09.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:34:40 -0800 (PST)
Date:   Wed, 10 Feb 2021 17:34:38 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, luk@wybcz.pl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: cleanup macros within
 include/rtw_debug.h
Message-ID: <20210210173438.GA1349@kernelvm>
References: <20210210170003.100880-1-phil@philpotter.co.uk>
 <YCQUFvhKW7rSR6qy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQUFvhKW7rSR6qy@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 06:12:54PM +0100, Greg KH wrote:
> On Wed, Feb 10, 2021 at 05:00:03PM +0000, Phillip Potter wrote:
> > Remove do/while loops from DBG_871X, MSG_8192C and DBG_8192C. Also
> > fix opening brace placements and trailing single statement layout within
> > RT_PRINT_DATA, as well as making newline character placement more
> > consistent and removing camel case where possible. Finally, add
> > parentheses for DBG_COUNTER definition.
> > 
> > This fixes 3 checkpatch warnings, 5 checkpatch errors and 3 checkpatch
> > checks.
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
> 
> Odd, the do/while is correct here, why is checkpatch complaining about
> it?

The warning it gives me for these is:
WARNING: Single statement macros should not use a do {} while (0) loop

> 
> >  #endif /* defined(_dbgdump) */
> >  #endif /* DEBUG */
> >  
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
> 
> This is not the same as the above stuff, when you find yourself writing
> "also" in a changelog text, that's a huge hint you should break the
> patch up into a patch series.
> 
> Please do that here, this is too much for one patch.
> 
> thanks,
> 
> greg k-h

Thank you for the feedback, I'll do this - shall I leave out the
do/while stuff if you're saying checkpatch is wrong?

Regards,
Phil
