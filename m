Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18052458601
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 19:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbhKUSzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 13:55:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38050 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238552AbhKUSzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:55:21 -0500
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1morwi-00086u-T8; Sun, 21 Nov 2021 19:52:12 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Artem Lapkin <email2tema@gmail.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, gouwa@khadas.com,
        jbx6244@gmail.com, nick@khadas.com, wenst@chromium.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, robh+dt@kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: remove mmc-hs400-enhanced-strobe from rk3399-khadas-edge
Date:   Sun, 21 Nov 2021 19:52:06 +0100
Message-Id: <163752071859.2241976.7994917045018325320.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115083321.2627461-1-art@khadas.com>
References: <20211115083321.2627461-1-art@khadas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 16:33:21 +0800, Artem Lapkin wrote:
> Remove mmc-hs400-enhanced-strobe from the rk3399-khadas-edge dts to
> improve compatibility with a wider range of eMMC chips.
> 
> Before (BJTD4R 29.1 GiB):
> 
> [    7.001493] mmc2: CQHCI version 5.10
> [    7.027971] mmc2: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
> .......
> [    7.207086] mmc2: mmc_select_hs400es failed, error -110
> [    7.207129] mmc2: error -110 whilst initialising MMC card
> [    7.308893] mmc2: mmc_select_hs400es failed, error -110
> [    7.308921] mmc2: error -110 whilst initialising MMC card
> [    7.427524] mmc2: mmc_select_hs400es failed, error -110
> [    7.427546] mmc2: error -110 whilst initialising MMC card
> [    7.590993] mmc2: mmc_select_hs400es failed, error -110
> [    7.591012] mmc2: error -110 whilst initialising MMC card
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: remove mmc-hs400-enhanced-strobe from rk3399-khadas-edge
      commit: 6dd0053683804427529ef3523f7872f473440a19

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
