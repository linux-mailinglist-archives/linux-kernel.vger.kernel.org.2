Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB5836A016
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 10:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhDXIKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 04:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233614AbhDXIJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 04:09:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E2C261360;
        Sat, 24 Apr 2021 08:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619251694;
        bh=VskJfTkTIMulsBczm8HV+Sjr420qgt5zXXq/U2hRyMk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hjBty73LO3tWkU1eM8NO0cH+/12XF/b+iekWTnVNP9YwUVqZywjDUcbaE4zsCwM29
         2RjUJY11v43qidZc/ss8f2h5wBsloXx5UiMt5mBCiqFTfL1vLCzReAJ+zb7r3YLjrS
         w4Ct2kXD4Y5jbcy7zN/KlNBg2unrPntrURURKDX41Y6tzSMRRcPpdgg1x3CDRzJiK2
         l+4lkuyf6xT/5jlUiin1IMGDLzwf2X7awvZvBl5/vK9TZQs9z/5wGBRysuuaajfz6r
         +XYevDNcODZ0LyijHDXu4KVh57cpb174fYBNWjNfk10FWj65md9XwRyCj1PwOFjIcf
         dl9PUGwfzKvDw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Marcel Hamer <marcel@solidxs.se>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Marcel Hamer <marcel@solidxs.se>,
        Thinh Nguyen <thinhn@synopsys.com>
Subject: Re: [PATCH] usb: dwc3: gadget: add missing wakeup link states
In-Reply-To: <20210423152524.624619-1-marcel@solidxs.se>
References: <20210423152524.624619-1-marcel@solidxs.se>
Date:   Sat, 24 Apr 2021 11:08:07 +0300
Message-ID: <87pmykksuw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcel Hamer <marcel@solidxs.se> writes:

> In dwc3_send_gadget_ep_cmd() a check is performed if the gadget needs
> waking up. The following condition is checked before calling the
> __dwc3_gadget_wakeup() function:
>
> 	needs_wakeup =3D (dwc->link_state =3D=3D DWC3_LINK_STATE_U1 ||
>         		dwc->link_state =3D=3D DWC3_LINK_STATE_U2 ||
>                         dwc->link_state =3D=3D DWC3_LINK_STATE_U3);
>
> Inside __dwc3_gadget_wakeup() only link_state DWC3_LINK_STATE_U3 is check=
ed
> and link state DWC3_LINK_STATE_U1 and DWC3_LINK_STATE_U2 are considered
> invalid and generate a warning because of the call to:
>
> 	dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n", ret);
>
> because of ret being -EINVAL.
>
> Signed-off-by: Marcel Hamer <marcel@solidxs.se>
> ---
>  drivers/usb/dwc3/gadget.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index c7ef218e7a8c..d05a7d630410 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1972,6 +1972,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
>  	switch (link_state) {
>  	case DWC3_LINK_STATE_RESET:
>  	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
> +	case DWC3_LINK_STATE_U1:
> +	case DWC3_LINK_STATE_U2:

I think this was fixed recently by Thinh.

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=3D=
usb-next&id=3Dc560e76319a94a3b9285bc426c609903408e4826

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmCD0ecRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbpzQ//a7hc6O6M4DUDv/okIpNnthuRUFnA3k1t
NbJkVMmzsOouvmY9H/TuvgQSBX6FtjHXMI4ySj8SsYWFzPWcJPN5qMK2eqg1h+W2
NLgbQqU+WcjslyukiGGOJp0zZXVnGLvSkxvJt9JaH7Isi5H721eulw66ftDCBZ+p
rv3HvauTzc57E1/mm+IjGPSoyblls54WtDoI3y9F0A5fVpggDvI2OTWAQDOnejVE
QqJ6UKGF7FDeVy8H/QzjppZpS9cWnAsCpJOt4H/cocwHNI6jVQPO/6h/ku/akiEd
zU4lVoEXoANqVq9AnDnjgNysaAz3kPRcVmhuz0u2LyumAvWG9UWsv2jUdex+R/Sz
FVercH+NEqJ5EGVoClyGCx7ncB9E1NkJHcdWqZLJOuyxpeBugKYnZl8RiJkbtL5W
ztkz/pmsDWDiZtDxbT9Lr8fARz5+EBUZi/Z1V1yto6PcUD3PVtpiyKytqK7Erg0u
RqG4Yo84F6ray5UFfotfIZMc3fVeNgfiMsc/gsMzlO22XBSa46WYKGfV6Xy+ZF5y
geIai8VQ0nYW+swk9sSyFd2MkMS4bETBVIt4fgyz2HpfU7vGo/QNIAf7HHv6LnLl
2TvgN9rOlit0DigVCdi01CiqEaQ621oF/4c9z9OO1dlbXleyHaImaq4hEOFnv2Zc
gxHg/3DNRIs=
=IIGX
-----END PGP SIGNATURE-----
--=-=-=--
