Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89F3522B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhDAWSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:18:25 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:63918 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhDAWSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:18:24 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 1523916e;
        Fri, 2 Apr 2021 00:18:21 +0200 (CEST)
Date:   Fri, 2 Apr 2021 00:18:21 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
In-Reply-To: <20210401213652.14676-1-jbx6244@gmail.com> (message from Johan
        Jonker on Thu, 1 Apr 2021 23:36:48 +0200)
Subject: Re: [PATCH v6 0/4] convert rockchip,dwc3.txt to yaml
References: <20210401213652.14676-1-jbx6244@gmail.com>
Message-ID: <c1bced42d7388f34@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Johan Jonker <jbx6244@gmail.com>
> Date: Thu,  1 Apr 2021 23:36:48 +0200
> 
> The conversion of rockchip,dwc3.txt to yaml was added to linux-next,
> but the necessary changes for rk3399 are still pending.
> 
> For rk3399 dwc3 usb the wrapper node for only clocks makes no sense,
> so that was removed in the YAML example.
> 
> Now dtbs_check still generates notifications for the compatibility string in
> the dts files that doesn't match, because it changed from
> "rockchip,rk3399-dwc3" to "rockchip,rk3399-dwc3", "snps,dwc3".
> 
> The problem is to keep compatible with old device trees.
> I.e. a device running an older device tree should still work with newer
> kernels.
> 
> Comment by Rob in version 3:
> Presumably you are getting lucky here (with link order). The kernel
> has no logic to decide which driver to bind to if there are 2 matching
> drivers. If we did, it would probably be the opposite of what you want
> here as we'd pick the most specific match. This driver should probably
> bail probe if no dwc3 child node.
> 
> Please advise how to move forward with this serie.

As I tried to point out earlier, this kind of binding change is
unhelpful.  Yes, you now have extra code in future Linux kernels that
works around the problem.  But other consumers of device trees
(U-Boot, other OSes) will have to add similar code or keep using older
device trees.  And even then it will still cause frustration for users
that want to run older kernels.

I do understand that it is sometimes necessary to change device tree
bindings.  But changes like this one just cause a lot of pain without
a significant technical benefit.

Cheers,

Mark


> Changed V6:
>   rebase
>   remove accepted patches from serie
> 
> Changed V5:
>   add select
> 
> Changed V4:
>   removed patch "of-simple: add compatible for rk3328"
>   add patch "of-simple: bail probe if no dwc3 child node"
> 
> Changed V3:
>   remove aclk_usb3_rksoc_axi_perf
>   remove aclk_usb3
> 
> Changed V2:
>   remove node wrapper
> 
> Johan Jonker (3):
>   usb: dwc3: of-simple: bail probe if no dwc3 child node
>   arm64: dts: rockchip: restyle rk3399 usbdrd3_0 node
>   arm64: dts: rockchip: restyle rk3399 usbdrd3_1 node
> 
> Wu Liang feng (1):
>   arm64: dts: rockchip: optimize clks for rk3399 dwc3
> 
>  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts      |  4 +-
>  arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    | 12 +--
>  .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |  6 +-
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  6 +-
>  arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 12 +--
>  .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      | 12 +--
>  arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts  | 12 +--
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts |  2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |  8 --
>  arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts   | 12 +--
>  .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |  8 --
>  .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  4 -
>  arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  6 +-
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi    | 10 +--
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 12 +--
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dts    |  4 +-
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |  8 --
>  arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 12 +--
>  arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  | 12 +--
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 86 ++++++++--------------
>  .../boot/dts/rockchip/rk3399pro-vmarc-som.dtsi     |  4 -
>  drivers/usb/dwc3/dwc3-of-simple.c                  |  4 +
>  22 files changed, 59 insertions(+), 197 deletions(-)
> 
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
