Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E903A29E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhFJLLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhFJLLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:11:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 302016128A;
        Thu, 10 Jun 2021 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623323367;
        bh=OfaX/teV71AJoN/dAZjPB4P3vHvVUY6txaOOAlwSzXU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=I4uoF9vdhxZhZvhoR8wEF2WvOIoVNB99TqW+500EL24KdN9YTzknOZMWtyixl2bhe
         rWQXby4YcpMFNAkc1lFJyZBK+Wa/ZVsFi/HPaqUZRUpLaOk43s1Oq89WuighL6uddy
         415Ps7REqUa+wrcjDJaFhnk6M3BKTmWV3pFuzZmvgF6wPij/fdX3/XQQGjB4cujudn
         tmknbqsyiZ9UUZa0KULP2R8ZQp/fPgrf+H9ROEyAj10BkRxmW8T0BJLMi9rlZOKG7W
         oGUojLI8cWlqzX28zls4c5w+88zJcYlVzmzn4pk65X5ZWndxA8B0RnMOAXus3Sl5Nt
         O2+mYLBcY2PEA==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Disable gadget IRQ during pullup
 disable
In-Reply-To: <1621571037-1424-1-git-send-email-wcheng@codeaurora.org>
References: <1621571037-1424-1-git-send-email-wcheng@codeaurora.org>
Date:   Thu, 10 Jun 2021 14:09:19 +0300
Message-ID: <87h7i60ye8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Wesley Cheng <wcheng@codeaurora.org> writes:

> Current sequence utilizes dwc3_gadget_disable_irq() alongside
> synchronize_irq() to ensure that no further DWC3 events are generated.
> However, the dwc3_gadget_disable_irq() API only disables device
> specific events.  Endpoint events can still be generated.  Briefly
> disable the interrupt line, so that the cleanup code can run to
> prevent device and endpoint events. (i.e. __dwc3_gadget_stop() and
> dwc3_stop_active_transfers() respectively)
>
> Without doing so, it can lead to both the interrupt handler and the
> pullup disable routine both writing to the GEVNTCOUNT register, which
> will cause an incorrect count being read from future interrupts.
>
> Fixes: ae7e86108b12 ("usb: dwc3: Stop active transfers before halting the=
 controller")
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/dwc3/gadget.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 49ca5da..89aa9ac 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2260,13 +2260,10 @@ static int dwc3_gadget_pullup(struct usb_gadget *=
g, int is_on)
>  	}
>=20=20
>  	/*
> -	 * Synchronize any pending event handling before executing the controll=
er
> -	 * halt routine.
> +	 * Synchronize and disable any further event handling while controller
> +	 * is being enabled/disabled.
>  	 */
> -	if (!is_on) {
> -		dwc3_gadget_disable_irq(dwc);
> -		synchronize_irq(dwc->irq_gadget);
> -	}
> +	disable_irq(dwc->irq_gadget);
>=20=20
>  	spin_lock_irqsave(&dwc->lock, flags);

spin_lock_irqsave() is already disabling interrupt, right? Why do we
need another call to disable_irq()?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmDB8t8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUhu9Qf8DEV2wOBk/LUS2p/sG3bNfv8n6vpJAzGe
b4ExG7WtxEcRBsAnqL9I9rDs+T0gtWLVGzznJVAZ7Lj9v37jVvMs2yKSkTbY80iV
CpFiL1Yb+SD81+h76/aIBer26uDTEBP8ouhGxlcAg1EfXglrB03oob7o32upz47N
UB1n1jXxGzAT15gwoWTaGd4+YzOZgxrSt7idBzlAtQ5cxh5BWSe1OGwXwKNlRpIR
YWhDZVqEyx9yFwVOuSqsrvOoYL3dqrYiylDUT9bAng3fhGp7vFFl1A1y/rgJWTlp
CAwRxKDbjugp9MUMnzImAtJ+5AlctkhO7B9aLAB+cWMYpkS5qJ6zHw==
=bNqx
-----END PGP SIGNATURE-----
--=-=-=--
