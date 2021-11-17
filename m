Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567E9454A39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbhKQPqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238767AbhKQPph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:45:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E387C613A9;
        Wed, 17 Nov 2021 15:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637163758;
        bh=5UIZxhEew+ku9anwyaoH9aTiF+jM6bCzSfKagIqb+mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBDJ4u2j+J1ojZYivBXCW/bIuJztzoZWruflq9Jo8iWApwOU56T9sy564kGdbYyj/
         2eKqXsy8zwfz6qhix+3U5ONHwicxzoWiF0NG9aP1YQhyMfBgv55Bh/Icy3o3Qs8/Z9
         wL3U5JLo++zNMUsFEt109qMBecOBP7WxyoZtPiDn0/d+A1Rhlx12aDKDibMNrcy2Wu
         zEP3UL/DUI0NndATaCGONn/Sx4cj4cugPi03d2pxqQb6lgsr2FemrhF+2ZJKWDMncx
         EsxVEzdpwsUw6uAMK2xNRZaV6Do3IKj6hqtp1gDnZuxi3Kvp8IZCQQPPD0GUYfQs7o
         zd+lWFNnZw4IA==
Date:   Wed, 17 Nov 2021 15:42:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, aou@eecs.berkeley.edu,
        borntraeger@de.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mhiramat@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 3/9] arm64: Mark __switch_to() as __sched
Message-ID: <YZUi52LQDtcUQojl@sirena.org.uk>
References: <20211117140737.44420-1-mark.rutland@arm.com>
 <20211117140737.44420-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YPUW0w/AkazUwy+r"
Content-Disposition: inline
In-Reply-To: <20211117140737.44420-4-mark.rutland@arm.com>
X-Cookie: One Bell System - it sometimes works.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YPUW0w/AkazUwy+r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 17, 2021 at 02:07:31PM +0000, Mark Rutland wrote:
> Unlike most architectures (and only in keeping with powerpc), arm64 has
> a non __sched() function on the path to our cpu_switch_to() assembly
> function.

Reviwed-by: Mark Brown <broonie@kernel.org>

--YPUW0w/AkazUwy+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVIucACgkQJNaLcl1U
h9CCdAf8C3y4zTjfBlLnE79zMnI6wvhSdPPkuALbPp/k/jzP09o+I6zib1sVDiIY
DhfuToKo8XZb9+/hMqEZN5gbrmFwRpEs8utHNiFQ28U2QxvSTvqjwVaCFtnVmmD4
BzyH1vSWgiaboA6NVowZd29qMm+bmNtUdcP51+qfMts26pblYhHCZvyUpm2nZdyQ
0iZD5s/RYp+X37AzXGlhJ5OtdhPvK9BiIne3v6mfYKwYr40w6hD5XtOWufrBicfk
E9vUxhINYXHs0xmEUAohGdKFwP7VKCAZoMRjHBoTTN9zC8nu6WePqqpT15COn1U9
iabqdPlFgOjTR+3KGSSijIOw3bemyw==
=FfeE
-----END PGP SIGNATURE-----

--YPUW0w/AkazUwy+r--
