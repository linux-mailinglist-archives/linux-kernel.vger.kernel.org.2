Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327213EC12D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 09:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhHNHeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 03:34:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47986 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhHNHeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 03:34:36 -0400
Received: from 82-99-180-238.static.bluetone.cz ([82.99.180.238] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mEoB4-0003bg-2O; Sat, 14 Aug 2021 09:33:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Liang Chen <cl@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 0/7] arm64: dts: rockchip: rk3568-evb1-v10: add sd card support
Date:   Sat, 14 Aug 2021 09:33:54 +0200
Message-Id: <162892642459.2674259.13856979859165200065.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210805120107.27007-1-michael.riesch@wolfvision.net>
References: <20210805120107.27007-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 14:01:00 +0200, Michael Riesch wrote:
> This series enables the SD card reader on the RK3568 EVB1
> and completes the support for the on-board eMMC.
> 
> As the PMU IO domains are required, the patch series that
> introduces support for the RK3568 PMU IO domains [1] has been
> revised and integrated in this series.
> Additionally, the required voltage regulators of the RK809
> PMIC are enabled.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: power: add rk3568-pmu-io-domain support
      commit: fadbd4e7847905d61dd333a0d3d31654f4510bc6
[2/7] soc: rockchip: io-domain: add rk3568 support
      commit: 28b05a64e47cbceebb8a5f3f643033148d5c06c3
[3/7] arm64: dts: rockchip: enable io domains for rk356x
      commit: 2e9ce86bbea81022540ede98cac152df5566205e
[4/7] arm64: dts: rockchip: rk3568-evb1-v10: enable io domains
      commit: 915186bd99a55642ae77d7f9c46e295b3fd9dc1c
[5/7] arm64: dts: rockchip: rk3568-evb1-v10: add regulators of rk809 pmic
      commit: e3f6b997b6b17810583af79f458b35fc0a34d939
[6/7] arm64: dts: rockchip: rk3568-evb1-v10: add node for sd card
      commit: ef180dba76f583efc19c7d5f3d2809e0aa8856e8
[7/7] arm64: dts: rockchip: rk3568-evb1-v10: add pinctrl and alias to emmc node
      commit: eb8d07586e13fc7aa4ed68820240d36a03418193

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
