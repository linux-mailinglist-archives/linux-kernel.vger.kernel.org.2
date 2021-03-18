Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785E33406E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCRNb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhCRNbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21CB264F04;
        Thu, 18 Mar 2021 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616074268;
        bh=z6sAQQqqwq+ku08MYCtNPa0qu8qdyolLoJHSKZAiyFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOooP3WlYZhHVmkIfSWQzBPToHUYNbODzRLzjmQQnPqEXq4AUHzbNj1OWgQ2zErmT
         wjvDGysvPt0TbZ+KVZx38qAJVQxrdKhHTx/nUPYCa1/hPpr/ArqGIM73K1jGXCpyrm
         8WqZ9Y0+9eG+dXl3r1H0eC+N5ee6NRAN/GdvBw076HjHhMnW0NKT3cy8rhZYaABip/
         G2XsVrwj6/uby/9rwoFejERUWl1MrDld8/ZV4EPUgHgSDLyjhDISkzOZV+JtKlHlmS
         Tgz/7OrB7B3Z+CIKyN7k40fey1ikyHT9zfVEHWZ04gosyQsrIRjyZ2gAsaSY2abRTv
         Cus/d36uf0u4A==
Date:   Thu, 18 Mar 2021 13:31:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH 4/7] regulator: mediatek: Add regulators_node to
 description
Message-ID: <20210318133105.GI5469@sirena.org.uk>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
 <20210312145545.26050-4-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U3s59FfKcByyGl+j"
Content-Disposition: inline
In-Reply-To: <20210312145545.26050-4-matthias.bgg@kernel.org>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U3s59FfKcByyGl+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 12, 2021 at 03:55:42PM +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
>=20
> Define the regulator node under which the regulators are described.

Acked-by: Mark Brown <broonie@kernel.org>

--U3s59FfKcByyGl+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTVhgACgkQJNaLcl1U
h9B0rwgAhWIFbjnu1R958nrCRqX4nGCc4cq5VC68qC4FckALc9suDvP9cDSehbpy
UFRsmu9IUBa4CZJA5bnvRgpxlfWWk5dURVm+Mk2L6JTtEtgJnnUPb2ZVJdmqvsGc
P4CgJjG7i8fpadCWfg3gICTCJTrkmL6c4v4u5OykKVZJ1Sk/qpoSwQ4t1A2kl+dR
fVuMeEChMUWur8BWYo+4m6Hu5/t4hpm0D+a1me4IKc1W86NWUGh1VHMOAsKiW+1T
jY1F0wHnEbBhhkS8cYmajecLEtddOk5nUgXRvXRZVcqZOWnjS/yOtws/o16fop78
PuyJaHJbD3++kKfDbLX0fYazdWR3bQ==
=R5ld
-----END PGP SIGNATURE-----

--U3s59FfKcByyGl+j--
