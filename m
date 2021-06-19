Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2D3ADBDA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 23:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFSWA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 18:00:58 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51424 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFSWAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 18:00:53 -0400
Received: from p508fcd5b.dip0.t-ipconnect.de ([80.143.205.91] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1luiz8-0000U7-AG; Sat, 19 Jun 2021 23:58:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Markus Reichl <m.reichl@fivetechno.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Re-add regulator-boot-on, regulator-always-on for vdd_gpu on rk3399-roc-pc
Date:   Sat, 19 Jun 2021 23:58:35 +0200
Message-Id: <162413990967.13616.2556235400488148466.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210619121446.7802-1-knaerzche@gmail.com>
References: <20210619121446.7802-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2021 14:14:46 +0200, Alex Bee wrote:
> This might be a limitation of either the current panfrost driver
> devfreq implementation or how the gpu is implemented in RK3399 SoC.
> The gpu regulator must never get disabled or the registers get
> (randomly?) inaccessable by the driver. (see all other RK3399 boards)

Applied, thanks!

[1/1] arm64: dts: rockchip: Re-add regulator-boot-on, regulator-always-on for vdd_gpu on rk3399-roc-pc
      commit: 06b2818678d9b35102c9816ffaf6893caf306ed0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
