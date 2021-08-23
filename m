Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B3C3F48E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 12:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhHWKsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhHWKsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 06:48:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18791C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:47:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mf2so17539803ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vDFsfAzgg8pTYEtlapSW0caiBmfQljPcziSOHOjY7/8=;
        b=l8EiydJYNtcZ5nx6fu/aA4H0DfERCiFxLFNgA/xyQx4LCFPYLRrh3cmB/RJHo/3Ri6
         w98Ln+WoptdDy2d5YJNdlp3FZ3PR5/D2v0a/rwrpnsUtl2ogcQD7ocqNqBAe0wZum4b5
         D+R5VNvc7nnN+BWRVoUTtW8KUBXFUTkzUhWByAl5GNvdVpgbIEL692+txN7W7nNxeQFq
         SuTiN9b4Qj59lFWnbuLhYPRTdAgP2Ui5Nbl8ftogz1+txQrNXJ0IfhFp+wZML2zan0fw
         +WksNkTob+t4Hs3Xxwf2PS1ipE/4rnRtRfPYSsnLAJn3sWQfL4Vwj0hh/ftzWWH2WQ1Z
         G87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDFsfAzgg8pTYEtlapSW0caiBmfQljPcziSOHOjY7/8=;
        b=sBPu/gFU5mwsW3y2vRAHn/CWSLrqdi2TUTvklio4HjN59IgyEku8eBz4tZNyHruCbJ
         xnLsm+E5WUVJ2xWufrgEkrcOjKk7hehcDSfpN/TlYMURiE3YtbINyLEicgVVSbn87ccv
         3e3bc8SfxTCiYQSwaiQldofWdfAR9jV92FABiF2WigaGHBD9Kespnx1glxYmtakWnihr
         ovMKqerstDEEYFzttyPtX/nqstAUJKyAr99N0bGhGY3inURo4bXofAGnn2odxRdr19kx
         UDRsVC07nfQIVVKpS8CGmdXLUFinKQTKu3epTpwncMxmHTn69tU5weoFFicDZmDTyj96
         46nw==
X-Gm-Message-State: AOAM530IH6Kux2x0FZGmN/6Woj1l7z18sTEtCSiA83CB9giBNBRJyRKS
        Jyy+BD4YpGX/hU+vIFvNpSs=
X-Google-Smtp-Source: ABdhPJzUgAYUMV7ZimkvzfBCbrfAVY8nvXGQlD+IMyLoWuKhnE1jrRfWvrUcGJYbI5TBA/pslJ+lsA==
X-Received: by 2002:a17:906:ad87:: with SMTP id la7mr8120604ejb.145.1629715667569;
        Mon, 23 Aug 2021 03:47:47 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id bx14sm4506257edb.93.2021.08.23.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:47:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH RFC] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Mon, 23 Aug 2021 12:47:45 +0200
Message-ID: <8275282.m2tVFbhrJk@localhost.localdomain>
In-Reply-To: <69bbb80c-2b30-28b9-ad8c-6862a6c3b911@gmail.com>
References: <20210822230235.10953-1-fmdefrancesco@gmail.com> <69bbb80c-2b30-28b9-ad8c-6862a6c3b911@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 23, 2021 10:11:52 AM CEST Pavel Skripkin wrote:
> On 8/23/21 2:02 AM, Fabio M. De Francesco wrote:
> > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > usb_control_msg_send() API of USB Core.
> > 
> > This patch is an RFC for different reasons:
> > 
> > 1) I'm not sure if it is needed: while Greg Kroah-Hartman suggested to
> > use the new API in a message to a thread that was about a series of patches
> > submitted by Pavel Skripkin (who decided to not use it), I cannot explain
> > if and why the driver would benefit from this patch.
> > 2) I have doubts about the semantic of the API I use here, so I'd like to
> > know whether or not I'm using them properly.
> > 3) At the moment I cannot test the driver because I don't have my device
> > with me.
> > 4) This patch could probably lead to a slight change in some lines of
> > Pavel's series (for sure in usb_read*()).
> > 
> > I'd like to hear from the Maintainers and other interested people if this
> > patch is worth to be considered and, in this case, if there are suggestions
> > for the purpose to improve it.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >   drivers/staging/r8188eu/hal/usb_ops_linux.c | 19 ++++++++++---------
> >   1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > index 6a0a24acf292..9e290c1cc449 100644
> > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > @@ -15,7 +15,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> >   	struct adapter	*adapt = pintfhdl->padapter;
> >   	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> >   	struct usb_device *udev = dvobjpriv->pusbdev;
> > -	unsigned int pipe;
> > +	u8 pipe;
> >   	int status = 0;
> >   	u8 reqtype;
> 
> I think, we can pass REALTEK_USB_VENQT_{READ,WRITE} directly as 
> requesttype argument and get rid of u8 reqtype. + we can define these 
> macros:
> 
> #define
> usbctrl_vendor_read(...)   usbctrl_vendorreq(...,REALTEK_USB_VENQT_READ)
> 
> 
> #define
> usbctrl_vendor_write()    usbctrl_vendorreq(...,REALTEK_USB_VENQT_WRITE)
> 
> 
> This will make code more nice, IMO  :)

Dear Pavel,

I agree in full: nicer and cleaner :)

I'll do that, but please notice that I will also need to change the code of the three 
usb_read*() for calling usbctrl_vendor_read(). Furthermore, "else res = 0;" becomes
unnecessary. Please take these changes into account when you'll send them again
as "regular" patches.

> (Sorry for this formatting, my email client disabled "paste without 
> formatting" option)

Actually I don't see any oddities in the format of your message :)

> >   	u8 *pIo_buf;
> > @@ -47,19 +47,20 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> >   		memset(pIo_buf, 0, len);
> >   
> >   		if (requesttype == 0x01) {
> > -			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> >   			reqtype =  REALTEK_USB_VENQT_READ;
> > +			status = usb_control_msg_recv(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > +						      reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> > +						      pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > +						      GFP_KERNEL);
> >   		} else {
> > -			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> >   			reqtype =  REALTEK_USB_VENQT_WRITE;
> > -			memcpy(pIo_buf, pdata, len);
> 
> I guess, this memcpy is needed, since we want to send data from pdata

Oh, dear! How could I have missed that? Two alternatives: either because of working 
during bedtime, or I'm definitely losing my mind... :(
 
> 
> > +			status = usb_control_msg_send(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > +						      reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> > +						      pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > +						      GFP_KERNEL);
> >   		}
> >   
> > -		status = usb_control_msg(udev, pipe, REALTEK_USB_VENQT_CMD_REQ,
> > -					 reqtype, value, REALTEK_USB_VENQT_CMD_IDX,
> > -					 pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
> > -
> > -		if (status == len) {   /*  Success this control transfer. */
> > +		if (!status) {   /*  Success this control transfer. */
> >   			rtw_reset_continual_urb_error(dvobjpriv);
> >   			if (requesttype == 0x01)
> >   				memcpy(pdata, pIo_buf,  len);
> > 
> 
> 
> With regards,
> Pavel Skripkin

Thanks for you review, I really appreciate it.

Regards,

Fabio

P.S.: As I wrote, I have not my ASUS N10 Nano with me and I won't have the opportunity
to test this as well as any other patch until the end of August. I hope to not break anything.
If somebody has time to test the final patch that I'm going to submit, I'd really appreciate it.


