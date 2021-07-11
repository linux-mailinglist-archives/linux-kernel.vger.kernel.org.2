Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A1D3C3FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 01:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGKX27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 19:28:59 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54640 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhGKX26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 19:28:58 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m2ipq-0000zL-OX; Mon, 12 Jul 2021 01:26:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: remove clock_in_out from gmac2phy node in rk3318-a95x-z2.dts
Date:   Mon, 12 Jul 2021 01:26:00 +0200
Message-Id: <162604593565.371932.11619323372209333950.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210701144110.12333-1-jbx6244@gmail.com>
References: <20210701144110.12333-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 16:41:09 +0200, Johan Jonker wrote:
> Recently a clock_in_out property was added to the gmac2phy node
> in rk3328.dtsi, so now the clock_in_out in rk3318-a95x-z2.dts
> can be removed.

Applied, thanks!

[1/2] arm64: dts: rockchip: remove clock_in_out from gmac2phy node in rk3318-a95x-z2.dts
      commit: ac0af67f8c898f38427c7d15e3598773c19cd6e8
[2/2] arm64: dts: rockchip: remove ddc-i2c-scl-* properties from rk3318-a95x-z2.dts
      commit: 1aeab005562f8dc26f7df4eb76b130b591b56f63

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
