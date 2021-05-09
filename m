Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812AC37796C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhEIX42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:56:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55724 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhEIX41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:56:27 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lftGT-0007y6-2C; Mon, 10 May 2021 01:55:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: rename LED label for NanoPi R4S
Date:   Mon, 10 May 2021 01:55:04 +0200
Message-Id: <162060449717.1266480.15512364220563668562.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210426114652.29542-1-cnsztl@gmail.com>
References: <20210426114652.29542-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 19:46:52 +0800, Tianling Shen wrote:
> However "sys" is not a valid function, and it is always on.
> Let's keep existing functions.
> 
> Fixes: db792e9adbf85f ("rockchip: rk3399: Add support for FriendlyARM NanoPi R4S")

Applied, thanks!

[1/1] arm64: dts: rockchip: rename LED label for NanoPi R4S
      commit: 6a11ffc2cc54d89719d5b2f3ca44244cebd7ed2e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
