Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7176360258
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhDOG1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230153AbhDOG1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:27:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE3E260231;
        Thu, 15 Apr 2021 06:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618468007;
        bh=+ENAR6b4b0HhPBE+r0SPMfIaZNMhcuo0VJOvNcPqXcQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dwgm81l0ZnPOhmJKZP9BvVqixZJokLlkolbuCZrO3WX/hAzHmpPLueKrTG16tybOt
         KKqfuz656EJ7SvVPzMmEKsMT74VhtXSyXjqajtnduiUzxS9D98yYldy1ypwVuelaE0
         c84BUUv02ZQ1q26bSh6zRkgZ9wbh/oNjXHt57QzlQqyuHpFprelNDDNP9LsihX/g2G
         nHJSDAp36J+Bjb3tg5GyaI+FwlwZXnK81tWTCH0O0NqALm0PFsP/tm60F1sNoZ9Gco
         Dm3W7kPgPrlKjf2wJkStpwRIZzbGxuE8eUH91RuSE11CdXqJXKn+zROcQNe2+imCSL
         pNk6TFpXegjRg==
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid canceling current request for
 queuing error
In-Reply-To: <1618439388-20427-1-git-send-email-wcheng@codeaurora.org>
References: <1618439388-20427-1-git-send-email-wcheng@codeaurora.org>
Date:   Thu, 15 Apr 2021 09:26:40 +0300
Message-ID: <87mtu0njvj.fsf@kernel.org>
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

> If an error is received when issuing a start or update transfer
> command, the error handler will stop all active requests (including
> the current USB request), and call dwc3_gadget_giveback() to notify
> function drivers of the requests which have been stopped.  Avoid
> having to cancel the current request which is trying to be queued, as
> the function driver will handle the EP queue error accordingly.
> Simply unmap the request as it was done before, and allow previously
> started transfers to be cleaned up.
>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/usb/dwc3/gadget.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index e1b04c97..4200775 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1399,6 +1399,11 @@ static int __dwc3_gadget_kick_transfer(struct dwc3=
_ep *dep)
>  		if (ret =3D=3D -EAGAIN)
>  			return ret;
>=20=20
> +		/* Avoid canceling current request, as it has not been started */
> +		if (req->trb)
> +			memset(req->trb, 0, sizeof(struct dwc3_trb));

we don't need a full memset. I think ensuring HWO bit is zero is enough.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmB33KARHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbjrRAAgudUzvoaFOVpQwYbsfAE8oP1FM4o45Lw
//mO35HrO44ArfFT5nMh7N/hsvLZFvRk5LP4R5sSEG9+Qqm7EdEfrkmVxVzCpPYV
hhtBJBB2Lh1dpNtSafCUrDd9niDSXh/PtHo9KlN2NNCtecrW5NPmBRwcVElq7Lub
Hx10/+9bXBz/539PseIm4mXmprGO9ZU6TEJu78kmWcpWBOsJJZNTiz8e1chAzPvb
YS2k4XSm6mjKxIm9+PMVtV9psZG1D4tdDNAbNuITEfrxBSQnbi/h5zO/XWJZEBLQ
PLblcB5PX4/mV+P/xQNUUSM1hQ9o7rZFsS5JYLpwqLNn2H6L1kHExc/Exebzq/Ju
z6PoBLnY4/qBmL/7OjBfDYWMot4dznVpvvYVs6IP9KT6cMhU2pVQiW1pJ8K+pbrQ
6dkkEkDvWXe+blIRpQPf2nGg1JeaisJ4xuMDs3qK/seiDbrZwL3XwRj1LPz3/xUu
AdZY15RMifKh9mzDCrbIMUP5JglNmbktfYimnrVQjSPsR5DUuzGaauIaz7USafmF
0ExythixDvJMgYWDK2vQehTsBUOvz7nlfRD5z/N3fxYIE+FmjX5sJoIEzIPsehF6
U+9k9VH4yhtDaPpo+ysKEhF9ivB78QmicKn04bKSDzcRCQf8t4LLnKPPTnjEdWJu
p6mcEvHzUCY=
=jYQD
-----END PGP SIGNATURE-----
--=-=-=--
