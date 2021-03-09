Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF98332EED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhCITWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCITWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:22:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 108DA65237;
        Tue,  9 Mar 2021 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615317724;
        bh=AaO+UbGAEZUo3o9QYbxnPDFnaxXOUUGrUBCbEaRrUqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m/dBrQ1+uo1RqzGpHsIWLJzqjcWhuOoEE+iuSSc0rR/xOug/QrPbbotHfKKqcbjM5
         RIHFVUQWrZyKqyyASEB1jntulVnFyl9pzmNYIIe305SZw4SwbHBjITgWQlzyrd/rnR
         aCgXnVHLmLwASYzuNuOvsJFrqfCBbYLWOjP1GEESnuPQxZEpxEHRUEGfB9hGfhvJsJ
         ebJpuhVzZvKwQTsjQIyV/r7jken4639UrWYTKVJ0PvyBqcCEPuPr+U+q42XvEcPTV2
         oz68rihY5v8t1st/NWKI3vMgOF9Tlo7UV5503VAiqn3dzCWmjEQWqytPKEV3bKRrLh
         VAbujl3ZqVhiQ==
Received: by mail-ej1-f46.google.com with SMTP id jt13so30968284ejb.0;
        Tue, 09 Mar 2021 11:22:03 -0800 (PST)
X-Gm-Message-State: AOAM532fW5fUcFqBnb4qvjG8aWy3PxLa0cYsfSYbHdrKnhBplXPgliZC
        olvBCwn+AMLfwW++b1QheCmz4DOoUB/dqnKavQ==
X-Google-Smtp-Source: ABdhPJx9xoFco5obxQqg/gaAD5xU1Y8MOt0uO1HqmPol3JnaNkH/1zNviaIH/UHGYG9X+yHYVwGlwdD9FZ8o5qG5wjQ=
X-Received: by 2002:a17:906:7f84:: with SMTP id f4mr21383291ejr.525.1615317722613;
 Tue, 09 Mar 2021 11:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20210225194201.17001-1-noltari@gmail.com> <20210225194201.17001-3-noltari@gmail.com>
 <20210306211731.GA1217377@robh.at.kernel.org> <f60cc3a8-9629-3659-c3e5-4a42a588b63e@gmail.com>
In-Reply-To: <f60cc3a8-9629-3659-c3e5-4a42a588b63e@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Mar 2021 12:21:50 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLk5LWKarMxfnXhJ5VJZMvWEYnCnhP2qQ+LgOfUZALiyA@mail.gmail.com>
Message-ID: <CAL_JsqLk5LWKarMxfnXhJ5VJZMvWEYnCnhP2qQ+LgOfUZALiyA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mips: bmips: add BCM63268 timer reset definitions
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 7, 2021 at 3:08 AM =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gm=
ail.com> wrote:
>
> Hi Rob,
>
> El 06/03/2021 a las 22:17, Rob Herring escribi=C3=B3:
> > On Thu, Feb 25, 2021 at 08:41:59PM +0100, =C3=81lvaro Fern=C3=A1ndez Ro=
jas wrote:
> >> Add missing timer reset definitions for BCM63268.
> >>
> >> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> >> ---
> >>   include/dt-bindings/reset/bcm63268-reset.h | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-b=
indings/reset/bcm63268-reset.h
> >> index 6a6403a4c2d5..d87a7882782a 100644
> >> --- a/include/dt-bindings/reset/bcm63268-reset.h
> >> +++ b/include/dt-bindings/reset/bcm63268-reset.h
> >> @@ -23,4 +23,8 @@
> >>   #define BCM63268_RST_PCIE_HARD     17
> >>   #define BCM63268_RST_GPHY  18
> >>
> >> +#define BCM63268_TRST_SW    29
> >> +#define BCM63268_TRST_HW    30
> >> +#define BCM63268_TRST_POR   31
> >
> > Numbering should be local to the provider, so shouldn't this be 0-2?
> > Unless these numbers correspond to something in the h/w (bit positions
> > for example).
>
> Numbering corresponds to bit positions in the HW:

Okay, good.

Acked-by: Rob Herring <robh@kernel.org>
