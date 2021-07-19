Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2193CEDF1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387330AbhGSUEI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jul 2021 16:04:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46516 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1386801AbhGSTjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:39:55 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m5ZkU-0000Ug-KN; Mon, 19 Jul 2021 22:20:22 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     =?ISO-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>, Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Xing Zheng <zhengxing@rock-chips.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: clk: Convert rockchip,rk3399-cru to DT schema
Date:   Mon, 19 Jul 2021 22:20:21 +0200
Message-ID: <5554453.PYKUYFuaPT@diego>
In-Reply-To: <CAL_JsqKoEwbfKz3s3OJJkk8izu2ak=dEhD2qjaw6Ad71Tb3_EA@mail.gmail.com>
References: <20210610175613.167601-1-nfraprado@collabora.com> <20210719195115.cgh7fh54kwloo4o7@notapiano> <CAL_JsqKoEwbfKz3s3OJJkk8izu2ak=dEhD2qjaw6Ad71Tb3_EA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 19. Juli 2021, 22:12:10 CEST schrieb Rob Herring:
> On Mon, Jul 19, 2021 at 1:51 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Thu, Jun 24, 2021 at 01:00:41PM -0600, Rob Herring wrote:
> > > On Thu, 10 Jun 2021 14:56:13 -0300, Nícolas F. R. A. Prado wrote:
> > > > Convert the rockchip,rk3399-cru binding to DT schema format.
> > > > Tested with
> > > > ARCH=arm64 make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> > > > ARCH=arm64 make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> > > >
> > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > ---
> > > >
> > > > One caveat is that this node expects certain external clocks, mainly 'xin24m'.
> > > >
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Thanks! Is this blocked on something else?
> 
> I'm expecting Stephen to pick this up.

actually I'm expecting me to pick this up ;-)

With the merge window closing last sunday I haven't made my
way that far down my inbox yet. I'll just fix that right now :-)

Heiko


