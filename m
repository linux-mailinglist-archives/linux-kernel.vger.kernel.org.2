Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B178B4549EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbhKQPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238261AbhKQPe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:34:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D336761A64;
        Wed, 17 Nov 2021 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637163120;
        bh=Fy1DUbVKguQb7lEqOMy6zgHsmQaoWPaPgqU+nqO5inU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3fftaE8zW9s5Er6wsJhvoQes/7jiN7Dg+gDSsa12HBCnQnkVf3HExAwLcJY4wKO1
         4bxW0qEVY2ZIFEHJ3oIbabfwRgqNs72rtZlaL2hjziT1/iXYvlSS7qNiKid8gGM4rp
         BQJ4r1vH6rxK0F4MfXOcWeTmdKV4UQ/iSTU7uAvWGHH120xnkiCn8W5fdr783YdY8z
         Cfg/mGJdIZU5CBKpLQU7OkQEdtd5yylKjpuP0MVmmKYASaPhkUQ8yARZSDcXz7tdAb
         U0qnAGTKhfORiVzV/hYZb1pQ7c9KTkws3twYFiUNi6I7EzrTqPHCOkxkeF0IL/qVLp
         djAobvMfRVNsw==
Date:   Wed, 17 Nov 2021 15:31:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, aou@eecs.berkeley.edu,
        borntraeger@de.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mhiramat@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 7/9] arm64: Make profile_pc() use arch_stack_walk()
Message-ID: <YZUgacX5UESeYNcv@sirena.org.uk>
References: <20211117140737.44420-1-mark.rutland@arm.com>
 <20211117140737.44420-8-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N819f5Q53Ybwh5GI"
Content-Disposition: inline
In-Reply-To: <20211117140737.44420-8-mark.rutland@arm.com>
X-Cookie: One Bell System - it sometimes works.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N819f5Q53Ybwh5GI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 02:07:35PM +0000, Mark Rutland wrote:
> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>=20
> To enable RELIABLE_STACKTRACE and LIVEPATCH on arm64, we need to
> substantially rework arm64's unwinding code. As part of this, we want to
> minimize the set of unwind interfaces we expose, and avoid open-coding
> of unwind logic outside of stacktrace.c.

Reviewed-by: Mark Brown <broonie@kernel.org>

--N819f5Q53Ybwh5GI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVIGkACgkQJNaLcl1U
h9CLpAf/RZCT8dB2qE8LAJ3nRq06S3tZOg+3onQBt/Yn4O2x363iYznwBsAFFGQ/
b+RYPyG9oB+OvwBOmFySSVZAXRFI1KVllr0y2uX0zQUH9iG+lTgz0GK8+xp/dpWj
tVF+Zie24obwcUGFVV17al9Jn7AB0RyqakuBd+usywy+Yvis4olKX+nWTw8D/OMJ
vhDU9ElbrKyt63WvQupz/ly6g0bKN0DyMtyKw/arcbcVlJQNta7UNGzg2xeDNbNb
o2366pqdbawST0etUhcJFW4VdvxrZEsnByLDJLwFze8+VC04WzVRDmioDM6ysEt5
1qtMuG3uITiEIXhPhGfA8/v9plEfkg==
=SKJD
-----END PGP SIGNATURE-----

--N819f5Q53Ybwh5GI--
