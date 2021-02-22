Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECB1321FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhBVTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:12:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232846AbhBVTJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:09:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F371C650EC;
        Mon, 22 Feb 2021 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614019142;
        bh=2K70FOuXkm5Qh0yfPpxzra/jW8IhfuHl6s8zxVDrC7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ese47PheqwCHpJ+65RuLgT7xSeHzBjuTCJ267M4r7s9zTQ2TAXsNZEo+tAbLKigAj
         9kqkZ3Aqst1tLZGjaLe8rlTc1NL4IxRv3Zty/vsBb+svkDQAkqVxiBG3p5OCuT4RTU
         ok5MatEne0rccGSPLrLxzwdhsShWNQPaJCJS6olquBhkUhkJyg7mciGZdwk/02ipWN
         1pU1rMGyDtPYpMNhrA/dgi2+YE4o36pGFBAan6cG86SjwqWa13dfghJ3frcaQPsvwC
         TgNf/fpGx1zlZ1HLVmgsvty2tsWKADklJp7yIsfnDFKQ2O5sflGKi+xlornWFLUTlO
         bL/OJUQfYuP1w==
Received: by mail-ej1-f54.google.com with SMTP id u20so30279709ejb.7;
        Mon, 22 Feb 2021 10:39:01 -0800 (PST)
X-Gm-Message-State: AOAM530roKQM9aSiOVLMqk007+ftR/a8tXZFgOIiRA8mUSzYx6Chw+r3
        8DNOO2632j0awZK4gDUXCd3JD96l9fVm0DuYStA=
X-Google-Smtp-Source: ABdhPJxbslsJjK1ipC63AcC6Ia3WuVrnz/HY1pq7QjRD3xKySvHKo9H4EYg/0gUBQwTVNk7zOYI2pOg29+UwpraPqPY=
X-Received: by 2002:a17:907:20e8:: with SMTP id rh8mr22631971ejb.119.1614019140508;
 Mon, 22 Feb 2021 10:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20210218123327.25486-1-heiko.thiery@gmail.com>
 <20210218123327.25486-3-heiko.thiery@gmail.com> <20210221121111.nsenzgenwb6pu3o7@kozik-lap>
 <CAEyMn7YN4xqcFxR0QHUDp8cc1QP62HgpGMCYAjh0RfWL-iRQCA@mail.gmail.com>
 <20210222084027.jd3eop7j4czoqqim@kozik-lap> <CAEyMn7YPNRDbPH84wg2s+r2F6Fo=0DJOUd-R03Fg=6_CxgknSg@mail.gmail.com>
In-Reply-To: <CAEyMn7YPNRDbPH84wg2s+r2F6Fo=0DJOUd-R03Fg=6_CxgknSg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 22 Feb 2021 19:38:47 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdhbwpEHA+h3706NXf0uRhyu8VVC++K8WpzA6h2=8PK8Q@mail.gmail.com>
Message-ID: <CAJKOXPdhbwpEHA+h3706NXf0uRhyu8VVC++K8WpzA6h2=8PK8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: fsl: add support for Kontron pitx-imx8m board
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 at 10:09, Heiko Thiery <heiko.thiery@gmail.com> wrote:
> > > > > +
> > > > > +     pcie0_refclk: pcie0-refclk {
> > > >
> > > > Generic node names (from the dt spec candidate is "clock").
> > >
> > > Should I simply set the node name to pcie0-clock? And pcie1-clock for
> > > the next one?
> >
> > I am fine with "pcie0-clock" or just "clock-0".
>
> I saw now that in "imx8mq-zii-ultra.dtsi" the name
> "clock-pcie0-refclk" is used. Can I use the same?

It's not that generic anymore - but specific, but it's also not that
important, so go ahead.

> > >
> > > When I run "make dtbs_check" it runs quite a long time and stops with
> > > an error. But as far as I can say there is an error coming from the
> > > included "imx8mq.dtsi".
> > >
> > > You can see the output here: https://pastebin.com/raw/iU2geBDh
> >
> > Looks fine (except the error tool :) ).
>
> What do you mean with error tool?

I lost some words on the wire - I meant: "except the error from the
tool itself".

Best regards,
Krzysztof
