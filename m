Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0EB36F3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 04:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhD3CDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 22:03:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhD3CDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 22:03:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4743E613B4;
        Fri, 30 Apr 2021 02:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619748147;
        bh=FHzujwGmdMUBeThmjTcOfbavQK2/+QHmQ2rFXtDGaNo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dYboXGZsaAygY3Sd9pzVuSPtxPquPZe38FhvP9d5GrYeebWEOvOjvIsXlMptguvLL
         nB0OwFo+ngDKl3uSc/WpwBpWaD0v8+0KFLgh0IUHxKbm0We/2NGoi3qXgIBCcyHhbi
         pMCowSpPZVGrD8e3BcpUX4MS0dwdlTgs1PJFhHpPRqkS5bPt1A/XV3ticIAA5iPXIH
         YXHvTVsLOVT6DN4sZZSMQ8r5FuXEuo/Qwbm+z8M6RZ7SAPmulZfncnXjL0Fnu0+ELw
         neUh0fWgCKuyMZ2ATB0FS6bdkZvwSGpuXo60I+7wdMqOeSwbxHJrzslzfPQJKuKGP1
         V1UbIUimAhAzw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFBinCCcKHqd7Mh3bV9NyyWzi=96pCWxzSZBOjg5Puy9wOuihQ@mail.gmail.com>
References: <20210429090516.61085-1-jbrunet@baylibre.com> <CAFBinCCcKHqd7Mh3bV9NyyWzi=96pCWxzSZBOjg5Puy9wOuihQ@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: axg-audio: do not print error on defer
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 29 Apr 2021 19:02:26 -0700
Message-ID: <161974814600.177949.13534344520666393105@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-04-29 13:49:54)
> Hi Jerome,
>=20
> On Thu, Apr 29, 2021 at 11:06 AM Jerome Brunet <jbrunet@baylibre.com> wro=
te:
> [...]
> > diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audi=
o.c
> > index 7c8d02164443..5e501eff0840 100644
> > --- a/drivers/clk/meson/axg-audio.c
> > +++ b/drivers/clk/meson/axg-audio.c
> > @@ -1811,7 +1811,8 @@ static int axg_audio_clkc_probe(struct platform_d=
evice *pdev)
> >
> >         ret =3D device_reset(dev);
> >         if (ret) {
> > -               dev_err(dev, "failed to reset device\n");
> > +               if (ret !=3D -EPROBE_DEFER)
> > +                       dev_err(dev, "failed to reset device\n");
> many drivers are switching to dev_err_probe nowadays
> According to it's documentation:
>   In case of -EPROBE_DEFER it sets also defer probe reason, which can be
>   checked later by reading devices_deferred debugfs attribute.
>=20
> so I think it makes sense to use dev_err_probe here as well
>=20
>=20

Yes please use dev_err_probe()
