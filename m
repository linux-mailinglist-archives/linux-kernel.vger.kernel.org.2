Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849F0458606
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 19:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbhKUSze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 13:55:34 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38072 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238779AbhKUSzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:55:23 -0500
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1morwk-00086u-4K; Sun, 21 Nov 2021 19:52:14 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: fix audio-supply for Rock Pi 4
Date:   Sun, 21 Nov 2021 19:52:10 +0100
Message-Id: <163752071859.2241976.10258327599420695432.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027143726.165809-1-knaerzche@gmail.com>
References: <20211027143726.165809-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 16:37:25 +0200, Alex Bee wrote:
> As stated in the schematics [1] and [2] P5 the APIO5 domain is supplied
> by RK808-D Buck4, which in our case vcc1v8_codec - i.e. a 1.8 V regulator.
> 
> Currently only white noise comes from the ES8316's output, which - for
> whatever reason - came up only after the the correct switch from i2s0_8ch_bus
> to i2s0_2ch_bus for i2s0's pinctrl was done.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: fix audio-supply for Rock Pi 4
      commit: 8240e87f16d17a9592c9d67857a3dcdbcb98f10d
[2/2] arm64: dts: rockchip: add interrupt and headphone-detection for Rock Pi4's audio codec
      commit: c681c6fcc5ddfa0492ca015b0bf325cd4881ce07

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
