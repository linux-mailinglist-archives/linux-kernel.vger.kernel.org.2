Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B555F36B1BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhDZKkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233181AbhDZKjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:39:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E041260FE5;
        Mon, 26 Apr 2021 10:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619433519;
        bh=QWf2QF2tmOt45LbuGNFNJTJu2BK2aUi7N9rUAgMP8Ek=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YhT+7SoxVvujIK56rCT/NOvSu7GAP0BQSGU6SjwIeNQ1H0uHrDoX6Gi4RfOg1tRRx
         6IVrQDNB6FxGqP9HB+6/x8MgVn92EC7jjhSMp0tUsc+fXEcyO/vTp51nAWAg4Irihr
         Xoa2CAqWa78p/dDr4M1NovwZC7tRHbqA9CuW7Mx21+y0CMOJeD9C55Oo3FrOSMI/+p
         gdKsxnWz1Q+rxtmO5capC752pN9u8ufuBWVBt2Z+8NvaOvPYxsKuqL5J1weP/5O2gg
         2PbpzQKgNofdz5UPw8rJWm40P2Ed1eWNIQMTfDIhWdS/M17vCR/E+RFCUjUJB9T9Sb
         GcyfhXzZKrthw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Ferry Toth <ftoth@exalondelft.nl>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/1] usb: dwc3: pci: Enable usb2-gadget-lpm-disable
 for Intel Merrifield
In-Reply-To: <20210425195452.94143-1-ftoth@exalondelft.nl>
References: <20210425195452.94143-1-ftoth@exalondelft.nl>
Date:   Mon, 26 Apr 2021 13:38:32 +0300
Message-ID: <875z09l49j.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ferry Toth <ftoth@exalondelft.nl> writes:

> On Intel Merrifield LPM is causing the host to reset port after a timeout.
> By disabling LPM entirely this is prevented.
>
> Fixes: 066c09593454 ("usb: dwc3: pci: Enable extcon driver for Intel Merr=
ifield")
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmCGmCgRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYg7BAAiaSBbiXDCsLe6vVQLjvhcEVJjB+xRLDL
1bLNiMILGC7gq3vsNQwPaeDd2YtNGlcqnhXWCl5uIYwESZHj43oPKU9NIXLZ502s
WSsINOjSoNPbrrt1zuVLJYiaA74mvA7JGIyfhFZwwECyUuHMtSUSu7aChcrFKSme
7/QlnDDKTIbCBp52bKA3WWIYm4TxaQDQ6hFX1Nvh5TD2BOEdMQSxNmJAHxvvlKLq
3VNu0WlaL4LjnZQjhN2dGq57pHVpp/OrHpeH16vNylGMKy2PNV82iAk6WxKfz3BV
wOCGLqS6AFzgCJCy7TJveG1d3ttoDtRphY8Wodg7vqbyhnqv6EInbDG8LwZSd7FA
u6c9Dz+nVEhO2nsXR8xjPOZrA1IkekiUSZb/AeWiHWcMt1mcEnHfYYB2wFokmDqg
Aolk5F7DBiLpSCSTzFs/Y+IYCgjj2ohdKwW+J2Suxyh/EO5c7ZdXNyTepJDhXV3h
pHYS4aRJgdDJgEhLNJyLtR96ax41WwvsmpAPRvVNhrtG1f37hyqxl7BiaPU/gDjh
q1dlH7AFT71NoeOCzRWFsgILdUrRYQ9enBxSF4shlInCnWt0Jw5leL0h7VDwHPmw
MvZ5SSvPI/bS95tyDDIpOOD1sb2HmQmsRXnj4OckjnpjiFgrmQh8636hOcDEqtya
Flst+gs5QFE=
=/AB+
-----END PGP SIGNATURE-----
--=-=-=--
