Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA193D9443
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhG1RZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhG1RZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10B3061037;
        Wed, 28 Jul 2021 17:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627493140;
        bh=LOPa9M/VXLESqMP09wMrmR6ALvHacP6UNwwzwnDINFo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nKbnqqp7ZAL1TVU2KCxlMI0NE963f7igidLLFS54z9dWN91j7Ao5CQuouUHBqHl+g
         dcCAZiIM9aFkGdraEMQt3hhUCMOEgfKMNRIoky6FMxnE649cPuDK6bWfWDEVGarh9T
         FxFNSY5syj2f6ZruMOO1DLMGeDNpnypBzwP8XLuSsdWAZs1u8KJZTGNlOmMkIMZvM7
         zm5vUf6Aa/0MGK9fr5zCGO3K/lbs0w/G/ucNmvsz7JI/kKz7gLFWCQVHKmo4IJ7R9F
         +VuTBuQMxDL3G1VGL2SyJiQfd6JlsAaynGvHnnNYJdNn6XaMy2mvVku7PpBNgl0ZBH
         Q4+FWgtC1mARg==
Received: by mail-ej1-f48.google.com with SMTP id e19so5798805ejs.9;
        Wed, 28 Jul 2021 10:25:39 -0700 (PDT)
X-Gm-Message-State: AOAM530b2GOiAV5Xtz5Owsi/p+lgMCXO1Nl/iVXQSLFWcKCSa91+W1Ry
        zhHv9dRXO6EGvc6RSstys/v1dOaf70ozX354pQ==
X-Google-Smtp-Source: ABdhPJwjV6JnpxeDQO/A1R1Vv9Ly6bfQZtLChu6Kyy9z+4HlfXjFG80f0I7SA2bQNHDFom/M3452cC52BHRDuhUNS+s=
X-Received: by 2002:a17:906:af7c:: with SMTP id os28mr507805ejb.341.1627493138663;
 Wed, 28 Jul 2021 10:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210710151034.32857-1-pgwipeout@gmail.com> <20210710151034.32857-5-pgwipeout@gmail.com>
 <20210715162131.GA1184545@robh.at.kernel.org> <CAMdYzYpXNdmHKBOOgC6DL-_7qrZyifnDPB=WuU0vAY8qPj1_ww@mail.gmail.com>
In-Reply-To: <CAMdYzYpXNdmHKBOOgC6DL-_7qrZyifnDPB=WuU0vAY8qPj1_ww@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Jul 2021 11:25:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJxutcEjDC6Fv1BTnsx6PqL1Th3hNfEOt+WeR8=cgK9ow@mail.gmail.com>
Message-ID: <CAL_JsqJxutcEjDC6Fv1BTnsx6PqL1Th3hNfEOt+WeR8=cgK9ow@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] arm64: dts: rockchip: add basic dts for Pine64 Quartz64-A
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Liang Chen <cl@rock-chips.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:19 AM Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Thu, Jul 15, 2021 at 12:21 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, 10 Jul 2021 11:10:34 -0400, Peter Geis wrote:
> > > Add a basic dts for the Pine64 Quartz64 Model A Single Board Computer.
> > > This board outputs on uart2 for debug.
> > >
> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > ---
> > >  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
> > >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> > >  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 321 ++++++++++++++++++
> > >  3 files changed, 327 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > >
> >
> > Acked-by: Rob Herring <robh@kernel.org>
>
> Thank you!
> I need to split the dt-bindings out into a separate patch, and the
> quartz64-a dts has some mild changes.
> Are you okay with me using your ack still?

Yes.

Rob
