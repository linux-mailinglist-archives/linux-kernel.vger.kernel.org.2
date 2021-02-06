Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B7311B4D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 06:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhBFFGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 00:06:22 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47342 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbhBFD61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:58:27 -0500
Received: from p508fdf7d.dip0.t-ipconnect.de ([80.143.223.125] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l8B78-00052x-Dn; Sat, 06 Feb 2021 01:06:14 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-clk@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH 1/5] clk: rockchip: add clock ids for PCLK_DPHYRX and PCLK_DPHYTX0 on rk3368
Date:   Sat,  6 Feb 2021 01:06:12 +0100
Message-Id: <161256995504.1897877.6561871784286411999.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205110502.1850669-1-heiko@sntech.de>
References: <20210205110502.1850669-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 12:04:58 +0100, Heiko Stuebner wrote:
> Needed by the mipi dphys.
> The naming follows the clock names in the manual.

Applied, thanks!

[1/5] clk: rockchip: add clock ids for PCLK_DPHYRX and PCLK_DPHYTX0 on rk3368
      commit: 0be10b6f68b217876665031f643e571a5661fc9c
[2/5] clk: rockchip: use clock ids for PCLK_DPHYRX and PCLK_DPHYTX0 on rk3368
      commit: fabb841c5b16721298cfe649b569a4fa40af28a6
[3/5] clk: rockchip: add clock id for SCLK_VIP_OUT on rk3368
      commit: 686458aa752362f86d881d7fa4576c9f175b2d9b
[4/5] clk: rockchip: use clock id for SCLK_VIP_OUT on rk3368
      commit: ed2243e0038b8afdd7726d117da34ee4577e11ad
[5/5] clk: rockchip: fix DPHY gate locations on rk3368
      commit: 4bc23b3c83c9a3fc0a7dd8f2f11f451aa92c85cd

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
