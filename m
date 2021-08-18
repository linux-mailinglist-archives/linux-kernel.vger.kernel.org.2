Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E94B3F0D50
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 23:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhHRV0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 17:26:05 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44200 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhHRV0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:26:04 -0400
Received: from [212.185.68.41] (helo=phil.client.m3-hotspots.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mGT3t-0001S4-Ut; Wed, 18 Aug 2021 23:25:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/8] fixes and enablement for rk356x
Date:   Wed, 18 Aug 2021 23:25:24 +0200
Message-Id: <162932191989.2857998.7332944656635209644.b4-ty@sntech.de>
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

[3/8] arm64: dts: rockchip: add rk356x gpio debounce clocks
      commit: bf092ebe6e81fe7f7b710e749a3debfece193ff5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
