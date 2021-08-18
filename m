Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545F43F0D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 23:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhHRVn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 17:43:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44348 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234009AbhHRVnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:43:24 -0400
Received: from [212.185.68.41] (helo=phil.client.m3-hotspots.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mGTKf-0001Wh-RY; Wed, 18 Aug 2021 23:42:45 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/8] fixes and enablement for rk356x
Date:   Wed, 18 Aug 2021 23:42:44 +0200
Message-Id: <162932289621.2860738.15310161824918921933.b4-ty@sntech.de>
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

Applied, thanks!

[5/8] arm64: dts: rockchip: add rk3568 tsadc nodes
      commit: 1a9563ba0a59b221156d80a3a77a43fdd144576c

[I've moved the tsadc-pin pin setting to the second pinctrl
 block meant to hand-crafted pin settings in rk3568-pinctrl.dtsi]


[8/8] arm64: dts: rockchip: add thermal support to Quartz64 Model A
      commit: d0e2e61b3cbaab474e2093ceb2073c4441bd36f8

Looks like we're all done with that series now.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
