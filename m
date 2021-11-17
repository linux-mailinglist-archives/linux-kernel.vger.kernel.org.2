Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14278454A20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhKQPmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:42:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235478AbhKQPmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:42:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 333E1613D3;
        Wed, 17 Nov 2021 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637163550;
        bh=122fOvw9CUtf9DMpUlmBgs1ys/g+EKIv9w4Gu3hFMU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGX/Yg3tsK0vHq3Fgji6Ji40gQ4hwmTyzhnnA7XKyGnSZQFxUQZbMYti64elxM80d
         8D3BnNOhLYTTJ0m2yj5GL36xi4G9LjdUe5c3P5Wgl/WAr4QP3203d/nGtxVtVNyO5W
         xe/mIPPLPy30PSzAzz9vnUbhcf7F4zAc2zNFJosxdUnpeCyQPuEfqhf7pbz+4JOiGC
         53DU1X32OYNQGVS+2ZfttLDlJZQPhHTKFpVgKtsVaxsQHOZSz9yuAiHq7ycWqlBmq2
         DbIBhcMoQHkh2EdQLaxQmbKLf+wVDrtHnDelfeeib4+/F5WE26u7ZWlMxb6ndG6DSN
         Kuq3Llh4x8zQw==
Date:   Wed, 17 Nov 2021 15:39:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, aou@eecs.berkeley.edu,
        borntraeger@de.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mhiramat@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 9/9] arm64: Make some stacktrace functions private
Message-ID: <YZUiFr80mokTT7EO@sirena.org.uk>
References: <20211117140737.44420-1-mark.rutland@arm.com>
 <20211117140737.44420-10-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MfZatu15GQtRTZZk"
Content-Disposition: inline
In-Reply-To: <20211117140737.44420-10-mark.rutland@arm.com>
X-Cookie: One Bell System - it sometimes works.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MfZatu15GQtRTZZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 17, 2021 at 02:07:37PM +0000, Mark Rutland wrote:
> Now that open-coded stack unwinds have been converted to
> arch_stack_walk(), we no longer need to expose any of unwind_frame(),
> walk_stackframe(), or start_backtrace() outside of stacktrace.c.

Reviewed-by: Mark Brown <broonie@kernel.org>

--MfZatu15GQtRTZZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVIhYACgkQJNaLcl1U
h9BLeQf/eYc0WN/W68AGQuDmNzR0UTlZ3g3Az0DjwdvKpb7fxJU9DRpVRpzj2h1c
bryn5CLy5opItd4mr5ULEIqncgh2zl+KtdiIgN6X1Wnfo7bHqcWQCaVq6x5yxBQL
d/GjwDkOkGx6O0Chmb80jEllVAAWa9RghOpX95Y3TYA3qEtS0CmiCEH2k7x0LwkN
yxcyUeczfcy0YShebYFtr1KkoM7vYRcyUnfc1Ahhmiy0YQDvnH/QPTYlBMLA5+VI
wUstOaAKuZ0DrjpHDS5/xUaQEMuI/qmAiXnhdryTKkBwtnd1aaPNDsT23pBbvg9J
OxkR76uy/ZVun21gllLs0Z7cL4VE6A==
=mHa5
-----END PGP SIGNATURE-----

--MfZatu15GQtRTZZk--
