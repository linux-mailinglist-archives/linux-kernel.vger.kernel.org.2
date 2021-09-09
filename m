Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366D1404833
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhIIKFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhIIKFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:05:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEF6161104;
        Thu,  9 Sep 2021 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631181835;
        bh=aNdNVuOHQN5in236EpLXyDhP5u8tvEK2yD/1lia4+b4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3/QlHVj/fckqSe3t/Fb/99JM1BygLomd5IwSSiFxf/zy5l77jKm6+Dw4WAAPreV3
         9LkRkr4HdCB90k0x6zROAejj3E7C3b1KcSV8fr5siMX1UTQg6aL+BmLHIRhHTuqDNv
         uN8nxT2T2vS2vYuc74BNI1Gn1fFvkIBsUw0tgYhs=
Date:   Thu, 9 Sep 2021 12:03:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        nathan@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: os_dep: simplifiy the rtw_resume
 function
Message-ID: <YTncCDuVwnk9RF09@kroah.com>
References: <YTNjNLcNvPfD9+5Z@user>
 <YTTYo2BSG/JTuijx@kroah.com>
 <41bd374e-3122-0580-f38d-bb03401730b6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41bd374e-3122-0580-f38d-bb03401730b6@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 11:17:20PM +0530, Saurav Girepunje wrote:
> 
> 
> On 05/09/21 8:18 pm, Greg KH wrote:
> > On Sat, Sep 04, 2021 at 05:44:44PM +0530, Saurav Girepunje wrote:
> > > Remove unused variable ret and pwrpriv.
> > > Remove the condition with no effect (if == else) in usb_intf.c
> > > file.
> > > Remove rtw_resume_process() and move whole thing to rtw_resume().
> > > 
> > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > ---
> > > 
> > > ChangeLog V2:
> > > - Remove rtw_resume_process() and move whole thing to rtw_resume().
> > > ---
> > >   drivers/staging/r8188eu/include/usb_osintf.h |  2 --
> > >   drivers/staging/r8188eu/os_dep/usb_intf.c    | 12 ------------
> > >   2 files changed, 14 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
> > > index d1a1f739309c..34229b1cb081 100644
> > > --- a/drivers/staging/r8188eu/include/usb_osintf.h
> > > +++ b/drivers/staging/r8188eu/include/usb_osintf.h
> > > @@ -24,6 +24,4 @@ void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
> > >   void nat25_db_expire(struct adapter *priv);
> > >   int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method);
> > > 
> > > -int rtw_resume_process(struct adapter *padapter);
> > > -
> > >   #endif
> > > diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > > index bb85ab77fd26..77b03e7631b7 100644
> > > --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> > > +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> > > @@ -493,18 +493,6 @@ static int rtw_resume(struct usb_interface *pusb_intf)
> > >   {
> > >   	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
> > >   	struct adapter *padapter = dvobj->if1;
> > > -	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
> > > -	int ret = 0;
> > > -
> > > -	if (pwrpriv->bInternalAutoSuspend)
> > > -		ret = rtw_resume_process(padapter);
> > > -	else
> > > -		ret = rtw_resume_process(padapter);
> > > -	return ret;
> > > -}
> > > -
> > > -int rtw_resume_process(struct adapter *padapter)
> > > -{
> > >   	struct net_device *pnetdev;
> > >   	struct pwrctrl_priv *pwrpriv = NULL;
> > >   	int ret = -1;
> > 
> > You can also remove the test for padapter being NULL in this function,
> > as you just proved it could never be null otherwise the above function
> > you removed would have crashed, right?  You should do that all at once
> > so we remember why that test was removed.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Yes, padapter was deference without checking it could be NULL on rtw_resume.

How can it ever be NULL there?

> I think having NULL check would be safe. However if padapter is NULL then on
> goto exit "if (pwrpriv)" condition  will never true as pwrpriv is
> initialized with NULL. There should be one more goto exit just to return.!
> 
> let me know you thought greg,

Don't check for things that can never happen.

thanks,

greg k-h
