Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA7134F16C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhC3TFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232972AbhC3TFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:05:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 310186187E;
        Tue, 30 Mar 2021 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617131129;
        bh=IJD/rkpVKnY66bDPbd/AUQ8CWnGj2XJHCYKsavCkWpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXD8w5dDeKwt5QCxPjksd+WxY+VbGgYZMToc/NSGxILUkZ2I17y+JolBv14I/bGaI
         4fxYQqXUii+MbUuxa66GLsApjZhCIe2Rn6utn9CW64zW+b6Nho7AQ3ga239rDi9fAi
         PWRK9vbQe/8YfGVYMYfFFlihnxasrTjsfF0SjU6uwOAkvyHioQuHLc74T+dVQPsYse
         TGIbS8WtTZyZCVvvvxOLbs24/49NqAD6CZ/YunAD7yQ/aUslBvhtGNCvHc2srSVGZO
         ByVsAJlNENPcbbBNlyMeLWRAu+FyTz8wwMiomnUVCYosx6pqpsZFEzsDf4RR0AledM
         CCMjArqxZjWzg==
Date:   Tue, 30 Mar 2021 20:05:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v4 3/5] regulator: sy7636a: Initial commit
Message-ID: <20210330190518.GL4976@sirena.org.uk>
References: <20210326015511.218-1-alistair@alistair23.me>
 <20210326015511.218-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PpocKf6TCvdC9BKE"
Content-Disposition: inline
In-Reply-To: <20210326015511.218-3-alistair@alistair23.me>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PpocKf6TCvdC9BKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 25, 2021 at 09:55:09PM -0400, Alistair Francis wrote:

> Initial support for the Silergy SY7636A-regulator Power Management chip.

In general this driver seems like it's trying to implement a bunch of
policy and extra features beyond standard regulator support - please
strip it back more, if you feel that there's things that really do need
to be added in the driver itself post them as separate patches.  It's
also open coding some features the core provides.  This should all make
the driver much smaller and simpler.

> +++ b/Documentation/ABI/testing/sysfs-driver-sy7636a-regulator
> @@ -0,0 +1,21 @@
> +What:		/sys/bus/regulator/drivers/sy7636a-regulator/state
> +Date:		April 2021
> +KernelVersion:	5.12

None of these sysfs files are appropriate for a driver, if they are
useful they should be added to the core (but some of them seem like
they duplicate files that already exist, this one being an example).
There's absolutely nothing device specific about any of them.

> +static int sy7636a_disable_regulator(struct regulator_dev *rdev)
> +{
> +	int ret = 0;
> +
> +	ret = regulator_disable_regmap(rdev);
> +	// Delay for ~35ms after disabling the regulator, to allow power ramp
> +	// down to go undisturbed
> +	usleep_range(30000, 35000);

If this is needed add it to the core, but really this sort of stuff is
going to be very board specific - it'll depend on what the load on the
regulator is - and it's pretty rare for anything to care, you don't have
the same issues you have on enable.

> +static int sy7636a_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	return regulator_is_enabled_regmap(rdev);
> +}

Just use the generic operation, this wrapper is not adding anything
except code size.

> +static int sy7636a_get_status(struct regulator_dev *rdev)
> +{
> +	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
> +	int pwr_good = 0;
> +	const unsigned int wait_time = 500;
> +	unsigned int wait_cnt;
> +	int ret = 0;
> +
> +	for (wait_cnt = 0; wait_cnt < wait_time; wait_cnt++) {
> +		pwr_good = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
> +		if (pwr_good < 0) {
> +			dev_err(&rdev->dev, "Failed to read pgood gpio: %d\n", pwr_good);
> +			ret = pwr_good;
> +			return ret;
> +		} else if (pwr_good)
> +			break;

This should just read the status, if the caller wants to retry for a
while then the caller can make that decision.

> +	ret = regulator_enable_regmap(rdev);
> +	if (ret)
> +		goto finish;
> +
> +	for (wait_cnt = 0; wait_cnt < wait_time; wait_cnt++) {
> +		pwr_good = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
> +		if (pwr_good < 0) {
> +			dev_err(&rdev->dev, "Failed to read pgood gpio: %d\n", pwr_good);

Use poll_enabled_time to check the status, no need for a custom enable
operation.

> +			ret = pwr_good;
> +			goto finish;
> +		} else if (pwr_good)
> +			break;

As per coding-style.rst both sides of the if statement should use braces
if one does.

> +	ret = sysfs_create_group(&rdev->dev.kobj, &sy7636a_sysfs_attr_group);
> +	if (ret) {
> +		dev_err(sy7636a->dev, "Failed to create sysfs attributes\n");
> +		return ret;
> +	}

*If* the driver is creating sysfs devices it *definitely* shouldn't be
creating and destroying them dynamically at runtime.

> +	ret = sy7636a_regulator_init(sy7636a);
> +	if (ret) {
> +		dev_err(sy7636a->dev, "Failed to initialize regulator: %d\n", ret);
> +		return ret;
> +	}

This function has one caller and one statement in it, just inline it.

--PpocKf6TCvdC9BKE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjdm0ACgkQJNaLcl1U
h9AtuAf/e3dCqonve89KAIfmXQuEcb6dosqXILcox8zWgCAVp6/YWQOAkOLlgmOB
HJdKCyZ+/tDt2Yq9qf6xicShgp1MsZgP7MrI7qOEqFlodWtigUawMILV3nheJGOF
xMtN+u3/tTyBJdsHLCR9nINWkMn9rhhtVVFf4XzRdijcc22rwAKYk6NADx4k99H5
xQy4ttsSInMgAzrRv/iLXwQ6sSALHTR+Uphp2FF0MOEpurai+2sS+gn20nxxuLj5
Z0vjR/1tDzdzjMwhal0Yp4N94qo9ww1tJCMznzUhmOYx0FE2VP3iu8xFsWUjK9yP
bFPFxo16PWxP4p/bMBUdJRl4Ff6wsw==
=yHlG
-----END PGP SIGNATURE-----

--PpocKf6TCvdC9BKE--
