Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED6A3B8FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhGAJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:33:56 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:33732 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhGAJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:33:55 -0400
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id DAC7DBEBD19;
        Thu,  1 Jul 2021 11:31:19 +0200 (CEST)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id SDSbjhjav00Y; Thu,  1 Jul 2021 11:31:18 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5c8:7b00:36f3:9aff:fec2:7e46])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Thu,  1 Jul 2021 11:31:18 +0200 (CEST)
To:     Dennis Gilmore <dgilmore@redhat.com>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210701004043.18585-1-dgilmore@redhat.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: helios64: fixup USB setup
Message-ID: <01f1b032-14a8-a6fa-9063-23de65fc6f43@kleine-koenig.org>
Date:   Thu, 1 Jul 2021 11:31:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210701004043.18585-1-dgilmore@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BpJ5xrTQirBbIjXcMUHPDnZ3mp4HzW92f"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BpJ5xrTQirBbIjXcMUHPDnZ3mp4HzW92f
Content-Type: multipart/mixed; boundary="1nWwQQLfYRngiveeI35Jked9SbcM6Pqbw";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Dennis Gilmore <dgilmore@redhat.com>, linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <01f1b032-14a8-a6fa-9063-23de65fc6f43@kleine-koenig.org>
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: helios64: fixup USB setup
References: <20210701004043.18585-1-dgilmore@redhat.com>
In-Reply-To: <20210701004043.18585-1-dgilmore@redhat.com>

--1nWwQQLfYRngiveeI35Jked9SbcM6Pqbw
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

On 7/1/21 2:40 AM, Dennis Gilmore wrote:
> Without the usbdrd_dwc3_1 node defined u-boot will throw an error and
> reset the system.

I wonder if this should better be fixed in u-boot then?!

> All other rk3399 systems use this format

This is true for the dwc nodes, however for the usb2 nodes there are=20
several that use this idiom (and even repeat the label name), see for=20
example the &u2phy0 node in=20
arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi .

In my eyes it's a bit ugly to have the two nodes as separate entities=20
and on the same indentation level in the machine dts given that one is=20
the parent of the other and enabling USB needs both status settings.

Best regards
Uwe


--1nWwQQLfYRngiveeI35Jked9SbcM6Pqbw--

--BpJ5xrTQirBbIjXcMUHPDnZ3mp4HzW92f
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdi10ACgkQwfwUeK3K
7Al/Pwf/fwKvnfatRdAv7KIh3rNNLcGJMdEn2xWYZ6hi1BSCujztTMA1Dwa6yMsy
HxFEpDWx/dUEi6ZsLKZpKH4RRfB8TFpZX2bT2LhqRs8FsuIdbfr/gipul8dRv6k/
8HqazpBR+flWTvGs1eaLRGGXOxAhvaZ/jXpihWJDGIX9inaLmUcHjr97yvXUMy7v
7YU8MSICXSZri0gEp6M8ZiljvXN/Q9RZe1Z034zOwd4NNBpR/nmBd4xLgvotnlJj
clNn+BwiSEBhfFjuRxaH0jo6hn3mDRmSDgxanuz7uKfFUPBpQ7ST50mMclzTZGyY
fT3Q+7Frw5I70d/FOvrQRFy6nwY0aQ==
=zJ9u
-----END PGP SIGNATURE-----

--BpJ5xrTQirBbIjXcMUHPDnZ3mp4HzW92f--
