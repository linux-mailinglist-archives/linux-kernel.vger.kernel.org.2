Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57DB35E73C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhDMTpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhDMTp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:45:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA23C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:45:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w23so12011369ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 12:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/r8Po62UU7ReVjPXAww2n9wrwCFgCw+v/ZKXdTzJ4fs=;
        b=nCNyA8h1EVH4+7f1bRMHsvhOwFMaHC9ADVJeCi5C7OEzIQt28nalhXIw1D3D8bfioq
         KLTxTuzA+arKaVV/OUQRzJqQgzf4pPE9VZnIJ3SZ1vzwmQPgCpIJ3IO5gh9IKj+kmKez
         4MKQzKjsQpMG1hI1Wdiw5Pe8lzE1gjMhhMp1xNSAiZGsbGQdSE+xuC8GOzuI56p3P+qY
         4pSyoA1SSKJzF7xhYT4uED5k6Qp8YN/1pvPBTRBG8PkY7mNPeOrIZ1hRNbUQIhe+/0g6
         6Ja5xhUgjt9DV56KIrh98YbUWUX5ZAJR1MYnmzAT0x3Ba8ZL5hLhXSTmquOht07BTS0G
         eVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/r8Po62UU7ReVjPXAww2n9wrwCFgCw+v/ZKXdTzJ4fs=;
        b=uY3ap9YqeKXf/1n5k5u2utLJLcbYCqZE1/5ZlxqEPGQy/s2sWlL87VIUvqkgfCmEKw
         P/1amWSZCrr14ZUqt1yBqfxPAV+BrSUpLMEmWAnv71IowysxnXuwCykArPIVNN3QnA5J
         9Sp6wtehwnB2sPYeQTjfzTLZ01pEOeqJMH8ZNiUF6Lm8ldmvAFo1qYYxg2R8/h9fvnNU
         bOxwAEDC8b8w8ZwIRxXtOJzrgxyRIaXUk+j2F3PSHFVQMYNuQ3M32BovJRGBPt0wIi7A
         9pyhH6/n+P6hGPdp9aX056rOQVqo/gg0p+hhLYJ/3E5pHRES9d32qGBYvbSB451gbi4g
         6ZNw==
X-Gm-Message-State: AOAM5300JfM2GmB3aWncaIGMpTHnt5WwfdHyM/RhZBzKvu8z3C1TOUzr
        cu3n7CA8uKseOmKkj/1f+sU=
X-Google-Smtp-Source: ABdhPJzyOFNyuMwGCptJ+wZNP2kaNQa66k3nnYD8QtMl+lTY1sLbKLQieDVFZRLzuQzOrfBx+Zr1+w==
X-Received: by 2002:a17:906:4a90:: with SMTP id x16mr13471772eju.44.1618343104974;
        Tue, 13 Apr 2021 12:45:04 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id w13sm9718354edc.81.2021.04.13.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 12:45:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Tue, 13 Apr 2021 21:45:03 +0200
Message-ID: <7008359.Jy8utYDuns@linux.local>
In-Reply-To: <alpine.DEB.2.22.394.2104132123180.14108@hadrien>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com> <2400087.QbMOWSuNhY@linux.local> <alpine.DEB.2.22.394.2104132123180.14108@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, 2021 9:25:05 PM CEST Julia Lawall wrote:
> On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > On Tuesday, April 13, 2021 8:57:20 PM CEST Julia Lawall wrote:
> > > On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > > > On Tuesday, April 13, 2021 8:20:50 PM CEST Dan Carpenter wrote:
> > > > > On Tue, Apr 13, 2021 at 06:47:06PM +0200, Fabio M. De Francesco
> > 
> > wrote:
> > > > > > On Tuesday, April 13, 2021 6:27:17 PM CEST Julia Lawall wrote:
> > > > > > > On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > > > > > > > On Tuesday, April 13, 2021 6:04:16 PM CEST Julia Lawall 
wrote:
> > > > > > > > > On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > > > > > > > > > Removed the led_blink_hdl() function (declaration,
> > > > > > > > > > definition,
> > > > > > > > > > and
> > > > > > > > > > caller code) because it's useless. It only seems to
> > > > > > > > > > check
> > > > > > > > > > whether
> > > > > > > > > > or
> > > > > > > > > > not a given pointer is NULL. There are other (simpler)
> > > > > > > > > > means
> > > > > > > > > > for
> > > > > > > > > > that
> > > > > > > > > > purpose.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Fabio M. De Francesco
> > > > > > > > > > <fmdefrancesco@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > > 
> > > > > > > > > >  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 1 -
> > > > > > > > > >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9
> > > > > > > > > >  ---------
> > > > > > > > > >  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
> > > > > > > > > >  3 files changed, 11 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > > > > > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > > > > > > > > 0297fbad7bce..4c44dfd21514 100644
> > > > > > > > > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > > > > > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > > > > > > @@ -150,7 +150,6 @@ static struct cmd_hdl wlancmds[] =
> > > > > > > > > > {
> > > > > > > > > > 
> > > > > > > > > >  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
> > > > > > > > > >  	GEN_MLME_EXT_HANDLER(sizeof(struct
> > 
> > SetChannelPlan_param),
> > 
> > > > > > > > > >  	set_chplan_hdl) /*59*/>
> > > > > > > > > > 
> > > > > > > > > > -	GEN_MLME_EXT_HANDLER(sizeof(struct
> > 
> > LedBlink_param),
> > 
> > > > > > > > led_blink_hdl)
> > > > > > > > 
> > > > > > > > > > /*60*/
> > > > > > > > > 
> > > > > > > > > This is worrisome.  Doyou fully understand the impact of
> > > > > > > > > this?
> > > > > > > > > If
> > > > > > > > > not,
> > > > > > > > > the change is probably not a good idea.
> > > > > > > > 
> > > > > > > > This is that macro definition:
> > > > > > > > 
> > > > > > > > #define GEN_MLME_EXT_HANDLER(size, cmd) {size, cmd},
> > > > > > > > 
> > > > > > > > struct C2HEvent_Header {
> > > > > > > > 
> > > > > > > > #ifdef __LITTLE_ENDIAN
> > > > > > > > 
> > > > > > > >         unsigned int len:16;
> > > > > > > >         unsigned int ID:8;
> > > > > > > >         unsigned int seq:8;
> > > > > > > > 
> > > > > > > > #else
> > > > > > > > 
> > > > > > > >         unsigned int seq:8;
> > > > > > > >         unsigned int ID:8;
> > > > > > > >         unsigned int len:16;
> > > > > > > > 
> > > > > > > > #endif
> > > > > > > > 
> > > > > > > >         unsigned int rsvd;
> > > > > > > > 
> > > > > > > > };
> > > > > > > > 
> > > > > > > > It's a bit convoluted with regard to my experience.
> > > > > > > > Probably I
> > > > > > > > don't
> > > > > > > > understand it fully, but it seems to me to not having
> > > > > > > > effects
> > > > > > > > to
> > > > > > > > the
> > > > > > > > code where I removed its use within core/rtw_cmd.c.
> > > > > > > > 
> > > > > > > > What am I missing?
> > > > > > > 
> > > > > > > It seems that the function is being put into an array. 
> > > > > > > Probably
> > > > > > > someone
> > > > > > > expects to find it there.  Probably you have shifted all of
> > > > > > > the
> > > > > > > functions that come afterwards back one slot so that they are
> > > > > > > all
> > > > > > > in
> > > > > > > the wrong places.
> > > > > > > 
> > > > > > > julia
> > > > > > 
> > > > > > Thanks for your explanation. Obviously this implies that the
> > > > > > function
> > > > > > cannot be removed, unless one fill the slot that is deleted by
> > > > > > to
> > > > > > not
> > > > > > calling this macro at the right moment.
> > > > > > 
> > > > > > I also suppose that providing a function pointer with a NULL
> > > > > > value
> > > > > > wouldn't work either.
> > > > > 
> > > > > It would work.  That array is full of NULL function pointers.
> > > > 
> > > > Interesting, thanks.
> > > > 
> > > > I'm going to remove that function and replace its name in the macro
> > > > with a NULL function pointer.
> > > > 
> > > > I couldn't believe it would work when I wrote about that.
> > > 
> > > Have you checked that a value of NULL in that place is going to have
> > > the
> > > same effect as the function?
> > 
> > No, I have not, but perhaps is not relevant.
> > 
> > I want to give to the macro the name of an empty function that I define
> > in the same header where there the prototype of led_blink_hdl() is
> > defined now: something like "u8 empty_function { return 0; }"
> > 
> > Can it work
> > What do you think about it?
> 
> The previous function didn't return 0.  It returned something else.
> 
> To do anything this, you have to find where it is called and what result
> the call site expects.  If you don't have that information, it does not
> seem safe to modify the function.
> 
> julia
> 
> > Fabio
> > 
> > > julia
>
OK, let's summarize:

1) The driver doesn't call that function from anywhere else than the macro.
2) You have explained that the macro add its symbol to a slot in an array 
that would shift all the subsequent elements down if that macro is not used 
exactly in the line where it is.
3) Dan Carpenter said that that array is full of null functions (or empty 
slots?).

Unless that function is called anonymously dereferencing its address from 
the position it occupies in the array, I'm not able to see what else means 
can any caller use.

I know I have much less experience than you with C: what can go wrong?

Thanks for your time,

Fabio


