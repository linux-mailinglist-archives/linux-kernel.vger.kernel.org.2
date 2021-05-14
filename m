Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F05380E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhENQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:38:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47212 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbhENQiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:38:52 -0400
Received: from p5b127fa9.dip0.t-ipconnect.de ([91.18.127.169] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lhaoi-0003p9-LK; Fri, 14 May 2021 18:37:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, vkoul@kernel.org,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        cl@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        kishon@ti.com, huangtao@rock-chips.com, zhangqing@rock-chips.com,
        jay.xu@rock-chips.com
Subject: Re: (subset) [PATCH v5 0/4] convert grf.txt to YAML
Date:   Fri, 14 May 2021 18:37:35 +0200
Message-Id: <162101023435.2009214.882597722137585064.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210512122346.9463-1-jbx6244@gmail.com>
References: <20210512122346.9463-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 14:23:42 +0200, Johan Jonker wrote:
> Changed V5:
>   changed compatibles for rk3066/rk3188
>   add rockchip-usb-phy.yaml
>   move and restyle grf nodes rk3066/rk3188
>   remove applied patches
> 
> Changed V4:
>   revert separate schemas for each 'if' subset
>   add additionalProperties
>   move properties to top level
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: soc: rockchip: convert grf.txt to YAML
      commit: f2ffa8f9e32d38f5c37e3c61c5b02d434057f3db
[3/4] ARM: dts: rockchip: move and restyle grf nodes rk3066/rk3188
      commit: a082a4ba218457fd52256e4357184b58d3fcaa49
[4/4] arm64: dts: rename grf-gpio nodename in rk3328.dtsi
      commit: 19486fe587b8ed17daf87a6419b51e3a65ce565c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
