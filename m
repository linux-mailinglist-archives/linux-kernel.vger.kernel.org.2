Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CE53B4130
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFYKOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFYKOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:14:04 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C8C061574;
        Fri, 25 Jun 2021 03:11:43 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1lwioD-0001cS-Mv; Fri, 25 Jun 2021 12:11:38 +0200
Date:   Fri, 25 Jun 2021 12:11:31 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Eric Woudstra <ericwouds@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: Re: Re: [PATCH] Fix mt7622.dtsi thermal cpu
Message-ID: <YNWr04QQD0tGuW6n@makrotopia.org>
References: <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
 <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
 <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
 <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
 <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
 <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
 <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
 <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66>
 <YNWgVxvNbwNcT3B8@makrotopia.org>
 <trinity-1a7ab0b7-d895-49ab-b3b9-3bf426889418-1624613519415@3c-app-gmx-bs66>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-1a7ab0b7-d895-49ab-b3b9-3bf426889418-1624613519415@3c-app-gmx-bs66>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Fri, Jun 25, 2021 at 11:31:59AM +0200, Frank Wunderlich wrote:
> > Gesendet: Freitag, 25. Juni 2021 um 11:22 Uhr
> > Von: "Daniel Golle" <daniel@makrotopia.org>
> 
> > On Fri, Jun 25, 2021 at 10:16:43AM +0200, Frank Wunderlich wrote:
> > > Daniel from openwrt have some other mt7622 Boards maybe he can test the Fan approach below
> >
> > I got Linksys E8450 aka. Belkin RT3200 ( https://fcc.io/K7S-03571 ) as
> > well as Ubiquiti UniFi 6 LR ( https://fcc.io/SWX-U6LR ). Both got quite
> > massive customized heatsinks (see internal photos on FCC submission),
> > which results in much better heat dissipation than just having the
> > naked chip like on the BPi-R64.
> > Hence I also can't test the fan approach on boards other than the R64.
> 
> Do your both mt7622 boards miss the fan-socket or is it not connected to pwm3? then we need to move the fan-parts to mt7622-bananapi-r64.dts instead of mt7622.dtsi

There is no fan intended on both devices.
E8450 has an unknown connector which **could** be for a fan, but I
never tried if and how it is actually connected to the SoC.
It could as well be an additional USB 2.0 (as it got 4 pins).

Hence I suggest to add the fan on PWM3 for the BPi-R64 only for now.


Cheers


Daniel
