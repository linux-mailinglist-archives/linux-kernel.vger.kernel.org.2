Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2F3899C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhESXZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:25:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40128 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhESXZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:25:08 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ljVXU-0003LC-Ri; Thu, 20 May 2021 01:23:44 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Cc:     linux-gpio@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jianqun Xu <jay.xu@rock-chips.com>
Subject: Re: [PATCH 4/7] gpio/rockchip: use struct rockchip_gpio_regs for gpio controller
Date:   Thu, 20 May 2021 01:23:42 +0200
Message-ID: <20019893.0c2gjJ1VT2@diego>
In-Reply-To: <20210510063602.505829-5-jay.xu@rock-chips.com>
References: <20210510063602.505829-1-jay.xu@rock-chips.com> <20210510063602.505829-5-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Mai 2021, 08:35:59 CEST schrieb Jianqun Xu:
> Store register offsets in the struct rockchip_gpio_regs, this patch
> prepare for the driver update for new gpio controller.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


