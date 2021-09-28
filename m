Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1541ADDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbhI1Ldi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240425AbhI1LdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:33:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 129296054F;
        Tue, 28 Sep 2021 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632828706;
        bh=1KQFI2M5uykNU1IsQH9vq6SitjQwbZIOudUgWmw3N0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apU8FFwBBHCE9hufbHg4XBkUvnrdRLDP77cwA+lQHTL6oKbbXC1+D8SChAV1TliR4
         7lU1ERUYcmj890j+RjJsXCcbYmS7SeiJ5wn1zLKAJdM3LEqLcKH4w78tsNtUW+mlYw
         lmklvOzRQZnHstvunsgSdlnG4pXlu0EwnbPxgrVXv0+8UfxzpXkgJNELm3LQ+lIDfT
         VajDEnkRBQiu3oEKpB1aRvtGvuudAr/7Rrt7Oaru17MxIT15f+hGm16ii8X7P2cm/G
         AhAw6tjQ9ZXvYxnEep6xkfp7sLl4uF0CH7aA/mb/V3IYiNDbHCFiLcOoU357Cw9hW6
         R5TDlpUn0FDMA==
Date:   Tue, 28 Sep 2021 12:30:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] regulator: Add Unisoc's SC2730 regulator driver
Message-ID: <20210928113057.GJ4199@sirena.org.uk>
References: <20210928073609.198975-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Content-Disposition: inline
In-Reply-To: <20210928073609.198975-1-zhang.lyra@gmail.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 28, 2021 at 03:36:08PM +0800, Chunyan Zhang wrote:

> +++ b/drivers/regulator/sc2730-regulator.c
> @@ -0,0 +1,502 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018-2021 Unisoc Inc.
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +static int debugfs_enable_get(void *data, u64 *val)
> +{
> +	struct regulator_dev *rdev = data;
> +

> +static int debugfs_enable_set(void *data, u64 val)
> +{
> +	struct regulator_dev *rdev = data;
> +

> +static int debugfs_voltage_get(void *data, u64 *val)
> +{

> +static int debugfs_voltage_set(void *data, u64 val)
> +{

If these were to be implemented they should be in the core as there's
nothing device specific about them (the read side is there), please
remove them from the driver.

> +static const struct of_device_id sc2730_regulator_match[] = {
> +	{ .compatible = "sprd,sc2730-regulator" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sc2730_regulator_match);

Since this is a part of a MFD I'd not expect it to have a compatible
string?

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFS/PAACgkQJNaLcl1U
h9AWpwf7B8JVyUAhlLUaJqdBrpEnFv79LScK1o7PYr11vt5lemlbHg+au3eCHCyF
4yPmlVbXRjwWhScMTN87gEcjEVCZjocw5aR7GKKhRWG9GozrbXYZCc4x9TS5tDkD
3e74xS9jjHKAV8Tk9nlbtgbXtIqIecVXwhCbGpBzxy/8V04/vTy4/0AIilO3Z92S
fZJ5Oc+FqA7TN6RnrgdOvva1leLeqCMCOheW53cWtoG/GoWk+m9RY0I8tezTo+H7
4BNMxgFhDOwIUYy7RRnKVyhmsoO+F6WSr9mHtgYo2ui1UWeLjKC92jo4Lglhuu/Z
qBnFDD+t0kMEfbs4m2cZZ/iKZoVHPA==
=jmQh
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
