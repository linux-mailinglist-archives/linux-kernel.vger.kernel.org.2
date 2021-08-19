Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE63F1405
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhHSHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhHSHH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:07:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA7C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:07:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u3so10752964ejz.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4OwX74q04U3Z64KJiTep2sFvtc+gcgTGZYkPI+IqrI=;
        b=XYpAm1TDfcahj17G3zDPV13rG/lwi0wRw+zNG6iNmaZaEJmnTxw/YN63HmdUIeXWe+
         memsdOb1/I1LbtuYTGoBiBMc5G3eex6PVOs5kO0BlIumEKc5WgxJ8jwcRJzxWDP9Gkxz
         WuCu3cWHGiIG8dAl6J8++KiNQQbuZpLfMkUPx4VhcN+vYoYkGsKyPT8tgm7vY8a8fnOj
         s7mAL4er5lSfmWwf8Z6VVdhKAPL7Ag/zgPzBVw3Sa3w9JjEszWg6iuupLX2UhUDz5uHb
         dsAlt8TcbzmdpAp2RqN7ciGAZXd4FteNI3Cm81NoUyxVoGEB1BZj3bfB6odTkUqjFsoy
         bNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4OwX74q04U3Z64KJiTep2sFvtc+gcgTGZYkPI+IqrI=;
        b=Hl/E6a7dTEIcWc4/ZLACI4N/u22fB9T6T2kaXI6czliDBlmTG8JkTxwNP/OHKR7tZV
         Z+COR44pBkyHHo9pYFdxrKWNJzHCXC2IBxZ1+7gaDLU6lGUZcxcfSMd/31rhZ+MUHPlb
         64ppHeW2ue++lS83dms3dyutdnc00kz4BMabWDg6XAB529GxYfU92Ko73cX4iImpeIxk
         tExskWlLKNCc//FW4UJmddy+2eyeazcnBdtTSiOqLyLZb9WbdAdAbt5KeGisapWzUhtG
         wE8JHZmD7TB/po8mBwokJMAL+Ab0lxJJaDTZtjnsoWhk5Ct43LuEgLkeV1pBuPFE0EKj
         R49Q==
X-Gm-Message-State: AOAM532x4Nk9JP7jkzq01VJgN3YT6p+IINhBVCNy9lfZSFg9Ao8Xsb6X
        R1tPKR2DJmkiMO+/0hSEzc4=
X-Google-Smtp-Source: ABdhPJxKHzB2gzrDkRztDR+AfUQswsotL6A7IMyAynCQCLHUaNAbpJT1CIhl3DrYABQYItou95nZJw==
X-Received: by 2002:a17:906:779a:: with SMTP id s26mr14364159ejm.106.1629356842416;
        Thu, 19 Aug 2021 00:07:22 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id q6sm826752ejm.106.2021.08.19.00.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 00:07:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Date:   Thu, 19 Aug 2021 09:07:20 +0200
Message-ID: <4394431.3q0Da8apZE@localhost.localdomain>
In-Reply-To: <YR36fT6bpiVoo2lM@kroah.com>
References: <20210819060837.23983-1-fmdefrancesco@gmail.com> <YR36fT6bpiVoo2lM@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 19, 2021 8:30:21 AM CEST Greg Kroah-Hartman wrote:
> On Thu, Aug 19, 2021 at 08:08:37AM +0200, Fabio M. De Francesco wrote:
> > Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> > unnecessary wrappers, respectively to mutex_lock_interruptible and to
> > mutex_unlock(). They also have an odd interface that takes an unused
> > second parameter "unsigned long *pirqL".
> > 
> > Use directly the in-kernel API; check and manage the return value of
> > mutex_lock_interruptible().
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_mlme_ext.c     |  5 +++--
> >  drivers/staging/r8188eu/hal/usb_ops_linux.c     |  7 +++++--
> >  drivers/staging/r8188eu/include/osdep_service.h | 13 -------------
> >  drivers/staging/r8188eu/os_dep/os_intfs.c       |  5 +++--
> >  4 files changed, 11 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > index f6ee72d5af09..484083468ebb 100644
> > --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > @@ -4358,7 +4358,8 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
> >  	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
> >  		return -1;
> >  
> > -	_enter_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
> > +	if (mutex_lock_interruptible(&pxmitpriv->ack_tx_mutex))
> > +		return -EINTR;
> 
> But the code never would return this value if the lock function returned
> an error.  Why do that here now?

I read from the documentation that "[mutex_lock_interruptible()] Return: 0 if 
the lock was successfully acquired or -EINTR if a signal arrived.". 

After reading that, I thought that if I got -EINTR I should return it. Shouldn't I?

Now I've just checked its usage pattern in another file where we have exactly 12
times the same management of the error (the example I'm talking about is in
drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c):

"if (mutex_lock_interruptible(&instance->vchiq_mutex))
                return -EINTR;".

Unless you mean that I should return the "ret" variable, which is already set to 
"_FAIL", I am really confused. Please, can you further elaborate what I'm doing 
wrong?

Thanks,

Fabio



 
  
> 
> thanks,
> 
> greg k-h
> 




