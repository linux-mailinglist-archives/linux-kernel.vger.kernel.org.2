Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947963CC687
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhGQVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 17:55:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35866 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231528AbhGQVzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 17:55:12 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4sEI-0006yf-7X; Sat, 17 Jul 2021 23:52:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2 0/5] Updates for Radxa ROCK Pi 4
Date:   Sat, 17 Jul 2021 23:52:10 +0200
Message-Id: <162655869103.853863.7477122882144074913.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210618181256.27992-1-knaerzche@gmail.com>
References: <20210618181256.27992-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 20:12:51 +0200, Alex Bee wrote:
> This series adds support for 2 new revisions of Radxa's ROCK Pi 4,
> namely ROCK Pi 4A+ and ROCK Pi 4B+. While most things are in common
> with the previous 4A and 4B revisions, they have OP1 revision of
> the SoC and eMMC soldered on board.
> Patch 4 and 5 add SPDIF and anlog Codec to the common device tree,
> since they are in place in previous revisions as well.
> It superseeds
> https://lore.kernel.org/linux-rockchip/d4e4e06e-6ddd-4707-232d-b829c1d646e6@gmail.com/
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: Add doc for ROCK Pi 4 A+ and B+
      commit: 0a777f84fd94aba8bd7282d9616e9160ac8ba757
[2/5] arm64: dts: rockchip: Add RK3399 ROCK Pi 4A+ board
      commit: 7ce2bc0f8295afd794264e503a4c8cabd09e8b38
[3/5] arm64: dts: rockchip: Add RK3399 ROCK Pi 4B+ board
      commit: fb094a9957b4500b6988b0927ef408636bff966b
[4/5] arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4
      commit: 9e595375ddf8c71bdd23df2a6769518116dbc6bf
[5/5] arm64: dts: rockchip: add SPDIF node for ROCK Pi 4
      commit: 30910d85c20d929ee1e618bfd86e0fc2f510739f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
