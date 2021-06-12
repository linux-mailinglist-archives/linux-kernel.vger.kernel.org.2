Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45443A4CA0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 06:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFLEYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 00:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLEYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 00:24:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EEB461181;
        Sat, 12 Jun 2021 04:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623471762;
        bh=lnCa+yYE/iEKMnRDCnwj7d8xjKl/wBPeaXerKKyZF4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raaw7QfqG7DnQA/2sB9s4SmxVF7Ik5XPCz4ZkzC9bEfDkwlUGS8JKyFR9tyuiptmD
         qdu7Hy16obokcfRYdTZNo5c6YiIOSoVKkxSsBqV8AH54R3ugI8wRkkJFtG/OVGBSrg
         q98TzzWSg6IWvnriuAred3kqt8JYXBfPtvaFaxklwDMD5tiq0VkP5/WPBv72jrd00j
         iOAgcDV+/Sl794yCxTUYNkV5ye/DBtoPv2ki/++692dQ2YmTjNCPdJh9RTewTuuZk/
         iWeqVyJ4fPnUOLDTj9uZKZBcZIikvBnQXCKhJGCJ149tK+xYEb24kAtLIGb8EA5zwQ
         old/+CK31LusQ==
Date:   Sat, 12 Jun 2021 12:22:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 0/3] Support for GE B1x5v2 and B1x5Pv2
Message-ID: <20210612042236.GU29138@dragon>
References: <20210526152243.51059-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526152243.51059-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 05:22:40PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> This series adds support for another General Electric patient
> monitor series (similar to existing Bx50v3), which is based on
> i.MX6DL using Congatec's QMX6 module.
> 
> This series has a runtime dependency on two commits, that have
> already been merged to linux-next:
> 
> 1. Any imx6dl-qmx6 based boards without f765e349c3e1 ("rtc: m41t80:
>    add support for fixed clock") and CONFIG_RTC_DRV_M41T80 enabled
>    will result in unstable system. Because the kernel will disable
>    one of the CPU clocks.
> 
> 2. Booting B155(P)v2 additionally requires 94dfec48fca7 ("drm/imx:
>    Add 8 pixel alignment fix") to avoid boot hanging indefinitely.
> 
> Changes since PATCHv2:
>  * https://lore.kernel.org/lkml/20210428222953.235280-1-sebastian.reichel@collabora.com/
>  * Add Acked-by from Rob Herring to patch DT binding patches
>  * Drop RTC and DRM patch (applied)
>  * order DT Makefile entries alphabetically
>  * order DT nodes alphabetically
>  * Remove a couple of superfluous status = 'okay';
>  * Move compatible property to start of nodes
>  * Move status property to end of nodes (but before sub-nodes)
>  * Drop useless fsl,spi-num-chipselects property
>  * Update pinctrl config for audio pins fixing noise issue affecting some boards
>  * rebased to v5.13-rc1
> 
> Changes since PATCHv1:
>  * https://lore.kernel.org/lkml/20210222171247.97609-1-sebastian.reichel@collabora.com/
>  * drop patch 5 (applied)
>  * instead of using 'protected-clocks' in RTC node, add fixed-clock
>    node as suggested by Saravana Kannan
>  * rebased to current master (68a32ba14177)
> 
> Thanks,
> 
> -- Sebastian
> 
> Sebastian Reichel (3):
>   dt-bindings: vendor-prefixes: add congatec
>   dt-bindings: arm: fsl: add GE B1x5pv2 boards
>   ARM: dts: imx6: Add GE B1x5v2

Applied all, thanks.
