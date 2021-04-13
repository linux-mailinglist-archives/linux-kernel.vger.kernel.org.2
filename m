Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD335E451
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbhDMQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:48:32 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:37565 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbhDMQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:48:28 -0400
Received: by mail-ej1-f49.google.com with SMTP id w3so27059612ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PPrRY59PSM3yh1tKzKnDdwXXNAeLcHdKyiHLS4Gj0hA=;
        b=PWc+O58bUAq/kMKopVybp8PnVvTQooI+TmUFcMtKNxZToh6H59xzyXWGeWkVeN6dOQ
         4ZXH8yBZsuEiv/KzeLynhpQouNAN0t4LHnPMpsW5fcTPSPi9r0ybW+jcPx8pftEqM/6v
         FWpO/yxes1F9i9ZNMcPJVyJXl/4vCASSa8LinvIXP2cl9J+pWueBjZjblMhS5OCG807k
         G914OIPOC/U8+BdFOTYm8BvSSGsLxQ/QGMvGcxrALARS3cwxHN2Vsg+wmOetdDMNFlKf
         HqYDX6KOlw1RAyVZMiava4gZFPB2OW6tgPXOI6f33e/TFbItHYpIllphVTMZfO/oZryf
         +/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PPrRY59PSM3yh1tKzKnDdwXXNAeLcHdKyiHLS4Gj0hA=;
        b=s9YGShUF2iTKtxQQTA9Wa0qCr1YTDPSh0Tztu+RbTwMQBPIKx96ytMvrtx8Tzjecdz
         u4JdPZ3HYi+/ZR2Ca2uAB+gSoRGeTTQi03o9PrZ/4kCIWMkx8ExZOqx8H/GeuJkKzwNN
         yI2lGSqU79W3QYPORM74PMQlTg9OcdfraRoUTLBB/1497qE+89ro0pGm3zRiQHfmGk+J
         sQlz6kXBLNq81SgfSwAM3I5lhn2rPjzIH4CW6kIsJOp1AJVvEUJ1IsXJbU5mg9iowaOd
         L1pYesK+8BWg5yyIiQjIabC6VI39wMj4QRqkmYUYKMeoGcQcpYH4x9u4TwovrPGRc8ln
         2ofw==
X-Gm-Message-State: AOAM531ehkLRG+An9kEvmdT8xteWtc8MrsEp0jJhYaRbP8xI2Fsur/Q+
        j52TldA5ua4k6IwJS+qeS/juL5OmDaT/lbZr
X-Google-Smtp-Source: ABdhPJz0gemxtEUhkyNn+0UOr/2CuNn6V/jLhexji8Boak1pkWkg0uu9NyPIsR+dKLLzEGf9b7Bqow==
X-Received: by 2002:a17:906:29cf:: with SMTP id y15mr8381481eje.500.1618332427687;
        Tue, 13 Apr 2021 09:47:07 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id j6sm9549653edw.73.2021.04.13.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:47:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Tue, 13 Apr 2021 18:47:06 +0200
Message-ID: <3381109.TaO10cqo9c@linux.local>
In-Reply-To: <alpine.DEB.2.22.394.2104131826160.8430@hadrien>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com> <1843649.8FsqevVC75@linux.local> <alpine.DEB.2.22.394.2104131826160.8430@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 13, 2021 6:27:17 PM CEST Julia Lawall wrote:
> On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > On Tuesday, April 13, 2021 6:04:16 PM CEST Julia Lawall wrote:
> > > On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > > > Removed the led_blink_hdl() function (declaration, definition, and
> > > > caller code) because it's useless. It only seems to check whether
> > > > or
> > > > not a given pointer is NULL. There are other (simpler) means for
> > > > that
> > > > purpose.
> > > > 
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 1 -
> > > >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
> > > >  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
> > > >  3 files changed, 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > > 0297fbad7bce..4c44dfd21514 100644
> > > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > @@ -150,7 +150,6 @@ static struct cmd_hdl wlancmds[] = {
> > > > 
> > > >  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
> > > >  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param),
> > > >  	set_chplan_hdl) /*59*/>
> > > > 
> > > > -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param),
> > 
> > led_blink_hdl)
> > 
> > > > /*60*/
> > > 
> > > This is worrisome.  Doyou fully understand the impact of this?  If
> > > not,
> > > the change is probably not a good idea.
> > 
> > This is that macro definition:
> > 
> > #define GEN_MLME_EXT_HANDLER(size, cmd) {size, cmd},
> > 
> > struct C2HEvent_Header {
> > 
> > #ifdef __LITTLE_ENDIAN
> > 
> >         unsigned int len:16;
> >         unsigned int ID:8;
> >         unsigned int seq:8;
> > 
> > #else
> > 
> >         unsigned int seq:8;
> >         unsigned int ID:8;
> >         unsigned int len:16;
> > 
> > #endif
> > 
> >         unsigned int rsvd;
> > 
> > };
> > 
> > It's a bit convoluted with regard to my experience. Probably I don't
> > understand it fully, but it seems to me to not having effects to the
> > code where I removed its use within core/rtw_cmd.c.
> > 
> > What am I missing?
> 
> It seems that the function is being put into an array.  Probably someone
> expects to find it there.  Probably you have shifted all of the functions
> that come afterwards back one slot so that they are all in the wrong
> places.
> 
> julia
>
Thanks for your explanation. Obviously this implies that the function 
cannot be removed, unless one fill the slot that is deleted by to not 
calling this macro at the right moment. 

I also suppose that providing a function pointer with a NULL value wouldn't 
work either.

OK, h2c_msg_hdl() cannot be deleted.

Thanks,

Fabio
  




