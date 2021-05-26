Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2893439155C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhEZKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:52:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57548 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbhEZKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:52:06 -0400
X-Greylist: delayed 704 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 06:52:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wsaiMJnVLV41pWxm0Qdhpy4PmimGudL5rbxqlYOE3Xc=; b=S3mF16ZlTsoIf3S/+Lvw1FIHBl
        3416CziM0S5DcY4EpuwredTPS9uXZlFylvBSlPZ6bBBCWAhZmbKnEjL6t1Ci1baa3M30AdmkyB9QZ
        9LxxpcDazNgg9LZEcvBKBlBjKoerHt2DVFMBwfdES1VPKsUzE8TLEx+lp/0ULEKjR0Gk=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1llr7N-005xtN-Nm; Wed, 26 May 2021 10:50:29 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3A60CD0581E; Wed, 26 May 2021 11:51:04 +0100 (BST)
Date:   Wed, 26 May 2021 11:51:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] regulator: rt6160: Add support for Richtek RT6160
Message-ID: <YK4oGB5cZ/DhG5vm@sirena.org.uk>
References: <1622008068-13474-1-git-send-email-u0084500@gmail.com>
 <1622008068-13474-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YmLY0JB8J0+AArwc"
Content-Disposition: inline
In-Reply-To: <1622008068-13474-2-git-send-email-u0084500@gmail.com>
X-Cookie: Ahead warp factor one, Mr. Sulu.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YmLY0JB8J0+AArwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 26, 2021 at 01:47:48PM +0800, cy_huang wrote:

This looks mostly good, a few small issues below:

> +static int rt6160_set_suspend_voltage(struct regulator_dev *rdev, int uV)
> +{
> +	struct rt6160_priv *priv = rdev_get_drvdata(rdev);
> +	struct regmap *regmap = rdev_get_regmap(rdev);
> +	unsigned int reg = RT6160_REG_VSELH;
> +	int vsel;
> +
> +	vsel = regulator_map_voltage_linear(rdev, uV, uV);
> +	if (vsel < 0)
> +		return vsel;
> +
> +	if (priv->vsel_active_low)
> +		reg = RT6160_REG_VSELL;
> +
> +	return regmap_update_bits(regmap, reg, RT6160_VSEL_MASK, vsel);
> +}

This seems to just be updating the normal voltage configuration
regulator, the suspend mode operations are there for devices that
have a hardware suspend mode that's entered as part of the very
low level system suspend process.

> +static int rt6160_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
> +{
> +	struct regmap *regmap = rdev_get_regmap(rdev);
> +	unsigned int ramp_value = RT6160_RAMPRATE_1VMS;
> +
> +	switch (ramp_delay) {
> +	case 1 ... 1000:
> +		ramp_value = RT6160_RAMPRATE_1VMS;
> +		break;

This looks like it could be converted to regulator_set_ramp_delay_regmap()

> +static unsigned int rt6160_of_map_mode(unsigned int mode)
> +{
> +	if (mode == RT6160_MODE_FPWM)
> +		return REGULATOR_MODE_FAST;
> +	else if (mode == RT6160_MODE_AUTO)
> +		return REGULATOR_MODE_NORMAL;
> +

This would be more idiomatically written as a switch statement.

> +	enable_gpio = devm_gpiod_get_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(enable_gpio)) {
> +		dev_err(&i2c->dev, "Failed to get 'enable' gpio\n");
> +		return PTR_ERR(enable_gpio);
> +	}

There's no other references to enable_gpio?

> +	regmap = devm_regmap_init_i2c(i2c, &rt6160_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i2c->dev, "Failed to init regmap\n");
> +		return PTR_ERR(regmap);
> +	}

It's better to print the error code to help anyone who runs into
issues figure out what's wrong.

--YmLY0JB8J0+AArwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCuKBcACgkQJNaLcl1U
h9Ajigf8DSeMCGtODpLMpfG77Q9MNmwYi8SmOMhdNnFCmgPIMqM5fCAX75eQEiSo
Rl8CAP9FOt0EH0JwZTBZmS4Yms3bpg/F4C/8j4vYHRY4P38Al+M3XPiTfTx15N26
a9niXKBRPD2ZFRbf6BlZY8w2+mxs8hRf65u8yRxzxlMxkhhfTbay3GcuA0orKPO4
9EEPl+5CswXS4Qr3rPQWZEZ3rlWJrn14C+AD73BOTcju8tQxeFKvnNHdE0jLcjJO
WNjRh/61e2e03drDs79L6LYxZPd05vavk04MdkAI7AWuiFs2HelckpFU7uigSVaf
LIq+E57TLrd+PbLr6cMxLqf/OCNh9w==
=8Tzc
-----END PGP SIGNATURE-----

--YmLY0JB8J0+AArwc--
