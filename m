Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E23F211E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhHSTz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhHSTz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:55:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D18AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:54:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cn28so10523601edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdPJqUzTL2bla6o5m8emr68PiRiwMbtm4VxJ8aYSnJI=;
        b=Go0zo6OpZx6zkBFoWqRkkGqGLYF1z+tpF+Yjoi3qfLlP7b0p5QlEWCUlRAWX7UACZ+
         oKX+CFTioduno/XaVrFXAWBmnHDIetZa1ZfEt/aucUP8R2F09+MHPNhhD9sJQCpMovfR
         Ckzo5dIOEcuQjvfjMCKRD6CuPhigfbLjlp3tJLwLZ1seNDOuPuzDocIbNDL0CvsJtpKj
         tvlWU6XWu3uL/VNGAMJXzsFUjGhWjGW5hOX58r/LZ05UGsPiZHDfQe/pL99f8AAmJVP5
         Hag6s15f83tcPawCNh8TCfMGcJ16ZUL3KKQUMFGJNzVfbWknHNtr1Qg+w3Jd2KIa2JqQ
         ln7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdPJqUzTL2bla6o5m8emr68PiRiwMbtm4VxJ8aYSnJI=;
        b=EADqLtX1KhMWxvPbfOx2alxomHmE5uVagIzfcw01QxBf0u1nsRdkpmlMT05VWY7Ups
         QIKoiVa3qwz1oRtSpjxOYygfjq22qRF6vagJapb473BYjN7Zt627sI1qQ8bnJfoL1vp1
         utlh2qkJVikRXeCOvssEkHn2+pJ/4bZXb5XLWShLJKe2f0NPNnVkIdTVacVEgvkw2TES
         UC5NYd+3Si9fQoB2HLFZqvURehVPP9TgBN78bUqP5QHRJUo7w/LCe3RGZuajxAwbzzyt
         dFheuvfunQp/MXVwGjxTQRdyDDxiG7Ak7SrkKmu9ow3uR8fTmNrCaEP8GPrC8ZBeBBRX
         0+Sg==
X-Gm-Message-State: AOAM530cxO2YWQASm7GCVW+a9JI9uTWGyV2VEk8CXjQQ/SWQ5g+vnEEx
        y9lPrJbvSUUs1MxheHkIiAU=
X-Google-Smtp-Source: ABdhPJzZUVQuabzx+Km5OlD9feqJ0uV9LNd7LSIqp3kU4U/7m7B8ur7iwnPhsWq/18VGP7RJ8JCbIw==
X-Received: by 2002:a05:6402:1515:: with SMTP id f21mr18559310edw.45.1629402888214;
        Thu, 19 Aug 2021 12:54:48 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id z6sm2283930edc.52.2021.08.19.12.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 12:54:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Date:   Thu, 19 Aug 2021 21:54:46 +0200
Message-ID: <2580811.joLFa7Ctqg@localhost.localdomain>
In-Reply-To: <YR5wiOgWXXFqVDH+@kroah.com>
References: <20210819124955.25540-1-fmdefrancesco@gmail.com> <YR5wiOgWXXFqVDH+@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 19, 2021 4:54:00 PM CEST Greg Kroah-Hartman wrote:
> On Thu, Aug 19, 2021 at 02:49:55PM +0200, Fabio M. De Francesco wrote:
> > Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> > unnecessary wrappers, respectively to mutex_lock_interruptible() and
> > to mutex_unlock(). They also have an odd interface that takes an
> > unused argument named pirqL of type unsigned long.
> > Replace them with the in-kernel API. Ignore return values as it was
> > in the old code.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v2: Ignore return values from Mutexes API.
> > 
> >  drivers/staging/r8188eu/core/rtw_mlme_ext.c     |  5 +++--
> >  drivers/staging/r8188eu/hal/usb_ops_linux.c     |  5 +++--
> >  drivers/staging/r8188eu/include/osdep_service.h | 13 -------------
> >  drivers/staging/r8188eu/os_dep/os_intfs.c       |  5 +++--
> >  4 files changed, 9 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > index 5325fe41fbee..9f53cab33333 100644
> > --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > @@ -4359,7 +4359,8 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
> >  	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
> >  		return -1;
> >  
> > -	_enter_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
> > +	if (mutex_lock_interruptible(&pxmitpriv->ack_tx_mutex))
> > +		;	/*ignore return value */
> 
> Ick, no.  (not to mention the wrong comment style...)
> 
> If this really is "criticial", why can it be interrupted?
> 
> The existing code is such that the code can be interrupted, but if it
> fails, the lock is not gotten, and the CODE CONTINUES AS IF IT IS OK!

This was perfectly clear. The old code ignored -EINTR and, in case when
blocking to wait for the lock to become available is interrupted (although
I really don't know how - a signal to a driver? I guess it cannot happen) it
continues to execute in the critical region so leading to potential race 
conditions.

This is what I get and I guess I'm not too far from the truth... Did I get it
right?
 
> So either this is never interruptable (my guess, one almost never needs
> interruptable locks in a driver) 

This is what I think, why interruptible locks in a driver? I suppose that they
should only be used when the kernel executes on behalf of a process. 

> and should just do a normal mutex lock,
> or the code is totally broken and the locking should be revisited
> entirely.

My guess is that the code that is waiting to acquire a lock could *really*
be interrupted should manage that interruption without falling blindly
in the critical region and we have two ways to do that:

1) return -EINTR to the caller which should manage that error by retrying
the acquisition, or

2) retry in a loop inside the callee, avoiding to proceed to the critical section
without an acquired mutex.

A third option is using mutex_lock() (uninterruptible), which I would prefer
if I were absolutely sure that nothing could interrupt waiting for acquiring
the lock. 

I have to look at how other drivers manage similar cases, although I'm 
pretty convinced that a simple mutex_lock() should be fine here.

Thanks,

Fabio

> But a "blind" change like this is not good, let's get it right...

I agree, let me take some time to investigate what are the best practices 
that the kernel implements in cases like this. What I'm sure at the moment is 
that the old code, as-is, is broken.

Thanks,

Fabio
 
> thanks,
> 
> greg k-h
> 




