Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50268377967
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEIX4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:56:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55670 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhEIX4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:56:21 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lftGV-0007y6-Rg; Mon, 10 May 2021 01:55:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk3328: rock-pi-e: Drop fephy pinctrl from gmac2phy
Date:   Mon, 10 May 2021 01:55:10 +0200
Message-Id: <162060449717.1266480.17694664157569213328.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210426095916.14574-1-wens@kernel.org>
References: <20210426095916.14574-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 17:59:16 +0800, Chen-Yu Tsai wrote:
> Turns out the fephy pins are already claimed in the phy node, which is
> rightfully where they should be claimed.
> 
> Drop the pinctrl properties from the gmac2phy node for the ROCK Pi E.

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3328: rock-pi-e: Drop fephy pinctrl from gmac2phy
      commit: e6526f90696e6a7d722d04b958f15b97d6fd9ce6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
