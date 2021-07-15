Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737CC3CAF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhGOWqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:46:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:53636 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhGOWp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:45:57 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m4A4H-0005t7-6u; Fri, 16 Jul 2021 00:42:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        "djw@t-chip.com.cn" <djw@t-chip.com.cn>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Liang Chen <cl@rock-chips.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Wayne Chou <zxf@t-chip.com.cn>,
        David Bauer <mail@david-bauer.net>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Johan Jonker <jbx6244@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Tianling Shen <cnsztl@gmail.com>
Subject: Re: [PATCH v0 0/2] Add support for Firefly ROC-RK3328-PC
Date:   Fri, 16 Jul 2021 00:42:50 +0200
Message-Id: <162638886252.651069.17368608559801468213.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210709080126.17045-1-djw@t-chip.com.cn>
References: <20210709080126.17045-1-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 16:01:24 +0800, djw@t-chip.com.cn wrote:
> 
> Hi all, this is an attemp to add Firefly ROC-RK3328-PC to the mainline
> kernel.
> 
> ROC-RK3328-PC is the board inside the portable Firefly Station M1
> Geek PC. As a redesign after the ROC-RK3328-CC, it uses TypeC as
> power input and OTG port, embedded with eMMC 5.1 storage and a
> SDIO WiFi/BT chip (RTL8723DS).
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: add doc for Firefly ROC-RK3328-PC
      commit: 773b358cb274a6cededc1f597ba70e75c0676752
[2/2] arm64: dts: rockchip: add support for Firefly ROC-RK3328-PC
      commit: ffe7ee186baafe3855d117a5d6e7183e8e77795d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
