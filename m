Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EB840468C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhIIHyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhIIHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:54:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A06DC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:53:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b6so1147992wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LB8gBhmyyayBgCkRPEtNI1MKciyISwJD+/3NCfbEPNg=;
        b=fbR2nlkB7w9YPzyH5M9jyoDJjgqsVqHSFxoak46LstznMy/FgMilVdR48cCDJVKoYw
         G+tEo8DC6txw4monwd9fL4RWKzhdokWkoNNDpTiBbRJqxunTPf/kXKwBsN2r9xALRT2E
         Az7idTWYtmhcs8X7pdDUHGquv86oP4O6ejsa/4rA7pdSstvXDd4r9os5BzqGir0nRnPa
         SJ+IXKJVcZ188iIpikNr6k2FwM/Tr2kO+TMo1ClGT9zIye6bOyQsJ4nhYLyibE28kAzh
         bgKfAvdwlcZkpsVvXlO4dSJaUzmfLzuUl81MGHthSkUbteKNkYYjAB0H6wVpxnfgfdUV
         3yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LB8gBhmyyayBgCkRPEtNI1MKciyISwJD+/3NCfbEPNg=;
        b=VSCBNZ6t0tlWDozDfJ2CCGxW3TevNl8WG6FzIAkJkXD0iwX+XEaTAECPy+USlCX71+
         nK5GLiCnDfbEToNf7yDn2rBzKbKive9I0qu8Mt95l/EpMveY6ziNbUJ4EYDcA6D0GzPL
         FuSyKjVCyMNz2hxFnaCswGs43cubjdOKqioj+C1oizp2amWrZEQuNcHnPVhpqDwnbRta
         KwG3hkWndVukuLd4xTWCZ9kxVrnlvcitG/LxSSjDyb3rNd96eaFjjIvLABXhBhgfOHaG
         zJ24VhyvZZS4q48nk5+MEoo3n0wo2GxKVmMY55zp/aCbL6QtWgy/kr+i5ozzDrlYp51y
         TQMA==
X-Gm-Message-State: AOAM530ODqfhsVREgyXtx/dD5PDbG9ysBFNFCObvuu0DEXyXG8/aXE2P
        YfYPKyINLN2qQdmNOxG1shBTYLYoUts=
X-Google-Smtp-Source: ABdhPJw2Ds20NEctIgy/BriIH+QNJuf6sx8Y4VgR8du4LZZW7Hm3zHUeQ0l1d/U1e6V10bTGTjOnQQ==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr1944589wrx.126.1631173985963;
        Thu, 09 Sep 2021 00:53:05 -0700 (PDT)
Received: from localhost.localdomain ([37.163.141.235])
        by smtp.gmail.com with ESMTPSA id l1sm372488wmq.8.2021.09.09.00.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 00:53:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] staging: r8188eu: Shorten calls chain of rtw_read8/16/32()
Date:   Thu, 09 Sep 2021 09:53:02 +0200
Message-ID: <7885982.jm2Fxi49sr@localhost.localdomain>
In-Reply-To: <YTYgnrvwxNt4+CvR@kroah.com>
References: <20210904220048.12822-1-fmdefrancesco@gmail.com> <20210904220048.12822-3-fmdefrancesco@gmail.com> <YTYgnrvwxNt4+CvR@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 6, 2021 4:07:26 PM CEST Greg Kroah-Hartman wrote:
> On Sun, Sep 05, 2021 at 12:00:47AM +0200, Fabio M. De Francesco wrote:
> > Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
> > For this purpose unify the three usb_read8/16/32 into the new
> > usb_read(); make the latter parameterizable with 'size'; embed most of
> > the code of usbctrl_vendorreq() into usb_read() and use in it the new
> > usb_control_msg_recv() API of USB Core.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v2->v3: No changes.
> > 
> > v1->v2: No changes.
> > 
> >  drivers/staging/r8188eu/hal/usb_ops_linux.c | 92 +++++++++++++++++----
> >  1 file changed, 78 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/
staging/r8188eu/hal/usb_ops_linux.c
> > index a87b0d2e87d0..f9c4fd5a2c53 100644
> > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > @@ -97,38 +97,102 @@ static int usbctrl_vendorreq(struct intf_hdl 
*pintfhdl, u16 value, void *pdata,
> >  	return status;
> >  }
> >  
> > +static int usb_read(struct intf_hdl *intfhdl, u32 addr, void *data, u8 
size)
> > +{
> > +	u16 value = (u16)(addr & 0x0000ffff);
> 
> Why not just pass in the address as a 16bit value?

Yes, it should be better. It will be done in v4.

> 
> 
> > +	struct adapter *adapt = intfhdl->padapter;
> > +	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
> > +	struct usb_device *udev = dvobjpriv->pusbdev;
> > +	int status;
> > +	u8 *io_buf;
> > +	int vendorreq_times = 0;
> > +
> > +	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) 
{
> > +		status = -EPERM;
> > +		goto exit;
> 
> This is "interesting" to see if it's really even working as they think
> it does, but let's leave it alone for now...

As you suggest, I also prefer to leave it alone for now.

> 
> > +	}
> > +
> > +	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
> > +
> > +	/*  Acquire IO memory for vendorreq */
> > +	io_buf = dvobjpriv->usb_vendor_req_buf;
> > +
> > +	if (!io_buf) {
> > +		DBG_88E("[%s] io_buf == NULL\n", __func__);
> 
> How can this buffer ever be NULL?

As you noticed a few lines below this, I moved some code around and ignored 
and left as was anything that wasn't functional for my purpose.. 

> 
> > +		status = -ENOMEM;
> > +		goto release_mutex;
> > +	}
> 
> Why share a buffer at all anyway?

Same answer as above.

> 
> > +	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> > +		status = usb_control_msg_recv(udev, 0, 
REALTEK_USB_VENQT_CMD_REQ,
> > +					      
REALTEK_USB_VENQT_READ, value,
> > +					      
REALTEK_USB_VENQT_CMD_IDX, io_buf,
> > +					      size, 
RTW_USB_CONTROL_MSG_TIMEOUT,
> > +					      GFP_KERNEL);
> > +		if (!status) {   /*  Success this control transfer. */
> 
> Comments go on the next line.

This will be fixed in v4, although I'm not sure if this comment and the next 
are really necessary. The code seems self-explanatory.

> 
> > +			rtw_reset_continual_urb_error(dvobjpriv);
> > +			memcpy(data, io_buf, size);
> > +		} else { /*  error cases */
> 
> Again, next line for the comment.

Same as above.

> 
> > +			DBG_88E("reg 0x%x, usb %s %u fail, status:
%d vendorreq_times:%d\n",
> > +				value, "read", size, status, 
vendorreq_times);
> 
> These should be removed eventually...
> 

I could use pr_debug() for now or remove it immediately. I'd prefer the 
latter but I'm not sure if it is the most appropriate thing to do. Let me 
think about it...

> > +
> > +			if (status == (-ESHUTDOWN) || status == -
ENODEV) {
> > +				adapt->bSurpriseRemoved = true;
> 
> Odd, but ok...
> 
> > +			} else {
> > +				struct hal_data_8188e *haldata = 
GET_HAL_DATA(adapt);
> > +
> > +				haldata-
>srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
> 
> Why are we not saying the command failed even if the device was removed?

This question is not clear to me. Are you talking about -ENOENT?
I suppose it should be if (status == (-ESHUTDOWN || -ENODEV || -ENOENT)) ...

> But if we do say an error happened, why are we trying to send this out
> again?  What would happen to make it work the second time?

There are some errors that are unrecoverable and the loop has no reason to 
re-iterate again and again. I'll break this loop on unrecoverable errors.

I see that usb_submit_urb() at the very end of the calls chain may fail for a 
lot of different reasons and some of them are a bit obscure to me 
(unfortunately, at the moment I have no time to go deeper into the 
architecture and the inner workings of the USB subsystem :) ) 

I hope that I won't overlook any of them - as far as it regards some of all 
possible errors I have doubts in telling whether or not they are 
unrecoverable and if some can actually happen in this code :(

> > +			}
> > +
> > +			if 
(rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
> > +				adapt->bSurpriseRemoved = true;
> 
> So we try to see if the device was removed again?

This must be changed, let me see if I can understand how. At the moment I 
don't have the whole picture.
 
> > +				break;
> > +			}
> > +		}
> > +
> > +		/*  firmware download is checksummed, don't retry */
> > +		if ((value >= FW_8188E_START_ADDRESS && value <= 
FW_8188E_END_ADDRESS) || !status)
> > +			break;
> 
> Nothing like a special case for firmware magic.

This is something that I really cannot understand, so I think I'll leave it 
as-is unless I may get some more hints... :)

> Those calls should just use a different write function entirely,
> eventually, to remove this...
> 
> Ok, I know you are just moving code around, this is fine, just pointing
> out things that should be fixed up eventually...

Yes, I'm just moving the code around. Anyway I guess that I can fix/change  
most of the things you pointed out.

Thanks very much for your review,

Fabio  

> 
> thanks,
> 
> greg k-h
> 




