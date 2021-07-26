Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC73D55BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhGZH6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:58:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:32828 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbhGZH6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:58:49 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m7w8l-0001Fy-Ue; Mon, 26 Jul 2021 10:39:12 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>, cl@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org, kever.yang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 09/10] arm64: dts: rockchip: add pwm nodes for rk3568
Date:   Mon, 26 Jul 2021 10:39:09 +0200
Message-Id: <162728868604.1545568.2785277023871790332.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210622102907.99242-1-heiko@sntech.de>
References: <20210622102907.99242-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 12:29:06 +0200, Heiko Stuebner wrote:
> Add the pwm controller nodes to the core rk3568 dtsi.

Applied, thanks!

[10/10] arm64: dts: rockchip: add watchdog to rk3568
(->2/2) commit: 7ca30712c3a82ac7517d9fd65aeec4739a463e24

Watchdog binding got applied for 5.14, so adapted the patch
for the new rk356x.dtsi and applied that one.

PWM still seems to need time.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
