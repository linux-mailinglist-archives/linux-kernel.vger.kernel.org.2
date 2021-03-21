Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E25343493
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhCUUPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:15:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43624 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhCUUOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:14:40 -0400
Received: from p508fc3a3.dip0.t-ipconnect.de ([80.143.195.163] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lO4T7-0007Oi-UH; Sun, 21 Mar 2021 21:14:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, cmuellner@linux.com,
        finley.xiao@rock-chips.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: synchronize rk3399 opps with vendor kernel
Date:   Sun, 21 Mar 2021 21:14:31 +0100
Message-Id: <161635763247.767241.15196995855292324141.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225133322.3420724-1-heiko@sntech.de>
References: <20210225133322.3420724-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 14:33:20 +0100, Heiko Stuebner wrote:
> The vendor-kernel did increase the minimum voltage for some low frequency
> opps to 825mV citing stability reasons. So do that in mainline as well
> and also use the ranged notation the vendor-kernel switched to, to give
> a bit more flexibility for different regulator setups.

Applied, thanks!

[1/3] arm64: dts: rockchip: synchronize rk3399 opps with vendor kernel
      commit: 6daae8ff20b8e9d67c282ba37c63e1a7ee3c2206
[2/3] arm64: dts: rockchip: used range'd gpu opps on rk3399
      commit: 6d5989a36e60614e12949c6c2dac368b380bf2ca
[3/3] arm64: dts: rockchip: drop separate opp table on rk3399-puma
      commit: b417764daa2d7e1325fe926144ffcb4b2bbd8d25

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
