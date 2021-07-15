Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB63CAF56
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhGOWp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:45:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53550 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhGOWpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:45:53 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4A4G-0005t7-9k; Fri, 16 Jul 2021 00:42:56 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     "cl@rock-chips.com" <cl@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jbx6244@gmail.com, linux-rockchip@lists.infradead.org,
        zhangqing@rock-chips.com
Subject: Re: (subset) [PATCH v1 0/3] arm64: dts: rockchip: add pmu and qos nodes for rk3568
Date:   Fri, 16 Jul 2021 00:42:48 +0200
Message-Id: <162638886252.651069.1161379837751983635.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210624114719.1685-1-cl@rock-chips.com>
References: <20210624114719.1685-1-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 19:47:16 +0800, cl@rock-chips.com wrote:
> v1:
> 1. Document rk3568 compatible for pmu and qos nodes.
> 2. Add the power-management and qos nodes to the core rk3568 dtsi.
> 
> Liang Chen (3):
>   dt-bindings: arm: rockchip: add rk3568 compatible string to pmu.yaml
>   dt-binding: mfd: syscon: add rk3568 QoS register compatible
>   arm64: dts: rockchip: add pmu and qos nodes for rk3568
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: rockchip: add rk3568 compatible string to pmu.yaml
      commit: b1c64924df5d2caedb8714148ce177d3384dfafd
[3/3] arm64: dts: rockchip: add pmu and qos nodes for rk3568
      commit: d178bed180ef7e7ac16d3c586fb7330b3cb8fc4d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
