Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1131647D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhBJLAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhBJKzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:55:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD9BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:54:57 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u143so1014507pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jBIUHOWtg2dF5e3zXMZeQ47GV+A9ufzsrhcBdcwlOIo=;
        b=PbcnLvfL7EHMpCXcXx+QTCQp2HAv0KSKug3hp/01z9XnzXtjBy8t7wN3PJ8eGZjY6q
         6de8pm2zJtdayjbLy87dafKVYOPvXFhtMK1D8gvRSXxeq5BnytQLM/0pMOwuv9ZZLipK
         DB3xXjXdOuboVfXx/o1U604M9QCJWHPunzVPLS8OSjMYyiDdR035eLT39EM0rVL0dSyI
         3X0giWKXciV1u6YFxuluFkjRnPjSscWo1YpeVqZJ4WlixccDQDyqZWJ4A5Oy4mHP92xD
         XrWzaa4SVG+aI5JSDODUH8CXlTpSbeIqPDgVmRyrp6FKfSZP02JWSQsky0unqbCP8zSL
         Ph+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jBIUHOWtg2dF5e3zXMZeQ47GV+A9ufzsrhcBdcwlOIo=;
        b=gga9H00zu9VtRvCKLrm6OQs21oiqcPPiMuVGnwe37kbm/thRRTQA100KDHxa9hfnGC
         vPL49tEtyv+1ckP1CA7IbMXIGY1WHhe2AjJwbXQ/gY5KDRyJLpsD8QSlEvfkYvdD6/eB
         TVh96YjDX2Ktw5SMLSnKavBYkFK0a6RBUcCoL04e9VqSeCVH5xK/v8SB1pCOPthvzu8n
         W1dn4BKiZYVQ29uYEegD69Rh4z6AdblnAj0dNQyxPWpy800x0N7jKOn0AqPxvnUxErsC
         zIhyaCGl2c85b53insz6+FyGOO/LvF2pz668ZWOEvXHqt7QBYiO+nFyKAfZJmyZk7KQ0
         EScg==
X-Gm-Message-State: AOAM530VkSuhYNs1zGZCaIWyCPxFSlGOC9m9vxwuWcRMnY0rSUE/zJob
        2u7Onb1IUmvX6XcX+LKWk8Q=
X-Google-Smtp-Source: ABdhPJzpgEDu8+JvRLSOi20pp034PJU0empTTSivHkAp73/RAwLGw3QhYWOtK3oKl1hKpRlNQ42WGA==
X-Received: by 2002:a05:6a00:16cd:b029:1c9:6f5b:3d8c with SMTP id l13-20020a056a0016cdb02901c96f5b3d8cmr2776402pfc.1.1612954497049;
        Wed, 10 Feb 2021 02:54:57 -0800 (PST)
Received: from localhost ([103.200.106.135])
        by smtp.gmail.com with ESMTPSA id y73sm2067698pfb.17.2021.02.10.02.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 02:54:56 -0800 (PST)
Date:   Wed, 10 Feb 2021 16:24:41 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH v2] staging: gdm724x: Fix DMA from stack
Message-ID: <20210210105441.56pvgjes3txfwn6c@archlinux>
References: <20210210080134.1978-1-ameynarkhede03@gmail.com>
 <YCOUIFVuvJuPP3lX@kroah.com>
 <20210210085811.7dunnfly6cqw67m3@archlinux>
 <YCOit8SI7k1Gv7dl@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="npqdei4u57mrjtde"
Content-Disposition: inline
In-Reply-To: <YCOit8SI7k1Gv7dl@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--npqdei4u57mrjtde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/02/10 10:09AM, Greg KH wrote:
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
>
> Please add a blank line after variables and before logic.
>
Will do thanks.
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
> Why is it needed now?  And why would that change?
>
> thanks,
>
> greg k-h
I was thinking about allcoating hci_packet(hci) but as Dan said
we only use first five bytes so kmalloc(5, ...) should work.

Thanks,
Amey

--npqdei4u57mrjtde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAmAju3EACgkQBBTsy/Z3
yzaCXgf/TkdeP+yE2c++y1LMX2H1wbyMJPaAsXWCaefA2pwj6IZbzoMV9d8E3RoE
9zZBBPzr88FQ3QVapx8mcfnnFv5sAMFLpJCm0n2c8lnC7pmIICwKr2ZTck9tLcXU
Mx7nYzBxVAunkn90KMkfjFy19J18BYi56Tca7FN+GHqlNR3Qd7wIy9EODk4krgU2
voAHnwhq/15MzCL20hC7Zn3VEnZnAMXYYSZ33DETvcW3/0nobh/Nx5pWHw1vEwmL
Ki7Pt4jjBMd48ht82jNMLkWd8IJYWAreSdN1iDKyq3jDzc52Op+wc8lGdZKg17q/
WIGwoSfzcRmFz8hIk/lVXIj0Wkr0qg==
=YyVo
-----END PGP SIGNATURE-----

--npqdei4u57mrjtde--
