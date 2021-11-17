Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667E54549F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhKQPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:39:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233227AbhKQPjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:39:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2842761360;
        Wed, 17 Nov 2021 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637163386;
        bh=YvjXcsSuhsAf6y4O7zY+m8TVErrrok6R9QiWzFbSH4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyJ0Qb57fcJ6SKjqleNdyn3YWnNRDHocNdYO8qWFEKGmF5e9+RbasS7uD4CO8Dmm5
         j5SWRPhcOIvz0uum1C0hsdQXFyDehSerqbFuvAwxpv0WjJ8vrpZrxa9bj46pMHsJzD
         1CZMBv/R1CR7pWJZvJZISUims27ghGRTTP5K2PHTNyZp3WkpAh9YyGcuHfgGWgV8O6
         tAHWz6redusWtEV4yoZJl7T8EYLA96Ua/SjBGJl7Yjk7rbEWSvc8vE4KtSXTFMHPMj
         cBHNEl6f4LkC5rP+s9XiNv3yN+CThfu7PgPJSLncoWWdSDTTCTALrpbelWdR+fU6Co
         yEPx8FDQjtsfw==
Date:   Wed, 17 Nov 2021 15:36:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, aou@eecs.berkeley.edu,
        borntraeger@de.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mhiramat@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 8/9] arm64: Make dump_backtrace() use arch_stack_walk()
Message-ID: <YZUhdHl9vC+fxuOi@sirena.org.uk>
References: <20211117140737.44420-1-mark.rutland@arm.com>
 <20211117140737.44420-9-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7QeFBRH6dWZOq1W3"
Content-Disposition: inline
In-Reply-To: <20211117140737.44420-9-mark.rutland@arm.com>
X-Cookie: One Bell System - it sometimes works.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7QeFBRH6dWZOq1W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 02:07:36PM +0000, Mark Rutland wrote:
> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>=20
> To enable RELIABLE_STACKTRACE and LIVEPATCH on arm64, we need to
> substantially rework arm64's unwinding code. As part of this, we want to
> minimize the set of unwind interfaces we expose, and avoid open-coding
> of unwind logic.

Reviewed-by: Mark Brown <broonie@kernel.org>

--7QeFBRH6dWZOq1W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVIXMACgkQJNaLcl1U
h9BXuwf/eHflyQt1F7NjcLV+HWiiFg445T/uHzE7nV0gVOdJRQr6He8Gdjkhq0VH
JNIszq2DA9eN1eHrM9g6z9Y0Ww5lk7BHIunj3Dtncs4V8yA83DlF31yXrxewO5u6
iYCzl+pYKF46ihlGoXOGK+qYXFMrJnCDEx07TcysJSY6B0KVMbjMGotumriBMsLD
7SsVHGe8sktlfRi43GuSWc3QzaDGrA6lBHbB+TMHaQcfSX4CZtfQUW85YjJUJk10
FdFgoIl6BB51k9oci7yjv7Aflu1mU8E2nIHvPyESAIH1bDzw4iyEofwxSyOWJMLA
ewyRL2i5IgDskwa11qxB+jKb/TS7ow==
=kk4+
-----END PGP SIGNATURE-----

--7QeFBRH6dWZOq1W3--
