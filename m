Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD640D98F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbhIPMPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbhIPMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:15:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E36C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 05:14:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j13so15958614edv.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dceZ5uiDy0+Um3nYa2DJqEKVOq4Y9eg0YaVZ8ELhM+o=;
        b=ITKmohoFX118+vkERG1GZWtf0ZHVsD6dL+I+loxNI89ZaS8sQGmfM62KdbUBpGqvTB
         rM85K7KFQHHjby/u+cHQSrzMBkPTdTKIY8zWkcDzP2QEqktty9S+XVQBC5T1vtEoV4Db
         V0ow4DcMeTHCMs+k+nyJx0/RUeLhuQgT79ZO5KKt6zXHeBDL58+BAqKH1nOGQNQyzJ73
         i7YC/GI1xyNVM77N8/NV56BsZnrLz2rKhX7TioLMKJPViWDRYChGJ2VGjAJtYEVetrqE
         Np2Z5zDW1W8wGYCeGu5cQeHFtzDlO1DXnHez9zCfoVLa8HbVeI+tvNGbAE0Sn3o45wRv
         /PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dceZ5uiDy0+Um3nYa2DJqEKVOq4Y9eg0YaVZ8ELhM+o=;
        b=WcgXtkGjrqZWKad+ptVDdN7gqVWXZomgIIPP1+PlXwKkaocWZKBYNoh5EoSZyuuKOr
         +MW5UvW3A54FOeGzDrejgz9FS9rVI//DzfovfST6b+hWqzswemFuA+1ezqF8gL3wsxmG
         +Q2ZD+hjmIj9sX2fEJaXCSVAJvxqDMqYqWfLyhYKujzcdVge14aLlrTXT0M8PyGJXNOt
         CYVQkjO39EVCp8CPyJnt0MoO6/atiHRaWktmICFXbFPLyiKnlk6g3t/buA2vCxMIOrs0
         XsAACs3I5bjrnP9W05z5qoGJCNoFezjaMDozZnOLGlJsXT12stVkHn2cmgEj7nzTeqM0
         FWrg==
X-Gm-Message-State: AOAM530w2WoDtH5ieJ4Pwcj05U+MEa/Ybgyp242XHSsb4WqxChZGq+7b
        m6bZXyAQcg7AMYQPS9pUjqE=
X-Google-Smtp-Source: ABdhPJyiCIJyLzFmU30/g1amsyFm/bu8BYO30s73qIG7d6Jul+70WYEzQS4YU90FawDjX4s8N6lr3A==
X-Received: by 2002:a17:906:4a0b:: with SMTP id w11mr6134745eju.265.1631794458498;
        Thu, 16 Sep 2021 05:14:18 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id gl2sm1102155ejb.110.2021.09.16.05.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 05:14:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>
Subject: Re: [PATCH v6 16/19] staging: r8188eu: Clean up rtw_read*() and rtw_write*()
Date:   Thu, 16 Sep 2021 14:14:14 +0200
Message-ID: <1797501.xtDa3BoUpI@localhost.localdomain>
In-Reply-To: <20210916113606.GJ2116@kadam>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com> <20210915211103.18001-17-fmdefrancesco@gmail.com> <20210916113606.GJ2116@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 16, 2021 1:36:06 PM CEST Dan Carpenter wrote:
> On Wed, Sep 15, 2021 at 11:11:00PM +0200, Fabio M. De Francesco wrote:
> > Clean up rtw_read{8,16,32}() and rtw_write{8,16,32,N}() in 
usb_ops_linux.c.
> > 
> 
> It would be good to know what you did more specifically.
> 
> 1) Rename variables:
> 	pio_priv => io_priv
> 	pintfhdl => intfhdl
> 	wvalue => address.
> 2) Remove unnecessary casts.
> 3) Fix types.  Use __le16 instead of __le32.

Dear Dan,

I'm sorry for missing that. :( 

Now I remember that you asked for this specifications at least once (if not 
twice). I'll redo the commit message and add the list above in v7. I guess 
that I have to do the same in 15/19.

> The last one is a small KASan bug fix.  So good job on that.

Thanks (even if I don't yet know anything about KASan).

> > Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/r8188eu/hal/usb_ops_linux.c | 68 ++++++++++-----------
> >  1 file changed, 34 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/
staging/r8188eu/hal/usb_ops_linux.c
> > index 2098ce935dc0..d87da84eca07 100644
> > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > @@ -91,91 +91,91 @@ static int usbctrl_vendorreq(struct intf_hdl 
*intfhdl, u16 value, void *data, u1
> >  
> >  u8 rtw_read8(struct adapter *adapter, u32 addr)
> >  {
> > -	struct io_priv *pio_priv = &adapter->iopriv;
> > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > +	struct io_priv *io_priv = &adapter->iopriv;
> > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > +	u16 address = addr & 0xffff;
> >  	u8 data;
> > -
> 
> Deleting this line introduces a checkpatch warning.

I didn't notice the warning. This too will be fixed in v7.

> > -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 1, 
REALTEK_USB_VENQT_READ);
> > +	usbctrl_vendorreq(intfhdl, address, &data, 1, 
REALTEK_USB_VENQT_READ);
> >  
> >  	return data;
> >  }
> >  
> >  u16 rtw_read16(struct adapter *adapter, u32 addr)
> >  {
> > -	struct io_priv *pio_priv = &adapter->iopriv;
> > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > -	__le32 data;
> > +	struct io_priv *io_priv = &adapter->iopriv;
> > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > +	u16 address = addr & 0xffff;
> > +	__le16 data;
> >  
> > -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, 
REALTEK_USB_VENQT_READ);
> > +	usbctrl_vendorreq(intfhdl, address, &data, 2, 
REALTEK_USB_VENQT_READ);
> >  
> > -	return (u16)(le32_to_cpu(data) & 0xffff);
> > +	return le16_to_cpu(data);
> 
> The last two bytes of "data" are not initialized.  I do not think that
> will cause a bug on either endian type of system during runtime but I
> this that KASan will catch it and complain.

I don't want to add mistakes on mistakes. I guess that you are talking of the 
same fix you wrote above and that "return le16_to_cpu(data);" is correct.
Am I interpreting your words in the correct way?
 
> >  }
> >  
> >  u32 rtw_read32(struct adapter *adapter, u32 addr)
> >  {
> > -	struct io_priv *pio_priv = &adapter->iopriv;
> > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > +	struct io_priv *io_priv = &adapter->iopriv;
> > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > +	u16 address = addr & 0xffff;
> >  	__le32 data;
> >  
> > -	usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, 
REALTEK_USB_VENQT_READ);
> > +	usbctrl_vendorreq(intfhdl, address, &data, 4, 
REALTEK_USB_VENQT_READ);
> >  
> >  	return le32_to_cpu(data);
> >  }
> >  
> >  int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
> >  {
> > -	struct io_priv *pio_priv = &adapter->iopriv;
> > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > +	struct io_priv *io_priv = &adapter->iopriv;
> > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > +	u16 address = addr & 0xffff;
> >  	int ret;
> >  
> > -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, 
REALTEK_USB_VENQT_WRITE);
> > +	ret = usbctrl_vendorreq(intfhdl, address, &val, 1, 
REALTEK_USB_VENQT_WRITE);
> >  
> >  	return RTW_STATUS_CODE(ret);
> >  }
> >  
> >  int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
> >  {
> > -	struct io_priv *pio_priv = &adapter->iopriv;
> > -	struct intf_hdl *pintfhdl = &pio_priv->intf;
> > -	u16 wvalue = (u16)(addr & 0x0000ffff);
> > -	__le32 data = cpu_to_le32(val & 0x0000ffff);
> > +	struct io_priv *io_priv = &adapter->iopriv;
> > +	struct intf_hdl *intfhdl = &io_priv->intf;
> > +	__le16 data = cpu_to_le16(val);
> 
> This is the other interesting change.  I think the original code works
> though.

Here too, I'm a bit confused... Do yo prefer the original code or you're 
saying that, although the original code works fine, I made the correct choice 
in changing it? Can you please confirm?

> 
> > +	u16 address = addr & 0xffff;
> >  	int ret;
> >  
> > -	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, 
REALTEK_USB_VENQT_WRITE);
> > +	ret = usbctrl_vendorreq(intfhdl, address, &data, 2, 
REALTEK_USB_VENQT_WRITE);
> >  
> >  	return RTW_STATUS_CODE(ret);
> >  }
> 
> regards,
> dan carpenter
> 
> 

Regards,

Fabio


