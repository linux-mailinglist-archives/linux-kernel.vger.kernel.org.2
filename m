Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CEA34C14A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhC2BwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhC2Bv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:51:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFEEB61941;
        Mon, 29 Mar 2021 01:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616982715;
        bh=U0Y5HEp4vLgEt3OrK0G+AlzV4k+/QymqO4rrPYmLDWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dT20VNVeUoj8H3ChZPXZla+P99WfnHv8Mnzy2scGz5waqBEfSy+U6dS4xFIjkgZBv
         mUtVCce8MHgk0yjq23piVjgyicmtuPZhWZBPQU+0UyD3C1l4BksxhkKYY7yOk2+L4n
         t0d+A2RlrWVAr2yH8iSFLpN2iv0r690Fe/0D2Me2tAwcFV2JqyaB0RNp7JlOxr+yXP
         vpKN5E9MmoNk0HuUbft0UATSY1FhXAO6qfGe7KH+OhGREhjgJvTkHGXMBBjl6Bq9Dw
         wv4dLzGz03UVgAsdM0kgklMdjqhMEPo1k80R9W+AAejxvYsO2f5zOI2wpwX5BQKzCK
         1xOBcDX50CuTQ==
Date:   Mon, 29 Mar 2021 09:51:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: pass phy reset
 delays
Message-ID: <20210329015149.GL22955@dragon>
References: <20210323140019.14388-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323140019.14388-1-heiko.thiery@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 03:00:21PM +0100, Heiko Thiery wrote:
> The TI DP83867 PHY datasheet says:
> T1: Post RESET stabilization time == 195us
> T3: Hardware configuration pins transition to output drivers == 64us
> T4: RESET pulse width == 1us
> 
> So with a little overhead set 'reset-assert-us' to 10us (T4) and
> 'reset-deassert-us' to 280us (T1+T3).
> 
> Without these reset delays the board will hang during startup when
> bootargs has ip=dhcp set.
> 
> Fixes: 1dc7f3d79a1a ("arm64: dts: fsl: add support for Kontron pitx-imx8m board")
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
> v2:
>  - add desciption what issue will be fixed
>  - add Fixes tag

My branch is not a stable one, so I just squashed it into the original
commit.

Shawn
