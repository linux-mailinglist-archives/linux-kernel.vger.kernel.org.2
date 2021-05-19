Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C738925E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354553AbhESPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354390AbhESPTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:19:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DC95611B0;
        Wed, 19 May 2021 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621437478;
        bh=c+IEVTunFe30w7ogB/IAN3huK2t9VfW9QwLl3VpCa08=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nf1qUo57ru5boOQUeQi6aZRa+idhytrYYWQBsMIh0N76Pv9ZELRHmFnK01Xu3q2/6
         MB6JrKgYdO2D6etejTV1zfK2BJmiS0XNkSz2f+HfWQmH2lc004fqqNkgn/vpcdAAgF
         qepnKyQZPQrUSk13bwr0+u054K1h6PZmnGuo+Zh2zkmzPOyNdGSEqBqg902bo/Q+o4
         +TjRt4gILLbdY/OhH1m8VuoRdoR2ZPzdN4r+RvOkNFWEI0NU/nEU0s2OEREzaEpSNC
         2qBgU0xveUp1R6FzjaCn1u/o4wsne77m8hqm0me9Lp/9gtqqAFkMe4fq13pICszSsR
         tKh4WJyfdSrlw==
Received: by mail-ed1-f51.google.com with SMTP id h16so15810444edr.6;
        Wed, 19 May 2021 08:17:58 -0700 (PDT)
X-Gm-Message-State: AOAM531Ghrsi5XUJwgjKacreSvjGsN5AlzLL+Zcbf/w9fnzuxAyXSRb8
        cMVFk1dZKvxA9eDGxtvTDqeMChxNtRs/+aLeHQ==
X-Google-Smtp-Source: ABdhPJwOYwVtRLx9sKZdict2H1FAMFQvZK2Ew7pbG3fTyjBtHO+tC9tIIgY6UaUnSE+9VfiPaZ5PHom5bkNsTthHsFs=
X-Received: by 2002:a05:6402:124b:: with SMTP id l11mr15226813edw.137.1621437476871;
 Wed, 19 May 2021 08:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210512122346.9463-1-jbx6244@gmail.com> <162101023435.2009214.882597722137585064.b4-ty@sntech.de>
In-Reply-To: <162101023435.2009214.882597722137585064.b4-ty@sntech.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 19 May 2021 10:17:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLbumF-x8yAO2C5wTG5cDpVmgFdqADrEDguQ-ZidMj25g@mail.gmail.com>
Message-ID: <CAL_JsqLbumF-x8yAO2C5wTG5cDpVmgFdqADrEDguQ-ZidMj25g@mail.gmail.com>
Subject: Re: (subset) [PATCH v5 0/4] convert grf.txt to YAML
To:     Heiko Stuebner <heiko@sntech.de>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:37 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> On Wed, 12 May 2021 14:23:42 +0200, Johan Jonker wrote:
> > Changed V5:
> >   changed compatibles for rk3066/rk3188
> >   add rockchip-usb-phy.yaml
> >   move and restyle grf nodes rk3066/rk3188
> >   remove applied patches
> >
> > Changed V4:
> >   revert separate schemas for each 'if' subset
> >   add additionalProperties
> >   move properties to top level
> >
> > [...]
>
> Applied, thanks!
>
> [2/4] dt-bindings: soc: rockchip: convert grf.txt to YAML
>       commit: f2ffa8f9e32d38f5c37e3c61c5b02d434057f3db

Patch 1 is a dependency of this, so now linux-next is broken.

> [3/4] ARM: dts: rockchip: move and restyle grf nodes rk3066/rk3188
>       commit: a082a4ba218457fd52256e4357184b58d3fcaa49
> [4/4] arm64: dts: rename grf-gpio nodename in rk3328.dtsi
>       commit: 19486fe587b8ed17daf87a6419b51e3a65ce565c
>
> Best regards,
> --
> Heiko Stuebner <heiko@sntech.de>
