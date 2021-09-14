Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C156540B593
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhINRHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhINRHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:07:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 871E9610E6;
        Tue, 14 Sep 2021 17:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631639156;
        bh=cK9jtjS6sGndb/tYO2Wm17SC/1VsCkyUP+bEtwppFPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCHy3K7hqUJRnHjHLDdAeKJDSDxQPS5Ivqc9cIXglOKIydm1jTbhb0TbwksK+XgEu
         TTBulmwC2NWmQ5rOVIT9weq8dtMXKYysBPb/usCVRFFY7V4Ic8+EUqje/hYrDtYBzA
         9xwqx8Miv+S3C5CYqlIOQ3Epjenhbfx7mSbQ61V4hNiRarwpvowTZ3zTQZKTM46tK4
         vnPSHVQkeR7lDWM4qgb5ZkRWKNGtpTnH/dij1prUq2ksh89duZ+wNIGepnnL/ZFvSw
         4u0GFE6r9TVHa3rpDZcsy0s+vkvnU6goOuJE/Z56BiWyaIgCC5OEZkq2QHcUYYQY+l
         rf9smhGKaEm8A==
Date:   Tue, 14 Sep 2021 18:05:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: cs42l42: Minor fix all errors reported by
 checkpatch.pl script
Message-ID: <20210914170516.GG4434@sirena.org.uk>
References: <20210914165220.752498-1-vitalyr@opensource.cirrus.com>
 <20210914165220.752498-2-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline
In-Reply-To: <20210914165220.752498-2-vitalyr@opensource.cirrus.com>
X-Cookie: This space intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 14, 2021 at 05:52:19PM +0100, Vitaly Rodionov wrote:
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---
>  sound/soc/codecs/cs42l42.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

This sort of minor cleanup should go after any fixes so that there's no
dependency created needlessly.

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFA1ksACgkQJNaLcl1U
h9CgbQf+OuIKym2dMtISggsJRRA2ZOkGY410Vm+jkhqXhNSBIRtiJY2B4hSlx3Yf
qJfA0NLH0p6T9Z5TDptaqRDit7nENLTUxl/sqrioYt9YQAsYUhVTL3y9qG2U8Xxx
sNcqEdK2AbsxmEYE94QMpjsewYD9BwRZJRF2wa4siL4kmIRWLlg72S7eoubDg/ET
gOqKzEVH95AjCFCSB7IMIERJE2LeE0QAyyZi7W4LqCAIe8XokfFIGOrXB05AwIqN
4/CMqir3xjM7MSx6i732GAxGxKcV1qQRT3RfLMADDOxb75Ua/9KVXElZm35s9N9z
zudNb7dDBRQVNiFZ3QTL5ASF6vz2Gw==
=UiJW
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
