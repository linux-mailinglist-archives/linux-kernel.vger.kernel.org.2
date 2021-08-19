Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFD03F1BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbhHSOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240137AbhHSOvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:51:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B02CF60231;
        Thu, 19 Aug 2021 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629384669;
        bh=mqlbbTGtIEi8G/JgjYJA5lBveLz8RQwPhrw58wj1KfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOE1dFTbUkDXVtxREFoFQplxUWsy9QqHcOYdzARpxHfIqAFuKOtzbqOVa4Rld4Bub
         EasZv/1aI14qf+vZFo+wCrKJZmaG6MDwzy0vkAOBhvmpiqnxjr4T2GqkRY5R7y+OTM
         8OiMR5L6nW+JJ8590CnBm4FtTfIPJKqijBcvnBnA=
Date:   Thu, 19 Aug 2021 16:51:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Message-ID: <YR5v2aMyr/Aa26Mm@kroah.com>
References: <20210819060837.23983-1-fmdefrancesco@gmail.com>
 <YR36fT6bpiVoo2lM@kroah.com>
 <4394431.3q0Da8apZE@localhost.localdomain>
 <2072985.qfodHclbUl@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2072985.qfodHclbUl@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 12:16:03PM +0200, Fabio M. De Francesco wrote:
> On Thursday, August 19, 2021 9:07:20 AM CEST Fabio M. De Francesco wrote:
> > On Thursday, August 19, 2021 8:30:21 AM CEST Greg Kroah-Hartman wrote:
> > > On Thu, Aug 19, 2021 at 08:08:37AM +0200, Fabio M. De Francesco wrote:
> > > > Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> > > > unnecessary wrappers, respectively to mutex_lock_interruptible and to
> > > > mutex_unlock(). They also have an odd interface that takes an unused
> > > > second parameter "unsigned long *pirqL".
> > > > 
> > > > Use directly the in-kernel API; check and manage the return value of
> > > > mutex_lock_interruptible().
> > > > 
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > >  drivers/staging/r8188eu/core/rtw_mlme_ext.c     |  5 +++--
> > > >  drivers/staging/r8188eu/hal/usb_ops_linux.c     |  7 +++++--
> > > >  drivers/staging/r8188eu/include/osdep_service.h | 13 -------------
> > > >  drivers/staging/r8188eu/os_dep/os_intfs.c       |  5 +++--
> > > >  4 files changed, 11 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > > > index f6ee72d5af09..484083468ebb 100644
> > > > --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > > > +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > > > @@ -4358,7 +4358,8 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
> > > >  	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
> > > >  		return -1;
> > > >  
> > > > -	_enter_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
> > > > +	if (mutex_lock_interruptible(&pxmitpriv->ack_tx_mutex))
> > > > +		return -EINTR;
> > > 
> > > But the code never would return this value if the lock function returned
> > > an error.  Why do that here now?
> 
> Ah, now I think I understand what you asked me ... sorry for not having 
> immediately grasped the meaning of your objection. :(
> 
> I guess you wanted to know why I decided to check and handle the 
> return values of mutex_lock_interruptible (), as the original code didn't. 
> Did I understand the correct meaning of your question?

Yes, that is correct.


