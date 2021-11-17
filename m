Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA711454A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhKQPxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238825AbhKQPxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:53:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58C2D615A4;
        Wed, 17 Nov 2021 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637164214;
        bh=7JQV2QbJkFAySIiIV6mIjuXxL5lFmjIpyhdopObBbG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0d5UPFOcCJSyQxEKrILXGpAAjvnxT97Ui49Klvn0J3rS18mBIy8sEr6oxG9FT/qL
         9tK83cgAI0ljhW5P06f+t4Wx8dFkZU6YtXnsKO/ZlvzUI03oES+07g0ztObQYdSXmY
         ogqZDm57Thel+b+Y8VaSmJSC/uf9n530Wpnn5nTX3r+t3vkJMgUbhY3EbsDu96Fzzx
         kDrRa/sUPFA7DfZZnmQvE3m9zZ3LgJKb6HIhHK9fdrOPzOE6qwm8aT+2JXWDqRrw/N
         MPeXy9Bp6lMXapmyPjezhF7QqibJrCg5c6spAH2Fkx6N2IS4TBBo9SYQt26c32atAS
         eUrqA989BmhZQ==
Date:   Wed, 17 Nov 2021 15:50:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, aou@eecs.berkeley.edu,
        borntraeger@de.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mhiramat@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 5/9] arm64: Make __get_wchan() use arch_stack_walk()
Message-ID: <YZUkrrBwFJBiRhs9@sirena.org.uk>
References: <20211117140737.44420-1-mark.rutland@arm.com>
 <20211117140737.44420-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QAFPEQR1AG7+BdUm"
Content-Disposition: inline
In-Reply-To: <20211117140737.44420-6-mark.rutland@arm.com>
X-Cookie: One Bell System - it sometimes works.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QAFPEQR1AG7+BdUm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 17, 2021 at 02:07:33PM +0000, Mark Rutland wrote:

> +static bool get_wchan_cb(void *arg, unsigned long pc)
> +{
> +	struct wchan_info *wchan_info = arg;
> +
> +	if (!in_sched_functions(pc)) {
> +		wchan_info->pc = pc;
> +		return false;
> +	}
> +	return wchan_info->count++ < 16;
> +}

I don't love the magic number but it was there before so not a problem
for this patch so

Reviewed-by: Mark Brown <broonie@kernel.org>

--QAFPEQR1AG7+BdUm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVJK4ACgkQJNaLcl1U
h9CAZQf+Mi5fy6asOazEo3Y0Bf9yVkbCbLsfX3JUTwBk3ehY5jkU49rWkz+tm+vZ
vxjmnNkaOK3Xx24t5hXt9ZHVhV5equkAQ6MXs4colLCGScIVr/n74NbZmP/TkMc2
KvpSjdo4NJP8ooWcGRM1TNoz57u829bi8Pb/7H+pcCvxfXWfs955jTExabGZmTWN
YvFNX+o33FL/IZjB6BfzHQEWIGw5JCdOqcNkRtLMnnh6nam+uNhhZ9+Yob84tQ8F
wIzJM4/z9OkWyeLbUwAjOMzRpa/hu4e6SRNZw4WKzVlwlp7L8TZfbt0SNqHOQPy9
jv0ZUkIcNCSqDy9SYST4Kb8qXwlDNw==
=VCBb
-----END PGP SIGNATURE-----

--QAFPEQR1AG7+BdUm--
