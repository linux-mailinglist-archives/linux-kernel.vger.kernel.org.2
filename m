Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E078B3CAF5E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhGOWqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:46:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53640 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232329AbhGOWp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:45:59 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4A4H-0005t7-Q0; Fri, 16 Jul 2021 00:42:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        "djw@t-chip.com.cn" <djw@t-chip.com.cn>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Liang Chen <cl@rock-chips.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, Wayne Chou <zxf@t-chip.com.cn>,
        Marty Jones <mj8263788@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        David Bauer <mail@david-bauer.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Kongxin Deng <dkx@t-chip.com.cn>
Subject: Re: [PATCH v0 0/2] Add support for Firefly ROC-RK3399-PC-PLUS
Date:   Fri, 16 Jul 2021 00:42:51 +0200
Message-Id: <162638886252.651069.15126347360852580125.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210628035402.16812-1-djw@t-chip.com.cn>
References: <20210628035402.16812-1-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 11:54:00 +0800, djw@t-chip.com.cn wrote:
> 
> Hi all, this is an attemp to add Firefly ROC-RK3399-PC-PLUS to the mainline
> kernel.
> 
> ROC-RK3399-PC-PLUS is the board inside the portable Firefly Station P1 Geek
> PC. As a redesign after the ROC-RK3399-PC, it uses DC-12V as power input
> and spares a USB 3 host port. It is also equipped with a USB WiFi chip and
> audio codec without the mezzanine board.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: add doc for Firefly ROC-RK3399-PC-PLUS
      commit: 4011a797dac7703ecda083b3be25d891f34e9040
[2/2] arm64: dts: rockchip: add support for Firefly ROC-RK3399-PC-PLUS
      commit: 95e18f24ab427401b7286d6d24b5a8b0621fab2e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
