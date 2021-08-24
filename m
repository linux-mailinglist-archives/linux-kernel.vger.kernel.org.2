Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB92C3F618A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhHXPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbhHXPYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:24:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64DEC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:24:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dm15so7267543edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/TKszmQsUuaSWEYHmuXj5AOgwSl/hQkXiLmhAR9+lZk=;
        b=GGO5AqZgPowHZpmVQvn1zQiR4daCuE9Q2r996UE0Big6LGDIY38dh3zB8wIxT88nI5
         enqTvhW30Q233gyeQw5IaQysHosNRCNWz4qUaaAEsj2rEVns7t8WpA89vCsLFfppG5r/
         yGO+hNIdoixzq/58O42ouEDsE+40J9wMCpvS8Nnu5WAme4ov07O4pOjmJZAbjsaaWHUz
         L50tX+n+G5jb5lEgYqmrOmSKmKhi1MCESutjW0iflYgoYbvD05xQPIuTJFthPF9U+tEF
         emMltCPs48smNZd7i4SEVrUaGKo/g865NGaMoXAnMKqf3EiE6t9KfJZ14KJEIov/u9jW
         PuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TKszmQsUuaSWEYHmuXj5AOgwSl/hQkXiLmhAR9+lZk=;
        b=dZZozxqvFGkUeZ5uNiMks3KJ8gKOBcqEhrsqmYbcQCE1c9ptI9yAkgDpIWN+bei9p1
         UoR4/6zsxi7mNKeH3Pc6IhDRSahxcnch/K5rMWL+BldbWorD5nMC2qrypLDp5SmBeJOl
         e4vhzt29U9JKHKQOtoMspKU5CSPctaxx1RS5XeQePMdss7IjOUqlfVkDOC41iL7R1cGH
         9lQ9SZcSlufPB+ZWKBo4ebIed4PO/g8ZU7PKznmLXx1l7U4qSfG1lzg3TNP/vyJZ0d+f
         0WSJbKHnQSnbHaEr23ivO0htksnHOkALhn+suCwe6fY8Gu/T5iX/87VOiLtwP3POpaTv
         obKw==
X-Gm-Message-State: AOAM5318KkWIOrgCWCpiwiGN7e3900B9BI4nxwCqbXiR4YJkuu1RLjvH
        SpLQ2MhHncge8bF/bdm9pu8=
X-Google-Smtp-Source: ABdhPJwx5o1jq17fUYiZZGiEWks0zfu/WfVB3B9drjSr5D8za+T7W6+UyjDW0m2ruN0HNLrzum3HQw==
X-Received: by 2002:a50:c94d:: with SMTP id p13mr191539edh.246.1629818641337;
        Tue, 24 Aug 2021 08:24:01 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id c19sm6597087ejs.116.2021.08.24.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:24:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in usbctrl_vendorreq()
Date:   Tue, 24 Aug 2021 17:23:59 +0200
Message-ID: <10796100.lKEGA7Tnzb@localhost.localdomain>
In-Reply-To: <ac4b9c30-fceb-6838-a6d5-b9f03d5a0246@gmail.com>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com> <20210824142823.16845-2-fmdefrancesco@gmail.com> <ac4b9c30-fceb-6838-a6d5-b9f03d5a0246@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 4:35:38 PM CEST Pavel Skripkin wrote:
> On 8/24/21 5:28 PM, Fabio M. De Francesco wrote:
> > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> > Remove no more needed variables. Move out of an if-else block
> > some code that it is no more dependent on status < 0. Remove
> > redundant code depending on status > 0 or status == len.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v1->v2: According to suggestions by Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr>, remove 'pipe' and pass an explicit 0
> > to the new API. According to suggestions by Pavel Skripkin
> > <paskripkin@gmail.com>, remove an extra if-else that is no more needed,
> > since status can be 0 and < 0 and there is no 3rd state, like it was before.
> > Many thanks to both them and to Phillip Potter <phil@philpotter.co.uk>
> > who kindly offered his time for the purpose of testing v1.
> >   
> > 
> >   drivers/staging/r8188eu/hal/usb_ops_linux.c | 45 ++++++++-------------
> >   1 file changed, 17 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > index a93d5cfe4635..13e925d21e00 100644
> > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > @@ -15,9 +15,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> >   	struct adapter	*adapt = pintfhdl->padapter;
> >   	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
> >   	struct usb_device *udev = dvobjpriv->pusbdev;
> > -	unsigned int pipe;
> >   	int status = 0;
> > -	u8 reqtype;
> >   	u8 *pIo_buf;
> >   	int vendorreq_times = 0;
> >   
> > @@ -44,22 +42,22 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> >   	}
> >   
> >   	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
> > -		memset(pIo_buf, 0, len);
> > -
> >   		if (requesttype == 0x01) {
> > -			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
> > -			reqtype =  REALTEK_USB_VENQT_READ;
> > +			status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> > +						      REALTEK_USB_VENQT_READ, value,
> > +						      REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
> > +						      len, RTW_USB_CONTROL_MSG_TIMEOUT,
> > +						      GFP_KERNEL);
> >   		} else {
> > -			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
> > -			reqtype =  REALTEK_USB_VENQT_WRITE;
> >   			memcpy(pIo_buf, pdata, len);
> > +			status = usb_control_msg_send(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> > +						      REALTEK_USB_VENQT_WRITE, value,
> > +						      REALTEK_USB_VENQT_CMD_IDX, pIo_buf,
> > +						      len, RTW_USB_CONTROL_MSG_TIMEOUT,
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
> > @@ -68,20 +66,11 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> >   				value, (requesttype == 0x01) ? "read" : "write",
> >   				len, status, *(u32 *)pdata, vendorreq_times);
> >   
> > -			if (status < 0) {
> > -				if (status == (-ESHUTDOWN) || status == -ENODEV) {
> > -					adapt->bSurpriseRemoved = true;
> > -				} else {
> > -					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
> > -					haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
> > -				}
> > -			} else { /*  status != len && status >= 0 */
> > -				if (status > 0) {
> > -					if (requesttype == 0x01) {
> > -						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
> > -						memcpy(pdata, pIo_buf,  len);
> > -					}
> > -				}
> > +			if (status == (-ESHUTDOWN) || status == -ENODEV) {
> > +				adapt->bSurpriseRemoved = true;
> > +			} else {
> > +				struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
> > +				haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
> >   			}
> >   
> >   			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
> > @@ -92,7 +81,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
> >   		}
> >   
> >   		/*  firmware download is checksumed, don't retry */
> > -		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
> > +		if (value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS)
> >   			break;
> 
> 
> Shouldn't we break the loop when we have received all data? I think,
> status == len should be replaced with !status. Correct me if I am wrong.

Yes, correct. I was about to replace status == len with !status when I've 
been interrupted by a phone call and then I forgot to do the work :(

I'll send a v3 this night. Unfortunately now I have to go. While at that
I'll also try to understand why 2/2 cannot apply. Sigh!
 
> Other changes look good to me, thanks

Thanks to you, Christophe and Philip for all the help you gave.

Regards,

Fabio

> With regards,
> Pavel Skripkin
> 




