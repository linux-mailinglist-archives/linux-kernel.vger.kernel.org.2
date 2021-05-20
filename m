Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C577738AD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhETMAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243377AbhETL7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:59:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4576B60FEE;
        Thu, 20 May 2021 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621511889;
        bh=+GNsNoufyy2FzTWH7h3Rc6RMzbggJYsR8UQ83JtMa6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6yKSuJNTtAmEaU2Wd2caCMWjF3I62/40trkwpfUSXIM6x8Y0Xi4YAORb7bP9W74h
         06KmkP+tLWTpWPA0Qc/INBWR012uARDXQFWP0+NDgWrJLs1ekgfwLU6s6o59IosDni
         39mxofkYej780MR6eqyaSHP2ksA7HfIkZw6dwdEVtXnQQyCpT5AEnxbKO7S+POAQnZ
         MNwjBQnzoDX1c10wwrNGcFwYonBJV1ypWyx+lg9NH9ulw4HkuKfm7I2lxjyZ2F9qqP
         XE5gLoxUbkR6VQpiPuJKVl6COhxFIZnwmVzwTXRGBqUu89UrjEImrxXexuZzUaB2Bo
         w79Cn2SYXOxyg==
Date:   Thu, 20 May 2021 12:57:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: core: always use enable_delay when
 enabling regulators
Message-ID: <20210520115724.GA3962@sirena.org.uk>
References: <20210519221224.2868496-1-dmitry.baryshkov@linaro.org>
 <20210519221224.2868496-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20210519221224.2868496-2-dmitry.baryshkov@linaro.org>
X-Cookie: Offer void where prohibited by law.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 20, 2021 at 01:12:24AM +0300, Dmitry Baryshkov wrote:
> Some regulators (e.g. fixed) do not have .enable callback per se, but
> use supply regulator and enable_delay. Do not return early from
> _regulator_do_enable in such cases, so that enable_delay is properly
> handled.

This doesn't seem like the right fix - if we didn't actually do anything
then we don't need to add a delay.  We should only be doing this if some
parent regulator changed state.

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCmTqMACgkQJNaLcl1U
h9DgwQf/V9iVLaIVjKp4EAPjN5dI5Mf+b7GoRVODYQqNDof8VUsifjS1jQUjd4ZI
AVX1vqEHELH/Xx8KkCwXuAeS1Dwt4zJneRzHC9wjVVJUDqFigy/LSVN/z8IAgibP
7OKWM/63S86MP+Xn1pvtUVkkZrGb0yi+wfF8JxGPhrpuqx354TselTylP9BzawM+
A5COobreilyOjeeNm7D6B7deb3N8uUH0pnCFDoYZMhgxpdY19FEiRTeGftEpWB4B
cTsrYeeWbKf/MOWiQs0h7FQ1GGXOmX5LbMe5G54MgODUaXwUkyBW0+/L+FK2ZQKC
ey6I3K2KN5FeGqCuHgBbhi3mwXtudQ==
=x+AI
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
