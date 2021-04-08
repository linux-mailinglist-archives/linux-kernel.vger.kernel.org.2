Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC765357953
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 03:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhDHBJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 21:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDHBJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:09:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19AE16113A;
        Thu,  8 Apr 2021 01:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617844179;
        bh=f/xx+JASbd9ZTZFHDhgzyPHyCRkJ2KLQ0QZAD9UJK0I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YdL/cbZe3Q+0BzvpVCZX+E2SWw5m+0YzggStnEkEWU+gb/4Md9vaL705I42JJNYVh
         /M0rK5h8Tw63R/4w3AS1zIvIQjQ7bV8KYBSWJQKHCTOOfN2R1uLwJcqLoU59lMewr2
         CSsky2x/UYBtKZXzDECzTJbru9MjXLyfv+QtoKYzJGiTBh+wZoFi7+CLU/SR9pZJ5i
         lH9OuX9BT0/1TjQBAHzgmlzd8/HcPgVIdPkhkEDh4mdawmuqrRU1seCgYHGiC0iFJw
         1m9RotrR+ggjiHwolVVYzEKg9Tgm17er0gxw7cVqRHLxqvvMIprRRPnHnKxGagHPln
         sbQdizP1tEFCw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210406153131.601701-1-quanyang.wang@windriver.com>
References: <20210406153131.601701-1-quanyang.wang@windriver.com>
Subject: Re: [V3][PATCH] clk: zynqmp: pll: add set_pll_mode to check condition in zynqmp_pll_enable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        quanyang.wang@windriver.com
Date:   Wed, 07 Apr 2021 18:09:37 -0700
Message-ID: <161784417793.3790633.1172679818900674783@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting quanyang.wang@windriver.com (2021-04-06 08:31:31)
> From: Quanyang Wang <quanyang.wang@windriver.com>
>=20
> If there is a IOCTL_SET_PLL_FRAC_MODE request sent to ATF ever,
> we shouldn't skip invoking PM_CLOCK_ENABLE fn even though this
> pll has been enabled. In ATF implementation, it will only assign
> the mode to the variable (struct pm_pll *)pll->mode when handling
> IOCTL_SET_PLL_FRAC_MODE call. Invoking PM_CLOCK_ENABLE can force
> ATF send request to PWU to set the pll mode to PLL's register.
>=20
> There is a scenario that happens in enabling VPLL_INT(clk_id:96):
> 1) VPLL_INT has been enabled during booting.
> 2) A driver calls clk_set_rate and according to the rate, the VPLL_INT
>    should be set to FRAC mode. Then zynqmp_pll_set_mode is called
>    to pass IOCTL_SET_PLL_FRAC_MODE to ATF. Note that at this point
>    ATF just stores the mode to a variable.
> 3) This driver calls clk_prepare_enable and zynqmp_pll_enable is
>    called to try to enable VPLL_INT pll. Because of 1), the function
>    zynqmp_pll_enable just returns without doing anything after checking
>    that this pll has been enabled.
>=20
> In the scenario above, the pll mode of VPLL_INT will never be set
> successfully. So adding set_pll_mode to check condition to fix it.
>=20
> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---

Applied to clk-next
