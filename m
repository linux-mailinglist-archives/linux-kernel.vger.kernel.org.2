Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CD7400839
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350722AbhICXXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:23:39 -0400
Received: from dnyon.com ([82.223.165.189]:56426 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242236AbhICXXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:23:38 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id E27503FEB7;
        Fri,  3 Sep 2021 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630711356; bh=tchsqUj+OfPK4wG9xezTZ/SvhX1irYZ1qa7IOGO6KLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mo89RMoN243CTz4Z3TSYPsPPR7+S9ZVK9v/JFPzAwQM1o0plDtLKp8OU7iYHaGCHH
         WFYC6/GMynzNweAVzwbvbrbNgBlJcfAPnnGNljK8h6A6rROebEmrXWs9LywTmuETi8
         J6qokAgPzwa+SOLlIbN9Qok1b/+y5/ClwBFQKP7xKlRKAmL8qbM3/jxyNaJ6XFtgy/
         2QY65Pc6Dpzu3jNjKQkdFUlxjQf0dpNU/Lhcu2W3gOeY09inbkdvTiSj5CwDg0V4dm
         HNHkrapIghO84BULOW9Hz+yfVbxCsICJFNx4cnXqC3O5RMrKlOscpGMFcJ4uelyczH
         U++nWCwdyuVyw==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date:   Sat, 04 Sep 2021 01:22:26 +0200
Message-ID: <5503823.DvuYhMxLoT@alexpc>
In-Reply-To: <80973391-4579-e14b-6def-ed81f367a4a5@linux.intel.com>
References: <cover.1630632805.git.atafalla@dnyon.com> <04a18f4115539752429da55fb857834cea0944e5.1630632805.git.atafalla@dnyon.com> <80973391-4579-e14b-6def-ed81f367a4a5@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 11:20 P=E9ter Ujfalusi wrote:
>=20
> If this is a 'reset' pin then it's ACTIVE state is when it places the
> device to _reset_.
> GPIOD_OUT_LOW =3D=3D Deasserted state of the GPIO line.
>=20
> If the reset pin should be pulled low for reset (GPIO_ACTIVE_LOW) and
> you want the device initially  in reset then you need GPIOD_OUT_HIGH,
> because:
> GPIOD_OUT_HIGH =3D=3D Asserted state of the GPIO line.
>=20
> Same goes for the gpiod_set_value_cansleep():
> 0 - deasserted
> 1 =3D asserted
>=20
> and this all depends on how the gpio is defined in DT
> (GPIO_ACTIVE_LOW/HIGH), which depends on how the documentation refers to
> the pin...
>=20
> reset pin:
> low to keep the device in reset, high to release it from reset:
> GPIO_ACTIVE_LOW
> gpiod_set_value_cansleep(0) to enable
> gpiod_set_value_cansleep(1) to disable
>=20
>=20
> enable pin:
> high to enable the part, low to disable
> GPIO_ACTIVE_HIGH
> gpiod_set_value_cansleep(1) to enable
> gpiod_set_value_cansleep(0) to disable
>=20
> In both cases
> electrical 0: reset/disable
> electrical 1: enable
I'll change it to be consistent in the next version. Thank you for the=20
explanation.
=20
> > +	if (IS_ERR(reset_gpio)) {
> > +		ret =3D PTR_ERR(reset_gpio);
> > +		return dev_err_probe(&i2c->dev, ret, "failed to request=20
GPIO reset
> > pin"); +	}
> > +
> > +	if (reset_gpio) {
> > +		usleep_range(8000, 10000);
> > +		gpiod_set_value_cansleep(reset_gpio, 1);
> > +		usleep_range(1000, 5000);
> > +	}
> > +
>=20
> You might want to put the device to reset on remove at minimum.
Okay, thanks.

=2D-=20
Alejandro Tafalla


