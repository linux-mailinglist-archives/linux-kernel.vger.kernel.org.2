Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE25F316459
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhBJKwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhBJKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:49:24 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:48:44 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id e7so989360pge.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hh731gWK/+w9llsFAgOpwQUfpMkvGJtarMtHikRhFf0=;
        b=dPUgqNTT61Q7/OkwxtprPL0+hwMUmL5JUAjiMSOA5PGKhnn2SfmUFfRQABQ2x4sUsR
         Pwa/kEzzde5zrTbPV4Jvjo3vDIhZM621jFUAA7y3FD68Do60k3IhPK39yO77hAX0Gemf
         bqmfN4+tMfpP+uOmF1CJrTbzFpuyiLysEm0mfVhuqdBGqnBQW36N5dAL/V5oiBqBNMQW
         zwkMgurousYTgsMi1GKBPRh6O0485aFFXTiCfyM09vMQODpy1idmGjNjlDpgpzCuW9Vn
         Wf4m9QDV7u/ocTtVVrrPanfhvwn0m3FZYneFxGcv9SLOwaqiTdHQBOgqvL9ZhGmiCiZn
         lgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hh731gWK/+w9llsFAgOpwQUfpMkvGJtarMtHikRhFf0=;
        b=QMAVUJWEyfYDEHi/459AhN8udEog21MmxOPpV5vjgSGaRCqie2X0pOdCYLLINDIxMd
         fUH6iRowNW9vagAMq4FWho4aiQ2c8i3pTOOATTPkdyUp2IybNmckTu0cmSMarNz6vJ1S
         1d7M9lpVoPdA22cdh/VuHRirKw5qZrU5Ug/kJolTJGfGjM0MLJWG2FGi+aJFG3ck846m
         jGSM8AISiY37thIBQq4kH0aVZxMDMpzFc2M2nYYySAylDuRdWXMKUlDuknUeu6sUhJDq
         ZrATISFpzhLyOvPQl16tAWdMtlWqd+XnDAoi0YLV/8l9zv1eULDNwoQ6GoMY8YdoKD69
         Hfcg==
X-Gm-Message-State: AOAM5337lQVEYdEAollW3cDq6IpEUMzDJ2T2Prx7zXQ9FOc/pqa4IGgp
        DvHpAK+bnDrpl1xJ1BaTW1g=
X-Google-Smtp-Source: ABdhPJxtrn+hHJV7vv5re1RBNyjD+P62IxjXjZzsPEWgOXtupdaYkwHMCdUiemtu9kDdtU3WtGHx4A==
X-Received: by 2002:a62:7d03:0:b029:1bb:5919:6dec with SMTP id y3-20020a627d030000b02901bb59196decmr2698734pfc.76.1612954124132;
        Wed, 10 Feb 2021 02:48:44 -0800 (PST)
Received: from localhost ([103.200.106.135])
        by smtp.gmail.com with ESMTPSA id s18sm1794327pjr.14.2021.02.10.02.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 02:48:43 -0800 (PST)
Date:   Wed, 10 Feb 2021 16:18:28 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] staging: gdm724x: Fix DMA from stack
Message-ID: <20210210104828.5kmdhrt6kaglmlmv@archlinux>
References: <20210210080134.1978-1-ameynarkhede03@gmail.com>
 <YCOUIFVuvJuPP3lX@kroah.com>
 <20210210085811.7dunnfly6cqw67m3@archlinux>
 <20210210090442.GV2696@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="knuynokjtvzjzo4t"
Content-Disposition: inline
In-Reply-To: <20210210090442.GV2696@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--knuynokjtvzjzo4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/02/10 12:04PM, Dan Carpenter wrote:
> On Wed, Feb 10, 2021 at 02:28:11PM +0530, Amey Narkhede wrote:
> > On 21/02/10 09:06AM, Greg KH wrote:
> > > On Wed, Feb 10, 2021 at 01:31:34PM +0530, Amey Narkhede wrote:
> > > > Stack allocated buffers cannot be used for DMA
> > > > on all architectures so allocate hci_packet buffer
> > > > using kzalloc().
> > > >
> > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > 	- Fixed build warning
> > > > 	- Fixed memory leak using kfree
> > > >
> > > >  drivers/staging/gdm724x/gdm_usb.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> > > > index dc4da66c3..c4a9b90c5 100644
> > > > --- a/drivers/staging/gdm724x/gdm_usb.c
> > > > +++ b/drivers/staging/gdm724x/gdm_usb.c
> > > > @@ -56,11 +56,15 @@ static int gdm_usb_recv(void *priv_dev,
> > > >
> > > >  static int request_mac_address(struct lte_udev *udev)
> > > >  {
> > > > -	u8 buf[16] = {0,};
> > > > -	struct hci_packet *hci = (struct hci_packet *)buf;
> > > > +	u8 *buf;
> > > > +	struct hci_packet *hci;
> > > >  	struct usb_device *usbdev = udev->usbdev;
> > > >  	int actual;
> > > >  	int ret = -1;
> > > > +	buf = kzalloc(16, GFP_KERNEL);
> > >
> > > checkpatch did not complain about this?
> > No. checkpatch shows no errors and warnings.
> > >
> > > And why do you need 'buf' anymore now?  Why not just allocate hci and
> > > pass that to the request instead?  Saves you an extra cast and an extra
> > > pointer.
> > >
> > > thanks,
> > >
> > > greg k-h
> > Thanks. I'll send v3. I assume now we don't need kzalloc anymore as we initialize
> > the hci_packet so kmalloc(sizeof(struct hci_packet),..) will do.
>
> We only initialize the first five bytes, but it also seems as if we only
> use the first five bytes which raises the question of why we are
> allocating 16 bytes.
>
> regards,
> dan carpenter
>
That makes sense. I kept 16 bytes as original implementation allocated
16 bytes on stack.

Thanks,
Amey

--knuynokjtvzjzo4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAmAjufwACgkQBBTsy/Z3
yzZjMgf/bKfhQf2JVB5X5W3OlSgMymWcO2ex2LjEc9biSbGRzufzyGbSprgy7Xri
S0kjg3C5bzuGVZ31W+os/zlbKNx/jw852EoXnlzt+1UPqQm3nHNKuJ4sQPYKeJnY
JhMvo54xrLlnYluJ0V1tp9CwT+38Bew9ZS3ylq3Sm5AtsSE9JHwny7HVU+yY6LHO
a7xNDbx74qXMOupXPCD7S8CniRvKKaGvx0FsxTlZk7W07uauKNgacik87gkFPvzn
52nb++/5ukoCueuW8f/jydoGuGUscUl73PTtQLlpGnha+a7PqTO/2bE6d4CZk0Yz
S5hg7dijv+l1tB8l+9kUwqi4JYzBIg==
=dc20
-----END PGP SIGNATURE-----

--knuynokjtvzjzo4t--
