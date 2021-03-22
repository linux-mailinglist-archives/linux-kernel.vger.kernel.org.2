Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3796344092
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCVMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhCVMNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:13:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61EBA6198B;
        Mon, 22 Mar 2021 12:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415216;
        bh=2xy/ZpPjOW0oIt6mLviODf/g/JztzLUVzbDrPox2lfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQSbCTQjeyS2UqljQkDqZmB9hNuuzGNxqFzi8tBD2j6ueNIDzsiCBtoliDyOuroNX
         aaSA2/yroenyErha3H67sIq7O7AJys3qFTeKaUiHcTauU5CZnaBlMwWPz4pZYW221x
         nU8nCIGfiXCckik4WcBuszHK5Qe18fibAQ/Fxcd0ZymHuCn8LyuV7kH+0+27U+bvgH
         cVm8jHgfFEEQbHFh1PVaKRJo7PKBfAtZKir9yBxtBtfRcVIVixrF5FoO2zLZ6hLdI9
         ekTb8DMBqmjxiafWkjIxXQM3TXEuK8Fxn7+pqs0ptkbKS3gpm+Uk5J9AGhIaTYbbIB
         8qHqNpr3lwBIQ==
Date:   Mon, 22 Mar 2021 12:13:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Jun <chenjun102@huawei.com>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: stacktrace: don't trace arch_stack_walk()
Message-ID: <20210322121330.GA4681@sirena.org.uk>
References: <20210319184106.5688-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20210319184106.5688-1-mark.rutland@arm.com>
X-Cookie: A friend in need is a pest indeed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 19, 2021 at 06:41:06PM +0000, Mark Rutland wrote:
> We recently converted arm64 to use arch_stack_walk() in commit:
>=20
>   5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
>=20
> The core stacktrace code expects that (when tracing the current task)
> arch_stack_walk() starts a trace at its caller, and does not include
> itself in the trace. However, arm64's arch_stack_walk() includes itself,

Reviewed-by: Mark Brown <broonie@kernel.org>

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBYiecACgkQJNaLcl1U
h9DEbQf/RW80IksT99bCxlvuUNGMepB0HODebTps3dINdEdl0awUTI6YBtkkgbgf
xvpA4kcJhNSyMELjqZ/fW4tleGNcrLP8O11OoUb3+eDqL6s/bvz1eKLoszb+jWDa
XMMMjPCq7+gVNwwaSpajrys50UszkyzmlKvq5eE/7rfWHBGdjzRQ8XJwSadHuWg5
0zJEvSQPDGEQZ+158WWs+LwhRDFuMkFs8wtVH0H0Es60AICB4rBPEkI6PLQnh6gg
55SK9zeFuOwxTM1MTd7bgDeI3VugSBf/s0NoBqaC1TdsqYjiUk6bbKtBzpvWMPlZ
pvnhkiUq/XGWnYLwbzV/fye8mr1zcw==
=gunV
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
