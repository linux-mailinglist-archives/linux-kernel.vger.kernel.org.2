Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6283E1A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbhHERXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhHERXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:23:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E498461040;
        Thu,  5 Aug 2021 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628184196;
        bh=449gq+Na7KsB0w5p/YYNbxeSQ7SEH1snnxDkgA337kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG0EHHaJgCTZY/XJnC5ybhEMOPyoljGy/kU1kKCb07WQTvZ/+BtK2G4mNhlM9iah/
         vfOUjGT7wYOYLLC4K/vX5bA+2IaYI4PrrjCrT/sHnxwGPtVUapdcKAlxaT3nTXv9TW
         Cjo4pbl/XDfq8xoIqKs1XXL8X/8uqlrr5hrEGAfjkGJZ93bXLxV/Js5Ndn8qKwYNm/
         YXVa5eKaBJwCdyQraOUGaksp4NnG7jpYHylraPtVJ/VEYOvoF8YPDQ+W4KugxZLg5t
         PgPhjqmKVWmn0WGJswu7eJC1P7dRFk3zOmrgePIc0tdzWY8jNSGtgzfq3mMhh+X+Oc
         Qwb7apa9/KqfQ==
Date:   Thu, 5 Aug 2021 18:23:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: RFC power domain vs generic supply regulator
Message-ID: <20210805172300.GR26252@sirena.org.uk>
References: <CAOf5uwnZvJWhwf=h8nx=MmZz4BOyaq_BTr8vyDcGHqnBO7jK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qwbT0JTInWqknst"
Content-Disposition: inline
In-Reply-To: <CAOf5uwnZvJWhwf=h8nx=MmZz4BOyaq_BTr8vyDcGHqnBO7jK1Q@mail.gmail.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qwbT0JTInWqknst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 08, 2021 at 08:01:20AM +0200, Michael Nazzareno Trimarchi wrote:

> I'm trying to understand how to deal with devices that do not provide
> a supply handle connection using the device tree, or if there is a
> generic way
> to connect to a regulator. The pinctrl has a generic binding inside
> dd.c that allow to mux pinout during probing or it allows to define a
> power domain,
> According to the code I read the power domain can be only connected to
> the SoC power domain but in general a generic power domain can be
> connected
> to any source aka a regulator. For example and spi-nor can be powered
> but a gpio regulator or any kind of supply connection and bunch of
> devices
> can just need a supply if they are probed or binded runtime. Can
> someone give me feedback on this topic?

I'm having a really hard time parsing the issue you're trying to solve
here.  Power domains and regulators are different things, power domains
represent blocks with a SoC which have some kind of power control which
may involve a combination of things, the drivers for the devices within
those domains generally just do runtime PM and then let the driver core
figure out what's going on with them.  Regulators are for things with
physical supplies that can be seen in the schematic for the board, in
general anything that uses a regulator should explicitly say so in its
binding - supporting some sort of generic mapping isn't great since it
means that we don't have any control over which regulator is which and
that makes it hard to add control of the regulators later.  Power
domanis may possibly have regulators among the resources they use but
that would just be a normal device binding for the power domain.  All of
this is orthogonal to when drivers for devices get loaded, that can
happen at any point while the system is running and doesn't really
affect how the relationships are described.

--2qwbT0JTInWqknst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEMHnMACgkQJNaLcl1U
h9DD1gf+PHowNvrKDS3RQBg1lraOVRV4tu1K7RxIn8jTcrVhwuFUqzg2wdZVdmaq
dyCaNB6Fcj0zOFIqqXahLfjLy1c0NEC3qqInbsm6lPbWWVG4whhoE9gnuzl1lRNF
8wwU5phofNxICoqJzWny79za5gNgSGwLSy82HJ79Yc9k4zjcgx0rZGToTF1fE6xF
bGb47tH9u8SQryDy0yaIP0AeUf4UOZSJBBXHK66TrTDxUCzSLJL+ybG/n+Sk5jx9
u6aGzMr/+peG7folgu+A7eeOEAEJda+sv+9rTIeAGreclRpM7fyWTNDsWWSP8dYT
wVS2LWTlGxyWZBcJbZj2GH4iqkAmmg==
=ZZ0x
-----END PGP SIGNATURE-----

--2qwbT0JTInWqknst--
