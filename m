Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF15377968
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhEIX4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:56:22 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55668 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhEIX4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:56:21 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lftGV-0007y6-DY; Mon, 10 May 2021 01:55:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: rk3328: Enable USB3 on some SBCs
Date:   Mon, 10 May 2021 01:55:09 +0200
Message-Id: <162060449717.1266480.5856172101082132800.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210504083616.9654-1-wens@kernel.org>
References: <20210504083616.9654-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2021 16:36:12 +0800, Chen-Yu Tsai wrote:
> Here are some patches that enable USB3 on RK3328 SBCs that I own. The
> changes are quite straightforward, except for the NanoPi R2S, which
> has a USB3 Ethernet chip attached. I am aware that there's already a
> patch [1] for that. This is my spin on things using the USB device
> binding, with comments on how the USB ports are arranged, that I had
> done but couldn't find the time to send out.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: rockchip: rk3328: Enable USB3 for Rock64
      commit: bbac8bd65f5402281cb7b0452c1c5f367387b459
[2/4] arm64: dts: rockchip: rk3328: Enable USB3 for ROC-RK3328-CC
      commit: 75f95927334dea863f16f4ecd29cc709edc3c6ad
[3/4] arm64: dts: rockchip: rk3328: Enable USB3 for Rock Pi E
      commit: bf340c8084d2932936f385ebf48c4734b2911457
[4/4] arm64: dts: rockchip: rk3328: Enable USB3 Ethernet on NanoPi R2S
      commit: d49f120e27dc1689e11a14e9714e63a390dd4520

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
