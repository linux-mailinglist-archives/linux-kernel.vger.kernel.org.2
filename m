Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4616B32FCD4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFTm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhCFTm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:42:28 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1684C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 11:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m73A6zMCVbK5mbsOfUBuvDvfG/aaNxXDXfwY7sKcxBw=; b=Pz99ln7L65TCF43YtL8SeAineZ
        Rk7VjtNes2Et+1S0nJ712uPmmY7NOydjFjttcHqnYkhveScA6uaV8T63o8akxweED4CvLtUnBNq5y
        zowv9YJR8WFF6Zjgdu5UfdacvpgaNZScu4b9H921vn6QzuoaN8KWYIt3kef/cOVqDcpk=;
Received: from p200300ccff3790001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:9000:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lIcod-0004uJ-Tc; Sat, 06 Mar 2021 20:42:20 +0100
Date:   Sat, 6 Mar 2021 20:42:19 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210306204219.6a7eae56@aktux>
In-Reply-To: <YEPUppNWNiAMnczF@latitude>
References: <20210306181314.12673-1-andreas@kemnade.info>
        <YEPUppNWNiAMnczF@latitude>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Mar 2021 20:14:46 +0100
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> Hi,
>=20
> (Cc'ing Mark Brown because of the regmap related questions)
>=20
> On Sat, Mar 06, 2021 at 07:13:14PM +0100, Andreas Kemnade wrote:
> > Add the version of the EC in the Tolino Shine 2 HD
> > to the supported versions. It seems not to have an RTC
> > and does not ack data written to it.
> > The vendor kernel happily ignores write errors, using
> > I2C via userspace i2c-set also shows the error.
> > So add a quirk to ignore that error.
> >=20
> > PWM can be successfully configured despite of that error. =20
>=20
> I'm curious, is this one of the variants with two PWM channels
> (for configurable color temperature)?
>=20
No. Tolino Shine 3 and Kobo Clara HD have such things. There you have a
/sys/class/backlight/backlight_{cold,warm}.

> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/mfd/ntxec.c       | 57 ++++++++++++++++++++++++++++++++++++---
> >  include/linux/mfd/ntxec.h |  1 +
> >  2 files changed, 55 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
> > index 957de2b03529..e7fe570127af 100644
> > --- a/drivers/mfd/ntxec.c
> > +++ b/drivers/mfd/ntxec.c
> > @@ -96,6 +96,36 @@ static struct notifier_block ntxec_restart_handler =
=3D {
> >  	.priority =3D 128,
> >  };
> > =20
> > +static int regmap_ignore_write(void *context,
> > +			       unsigned int reg, unsigned int val)
> > +
> > +{
> > +	struct regmap *regmap =3D context;
> > +
> > +	regmap_write(regmap, reg, val);
> > +
> > +	return 0;
> > +}
> > +
> > +static int regmap_wrap_read(void *context, unsigned int reg,
> > +			    unsigned int *val)
> > +{
> > +	struct regmap *regmap =3D context;
> > +
> > +	return regmap_read(regmap, reg, val);
> > +}
> > +
> > +/* some firmware versions do not ack written data, add a wrapper */
> > +static const struct regmap_config regmap_config_noack =3D {
> > +	.name =3D "ntxec_noack",
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 16,
> > +	.cache_type =3D REGCACHE_NONE,
> > +	.val_format_endian =3D REGMAP_ENDIAN_BIG,
> > +	.reg_write =3D regmap_ignore_write,
> > +	.reg_read =3D regmap_wrap_read =20
>=20
> Is the read wrapper necessary? It seems to me from reading regmap.h
> that leaving .reg_read set to NULL should do the right thing, but I'm
> not sure.
>
well if we want to read from it, there need to be some function for it.
But if... I do not see anything worth to read besides of version.
I think we can leave ouf val_format_endian because a lot of stuff is
bypassed if no bus is set in regmap_init().
There is e.g. a goto skip_format_initialization.

> > +};
> > +
> >  static const struct regmap_config regmap_config =3D {
> >  	.name =3D "ntxec",
> >  	.reg_bits =3D 8,
> > @@ -109,10 +139,15 @@ static const struct mfd_cell ntxec_subdevices[] =
=3D {
> >  	{ .name =3D "ntxec-pwm" },
> >  };
> > =20
> > +static const struct mfd_cell ntxec_subdev_pwm[] =3D {
> > +	{ .name =3D "ntxec-pwm" },
> > +}; =20
>=20
> ntxec_subdevices vs. ntxec_subdev_pwm seems slightly inconsistent in
> naming. ntxec_subdevices_pwm would be a wrong plural, but IMHO slightly
> better because of consistency. Maybe rename ntxec_subdevices to
> ntxec_subdev?
>=20
yes, I will change it.

> > +
> >  static int ntxec_probe(struct i2c_client *client)
> >  {
> >  	struct ntxec *ec;
> >  	unsigned int version;
> > +	bool has_rtc;
> >  	int res;
> > =20
> >  	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> > @@ -137,6 +172,15 @@ static int ntxec_probe(struct i2c_client *client)
> >  	/* Bail out if we encounter an unknown firmware version */
> >  	switch (version) {
> >  	case NTXEC_VERSION_KOBO_AURA:
> > +		has_rtc =3D true;
> > +		break;
> > +	case NTXEC_VERSION_TOLINO_SHINE2:
> > +		has_rtc =3D false;
> > +		ec->regmap =3D devm_regmap_init(ec->dev, NULL,
> > +					      ec->regmap,
> > +					      &regmap_config_noack); =20
>=20
> Ah=E2=80=94 A custom regmap stacked on top of the old regmap=E2=80=A6 I t=
hink this
> deserves a comment.
>=20
Yes, devm_regmap_init_i2c() sets a different set of callbacks depending
on circumstances. Seems to be the easiest way to avoid duplicating too
much code. I really hope that there are not so much devices requiring
such a dirty stuff that adding such thing to the generic regmap code
would be justified.

> > +		if (IS_ERR(ec->regmap))
> > +			return PTR_ERR(ec->regmap);
> >  		break;
> >  	default:
> >  		dev_err(ec->dev,
> > @@ -155,7 +199,6 @@ static int ntxec_probe(struct i2c_client *client)
> >  		 */
> >  		res =3D regmap_write(ec->regmap, NTXEC_REG_POWERKEEP,
> >  				   NTXEC_POWERKEEP_VALUE);
> > -		if (res < 0)
> >  			return res; =20
>=20
> This deletion looks like a mistake.
>=20
Oops, sorry.

> > =20
> >  		if (poweroff_restart_client)
> > @@ -181,8 +224,16 @@ static int ntxec_probe(struct i2c_client *client)
> > =20
> >  	i2c_set_clientdata(client, ec);
> > =20
> > -	res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_subd=
evices,
> > -				   ARRAY_SIZE(ntxec_subdevices), NULL, 0, NULL);
> > +	if (has_rtc)
> > +		res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
> > +					   ntxec_subdevices,
> > +					   ARRAY_SIZE(ntxec_subdevices),
> > +					   NULL, 0, NULL);
> > +	else
> > +		res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE,
> > +					   ntxec_subdev_pwm,
> > +					   ARRAY_SIZE(ntxec_subdev_pwm),
> > +					   NULL, 0, NULL); =20
>=20
> At some point, it will probably be simpler to have
>=20
> 	struct mfd_cell *subdev =3D ntxec_subdevices;
> 	size_t subdev_size =3D ARRAY_SIZE(ntxec_subdevices);
>=20
> on top of the probe function and override them in the switch statement,
> but at this point I think it doesn't matter, and either way is fine.
>=20
Yes, that might be a good idea.

Regards,
Andreas
