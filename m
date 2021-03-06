Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C421832FDAC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 23:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCFWHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 17:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFWG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 17:06:27 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5657CC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 14:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7KlDfjGp7qrFtRej7uFJqB5juRL+J4hofoA6AzEBi7Q=; b=PtsDOYiVkLb+QY3R5bsgbUOvIT
        QQyQuBkj4fU1aGorkPdjUeswlh8YZff3rvDd3ey6oi7P9ahJ9n8OwSBnqJD7yn7FT1XU6W02QlLeI
        PUEOIje2R+6U0tLLFZh933Cdulh/Fa1LqzCmPWVM+WDVUI4/m6R+jcelFwlDCVQUbJt8=;
Received: from p200300ccff3790001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:9000:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lIf3z-0005tT-Ql; Sat, 06 Mar 2021 23:06:19 +0100
Date:   Sat, 6 Mar 2021 23:06:19 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210306230619.15ae787f@aktux>
In-Reply-To: <YEPj2ss13w5p+R4C@latitude>
References: <20210306181314.12673-1-andreas@kemnade.info>
        <YEPUppNWNiAMnczF@latitude>
        <20210306204219.6a7eae56@aktux>
        <YEPj2ss13w5p+R4C@latitude>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Mar 2021 21:19:38 +0100
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

[...]
> > > > +	case NTXEC_VERSION_TOLINO_SHINE2:
> > > > +		has_rtc =3D false;
> > > > +		ec->regmap =3D devm_regmap_init(ec->dev, NULL,
> > > > +					      ec->regmap,
> > > > +					      &regmap_config_noack);   =20
> > >=20
> > > Ah=E2=80=94 A custom regmap stacked on top of the old regmap=E2=80=A6=
 I think this
> > > deserves a comment.
> > >  =20
> > Yes, devm_regmap_init_i2c() sets a different set of callbacks depending
> > on circumstances. Seems to be the easiest way to avoid duplicating too
> > much code. I really hope that there are not so much devices requiring
> > such a dirty stuff that adding such thing to the generic regmap code
> > would be justified. =20
>=20
> Ok, please add a short comment here or extend the one above the repmap
> config struct, to save interested readers a bit of trouble. I guess "add
> a wrapper" goes in right direction, but it didn't make the stacking
> obvious to me when I first read it.
>

I will wait for some days to see whether anybody chokes on that stack.

Regards,
Andreas
