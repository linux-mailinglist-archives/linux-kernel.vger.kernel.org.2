Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950493733B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 04:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhEECOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 22:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhEECOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 22:14:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2370E613CB;
        Wed,  5 May 2021 02:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620180835;
        bh=MS/d4ZN0JnYDku5sm2cm+kvbugSMciKF/8ZcDFMH82Y=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=ZTnAKba9HzNnwk/31MfKNoaJVhv9kXxI+4ipPLwhN65rWvH7x8Tbb3SOk1Q6wSvn5
         ApTZEuZ2feffM3TKjYyjSQxuf/cXBDTHvnCMO5XxLfVhgxRM1yBN1Dp+XbIXdkMlMW
         l+Re2zb8TtcfIks0DxhmwlGvBYHpmI8rBVhDa4I24kXTRX1vZTHEXJUcnK3+AEbUb3
         bk5PW/PZfnc7moTPKZz8ePuR4jGV5gBf2yN2GvUbqaea92sNfDc9LaDI1C8dIyWOs2
         G5w+cdq0CGEbxGwUlN10Fmtxzgx/1sB9bmnAfaIemts00rhcBh5/NVkmsxyjVOf3/Z
         4ShMLcH6t2olA==
Received: by mail-lf1-f51.google.com with SMTP id 124so369250lff.5;
        Tue, 04 May 2021 19:13:55 -0700 (PDT)
X-Gm-Message-State: AOAM531iZJ45udqw+dce+kVu7ImvFt/cZBW80hSgbpslfKbeQ9/coUPP
        zAuLrtvB+QrzNpjKIC986uV8QZZIccYW9jR5EIw=
X-Google-Smtp-Source: ABdhPJw70gAAhcuwtjzZMCSy1Meu3USnDN3fd80aidrCUZR9Mm/KKzuSfSLYwDIbq80gQA55kyu++poc26ICP6AbXD8=
X-Received: by 2002:ac2:5f72:: with SMTP id c18mr66079lfc.233.1620180833466;
 Tue, 04 May 2021 19:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210504041659.22495-1-wens@kernel.org> <CAFBinCBZa-OjjLE0oaNQzAL+tGTkiC_Kf+iHR1H3K5-b+uFK0w@mail.gmail.com>
In-Reply-To: <CAFBinCBZa-OjjLE0oaNQzAL+tGTkiC_Kf+iHR1H3K5-b+uFK0w@mail.gmail.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Wed, 5 May 2021 10:13:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v670njcGHvcYCVARgVMrvK5gx=Ua-eew=Gvhxo4bYk8zjg@mail.gmail.com>
Message-ID: <CAGb2v670njcGHvcYCVARgVMrvK5gx=Ua-eew=Gvhxo4bYk8zjg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: meson-gxbb: nanopi-k2: Enable Bluetooth
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 4:52 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi,
>
> On Tue, May 4, 2021 at 6:17 AM Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The NanoPi K2 has a AP6212 WiFi+BT combo module. The WiFi portion is
> > already enabled. The BT part is connected via UART and I2S.
> >
> > Enable the UART and add a device node describing the Bluetooth portion
> > of the module.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > Changes since v1:
> >   - added uart-has-rtscts property
> >   - added alias for uart_A
> >
> > Hi Neil, Martin,
> >
> > I dropped your review-bys since I added the UART alias and I'm not sure
> > what the policy for those are.
> >
> > ChenYu
> > ---
> >  .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> > index 7273eed5292c..f017a263784f 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
> > @@ -15,6 +15,7 @@ / {
> >
> >         aliases {
> >                 serial0 = &uart_AO;
> > +               serial1 = &uart_A;
> this should not be needed anymore since
> a26988e8fef4b258d1b771e0f4b2e3b67cb2e044 ("tty: serial: meson: if no
> alias specified use an available id")
>
> IIRC for "newly added" .dts we are only adding the alias for anything
> that shows up in /dev/ for the user
> meson-khadas-vim3.dtsi for example is not adding an alias for uart_A
> (also used for Bluetooth)

I see. So if some user had a customized .dts enabling more UARTs, they
would probably have the user visible ones aliased, and the Bluetooth
one would be in the reserved range regardless.

I'll drop the extra alias then.

Thanks
ChenYu
