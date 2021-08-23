Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE43F5085
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhHWSnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:43:22 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54100 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhHWSnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:43:10 -0400
Received: from dynamic-046-114-139-102.46.114.pool.telefonica.de ([46.114.139.102] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mIEtr-0002Jl-Ei; Mon, 23 Aug 2021 20:42:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/1] arm64: dts: rockchip: add missing rockchip,grf property to rk356x
Date:   Mon, 23 Aug 2021 20:42:15 +0200
Message-Id: <162974163915.2977894.4550089121639046770.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210823123911.12095-1-michael.riesch@wolfvision.net>
References: <20210823123911.12095-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 14:39:10 +0200, Michael Riesch wrote:
> The following error messages appear on my RK3568 EVB1 board during boot:
> 
>   rockchip_clk_register_muxgrf: regmap not available
>   rockchip_clk_register_branches: failed to register clock clk_ddr1x: -524
> 
> These can be fixed by providing the missing rockchip,grf property to the
> device tree (similar to other Rockchip SoCs, such as the RK3399).
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add missing rockchip,grf property to rk356x
      commit: 7e0a31c49b5a1dc16540581d2a9cbe35da97c06c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
