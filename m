Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA945828B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 09:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhKUIrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 03:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231700AbhKUIrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 03:47:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E834C60249;
        Sun, 21 Nov 2021 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637484243;
        bh=tu69UPs2oFYdHGpPkYWSO++YLwvfUcLbBzuvXbiASYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5Er70nazIbKppLsd5F5Xp/QgKOjqOlEYkmYtQAD0y5OpCROq1qwnPjiUGqIeKcZ8
         QOO4vJmuckEkXlZuydebEuZRyTvuMW/b5mhCpIOGZhRcOOs5SqdyCDrsC6/r6zVqDo
         HmA0WVOq8M9ANGfm1YLgLfunPKpkDwXmEpFjzP4mPa2cifyRIpKUjJHgRxp0qqN8ge
         aAFZ/vP97Nfvl6V0Z1FDaRZ8/KstBjxPa4GYQSGNJoqsypN3TnKS0dMrrmiuh+agVj
         xVbs4DbIeG00oLvkMJiS3xFGdKExpFCqrfLyKaelKtxsdi4wbGSomDVWFP544XHxmf
         k7pa5d51aJc7Q==
Date:   Sun, 21 Nov 2021 16:43:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] arm: imx: remove dead left-over from
 i.MX{27,31,35} removal
Message-ID: <20211121083934.GK31998@dragon>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-8-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028141938.3530-8-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 04:19:32PM +0200, Lukas Bulwahn wrote:
> The commits:
> 
>   commit 879c0e5e0ac7 ("ARM: imx: Remove i.MX27 board files")
>   commit c93197b0041d ("ARM: imx: Remove i.MX31 board files")
>   commit e1324ece2af4 ("ARM: imx: Remove i.MX35 board files")
> 
> remove the config MACH_MX27_3DS, MACH_MX31_3DS and MACH_MX35_3DS.
> Commit a542fc18168c ("ARM: imx31: Remove remaining i.MX31 board code")
> further removes arch/arm/mach-imx/3ds_debugboard.{c,h}. So, only some
> dead left-over in Kconfig and Makefile remains.
> 
> Remove this remaining left-over.
> 
> This issue was identified with ./scripts/checkkconfigsymbols.py,
> which warns on references to the non-existing configs
> MACH_MX{27,31,35}_3DS in ./arch/arm/mach-imx/Kconfig.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied, thanks!
