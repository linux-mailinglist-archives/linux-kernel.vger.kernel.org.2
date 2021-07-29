Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882213DA3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbhG2NTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:19:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57688 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237427AbhG2NT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:19:28 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m95wW-0003Jt-V3; Thu, 29 Jul 2021 15:19:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, Simon Xue <xxm@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [PATCH v2 0/2] add ethernet support to rk3568 dts
Date:   Thu, 29 Jul 2021 15:19:17 +0200
Message-Id: <162755606328.1705274.2968176940580223708.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210729093913.8917-1-michael.riesch@wolfvision.net>
References: <20210729093913.8917-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 11:39:11 +0200, Michael Riesch wrote:
> these patches should be orthogonal to the ongoing work of Peter Geis
> that aims to introduce the GMAC1 node to the common RK356x dts.
> The GMAC0 node, which is exclusive to the RK3568, and the Ethernet
> phy nodes in the RK3568 EVB1 are introduced by this series.
> 
> v2:
> - sort properties alphabetically
> - use phy-mode "rgmii-id" without delay properties
> - rename phy nodes to "ethernet-phy"
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: add gmac0 node to rk3568
      commit: 2ff79e4cec9850de4df59e3902197141de7ba9ea
[2/2] arm64: dts: rockchip: rk3568-evb1-v10: add ethernet support
      commit: f96f01eb249165631456e1d81aed0e2f3d4e2cea

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
