Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D47350C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 03:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhDABtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 21:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231620AbhDABtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:49:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D91A6023F;
        Thu,  1 Apr 2021 01:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617241751;
        bh=gCKtgYFPiARAe74loKLPUu7HIWHnqcsMdjuZGyRocBA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fJN2TMVwNfe+WNkFSYew2AS8l7uTM6SSPDCBJas+3YKtb7lM4fnJefKvkWDJOeTRX
         ImAdnZ5rjfBMl7GbM5f1GJBG/qPTTlUWVaQRTY9/VKkwpcEr3y66y/6gt+T8q5BRYU
         qwpGgL+EnrJI0Gei82VT8pmtLXIrqpr1wmQtXzAF6S5L3zOcKW1ELdlBBZLb5qXFsf
         6SO6u6FhJJDne1Lgsg3TkTMR+C5BPYCCPI/9ZE53CjKjmuF0vbg1rWhdmNO1iYS14t
         NbIax6P7p0adMudcm9NV50Yu6a//oX6O3GmnAxCPQ0lAIlSJS0dqwpD4P7xYrUUew/
         J751LqP044Hwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210330121701.3258948-1-quanyang.wang@windriver.com>
References: <20210330121701.3258948-1-quanyang.wang@windriver.com>
Subject: Re: [V2] [PATCH] clk: zynqmp: pll: add set_pll_mode to check condition in zynqmp_pll_enable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        quanyang.wang@windriver.com
Date:   Wed, 31 Mar 2021 18:49:09 -0700
Message-ID: <161724174987.2260335.3629133210221429059@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting quanyang.wang@windriver.com (2021-03-30 05:17:01)
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
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---

Any Fixes tag?
