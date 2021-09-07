Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9540238F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhIGGlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231779AbhIGGlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:41:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96DBB610C8;
        Tue,  7 Sep 2021 06:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630996826;
        bh=vw36oiTbd8GqLY+2Rft58nRS8q9JMwoME7OU7t2o8VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKPJR3sh0Zxgkpj1mC87uUzG/+S+CKTSkaO5q0KWpMc+nhaTYOuPu8wGlJgkA0o1d
         VmHcaPH0eeMWQN2yhCxzofmpQJk9Aj+zIzVT9DcAwGDKPh/vA66SAdD7r1REsOH47L
         19GQD7ccy1gH9lyZrOwnBvf30EkmWrDsyTrCJ5zo=
Date:   Tue, 7 Sep 2021 08:40:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: include: remove duplicate declaration.
Message-ID: <YTcJV4AuWF8xaZBJ@kroah.com>
References: <YTRuXTu/kePBDwAF@user>
 <YTXj+6QU10tYmec7@kroah.com>
 <c6cfec10-dc13-7d02-d122-76278b3d15be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6cfec10-dc13-7d02-d122-76278b3d15be@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 10:04:07PM +0530, Saurav Girepunje wrote:
> 
> 
> On 06/09/21 3:18 pm, Greg KH wrote:
> > On Sun, Sep 05, 2021 at 12:44:37PM +0530, Saurav Girepunje wrote:
> > > Remove below duplicate declaration from rtl8188e_led.h file
> > > 
> > > void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
> > > void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
> > > 
> > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > ---
> > >   drivers/staging/r8188eu/include/rtl8188e_led.h | 2 --
> > >   1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/include/rtl8188e_led.h b/drivers/staging/r8188eu/include/rtl8188e_led.h
> > > index b00954198764..02cdc970bb17 100644
> > > --- a/drivers/staging/r8188eu/include/rtl8188e_led.h
> > > +++ b/drivers/staging/r8188eu/include/rtl8188e_led.h
> > > @@ -12,7 +12,5 @@
> > >   /*  */
> > >   void rtl8188eu_InitSwLeds(struct adapter *padapter);
> > >   void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
> > > -void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
> > > -void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
> > > 
> > >   #endif
> > > --
> > > 2.32.0
> > > 
> > 
> > This email did not make it to lore.kernel.org again:
> > 	https://lore.kernel.org/r/YTRuXTu/kePBDwAF@user
> > 
> > Any ideas what is happening?
> > linux-staging@lists.linux.dev
> > thanks,
> > 
> > greg k-h
> > 
> 
> I missed to add the linux-staging@lists.linux.dev. I will resend it v2
> version of this patch.
> However I am able to see it on  https://lore.kernel.org .
> 
> https://lore.kernel.org/all/YTRuXTu%2FkePBDwAF@user/

You are right, that is odd.  I've emailed the b4 developer to see what
is up with this, I'll take this patch in a bit...

thanks,

greg k-h
