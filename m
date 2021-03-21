Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E715343496
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhCUUPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:15:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43654 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhCUUOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:14:42 -0400
Received: from p508fc3a3.dip0.t-ipconnect.de ([80.143.195.163] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lO4T8-0007Oi-VT; Sun, 21 Mar 2021 21:14:39 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     sboyd@kernel.org, Elaine Zhang <zhangqing@rock-chips.com>,
        robh+dt@kernel.org, mturquette@baylibre.com
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, cl@rock-chips.com,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/4] clk: rockchip: add clock controller for rk3568
Date:   Sun, 21 Mar 2021 21:14:35 +0100
Message-Id: <161635763247.767241.10092028864316275030.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210315085608.16010-1-zhangqing@rock-chips.com>
References: <20210315085608.16010-1-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 16:56:04 +0800, Elaine Zhang wrote:
> Add the clock tree definition for the new rk3568 SoC.
> 
> Change in V5:
> [PATCH v5 1/4]: No change.
> [PATCH v5 2/4]: No change.
> [PATCH v5 3/4]: fix up the warning:
> 		>> drivers/clk/rockchip/clk-rk3188.c:187:67: warning:
> 		>> missing braces around initializer [-Wmissing-braces]
> 		187 | static const struct rockchip_cpuclk_reg_data
> 		rk3188_cpuclk_data = {
> [PATCH v5 4/4]: No change.
> 
> [...]

Applied, thanks!

[1/4] dt-binding: clock: Document rockchip, rk3568-cru bindings
      commit: 0cd74eec54a3ec34416bab6cc640a88230472078
[2/4] clk: rockchip: add dt-binding header for rk3568
      commit: 0865517926660309b796bd9bd5ba6671704733bc
[3/4] clk: rockchip: support more core div setting
      commit: a3561e77cf3ca0937227ba13744d84fc46e5eb4b
[4/4] clk: rockchip: add clock controller for rk3568
      commit: cf911d89c4c5e225a2a2cfadf1364838154b2202

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
