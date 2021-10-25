Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B43439001
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhJYHJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230059AbhJYHJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:09:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C101460F6F;
        Mon, 25 Oct 2021 07:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635145616;
        bh=5Q4aeYKi7bwUBr+sTkOgfJdsuo2f2X2m6DU4ecUe6xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1Hn7zvOkNB49RWQq+6GHb8R1nl5v0i8PZZQ89qMs4syvklBKlL/B2M6dyPPSRPdD
         SxTA6cqHDTkL7ev+aP6uKiEzRxu/Vwzz5ECgpQA2/+TN8Z0owGfT7zXG52VnNwhvbA
         TkZuve11F+tH6/huM03e1qpHeVxqR2173M3NeCRm8ETqDsnmUP8IKtcw/4nje29FEz
         mlea3AUpeqYhaejEWZUDS3uqaxxc9Sfs9yrz1rtgYq28qT9Z5ius4Gulhzyg1gfP1w
         3drlEEYxaKOibJY70yFbXmI4s7Jv6EOl/+kfFdHSwyM8xsMxtsofr+QPURQoVTBqnc
         uGfOBv1ehTfcQ==
Date:   Mon, 25 Oct 2021 12:36:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        "Kishon Vijay Abraham, I" <kishon@ti.com>, p.zabel@pengutronix.de
Subject: Re: [PATCH v2 2/3] phy/rockchip: add naneng combo phy for RK3568
Message-ID: <YXZXjGG1qpHCgdHc@matsya>
References: <20211013101938.28061-1-yifeng.zhao@rock-chips.com>
 <20211013101938.28061-3-yifeng.zhao@rock-chips.com>
 <YXKXULdyPuv1BirB@matsya>
 <CAMdYzYqJs_uT1DT9EFydAmWCoRuizkA==HoMW8VTd68dg0hQ2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYqJs_uT1DT9EFydAmWCoRuizkA==HoMW8VTd68dg0hQ2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-21, 07:26, Peter Geis wrote:
> On Fri, Oct 22, 2021 at 6:51 AM Vinod Koul <vkoul@kernel.org> wrote:
> > On 13-10-21, 18:19, Yifeng Zhao wrote:

> > > +#define RK3568_T22_PHYREG6           (0x6 << 2)
> > > +#define T22_PHYREG6_TX_RTERM_MASK    GENMASK(7, 4)
> > > +#define T22_PHYREG6_TX_RTERM_SHIFT   4
> > > +#define T22_PHYREG6_TX_RTERM_50OHM   0x8
> > > +#define T22_PHYREG6_RX_RTERM_MASK    GENMASK(3, 0)
> > > +#define T22_PHYREG6_RX_RTERM_SHIFT   0
> > > +#define T22_PHYREG6_RX_RTERM_44OHM   0xF
> > > +
> > > +#define RK3568_T22_PHYREG7           (0x7 << 2)
> >
> > Pls use GENMASK for these?
> >
> > > +#define T22_PHYREG7_SSC_EN           BIT(4)
> > > +
> > > +#define RK3568_T22_PHYREG10          (0xA << 2)
> > > +#define T22_PHYREG10_SU_TRIM_0_7     0xF0
> > > +
> > > +#define RK3568_T22_PHYREG11          (0xB << 2)
> > > +#define T22_PHYREG11_PLL_LPF_ADJ     0x4
> > > +
> > > +#define RK3568_T22_PHYREG12          (0xC << 2)
> > > +#define T22_PHYREG12_RESISTER_MASK   GENMASK(5, 4)
> > > +#define T22_PHYREG12_RESISTER_SHIFT  0x4
> >
> > bitfield.h has nice helpers which can extract/program values and avoid
> > one to define these shifts
> 
> They aren't values, they are registers.

Yes!

> This is a remnant from the downstream driver's attempt at obfuscating
> the register it's touching.
> Please define these correctly.

The point of bitfield.h is one defines register bit fields using
BIT/GENMASK, no need to define SHIFT etc and use the helpers to
extract/program values and avoid defining these shifts etc!

-- 
~Vinod
