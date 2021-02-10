Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81E53169AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBJPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhBJPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:02:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A6AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:01:51 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z6so1439958pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=beJP1mYrkSB9mBgiVe08BgvkPCu0WrVWSYUe1T5cFT8=;
        b=JmIFfWvmUP1+frG/lAkaqmY/IXMtopiZCRe9kvND+RaZK7hebEHmzLVsHrefm3xOPB
         0y0NhuswZTgIKWPwQ/DrS7xlAGDDGiRn9vDgcXrxyuFg7DIcd70f+lrzaqDLoXC8+wtu
         9+3SiFHFTHnfmzqHg2iFD49T97GUrn71t4r5Xk01IaoaomKo1l0iFv3vhTRcVsuhHaHk
         7/bPo8fKQ9AJh6zt+/r/NJP9ukPSDGNqSVBkLK1InlyiV5S/524LW4jio2oqM9C+LoS3
         WSfXz06h8XuECd5Yn6F0+GHo1Dp4outBSdWLsHUjjyuZS2/TK/2AK1bm+9b4ctbINZME
         KFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=beJP1mYrkSB9mBgiVe08BgvkPCu0WrVWSYUe1T5cFT8=;
        b=lNF/qKdacqsGbGokJAvvTBAZPaVbAdSi6dt7EshjvLdt31Uupvn9g2DJ7V+vk6FJ08
         wTVT9IlrgAEgqsesTjq68CgACfVFlbWIfEqUP2YBHqj3owRu2P00dOaWWz15ei/bYhC7
         xBzCO/JJ3TCu1eHaHKCWN2MQnNu0681cnHEXjaxetbffo03O6I9Gqi0LREF0HMO1Cn/S
         AoI3BUjvNdJUYRlPNljWDiAdys/Qo79h+M4T4NuvJ/RBXa+5vy9DcbJoCtvnfZgup2hr
         DEN/EmY1dGSsJ9PMXTv1aOOHPo5vP0mNPk8YNOdt2YcBrgYdkFYo/cGIEg7H640FJ77w
         U6rA==
X-Gm-Message-State: AOAM530tRTBau/U9iU9vLSHlem0jwtYyiU2fdIavVDIHN/FdxPC7mwVX
        yU9Bzt0wPvevBRLS4iWqRNOgjlVENqE=
X-Google-Smtp-Source: ABdhPJwC+Uvy/gzCp/1OSVlsPTqUU2JoH2LX9RLXrZ9/C4CeS5MQZnrciTxFhUyij+/J5IWuTSH1tQ==
X-Received: by 2002:a62:5a45:0:b029:1e5:4c81:c59 with SMTP id o66-20020a625a450000b02901e54c810c59mr3645349pfb.51.1612969308755;
        Wed, 10 Feb 2021 07:01:48 -0800 (PST)
Received: from localhost ([103.200.106.135])
        by smtp.gmail.com with ESMTPSA id u3sm2901202pfm.144.2021.02.10.07.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:01:48 -0800 (PST)
Date:   Wed, 10 Feb 2021 20:31:33 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v3] staging: gdm724x: Fix DMA from stack
Message-ID: <20210210150133.chf4gwefgcvaewnd@archlinux>
References: <20210210142512.23152-1-ameynarkhede03@gmail.com>
 <YCPz7jy6BLRzmvU3@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ydswyj5saqachrzt"
Content-Disposition: inline
In-Reply-To: <YCPz7jy6BLRzmvU3@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ydswyj5saqachrzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/02/10 03:55PM, Greg KH wrote:
> On Wed, Feb 10, 2021 at 07:55:12PM +0530, Amey Narkhede wrote:
> > Stack allocated buffers cannot be used for DMA
> > on all architectures so allocate hci_packet buffer
> > using kmalloc.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> > Changes in v3:
> > 	- Remove superfluous buf pointer
> > 	- Reduce size of allocation of hci_packet to match number of
> > 	bytes used for DMA
> >
> >  drivers/staging/gdm724x/gdm_usb.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> > index dc4da66c3..80c58a3ef 100644
> > --- a/drivers/staging/gdm724x/gdm_usb.c
> > +++ b/drivers/staging/gdm724x/gdm_usb.c
> > @@ -56,20 +56,24 @@ static int gdm_usb_recv(void *priv_dev,
> >
> >  static int request_mac_address(struct lte_udev *udev)
> >  {
> > -	u8 buf[16] = {0,};
> > -	struct hci_packet *hci = (struct hci_packet *)buf;
> > +	struct hci_packet *hci;
> >  	struct usb_device *usbdev = udev->usbdev;
> >  	int actual;
> >  	int ret = -1;
> >
> > +	hci = kmalloc(5, GFP_KERNEL);
>
> Why "5" and not:
> 	hci = kmalloc(sizeof(*hci), GFP_KERNEL);
> ?
>
> thanks,
>
> greg k-h
I really need a cup of coffee :)
I'll send v4

Thanks,
Amey

--ydswyj5saqachrzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAmAj9U0ACgkQBBTsy/Z3
yzblYAf9H3EOJk/l30Do38RCSkbDmugXm/zeGUYvILtXRiTHX/xDK2Bzo/c1j2Gz
jiqUFbLs1/MgehpgDxj4bST8Z0FeGLOOhkf+Jr/KRNbAUwy4GB8KcUhBI8+v7s/U
icimCI49xSO3yk4SN17BfADrODZM4oUuQPewlfHNYYYg+amq1PGYHBIre4vHWWdg
/jzDLtQG8vJqPBDgLKBRWwwGPxQfvR6Vxpqs0lw394r/LQePk5lau+GSgCBPsqZp
8cAyIHu4xmD601IjbcmlPCRJpXHPFzCWzw0Y+iI9IbKLkDYe1828pgoPFojR5/Hf
zv93hZDStFHoE9kE6KwuRLlNYJ8JWQ==
=Ux+e
-----END PGP SIGNATURE-----

--ydswyj5saqachrzt--
