Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F074A35B6A5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhDKSz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 14:55:29 -0400
Received: from gloria.sntech.de ([185.11.138.130]:42390 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235261AbhDKSz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 14:55:28 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lVfEk-00065O-DX; Sun, 11 Apr 2021 20:55:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     robin.murphy@arm.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@kernel.org,
        linux-arm-kernel@lists.infradead.org, jbx6244@gmail.com,
        jagan@amarulasolutions.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH 1/7] ARM: dts: rockchip: move rk322x mmcx aliases to board dts files
Date:   Sun, 11 Apr 2021 20:55:08 +0200
Message-Id: <161816730063.114996.16784124163737635566.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210324122235.1059292-1-heiko@sntech.de>
References: <20210324122235.1059292-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 13:22:29 +0100, Heiko Stuebner wrote:
> As suggested by Arnd Bergmann, mmc-aliases are supposed to be
> board-specific, so move the newly added general aliases to
> the board-level on rk322x-based boards.

Applied, thanks!

[1/7] ARM: dts: rockchip: move rk322x mmcx aliases to board dts files
      commit: 23a52b0dfebf8b9ae44829c561c3d82d8b9c48e3
[2/7] ARM: dts: rockchip: move rv1108 mmcx aliases to board dts files
      commit: e89db2b4c706b9ca1293e7025ef5e8730b5d1b5b
[3/7] arm64: dts: rockchip: move mmc aliases to board dts on px30
      commit: 78b8513b763c121d0ac5ed8fef3188ea065913bb
[4/7] arm64: dts: rockchip: move mmc aliases to board dts on rk3308
      commit: 3f6c22987c0bdfb42b497e346d77b6cdaed55de3
[5/7] arm64: dts: rockchip: move mmc aliases to board dts on rk3328
      commit: 28869aa53506a12d98f6e5ff54b051400be1c2bf
[6/7] arm64: dts: rockchip: move mmc aliases to board dts on rk3368
      commit: 751a78a8bd25ac2634baa19f6f918912360fba93
[7/7] arm64: dts: rockchip: move mmc aliases to board dts on rk3399
      commit: 5dcbe7e3862dfc89d219f37a9ed5e53944fa13c2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
