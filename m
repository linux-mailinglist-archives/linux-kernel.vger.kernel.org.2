Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DDD420CEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhJDNKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235498AbhJDNIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:08:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D20A61425;
        Mon,  4 Oct 2021 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633352543;
        bh=VtcPaXR9dkDp4NIqjnvCK/gI/LxrXMTSniLXLU0DfHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrFZXdCNyZhqZt+0afA1Gx/mx7HB6ERk5cuD+2B3evuK+Z558+QXtpt9dTZ+LDAmI
         UyFmhvyJgPDbdZYsW/BBAkoxaovGIaU21efU2k0C+ET0m1BKFprHaU7zWnCjs/XCvP
         f9Y3G8leu0tSglFS19ydfOB8qlHEEAdU/hsnyPH+I9gPMJzOMM+ZQT0nZPzzUy0ahr
         5LIt9K2kGN0xtkWmX1E/yYEMsylCt17zshVeb0CkHDUmKEPrsmWkUC5luewRqwSmo8
         mXgKoWidg1Ouwm95506dJBpfbWoNM6ksNLEbtUYLEqSMDnvuM7UKDwBcYGxxzCl9o5
         jFRI9y3jbKXoA==
Date:   Mon, 4 Oct 2021 21:02:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH 0/7] arm64: dts: ls1028: GPU support and cleanups
Message-ID: <20211004130218.GJ15650@dragon>
References: <20210831134013.1625527-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831134013.1625527-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 03:40:06PM +0200, Michael Walle wrote:
> In an attempt to unify u-boot's and linux' device tree for the LS1028A SoC
> we first need to clean up some network related stuff. Vladimir suggested to
> move the Ethernet PHYs into the MDIO controller node, which is already the
> case for u-boot's device tree. Further we unify the use of phy-mode and
> phy-connection-type. Both have the same meaning, but phy-mode is used more
> often in the kernel and for the ls1028a both were used. Replace
> phy-connection-type with phy-mode.
> 
> Further move all the nodes which belongs to the CCSR into the /soc node.
> These are the Mali display conntroller and its associated pixel clock PLL.
> Finally, add the GPU node for the etnaviv driver under /soc.
> 
> Michael Walle (7):
>   arm64: dts: ls1028a: move pixel clock pll into /soc
>   arm64: dts: ls1028a: move Mali DP500 node into /soc
>   arm64: dts: ls1028a: add Vivante GPU node
>   arm64: dts: freescale: fix arm,sp805 compatible string
>   arm64: dts: ls1028a: disable usb controller by default
>   arm64: dts: ls1028a: move PHY nodes to MDIO controller
>   arm64: dts: ls1028a: use phy-mode instead of phy-connection-type

Applied all, except #4 which had been picked up separately.

Shawn
