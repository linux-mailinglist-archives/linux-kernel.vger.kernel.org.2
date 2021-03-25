Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC203491DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCYM0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhCYMZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:25:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C4B461A02;
        Thu, 25 Mar 2021 12:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616675152;
        bh=+s4xM0Lyz3jyD1nMjPUWpzDFZqWRYVY9+ICqQhQ1i/g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XDYkAB6hdGdlqyl1jGYORZsDc8NO6yWXuKM8ENB31agKA4iivkfDkcfsKgFq+55Gw
         AFPlCreyFLWB4WUqVIbNyVGJBQWjAis4Q1lMIga7acjFvv6gtyYZwm3znr1F603pW4
         pjpRGvBRtXJmtOrHC+MxW5JZtU0lBuUjCuiPFsbED2KEVt6q+0JYCHZVTqsrbzP6rB
         g8BiU0hS0XEFzarEs7ti5gef9mHbfnbySBvfyNif/5eKya3XzN06zcr6xdstcix5Yv
         lOocgfGrg0rQP79JwJJR7n3SV4e5c7hCNhytiNQqJ5B3c5D0rMtG/hqgD3qt6YfBoO
         +GFNN08Dok6Ag==
From:   Felipe Balbi <balbi@kernel.org>
To:     Ray Chi <raychi@google.com>, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        albertccwang@google.com, Ray Chi <raychi@google.com>
Subject: Re: [PATCH] usb: dwc3: add cancelled reason for dwc3 requests
In-Reply-To: <20210325115436.861299-1-raychi@google.com>
References: <20210325115436.861299-1-raychi@google.com>
Date:   Thu, 25 Mar 2021 14:25:44 +0200
Message-ID: <87y2ebju7r.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Ray Chi <raychi@google.com> writes:
> diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
> index 0cd281949970..a23e85bd3933 100644
> --- a/drivers/usb/dwc3/gadget.h
> +++ b/drivers/usb/dwc3/gadget.h
> @@ -56,6 +56,12 @@ struct dwc3;
>=20=20
>  /* Frame/Microframe Number Mask */
>  #define DWC3_FRNUMBER_MASK		0x3fff
> +
> +/* Cancel reason for dwc3 request */
> +#define DWC3_REQUEST_DEQUEUED		-ECONNRESET  /* Request get dequeued */
> +#define DWC3_REQUEST_DISCONNECTED	-ESHUTDOWN   /* Device is disconnected=
/disabled */
> +#define DWC3_REQUEST_STALL		-EPIPE       /* Bus or protocol error */

this is just obfuscation, pass the errors directly. Also, make sure
these are documented in the API.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmBcgUgRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbkIBAAo0rcWRTbI1kOE56uyHRCFxKcIhRb6hr1
WG2Md+N3TXpnwEEAVp04kp+MSBFBBzLKZHGaR4vhxM3wWVoG/QLzCz8VI6Q7/IMT
Jrh3rm7mCO0Jsd4JGn5R4dXDzFgOdP8F3+T6izh/XiJt5maOsaOOjLy3S2PbQnCh
KvsvyZJ8Apcw7fquObgURibkwP5W/AZl1hTT9LNxsg+umXgNu2jNg7PHqK9+Wtq9
oz8PkumUqhZ4yDkYSUmKYwdoCQYgQIdmq2OMA/sKjD6L5ogGXZJ7qLqcGLgKJFC3
X1X3HF2gjzScmKttP4XIPn35xtY3HSPyGs5/e88ohqrMBFAzf9nNasJpy6oSV6/Z
0baVSjcLjAPTWjse5UgTOIZdeQ1DaJRuBUTyRR3mTqCv60vQmYWd2WfJA34jMqo7
0xqfyr/Xyr0UcSbZBxPa0VaIz6FVqhrg8ZAr3gviD7ARdoKl0eGOlEzLtTpKhLAj
NfU1n0gP/Id6tF11oxxnydqrBn50St7fEuHtxFiZCB+EhExrUJH0GLlguD8W5GaO
JtrXSoYC5GwO21yBvVztmfbrwHX3n/+NLsudyUXEVqzfv0PtAqYEtX9jnMcSA+w1
CG3DvbDDKe1Pb+UZBWBF6rpebdJ6DtaE1O2PTo/LLaLNBgm5b++pd7LHnvkDWSZl
336XHQjpjnc=
=FB4s
-----END PGP SIGNATURE-----
--=-=-=--
