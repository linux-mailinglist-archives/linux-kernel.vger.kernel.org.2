Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2C4549D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhKQP1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhKQP1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:27:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1227E6112D;
        Wed, 17 Nov 2021 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637162644;
        bh=M9gTPOIG8pwB0M2TMTH9ii2V7sjKTrCehIiWvcSY6SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ry/tXbDCVaOBsQWEDG/iD5C1ZdIBfg4awP1lDX1LnvLOocpl0cJZG9Ch3j7meScKz
         UUP5vIuxu7DA7bMLYdHdmwdZLX2XAXnGnscZMVsYEhC6BFj7v8lyPsvROzi69fUbp5
         gMuHPqA0bNdEYpKT2IdAZQbMQLvfgL3j4bGONLuOwsk5cTkKIyYpmMWm7fXgQ5NTT3
         M8FmK+531KqmCvlMiMz5PtccPUdohEaT6mYFjwHOPL4/1wUkzDB12xBObIsqdx7Sr5
         /WcunlEfF+hVj+yPwctvBfeP5jXMQP7T19vKiVdHmdN6nB+9wNa6daTFiVcEkF5rCM
         kL6I+50MbYVAA==
Date:   Wed, 17 Nov 2021 15:23:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, aou@eecs.berkeley.edu,
        borntraeger@de.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mhiramat@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 2/9] arm64: Add comment for stack_info::kr_cur
Message-ID: <YZUejUwy4hF1A66s@sirena.org.uk>
References: <20211117140737.44420-1-mark.rutland@arm.com>
 <20211117140737.44420-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Tkn64WSCkh0z9oK"
Content-Disposition: inline
In-Reply-To: <20211117140737.44420-3-mark.rutland@arm.com>
X-Cookie: One Bell System - it sometimes works.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Tkn64WSCkh0z9oK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 02:07:30PM +0000, Mark Rutland wrote:
> We added stack_info::kr_cur in commit:
>=20
>   cd9bc2c9258816dc ("arm64: Recover kretprobe modified return address in =
stacktrace")
>=20
> ... but didn't add anything in the corresponding comment block.

Reviwed-by: Mark Brown <broonie@kernel.org>

--4Tkn64WSCkh0z9oK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVHosACgkQJNaLcl1U
h9De0gf/Xi8aAklrBWxIz36taJai9HWfXmVYo6tx5YvI0b5eQrukp8xP1eANR3r0
es6HA4vVZxDXG8nAJM/dR9O5kpwuVfarxnc2c+y30/s4X+qQcVY6YFzYKAhFpZ9b
l6bNlS4Xdc6JvBLGVcPN0nisdiA067rPJwUI5cpbXif7zgk8ujh4wuxNiREMfx3H
g4CEDOFEML/E9AD7J5KHgFa1965VLgiLhBRM4aGD4vkxZ8c4zOqtfbBD3WsXuzF8
GczLEYswi6MoEHy2nO1FMWszdhFICcZ/+msdzxMuhLSlizJf5osFm1jITS7pTuF1
l14pxC8IF5P+XpC0euM45Qysv8yNWg==
=fqDz
-----END PGP SIGNATURE-----

--4Tkn64WSCkh0z9oK--
