Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288304534C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhKPPCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:02:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhKPPCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:02:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A60AA61C4F;
        Tue, 16 Nov 2021 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637074776;
        bh=kLgNCOXcOMdbR7IPP44gOExLnRjFLRrAYmTTznSGFas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEt18bk582cM292euP4s0OwFA1lx3lzTTclKy3RNrQ4QN2xysp9MJJSw7MGDMM9bH
         RNX30oV5vCIzcGXZ3oIULBZkWjAC5b0BJPnXeTziRvUR0cL8PUJvgF0msn25RAylB9
         hg7oPwHtqPsEYP5GG9CzRatQF6/l0DWdeT0Z8iruXDO72CV1FcF9jHuK8zB7nI32Rm
         0u3tSnLIV6IQ0D2rKkx3Bo8j6mqp7HQxvqzTPG03hT83tt0r9pv5Zk1/ofT6/1hQLi
         eNXBow7yOCqovGhoca+j4usdpXbcdyElvdv6wvrx74u4+i2pixjcOD3GvttY5KKGkU
         6EzdhT/s4h7Yw==
Date:   Tue, 16 Nov 2021 14:59:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     YC Hung <yc.hung@mediatek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        daniel.baluta@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code
 from machine driver
Message-ID: <YZPHUmDdGF/59XqA@sirena.org.uk>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
 <20211103100040.11933-4-trevor.wu@mediatek.com>
 <YYP+l7tMofYoB+aC@sirena.org.uk>
 <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
 <YYVQC7KLZx8oxdXT@sirena.org.uk>
 <e404d241-0685-643b-4b9d-d85bb8783385@linux.intel.com>
 <YYVez/V9ocCXhYmg@sirena.org.uk>
 <4e876c89ee58cd1408511a34573005e3df359cd0.camel@mediatek.com>
 <f915d1090abf2b6d188ce27068919a181828e463.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YuLN/D4BxE4Sko6x"
Content-Disposition: inline
In-Reply-To: <f915d1090abf2b6d188ce27068919a181828e463.camel@mediatek.com>
X-Cookie: UNIX enhancements aren't.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YuLN/D4BxE4Sko6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 16, 2021 at 05:33:48PM +0800, Trevor Wu wrote:

> Is the reply from YC clear? Any suggestion would be appreciated. If you
> need more information, please let us know.=20

Not really.  It's super high level and only at the driver level, not
talking about the hardware much.  As far as I can see it's showing a
single physical system and even seems to have what looks like it's
supposed to be two cards connected together which really seems like
it's a single device.

> Additionally, it was my understanding you suggested that DSP routes
> should be configurable in some ways, and we should not just add a new
> driver for SOF in case we need to support some other interface
> combinations in the future. If I'm wrong, please kindly correct me.

Yes, I'd not expect a separate driver depending on system configuration.

--YuLN/D4BxE4Sko6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGTx1EACgkQJNaLcl1U
h9DQcQf/UeSfcn6HVEpGYxZ8QFiUTj+pbv+kGdokbgKrS0ecwwnxMi4Py7KS5Z+G
t3FU9D3QiuU1BnHL92LIKT0wdYM7r7yededEPF0t8bnU4+CiO6nJbCRNp9E3jfPA
wlXwe7J+sTEWqmJ+HUNIX/MVHTBdAPwSIyYHWQmB3CgC2WDX8oLsLwobCOCZyh9n
7hdw4rjGE5m4P95j+SHERYBB1osAixaTLMrQ4aa59f5epfn0M5iQ0ABQltYIR48u
DOyGK2ZiJUs524JKVVbHtjz/JY3/SJqlY2DQKIt3vePa/fNNowo5Fjv4oReFJoQS
uek9HwybelDl1KbN9VhWNQDm2SyfsQ==
=42uA
-----END PGP SIGNATURE-----

--YuLN/D4BxE4Sko6x--
