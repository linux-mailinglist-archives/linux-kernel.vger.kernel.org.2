Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB73A421CDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 05:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhJEDZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 23:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJEDZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 23:25:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E266E61354;
        Tue,  5 Oct 2021 03:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633404214;
        bh=N9qJny+X7eZ/NTqj1t+bABu+tmAErSvLKBYAn7VeLqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGtJqLWFaVTCdVADszAvxcJhDRCbNfNMsNthRTGLf4mNsFuvEGgspkVLi7ckALiMT
         4e8I3vRV5HOuhgeFcRzeISsMr25xuNICL056Sxz3kpGD6qBjXNzN3s1Um/3coDtf80
         eOVR4eXKD5kTBkUD3qgSogckrVktuIRTMlGU1kovBqowIJbGGb2kI8cGNzBe/VIQ48
         DZcUDlnTDmzJxrykmSmsOHkYJD8X+gtANf6gBqwYUhHmnLRyV7kEvgsNFtFSMTqKGX
         cI1Z3bp86B+3GFULB1Xj0On6Pycy6uixsMzEoIEsziosoZaRSk7gmFKoIbCoCDf/gf
         02OoUXiuNg2AQ==
Date:   Tue, 5 Oct 2021 11:23:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] ARM: imx_v6_v7_defconfig: rebuild default
 configuration
Message-ID: <20211005032328.GC20743@dragon>
References: <20210920144938.314588-1-marcel@ziswiler.com>
 <20210920144938.314588-5-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920144938.314588-5-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:49:33PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Run "make imx_v6_v7_defconfig; make savedefconfig" to rebuild
> imx_v6_v7_defconfig.
> 
> This dropped the following nowadays obsolete configuration options:
> 
> CONFIG_MTD_M25P80=y (got integrated into MTD_SPI_NOR)
> CONFIG_CS89x0=y (selected by CS89x0_PLATFORM)
> CONFIG_SMSC_PHY=y (selected by USB_NET_SMSC95XX)
> CONFIG_GPIO_MC9S08DZ60=y (depends on MACH_MX35_3DS)
> CONFIG_REGULATOR=y (selected by various stuff)
> CONFIG_MEDIA_CAMERA_SUPPORT=y (defaults to on if MEDIA_CAMERA)
> CONFIG_MEDIA_CONTROLLER=y (selected by various stuff)
> CONFIG_VIDEO_V4L2_SUBDEV_API=y (selected by various stuff)
> CONFIG_SND_SOC_PHYCORE_AC97=y
> CONFIG_SND_SOC_IMX_MC13783=y
> CONFIG_USB_EHCI_MXC=y
> CONFIG_USB_FSL_USB2=y
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks!
