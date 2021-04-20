Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27422365482
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhDTIsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhDTIsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:48:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7876D61027;
        Tue, 20 Apr 2021 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618908482;
        bh=f260+khxi9MZ5DGVsHjWtuxRuqw8oFO4BOQzbS1x+rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/4GMcboS3Qaf6IpCKpYDK+p/Ech95zihdFgi8Fn3Crv6RcIetjhtVTsmlS1Qw7xo
         8cs9bzVSWaw9jSQ/mb3MKnLptutvM+mPu3c5ONLkr9yaNlrmrWsuV3USeGidGluAp8
         H/bpFNEk5wC9zeySpuc9lF6e8Wv0DWtz7s1DmEJk=
Date:   Tue, 20 Apr 2021 10:47:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        tejas.patel@xilinx.com, amit.sunil.dhamne@xilinx.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chinnikishore369@gmail.com,
        git@xilinx.com
Subject: Re: [PATCH 5/5] misc: zynqmp: Add afi config driver
Message-ID: <YH6VPt6qfxdFhFEB@kroah.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-6-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420081153.17020-6-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:41:53PM +0530, Nava kishore Manne wrote:
> This patch adds zynqmp afi config driver.This is useful for
> the configuration of the PS-PL interface on Zynq US+ MPSoC
> platform.

Again, please spell out what those terms mean, as I have no idea :(

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/misc/Kconfig      | 11 ++++++
>  drivers/misc/Makefile     |  1 +
>  drivers/misc/zynqmp-afi.c | 83 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 drivers/misc/zynqmp-afi.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 877b43b3377d..d1ea1eeb3ac1 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -456,6 +456,17 @@ config ZYNQ_AFI
>  	  between PS and PL, the AXI port data path should be configured
>  	  with the proper Bus-width values
>  
> +config ZYNQMP_AFI
> +        tristate "Xilinx ZYNQMP AFI support"
> +        help
> +	  ZynqMP AFI driver support for writing to the AFI registers for
> +	  configuring PS_PL Bus-width. Xilinx Zynq US+ MPSoC connect the
> +	  PS to the programmable logic (PL) through the AXI port. This AXI
> +	  port helps to establish the data path between the PS and PL.
> +	  In-order to establish the proper communication path between
> +	  PS and PL, the AXI port data path should be configured with
> +	  the proper Bus-width values

Please use tabs properly, you mix them above, checkpatch should have
caught that.

thanks,

greg k-h
