Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D024118DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbhITQIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhITQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:08:42 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68FAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:07:15 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d207so19027399qkg.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JR0eY503IkHJjk9jTmWA+lRcED24SP8xeTX1ZCjwatw=;
        b=F0o/6n6KN+ekB/ZkFTt9D3rjV8YW/1lrBw73xIsa9IvuPtDwj0uwMmPtuXgY+QvKHa
         HdSxdEjZdaxIG1wjaMScQzwLefU3zRrfSwhJ1bg6iPVe7xXF8UPkajxbuWR0dKamuivS
         DNo2Fb6k47ZXUoJSFOQQa5TJK0Te5Dgpsgrvr96TY/Oalo6BX8efPVQLyMJFs3mfOuAU
         97Uqm2Fm+cnXccDungqscRAOjf1HPrJ2tgQDfW9btTqwJ8LbXcxXe0i3yOl5k/b5WZ/l
         cdW00uPceGN1O7sMVG3gkm95dhN2mrHt931s34OdNwPCBuPzsaizw2dkcbnCY4THIPDr
         gRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JR0eY503IkHJjk9jTmWA+lRcED24SP8xeTX1ZCjwatw=;
        b=oqOJf7+CHr+l4MauoeJ8kNAB1ODMUnWTQyw5sKBV1xcfpgpCoGowp3twkBMj3Su/3b
         7yqCGp/sLncYxCNd8YSlHxBYp65L0JBkjKwnt2s8ap3JGZ0poW3a0xW4iuBdQmogF9bg
         k3oBFBjSnZLfCWrFxLdKv9d4Uu83meGLHZmTXoLtoXu1+4/p1MTk6FfSWt62U59J2dOJ
         AH7pNEi0W2sM80xOAXeOaMvMH6LO5ED28WFjK+vIctGqBbFBBfnE9sZqB8DcdPVSpTXM
         ukjhfp9FjeBwSI83SINkjwEraayCCWX/ZHdVZCYdS5LxFP2+rktniqY8qtEMClFoXfQl
         sgYw==
X-Gm-Message-State: AOAM5323lcTKuOwTS2WVEx++2o0p+eFzta1kZaKpBAPN+MXae5HcBoUO
        yTlcfIfN1aEQCBnROqd5szVUg+4/NZXBKGeT
X-Google-Smtp-Source: ABdhPJzH7fvxRNhTIJY6Fa1bhJ6FfAhbXKwduBasI9xtxCION+BPW7g4JPtBNgY3xnuUSpyTsTkIkw==
X-Received: by 2002:a37:9244:: with SMTP id u65mr25338431qkd.46.1632154034728;
        Mon, 20 Sep 2021 09:07:14 -0700 (PDT)
Received: from Zachary-Arch ([128.211.185.212])
        by smtp.gmail.com with ESMTPSA id p12sm3180353qkj.54.2021.09.20.09.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:07:14 -0700 (PDT)
Date:   Mon, 20 Sep 2021 09:07:13 -0700
From:   Zachary Mayhew <zacklukem.kernel@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@lists.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: add docs for fbtft_write_spi()
Message-ID: <YUixsZQ/J0dPfJqj@Zachary-Arch.localdomain>
References: <20210920152601.170453-1-zacklukem.kernel@gmail.com>
 <YUiq9iDGLN6+5+rd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUiq9iDGLN6+5+rd@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 05:38:30PM +0200, Greg KH wrote:
> On Mon, Sep 20, 2021 at 08:26:03AM -0700, Zachary Mayhew wrote:
> > Subject: [PATCH] staging: fbtft: add docs for fbtft_write_spi()
> 
> Odd, this shouldn't be in the body of the email :(
> 
> > 
> > This patch adds documentation for fbtft_write_spi() to make its
> > calling context clear and explain what it does.
> > 
> > Signed-off-by: Zachary Mayhew <zacklukem.kernel@gmail.com>
> > ---
> >  drivers/staging/fbtft/fbtft-io.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
> > index de1904a443c2..985d7cf8c774 100644
> > --- a/drivers/staging/fbtft/fbtft-io.c
> > +++ b/drivers/staging/fbtft/fbtft-io.c
> > @@ -5,6 +5,19 @@
> >  #include <linux/spi/spi.h>
> >  #include "fbtft.h"
> >  
> > +/**
> > + * fbtft_write_spi() - write data to current spi
> > + * @par: Driver data including driver &struct spi_device
> > + * @buf: Buffer to write to spi
> > + * @len: Length of the buffer
> > + * Context: can sleep
> > + *
> > + * Builds an &struct spi_transfer and &struct spi_message object based on the
> > + * given @buf and @len.  These are then used in a call to spi_sync() which will
> > + * write to the spi.
> > + *
> > + * Return: zero on success or else a negative error code
> > + */
> >  int fbtft_write_spi(struct fbtft_par *par, void *buf, size_t len)
> >  {
> >  	struct spi_transfer t = {
> > -- 
> > 2.33.0
> > 
> > 
> 
> Is this file being imported into the kernel doc tools?  If so, great, if
> not, this isn't going to help out all that much, right?

It doesn't appear to be imported at this time, as such it may not be
necessary.

> 
> thanks,
> 
> greg k-h

Thanks,
-Zachary Mayhew
