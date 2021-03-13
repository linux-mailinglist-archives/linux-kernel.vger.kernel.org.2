Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D65339ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 16:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhCMPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 10:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCMPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 10:08:04 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7662C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PT2uaudT8zK/o8zFyuudxww2y2Ec8rnLtUlr+iIExYo=; b=DvzORw6uIQ4WOWLBmx8wYGGsb9
        D9QbWGggJS47uwYIr5ZDLmQ5ulmW4jEycuTAyHlc5FmG1sO89yr6Ynm5RBlIFKVc7KJMPGQJTSmZs
        ei5Egb6w0Cw4Q0GaSV9NBIJxsFyGbekMEy47SYVsQGe35wZwRtSfrbttq/j0I0xjyp14=;
Received: from p200300ccff380e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff38:e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lL5ry-0000nW-05; Sat, 13 Mar 2021 16:07:58 +0100
Date:   Sat, 13 Mar 2021 16:07:57 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210313160757.084d74d0@aktux>
In-Reply-To: <YEyfTrTFzUaXiklf@latitude>
References: <20210308212952.20774-1-andreas@kemnade.info>
        <20210310095545.GC701493@dell>
        <YEyfTrTFzUaXiklf@latitude>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2021 12:17:34 +0100
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> On Wed, Mar 10, 2021 at 09:55:45AM +0000, Lee Jones wrote:
> > On Mon, 08 Mar 2021, Andreas Kemnade wrote: =20
> [...]
> > > -static const struct mfd_cell ntxec_subdevices[] =3D {
> > > +static const struct mfd_cell ntxec_subdev[] =3D {
> > >  	{ .name =3D "ntxec-rtc" },
> > >  	{ .name =3D "ntxec-pwm" },
> > >  };
> > > =20
> > > +static const struct mfd_cell ntxec_subdev_pwm[] =3D {
> > > +	{ .name =3D "ntxec-pwm" },
> > > +}; =20
> >=20
> > To put across what you're trying to achieve, maybe call this:
> >=20
> >   ntxec_subdev_no_rtc[]
> >=20
> > Then if other devices are added, the semantics/intent stays the same
> > and it won't have to be renamed. =20
>=20
> Andreas, what is the full amount of functionality this version of the EC
> can ever provide?
>=20
> If it's only PWM, I think ntxec_subdev_pwm fits well.
>=20
I think it is only PWM. At least I could not see any other I2C access.

> [ The next subdevice that I can foresee is battery monitoring. ]
>=20
That is done via the RC5T619 on that device.

Regards,
Andreas
