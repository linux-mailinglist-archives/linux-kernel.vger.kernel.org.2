Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EE6321F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhBVTFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhBVTD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:03:27 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5064EC061574;
        Mon, 22 Feb 2021 11:02:40 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e7so11803005ile.7;
        Mon, 22 Feb 2021 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+e8UIztOcsKjrlTctjSMc1WY3nEzfs9k9bIVsJIkLwU=;
        b=X+k64qx9S22kXdp3V9YOk+/i0xClR17rtxxYmkOaaGpG1SEEleI2gDY05YCqWQOxua
         xtlYd8V9geaibnFZhbw6WwaINx6DQ/G0yrCiAjlR5an/5J6sr12diWGQJS8yGsLV1jDW
         lSMVwO644zLsG7RM1XznYOifxadmxTLbLqTdgKBIC9hkPDg4AygDZD04j7P6RL7Yhrpv
         usY8mVGMrlyCeBkW8x9vNtMQM/OWBbjd9TQxYlf72GFJWTfZdtyCMxKbectEPZlQzsjc
         d7eIgCVB5nn2Ny/SUXXmp/+n2o0wAwePpPRLjVjkZT7azRghNOiyAFRli4eQP+NGF337
         MqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+e8UIztOcsKjrlTctjSMc1WY3nEzfs9k9bIVsJIkLwU=;
        b=OxAKDjcyn8rVzpjwU3EwRT0LG54jzc7/ZxAkW6sWph+Z8+srzTTm9/sagNe1QO8Jg5
         RXizmZaQtRtoCVA6xr0Yt41nNKdoTrS1ii6bR+M8Od1myUQ1nXohUolafBwmI7oplkUF
         4Z8ROMTbjytMIM+FUjdTFVWNDOZNDoV+CnyU/39FBApJue3g7yO8ZEiO1ecGZ1egz0Re
         N+ENnYzN/mxo0pjvHm13XgdvgXM5jP9C4DfAIG9foWuW1q/kwMYXHBEovHEPtTpN/sGZ
         V3tNy0PrfpOa7+GrGcvFGspwn70Hw1Tp1G4zzwwBeA02ZXE6rhJfHGU95rQ7OYj4Ogng
         rejg==
X-Gm-Message-State: AOAM5333jJR5USJ4GEOmDYYRu9lN/k3+27xoE+mxevuEJH/slUSUfdnb
        lbgWV/wXaPWzrWBGGQfm23wvOxdSUwT+c+To9vQ=
X-Google-Smtp-Source: ABdhPJzRK+14O8IUP3faQtq2TM10OHznaqxvVqO4EmlQADeJMDJYsZDwQCaw1/nY/Rnk9RTgI83LkzHg+EvokccMGdA=
X-Received: by 2002:a92:d201:: with SMTP id y1mr2582055ily.129.1614020559300;
 Mon, 22 Feb 2021 11:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20210218123327.25486-1-heiko.thiery@gmail.com>
 <20210218123327.25486-3-heiko.thiery@gmail.com> <20210221121111.nsenzgenwb6pu3o7@kozik-lap>
 <CAEyMn7YN4xqcFxR0QHUDp8cc1QP62HgpGMCYAjh0RfWL-iRQCA@mail.gmail.com>
 <20210222084027.jd3eop7j4czoqqim@kozik-lap> <CAEyMn7YPNRDbPH84wg2s+r2F6Fo=0DJOUd-R03Fg=6_CxgknSg@mail.gmail.com>
 <CAJKOXPdhbwpEHA+h3706NXf0uRhyu8VVC++K8WpzA6h2=8PK8Q@mail.gmail.com>
In-Reply-To: <CAJKOXPdhbwpEHA+h3706NXf0uRhyu8VVC++K8WpzA6h2=8PK8Q@mail.gmail.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Mon, 22 Feb 2021 20:02:28 +0100
Message-ID: <CAEyMn7YeKg2foozsoX4yJZyMkE_dRgxR5KncW6yixaY10NgjwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: fsl: add support for Kontron pitx-imx8m board
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

Hi Krzysztof,

Am Mo., 22. Feb. 2021 um 19:39 Uhr schrieb Krzysztof Kozlowski
<krzk@kernel.org>:
>
> On Mon, 22 Feb 2021 at 10:09, Heiko Thiery <heiko.thiery@gmail.com> wrote:
> > > > > > +
> > > > > > +     pcie0_refclk: pcie0-refclk {
> > > > >
> > > > > Generic node names (from the dt spec candidate is "clock").
> > > >
> > > > Should I simply set the node name to pcie0-clock? And pcie1-clock for
> > > > the next one?
> > >
> > > I am fine with "pcie0-clock" or just "clock-0".
> >
> > I saw now that in "imx8mq-zii-ultra.dtsi" the name
> > "clock-pcie0-refclk" is used. Can I use the same?
>
> It's not that generic anymore - but specific, but it's also not that
> important, so go ahead.

For me it is no problem to change this to pcie0-clock and pcie1-clock.
I need to make a new version anyway.

-- 
Heiko
