Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB93D964E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhG1UAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhG1UAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:00:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EE0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 13:00:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t21so4012804plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TJBawUD1aFfD+dzRqdwJ1MPEWpORtq7Fvvwh0fqmN4w=;
        b=U5xnZ2ApxaMWnn7gJYnJAR8u59w7nGyYjuMteJJ5vh2utJ4V+34Hki0luScN94y1q5
         NY7LJKxP0vdSs/BkhP4DvbU7p6TW8iGGLqYrsAgsXtFXw3z4kD6jfWlLcSNJq1dwldXH
         csVkvbMVSaBdzCzmn4y28pFJJ6R7MAveCAHYupzmC5jABC4uID9rD1tNvWsHFP6EuitP
         zz9zn2HchfkHh/FwP/LwNVEERNucc53wq7+yJRc3x98OP4+PY9iNN7tyJPbQ/rAj6XF4
         LtutpaEF6eqyZtY0HfbHWNEuwDt0yVaHLSFCpzTkNwcr15QBhOkGoIRO60MThiEhkT1e
         OyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TJBawUD1aFfD+dzRqdwJ1MPEWpORtq7Fvvwh0fqmN4w=;
        b=GpECbLONOXYPhjBfkACUJufnzcZJhfNYASmUP9/novQ2/6mEprQuqq7XZWqL0RJV64
         zCrd/XlymStcFrqizWNvqswPyNJXAfytwWYfhqwuykzO0r6MFQCoeh9JmLKcpNYdwM0e
         +kA5pHH+xWl+nD0YzHH3nTlLbGvqvxcgqaZRds8i7cmfXUkvuqRhUr937EeR3NX2xKrH
         F8ybEi01cDz5INAybQoYErhADeFi3tQmqibNuLSdZZDKLx+rDXBASSaXh9h5bswcJpGT
         STD+JwIiRr6BAfsMAi4VBdEZFGnADftAn3PLv7w6eHFfnpD7+6z8cHwQSdTISovh8gHH
         eOzw==
X-Gm-Message-State: AOAM533B7TOCqQDKkKSPfSA2BKtqWQVAupTiEfGc2N+9zCXWnvHWPZWQ
        ZAjYrCyVJlpXIbuwWU9H0HA=
X-Google-Smtp-Source: ABdhPJxglSz5HVVd1rwyBjzRsuioP4LKmTyej4fYd6rxpo5LXhgxwUrQNYu6edeKN6oVLP3h57Ocvg==
X-Received: by 2002:a17:90a:7505:: with SMTP id q5mr9437802pjk.64.1627502449011;
        Wed, 28 Jul 2021 13:00:49 -0700 (PDT)
Received: from ojas ([122.161.51.5])
        by smtp.gmail.com with ESMTPSA id b13sm808153pfl.49.2021.07.28.13.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 13:00:48 -0700 (PDT)
Date:   Thu, 29 Jul 2021 01:30:39 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     nsaenz@kernel.org, stefan.wahren@i2se.com,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vchiq: Add details to $CONFIG_VCHIQ_CDEV
 help text
Message-ID: <20210728200039.GA17046@ojas>
References: <cover.1627495116.git.ojaswin98@gmail.com>
 <9c9c128b41e31d6bebe646e052aa05c44b19eb83.1627495116.git.ojaswin98@gmail.com>
 <YQGmG6nwk+pOyAdu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQGmG6nwk+pOyAdu@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:46:51PM +0200, Greg KH wrote:
> On Thu, Jul 29, 2021 at 12:07:17AM +0530, Ojaswin Mujoo wrote:
> > Add some details to the Kconfig definition of $CONFIG_VCHIQ_CDEV to help
> > make the motive behind it a bit more clear.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> > ---
> >  drivers/staging/vc04_services/Kconfig | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
> > index 2b70c37cdd09..cb02d8a4cb74 100644
> > --- a/drivers/staging/vc04_services/Kconfig
> > +++ b/drivers/staging/vc04_services/Kconfig
> > @@ -25,8 +25,12 @@ config VCHIQ_CDEV
> >  	bool "VCHIQ Character Driver"
> >  	default y
> >  	help
> > -		Enable the creation of VCHIQ character driver to help
> > -		communicate with the Videocore platform.
> > +		Enable the creation of VCHIQ character driver to help communicate
> > +		with the VideoCore platform. The cdev exposes ioctls used by
> > +		userspace libraries and testing tools to interact with VideoCore.
> > +		This can be set to 'N' if the VideoCore communication is not needed
> > +		by userspace but only by other kernel modules (like bcm2835-audio).
> > +		If not sure, set this to 'Y'.
> 
> I still do not understand if I need this driver or not, and I have this
> hardware!  What functionality does this driver accomplish?  What is
> VideoCore?
Hey Greg,

I believe I can add this under the CONFIG_BCM2835_VCHIQ config option,
as that enables the core driver that implements the functions to
communicate with VideoCore platform? 

This config option merely adds a cdev which exposes the the core
driver's functionality to userspace. 

Regards,
Ojaswin
> 
> thanks,
> 
> greg k-h
