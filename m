Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000893899BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhESXUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:20:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40068 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhESXUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:20:18 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ljVSo-0003K0-IG; Thu, 20 May 2021 01:18:54 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-phy@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Vinod <vkoul@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>,
        Liang Chen <cl@rock-chips.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tao Huang <huangtao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: Re: (subset) [PATCH v5 0/4] convert grf.txt to YAML
Date:   Thu, 20 May 2021 01:18:53 +0200
Message-ID: <3206265.usfYGdeWWP@diego>
In-Reply-To: <CAL_JsqLbumF-x8yAO2C5wTG5cDpVmgFdqADrEDguQ-ZidMj25g@mail.gmail.com>
References: <20210512122346.9463-1-jbx6244@gmail.com> <162101023435.2009214.882597722137585064.b4-ty@sntech.de> <CAL_JsqLbumF-x8yAO2C5wTG5cDpVmgFdqADrEDguQ-ZidMj25g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 19. Mai 2021, 17:17:44 CEST schrieb Rob Herring:
> On Fri, May 14, 2021 at 11:37 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > On Wed, 12 May 2021 14:23:42 +0200, Johan Jonker wrote:
> > > Changed V5:
> > >   changed compatibles for rk3066/rk3188
> > >   add rockchip-usb-phy.yaml
> > >   move and restyle grf nodes rk3066/rk3188
> > >   remove applied patches
> > >
> > > Changed V4:
> > >   revert separate schemas for each 'if' subset
> > >   add additionalProperties
> > >   move properties to top level
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [2/4] dt-bindings: soc: rockchip: convert grf.txt to YAML
> >       commit: f2ffa8f9e32d38f5c37e3c61c5b02d434057f3db
> 
> Patch 1 is a dependency of this, so now linux-next is broken.

dang ... I've dropped the patch and recreated the for-next
branch, so hopefully this will go away with the next run.

I'll reapply it once the phy-yaml gets applied.

Sorry the breakage
Heiko

> 
> > [3/4] ARM: dts: rockchip: move and restyle grf nodes rk3066/rk3188
> >       commit: a082a4ba218457fd52256e4357184b58d3fcaa49
> > [4/4] arm64: dts: rename grf-gpio nodename in rk3328.dtsi
> >       commit: 19486fe587b8ed17daf87a6419b51e3a65ce565c
> >
> > Best regards,
> > --
> > Heiko Stuebner <heiko@sntech.de>
> 




