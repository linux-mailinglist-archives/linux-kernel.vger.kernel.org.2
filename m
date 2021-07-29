Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F7D3DA3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhG2NT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:19:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57674 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237360AbhG2NT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:19:26 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m95wX-0003Jt-8q; Thu, 29 Jul 2021 15:19:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/8] fixes and enablement for rk356x
Date:   Thu, 29 Jul 2021 15:19:18 +0200
Message-Id: <162755606328.1705274.3410702521597936344.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210728180034.717953-1-pgwipeout@gmail.com>
References: <20210728180034.717953-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 14:00:26 -0400, Peter Geis wrote:
> Good Morning,
> 
> This series aims to fix some early issues with the rk356x and enable
> nodes that are currently supported by the available drivers.
> 
> 1. fixes the mbi-alias, which points to the wrong location
> 2. fixes the rockchip clk-pll to work without a grf node
> 3. adds the gpio debounce clocks which are necessary for gpio to bind
> 4. adds the common gmac1 node
> 5. adds the tsadc nodes
> 6. adjusts the gpll and ppll clocks to better support hardware
> 7. enables the gmac1 on the Quartz64
> 8. adds thermal support to the Quartz64
> 
> [...]

Applied the easy ones for now, thanks!

[1/8] arm64: dts: rockchip: fix rk3568 mbi-alias
      commit: 0ecf7b9137e05e2ade45b0555b00248cc0b7ac69
-> just put that in for 5.15, as the rk3568 on 5.14 is
   still largely a wip

[2/8] clk: rockchip: fix clk-pll rk356x early pll init
      commit: 6fffe52fb336ec2063270a7305652a93ea677ca1
-> I've adapted the commit message here

[4/8] arm64: dts: rockchip: add rk356x gmac1 node
      commit: 6cdca5eb64c6eff6d552b475b6dc9182d84f2a31
-> did a bit of sorting here

[6/8] arm64: dts: rockchip: adjust rk3568 pll clocks
      commit: 66a6450203e2e9bcaf6cb5938e7a9a159234722a
-> adapted commit message with your reply from v1

[7/8] arm64: dts: rockchip: enable gmac node on quartz64-a
      commit: 797fc427ffb9a746d985c5f31e9c14defc1d1187

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
