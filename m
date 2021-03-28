Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF8034BCA8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 16:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhC1Onw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhC1Ona (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 10:43:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DC7C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 07:43:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g20so5297099wmk.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rj1gHcqJ6D3CVg382aakQnCnhfVirIRkWk/I75I+2pU=;
        b=jBOU199SOD136BiiE/UJDFniyiUznX9ADK4GnmJMo++LCW2lAN54tLKszh+3SvusmX
         UHu96z0r4T0wUi0xCJdvmQ0WHKyN9yJTHrqlTG+3c++WD7S36hjLl/flmc9CgXoF2gwA
         3El9TUEoL3VeE8usij6C2qYKnmv/FLEihD85G+4O74D1O+UHgxVbzc07+DuPfThA5Njg
         fCGqqyITsLT5ERbn23hE9dItzJIyjrHRxARG4+k6KOXPhWrWg3Jg0C0KUeU2HUru4l3H
         OWO7niWCLG+BTS6jMbhgM4+pBW4whqXwuzSnni7fR2rruuUsZLhh+YDvmmeVhETe1AQz
         fySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rj1gHcqJ6D3CVg382aakQnCnhfVirIRkWk/I75I+2pU=;
        b=Q1fnl4+x2sf+5Ab+5QuC5M6oNxoK60cKHjfvrleZfyJX7xwwg4VAXCYUpKAcKDs9aK
         jBb5hNtuqgHqeUtut2B0OmfChzJ4n43t5xRopkqItcUPqaJlJGaUmvU8e40AbGFOxFPY
         x+zFYvoE/t8ZWxqWq5ErDmPh5hNXa0s7wJo+QX9xSOiCkpLcZuQ+8qNM/4QOFCRsLblo
         07QdTjmSgp6K4DwWmC2gwpN3BcKN8fYt68f7xUafRcWIOLA3NoYe4o28L4jAxE3iSXA2
         oPPirFOnDjW2jfnlaqqZh/Y45MUVuy0kHEmYJYTiT+c+zryNe8nXmE09/CspdSDGt574
         uoXA==
X-Gm-Message-State: AOAM532vDlrUODWnTCBqfAABeAGOe35bDHlk63QXvdOulYkwduvt+go/
        J7F6sWrNacv7oMDJbf+l4cM=
X-Google-Smtp-Source: ABdhPJyt7hBpZNlo1nw5ej5CH2Xsk4xrz95wFR6hcPpi0sns8O553cP9if1l6M+CTv1BhUZalWA1Mg==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr21066713wmb.62.1616942607297;
        Sun, 28 Mar 2021 07:43:27 -0700 (PDT)
Received: from agape.jhs ([151.47.29.17])
        by smtp.gmail.com with ESMTPSA id c2sm20997616wmr.22.2021.03.28.07.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 07:43:27 -0700 (PDT)
Date:   Sun, 28 Mar 2021 16:43:24 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     joe@perches.com, dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/20] staging: rtl8723bs: put parentheses on macros
 with complex values in include/rtw_debug.h
Message-ID: <20210328144322.GB1450@agape.jhs>
References: <cover.1616854134.git.fabioaiuto83@gmail.com>
 <f36448ddc1553a018f700983b5d436eacaef9cb3.1616854134.git.fabioaiuto83@gmail.com>
 <YGBxyZyj3o6fT//G@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGBxyZyj3o6fT//G@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 02:08:41PM +0200, Greg KH wrote:
> On Sat, Mar 27, 2021 at 03:24:08PM +0100, Fabio Aiuto wrote:
> > fix the following checkpatch warning:
> > 
> > ERROR: Macros starting with if should be enclosed by a
> > do - while loop to avoid possible if/else logic defects
> > +	#define RT_PRINT_DATA(_Comp, _Level,
> > 	_TitleString, _HexData, _HexDataLen)			\
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/include/rtw_debug.h | 28 ++++++++++---------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > index d1c557818305..b00f8a6c4312 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_debug.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > @@ -236,19 +236,21 @@
> >  #if	defined(_dbgdump)
> >  	#undef RT_PRINT_DATA
> >  	#define RT_PRINT_DATA(_Comp, _Level, _TitleString, _HexData, _HexDataLen)			\
> > -		if (((_Comp) & GlobalDebugComponents) && (_Level <= GlobalDebugLevel))	\
> > -		{									\
> > -			int __i;								\
> > -			u8 *ptr = (u8 *)_HexData;				\
> > -			_dbgdump("%s", DRIVER_PREFIX);						\
> > -			_dbgdump(_TitleString);						\
> > -			for (__i = 0; __i < (int)_HexDataLen; __i++)				\
> > -			{								\
> > -				_dbgdump("%02X%s", ptr[__i], (((__i + 1) % 4) == 0)?"  ":" ");	\
> > -				if (((__i + 1) % 16) == 0)	_dbgdump("\n");			\
> > -			}								\
> > -			_dbgdump("\n");							\
> > -		}
> 
> This whole nightmare needs to just be deleted and any callers of it need
> to use the in-kernel functions for this instead.
> 
> thanks,
> 
> greg k-h

ok, will we get rid of the private debug level and components tracking as well?

Maybe encapsulating the built-in proposed by Joe, keeping the macro alive?

Thank you,

Fabio
 
