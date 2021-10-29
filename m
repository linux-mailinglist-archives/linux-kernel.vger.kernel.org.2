Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01A4400CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJ2RAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhJ2RAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:00:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00B5060E8B;
        Fri, 29 Oct 2021 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635526669;
        bh=Su9vVSviobYVjYObOCBEe73TcGXWuppnwITxt73nSf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiJMNRwTxy7TtwQvyW++op3MucoWFCDDO3IMRhqz/oqUlVRo7P7fGyId2IOHS6keC
         oeOR0pAalcKXLWbTReztyvIDld5jL4S8erPghdklD5p358ZtyjvbT5arJp7+k3f7G6
         x8nGhyNHUE/8ZOS6uTQyu1An1BDpdP4ihsAJsF/tC1UuocgdmgKKYNoJdfCzifqb4j
         u6Nmg8MTUQsoPBiGZFYRB9U/ONvqL8jNun2THPa2fUJpZqUfi9o/+6I3s04/yLWrtH
         CiGHV30HjvLkDxW+KuFvYBul76atwxcdJsrPISRFShGTBWeGkg+Wn7xV3J36A3GJRI
         E7JGhkWwq67yQ==
Date:   Fri, 29 Oct 2021 17:57:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, daniel.baluta@nxp.com,
        trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 1/2] ASoC: SOF: mediatek: Add mt8195 dsp clock support
Message-ID: <YXwoB7FtRw0AzgcD@sirena.org.uk>
References: <20211028135737.8625-1-yc.hung@mediatek.com>
 <20211028135737.8625-2-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L+FynStKYfLi0cU9"
Content-Disposition: inline
In-Reply-To: <20211028135737.8625-2-yc.hung@mediatek.com>
X-Cookie: QED.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L+FynStKYfLi0cU9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 28, 2021 at 09:57:36PM +0800, YC Hung wrote:
> Add adsp clock on/off support on mt8195 platform.
>=20
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
=2Ecom>
> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> ---
>  sound/soc/sof/mediatek/adsp_helper.h       |   2 +-

This doesn't apply against current code, there's no such file upstream.
Please check and resend.

--L+FynStKYfLi0cU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF8KAYACgkQJNaLcl1U
h9AoVAf+Lla83sRtVKTqKOk679LT17XuZlBpgOt3NtPFIbvAv9dQFo6vZbhSPUfv
FNFch9494hJbje4GQNsx+/P8YBAu8B8KT1L9mvI2xfE+R1ififzxOa8KFibsE4ee
kOaEBLq5sK5K4ujyPS9F6/fq5bih/0+C5YgBJtWYhW4/HwPL2eSp+U/cbLX7hUCV
Y6WZRE3jA3UDHCl/nTSz9EZAg2BExYI3zDrEINWf26Fs+8rwx/q6y88UQofl0WBK
kdelvP0X9dFsxgV8T3wug4bRTgfGezFAen3rkQG6I1tliMMb4XO2tvCUQlSyV3zS
h0KJSKLReUXZNM9ANMySrqQWAFF9wA==
=slFG
-----END PGP SIGNATURE-----

--L+FynStKYfLi0cU9--
