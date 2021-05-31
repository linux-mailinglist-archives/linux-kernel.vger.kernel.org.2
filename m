Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49813959F5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhEaL7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:59:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58290 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhEaL7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:59:34 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lngYH-0003WZ-Ce; Mon, 31 May 2021 13:57:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, huangtao@rock-chips.com,
        kishon@ti.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, david.wu@rock-chips.com,
        jay.xu@rock-chips.com, zhangqing@rock-chips.com,
        shawn.lin@rock-chips.com, cl@rock-chips.com,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, vkoul@kernel.org
Subject: Re: (subset) [PATCH v5 0/4] convert grf.txt to YAML
Date:   Mon, 31 May 2021 13:57:46 +0200
Message-Id: <162246221869.3034596.11877935008610274451.b4-ty@sntech.de>
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
      commit: 2ed2732ef28aefdc3b495409fbd05cc388a73c62

Reapplied this, as the phy-related patch also got applies to
the phy tree now.

dtbs-check was happy with me in my test right now as well.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
