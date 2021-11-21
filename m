Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF2458291
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhKUIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 03:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhKUIvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 03:51:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEF77604E9;
        Sun, 21 Nov 2021 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637484475;
        bh=20XWGXDXt0xLnm20lfPVNEqqgyIOtI9+pXelANfkry8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqkMtTwzSJSUSdW++3F9TFCRxJqtUNmtF4rMCJYgZ6NJdY+Bos7IeEGXmehFl5gRa
         T8CIIhrykRUx5XeYRgrXjsqtKGNlqJpnrOupWWoNkaUTEfhZ+kHKIRxcK32pmhMDBi
         Slh10npqFDvxesCZlLk6Hb4y44g12EMHJGM9cxBYc5kJ5H6nxCt/97nxSJGbX9OYAX
         sznGFzhXkucARtetkTFNpN9tbF0+5Bgpo4uXbesHmdNokmwHD0HPpnL5xUQu+o2/yu
         L25IbCIoSPL/fvgBJHJnbZjzID/9WflRyZ60oHVXaFiZi7bLMBMxItnMDJrNappD4K
         AKGd+VcL4QhuA==
Date:   Sun, 21 Nov 2021 16:47:47 +0800
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
Subject: Re: [PATCH 08/13] arm: imx: rename DEBUG_IMX21_IMX27_UART to
 DEBUG_IMX27_UART
Message-ID: <20211121084541.GL31998@dragon>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-9-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028141938.3530-9-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 04:19:33PM +0200, Lukas Bulwahn wrote:
> Since commit 4b563a066611 ("ARM: imx: Remove imx21 support"), the config
> DEBUG_IMX21_IMX27_UART is really only debug support for IMX27.
> 
> So, rename this option to DEBUG_IMX27_UART and adjust dependencies in
> Kconfig and rename the definitions to IMX27 as further clean-up.
> 
> This issue was discovered with ./scripts/checkkconfigsymbols.py, which
> reported that DEBUG_IMX21_IMX27_UART depends on the non-existing config
> SOC_IMX21.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied, thanks!
