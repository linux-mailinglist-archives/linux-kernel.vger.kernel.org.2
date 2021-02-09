Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5A43159EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 00:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhBIXRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 18:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhBITq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:46:58 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F479C061A30
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:36:06 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so12522419pfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XjEcIQFFk/DsYt3Z7ezRvXcADPPGVZJbm6+98Oh58aM=;
        b=ZinSA+0OpNXz9XeLKj8gV9wRbCXFqTQ7PLNK6gbHycJhhx0vHnjxuTcKTLNJJIICIc
         bfiTf801xPiH4ivaBBoN0GokTKt18JfLP2gg1FV4xcv4wghUFHo4dp1k5buXHYTQzoZY
         mlYEq2dW0PuYUeiTay0h8fsNEP2r6o1I+xdEpRxQimu9cKbCpFyuzeH5tvqlCudgvmxJ
         bfSVovZghJcAQH1+gXWuxdPmlPAldrhYL3eRTVlgktFiyCtgtyrawds2k72o9CCdNoaZ
         G0IRyfKgyA9wmwJxfKh5JbkKPplPgOWUPk2F9LRh/neMfBvzVB2tzCYrPLMwr52ei5f2
         dbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XjEcIQFFk/DsYt3Z7ezRvXcADPPGVZJbm6+98Oh58aM=;
        b=grZtjAV2Z6OqCD9w6/73dZoNCSj3P3+pUBDUuWT27Vct9WNwVLrGyplMWivBkTv+UY
         CdlySZa7lDgENQLS96PUwjdjSBOjp+D3p/PdeN5mBIZy44DigR423IusShwwWtJKXuZk
         843pA7x2fn9xaP0MKQTDz7bZYR82+8rdPSv/Bi8F1PS9ubBJGo+jpKnyoo+tZXAcIYhO
         4hWvNtdG9b7Db6h7eLoBjPkwFZLoSjThMR7Hv69HfjAQ0yQHrti/ii/zMGkelYalzrIw
         P/CCbDJ4IatunGvKz9wRQ44LkUUBASDSvjSO8vrkUYZOc255niCA/e7aCrWQ0aLMkGI0
         zfgw==
X-Gm-Message-State: AOAM5330/WPXlnK/BV3UctZf0XpW4wIyWpiiw8Walu+k3BM8nFRkQh0i
        nyXj/UYcBKD2wdFXVHqMKyA=
X-Google-Smtp-Source: ABdhPJw22DOE1L6KGpNIvwuEFjs8f7KzCZ8FBLWo1V/U3uWxQA4vIE2ALXCmdUO284Ddvcrgt5F6cQ==
X-Received: by 2002:a62:ce82:0:b029:1d9:1872:294b with SMTP id y124-20020a62ce820000b02901d91872294bmr19233956pfg.36.1612899366224;
        Tue, 09 Feb 2021 11:36:06 -0800 (PST)
Received: from localhost ([103.200.106.135])
        by smtp.gmail.com with ESMTPSA id 194sm20446771pfu.165.2021.02.09.11.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:36:05 -0800 (PST)
Date:   Wed, 10 Feb 2021 01:05:52 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: Fix DMA from stack
Message-ID: <20210209193552.bj343ls6t7r3xxei@archlinux>
References: <20210209145415.29609-1-ameynarkhede03@gmail.com>
 <YCLJHNvKhiMJmTP8@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3nrjkvplolsm5uhf"
Content-Disposition: inline
In-Reply-To: <YCLJHNvKhiMJmTP8@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3nrjkvplolsm5uhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/02/09 06:40PM, Greg KH wrote:
> On Tue, Feb 09, 2021 at 08:24:15PM +0530, ameynarkhede03@gmail.com wrote:
> > From: Amey Narkhede <ameynarkhede03@gmail.com>
> >
> > Stack allocated buffers cannot be used for DMA
> > on all architectures so allocate usbdev buffer
> > using kmalloc().
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/staging/gdm724x/gdm_usb.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> > index dc4da66c3..50dc463d4 100644
> > --- a/drivers/staging/gdm724x/gdm_usb.c
> > +++ b/drivers/staging/gdm724x/gdm_usb.c
> > @@ -56,7 +56,7 @@ static int gdm_usb_recv(void *priv_dev,
> >
> >  static int request_mac_address(struct lte_udev *udev)
> >  {
> > -	u8 buf[16] = {0,};
> > +	u8 *buf;
> >  	struct hci_packet *hci = (struct hci_packet *)buf;
> >  	struct usb_device *usbdev = udev->usbdev;
> >  	int actual;
> > @@ -66,6 +66,10 @@ static int request_mac_address(struct lte_udev *udev)
> >  	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
> >  	hci->data[0] = MAC_ADDRESS;
> >
> > +	buf = kmalloc(16, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
>
> This is great, but you just added a build warning, which implies that
> the patch is incorrect.
>
> You also have a memory leak here, which is not acceptable :(
>
> thanks,
>
> greg k-h
Apologoes. I'll send v2.

Thanks,
Amey

--3nrjkvplolsm5uhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAmAi5BgACgkQBBTsy/Z3
yzbR6wf8CE2iLWxMDz7+ihnsHFdLlTi+mSjNVW6Yqk3xMxNYVwY6nv5EiViy1Eus
AwBUPcoecH9RZDZMjwCAlevr8x+kw7YDiDAxbab78OW8Feyl5cRJiyVvWPcm9m2t
Xy8VSfZd9iSTdmyziPwe6njtt0kVd1e0+JB0HEOCsY2gWzqGTAEnotSW/wb2sepZ
U84IRZJceRoppXIaKFJEMLk4XO2ZXHyKGs/ElwA1T57otfHrq7lajKmKYgtaaBUU
0e1NOmcESAVwnOp8PdI2UfAY5Y8XZSONkjncfNOo/Wdx9BIYMI56EU48ka7+GSB0
ysT7+tg4zPIHLkXr6qoyb6095JqJ7w==
=76Pr
-----END PGP SIGNATURE-----

--3nrjkvplolsm5uhf--
