Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D499941266C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386617AbhITS5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385811AbhITSw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66A036137D;
        Mon, 20 Sep 2021 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632159597;
        bh=903YqIP8EUw0vSLRBRcde8XjuLqF8cyeILPKV/3g0IM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bNkmkaKO2MkoLOBBQhWsGuHqS0WLUmeqxBLYI8gIcQnHv1DneU0wJFO9OgfZu0JMm
         l7SACha1ruLKSF15gA+/snD/BJ5UtpZIQgLrOds5vzx6mG9J/fLy7eVSvCofRncu3M
         gb+Tr5RmmEy0MGdDQQhphvJ2vfTyKbACg6JCqAC5CtCH0XozrLC7rw37ipbIEvrcQO
         dhldO4XSvLuZ3EFl49YT8KB47oYI9am6zhF47TpVmlDc2ZqCufKYNUMqxzU179WIrb
         yQ79cP0Sz15KId3dgZe7ONUExNMzncZthXbANFjw5QEUvzpWkAsi6+6Te+ovLGX/vu
         xRUpUHIRSAb7Q==
Received: by mail-ed1-f47.google.com with SMTP id eg28so41684068edb.1;
        Mon, 20 Sep 2021 10:39:57 -0700 (PDT)
X-Gm-Message-State: AOAM530KIM3c7ifXu/cdCRfK5++clGemTduuu9qd+JQfLfP7EsUfItFV
        NSpZ6dr0/DJ09FKe0JMttqNLXMnuHbVvGh/Skg==
X-Google-Smtp-Source: ABdhPJzjibJYMKA9ye+veIVFRD13W50GOvjJ1druj/8FcBQX6F7YnxBrkI7wbV2lKiSfaKJsvWwGHnH4O3sC7tCSpDk=
X-Received: by 2002:a05:6402:b23:: with SMTP id bo3mr30686547edb.145.1632159595923;
 Mon, 20 Sep 2021 10:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210919125536.117743-1-marcel@ziswiler.com> <20210919125536.117743-8-marcel@ziswiler.com>
 <1632140917.871356.4136126.nullmailer@robh.at.kernel.org> <d0568e8c5c46ebc04530b09c14c500d9ae8d5e51.camel@toradex.com>
In-Reply-To: <d0568e8c5c46ebc04530b09c14c500d9ae8d5e51.camel@toradex.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Sep 2021 12:39:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJSR69YSSx7Gae+1Pof9DdkMYnaWF8U+YP13=2Zm9ujBA@mail.gmail.com>
Message-ID: <CAL_JsqJSR69YSSx7Gae+1Pof9DdkMYnaWF8U+YP13=2Zm9ujBA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] dt-bindings: arm: fsl: clean-up all toradex boards/modules
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.riedmueller@phytec.de" <s.riedmueller@phytec.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 9:19 AM Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
>
> Hi Rob
>
> On Mon, 2021-09-20 at 07:28 -0500, Rob Herring wrote:
> > On Sun, 19 Sep 2021 14:55:34 +0200, Marcel Ziswiler wrote:
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > >
> > > Simplify and unify the distinction between modules and carrier boards.
> > >
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > >
> > > ---
> > >
> > > Changes in v3:
> > > - Add Fabio's reviewed-by. Thanks!
> > > - Add Rob's ack. Thanks!
> > >
> > > Changes in v2:
> > > - New patch cleaning-up dt-bindings documentation.
> > >
> > >  .../devicetree/bindings/arm/fsl.yaml          | 79 ++++++++++---------
> > >  1 file changed, 41 insertions(+), 38 deletions(-)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/arm/fsl.yaml:475:111: [warning] line too long (113 > 110 characters)
> > (line-length)
> > ./Documentation/devicetree/bindings/arm/fsl.yaml:612:111: [warning] line too long (113 > 110 characters)
> > (line-length)
> >
> > dtschema/dtc warnings/errors:
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/patch/1529833
> >
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
>
> Strange, I have done all of that but I still can not convince dt_binding_check on my system to show me that
> same yamllint warnings/errors on that fsl.yaml file. However, it otherwise seems to work as it shows dozens of
> other issues throughout Documentation/devicetree/bindings but those are not for me to fix, at least not right
> now (;-p).

You shouldn't be seeing dozens of warnings unless you are on the
current linux-next. linux-next shouldn't be the basis for your
development as that's not a tree any maintainer applies patches to.

Rob
