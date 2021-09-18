Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F4D41065B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 14:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhIRMVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 08:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhIRMVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 08:21:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B96C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 05:19:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n10so39736829eda.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qn+DksEdBMENR1uvA0NKAX3ZxsUx8jYHAO154ypq2g=;
        b=EKwJXjuv0ncWqBYU8wjGCWihBKNPOb9DG97bqS586y04KrgRXKCIvARxbIdk/EosfF
         +GnedPCw5KiGBNB2eNxJfzRVYUO0qucXGnGW60bSmyPrkjmZdmQXAwMHmr+wg7MNyPmr
         X6zw455UDZ+X4vbKPq42JF30RCUrfYIPb3UOXZArX1i/kU9TEpm8aEHnZaUoJgc2gN8Y
         rHabmKQKt64XIHix+w9Ps+LlKVTD7+7OMGUP+292maZ1UD4Ac4fuy/BLYKGSAje5BaGi
         mnkiKjKEVxPYqMeKD0p29LNfH0+HyDwW+6YA/PcekfE9a9uF1fuekvtvUqDVrCFruJp7
         8QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qn+DksEdBMENR1uvA0NKAX3ZxsUx8jYHAO154ypq2g=;
        b=tdWBu+Ol/PX7IZbCqkOBa2YAeyiXvd704EIEP/gyxH8+xDEAvxA47HCHn48yY6OarT
         4GDNBJJgmj1sFdfUGdX99ktAI7U5eJTqsNeeKbCtxwXnLB5Kv98SnRoNAkSp1MwDbNGn
         QaJL8nomCUSzDRCoqoXfqntZCwnzbHgye21AidYXjzI3VxgJ5/k63U+KZgzRnba1th2K
         mQZQ6czdq2WgMFIhUXy2vdfkqWzjzHnG53Uy5Hp6ChK4iTs0U65Ju4uxNRlaGa1gJSOy
         l0Ts3/w5gxbu4/ZvHKwNE9kbsSgQ1oH6Nt4UUkL9XX4cXVp+l/qHroSGRspFo9zOV2Ls
         VMiw==
X-Gm-Message-State: AOAM531SzImkl66XEriDZ8b10ZbnZdxvcSyegFJp8r0oMTmCFFGkjo8O
        VJeDsrEXjWvXWJTAi09fRy0=
X-Google-Smtp-Source: ABdhPJwMCK1iUWLLgv0fn4p1DJ/XAn63gi/lPih8kGDpCl8WzdcQx9MS9N6n6hhyq7Q4oglRcsEeIA==
X-Received: by 2002:a05:6402:2061:: with SMTP id bd1mr18538339edb.186.1631967580486;
        Sat, 18 Sep 2021 05:19:40 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id o22sm4178967edi.89.2021.09.18.05.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 05:19:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 17/19] staging: r8188eu: shorten calls chain of rtw_read{8,16,32}()
Date:   Sat, 18 Sep 2021 14:19:38 +0200
Message-ID: <14193957.S5bSOd67d6@localhost.localdomain>
In-Reply-To: <YUSrIqW5WSYuoa14@kroah.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com> <20210917071837.10926-18-fmdefrancesco@gmail.com> <YUSrIqW5WSYuoa14@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 17, 2021 4:50:10 PM CEST Greg Kroah-Hartman wrote:
> On Fri, Sep 17, 2021 at 09:18:35AM +0200, Fabio M. De Francesco wrote:
> > Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
> > For this purpose unify the three usb_read8/16/32 into the new
> > usb_read(); make the latter parameterizable with 'size'; embed most of
> > the code of usbctrl_vendorreq() into usb_read() and use in it the new
> > usb_control_msg_recv() API of USB Core.
> >=20
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/r8188eu/hal/usb_ops_linux.c | 59 +++++++++++++++++++--
> >  1 file changed, 56 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/
staging/r8188eu/hal/usb_ops_linux.c
> > index 2d5e9b3ba538..ef35358cf2d3 100644
> > --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> > @@ -89,6 +89,59 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhd=
l,=20
u16 value, void *data, u1
> >  	return status;
> >  }
> > =20
> > +static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8=
=20
size)
> > +{
> > +	struct adapter *adapt =3D intfhdl->padapter;
> > +	struct dvobj_priv *dvobjpriv =3D adapter_to_dvobj(adapt);
> > +	struct usb_device *udev =3D dvobjpriv->pusbdev;
> > +	int status;
> > +	u8 *io_buf; /* Pointer to I/O buffer */
>=20
> As you "know" size is not going to be larger than 4 (hint, you should
> probably check it), just use bytes off of the stack here, and you can
> ignore this buffer entirely.  That will hopefully allow you in the
> future to get rid of that buffer as odds are it will not be needed
> anymore.

Dear Greg,

Yes we know that in fact, for the rtw_read*() cases, we only have 1,2,4 byt=
es=20
size embedded in the calls. It's different for rtw_write*() where we have a=
=20
version, that is rtw_writeN(), that could pass larger sizes (checked by the=
=20
caller to not be larger than  VENDOR_CMD_MAX_DATA_LEN).

Said that, we already get rid of the buffer in 19/19. As far as 17/19 and=20
18/19 are regarded we prefer to leave the code as-is, because we have=20
many other changes in this 17/19 and in the next 18/19.

>=20
> > +
> > +	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx)
> > +		return -EPERM;
>=20
> How is it ok to check this outside of the lock?  What happens if these
> values change right _after_ you check them?

Yes, this is a mistake that was in the original code and we didn't noticed.=
=20
Anyway, we guess that moving the acquire of he mutex soon before this check=
=20
is all that is required. I hope it is the correct fix. Isn't it?

>=20
> Why check them at all, is this something that we even care about?
>=20
> I know you are trying to make this just the same logic at is there
> today, but why not just do it right the first time?
>=20

Yes, we are trying to make the same logic that is there today: we already=20
changed a lot of other logic that was in this code. I see that=20
bSurpriseRemoved is set in error cases, so for the moment we don't feel lik=
e=20
removing anything related to this variable. With a high degree of probabili=
ty =20
we'll do this task later in future patches.=20

Do you agree with the argument above?

=46or instance, we got rid of that while loop around the control messages=20
sending/receiving API calls and we got rid of some plainly useless 'if' tes=
ts=20
(such as "if ((value >=3D FW_8188E_START_ADDRESS && value <=3D=20
=46W_8188E_END_ADDRESS) || status =3D=3D len) break;"), and much more.

> > +
> > +	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
> > +
> > +	io_buf =3D dvobjpriv->usb_vendor_req_buf;
> > +
> > +	status =3D usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
> > +				      REALTEK_USB_VENQT_READ,=20
addr,
> > +				      REALTEK_USB_VENQT_CMD_IDX,=20
io_buf,
> > +				      size,=20
RTW_USB_CONTROL_MSG_TIMEOUT,
> > +				      GFP_KERNEL);
> > +
> > +	if (status =3D=3D -ESHUTDOWN ||
> > +	    status =3D=3D -ENODEV ||
> > +	    status =3D=3D -ENOENT) {
> > +		/*
> > +		 * device or controller has been disabled due to
> > +		 * some problem that could not be worked around,
> > +		 * device or bus doesn=E2=80=99t exist, endpoint does not
> > +		 * exist or is not enabled.
> > +		 */
> > +		adapt->bSurpriseRemoved =3D true;
> > +		goto mutex_unlock;
> > +	}
> > +
> > +	if (status < 0) {
> > +		GET_HAL_DATA(adapt)->srestpriv.wifi_error_status =3D
> > +			USB_VEN_REQ_CMD_FAIL;
> > +
> > +		if (rtw_inc_and_chk_continual_urb_error(dvobjpriv))
> > +			adapt->bSurpriseRemoved =3D true;
> > +
> > +		goto mutex_unlock;
> > +	}
> > +
> > +	rtw_reset_continual_urb_error(dvobjpriv);
> > +	memcpy(data, io_buf, size);
> > +
> > +mutex_unlock:
> > +	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
> > +
> > +	return status;
>=20
> No one cares about this value, is that ok?

I'm aware of Pavel's work on changing all the callers up to the top of the=
=20
chains in order to do proper error checking. That's why we return status=20
here.

>=20
> thanks,
>=20
> greg k-h
>=20




