Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF75E343D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCVKER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:04:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46956 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCVKEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:04:14 -0400
Received: from p5b127c0a.dip0.t-ipconnect.de ([91.18.124.10] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lOHPd-0003jN-LW; Mon, 22 Mar 2021 11:03:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Marty Jones <mj8263788@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Bauer <mail@david-bauer.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Tianling Shen <cnsztl@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Date:   Mon, 22 Mar 2021 11:03:52 +0100
Message-Id: <161640742725.808893.3666594351389773587.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210319051627.814-1-cnsztl@gmail.com>
References: <20210319051627.814-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 13:16:26 +0800, Tianling Shen wrote:
> Add devicetree binding documentation for the FriendlyARM NanoPi R4S.
> 
> Changes in v6:
> - Fixed format of LED nodes
> 
> Changes in v5:
> - Dropped the empty PCIe node
> - Dropped useless `/delete-property/`
> - Renamed LED nodes
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
      commit: 1003888415e83e15ddb63d1d96189b4f2c5f1d48
[2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
      commit: db792e9adbf85ffc9d6b0b060ac3c8e3148c8992

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
