Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FDD37275F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhEDIki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhEDIhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:37:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67AD7613C4;
        Tue,  4 May 2021 08:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620117385;
        bh=FTUYwzBsfmH9HtTIoXaIZ7BmgshUPslDQNyHscw0au8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wj85VQOMIqoP6o1odMBeCc74EpJjcuxewMDwf2J8Nt/K+Ko5H659agmD0TAPXvhRQ
         WWkmUs7JwENIPVTB9RB5kGsvd6EhA41C99XOekyd9q2ZS1i7y3dXBFxtUFixZdC89G
         9f1sfTCq6KoOiyR7CgzCVD1qTOHPb0DUbzXrZ2JVZuggXBYkl+R9qtlMCRRYq2RwgT
         r2M6DDcfTlAG8H03u08su9GW2sdBJ/1PbNPCS/bXch3uYjYKb/9e4kfpq1yaCI4B8U
         TT8hDv/8rjwm5+F6faMivN5oeZLpINXimzR/pC1jaMwXUIPd5zt69qNoCCHukPQdlI
         nqEkUr16HifcA==
Received: by wens.tw (Postfix, from userid 1000)
        id 380F55FB8B; Tue,  4 May 2021 16:36:23 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Cameron Nemo <cnemo@tutanota.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 1/4] arm64: dts: rockchip: rk3328: Enable USB3 for Rock64
Date:   Tue,  4 May 2021 16:36:13 +0800
Message-Id: <20210504083616.9654-2-wens@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504083616.9654-1-wens@kernel.org>
References: <20210504083616.9654-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

Enable USB3 nodes for the rk3328-based PINE Rock64 board.

The separate power regulator is not added as it is controlled by the
same GPIO line as the existing VBUS regulators, so it is already
enabled. Also there is no port representation to tie the regulator to.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
[wens@csie.org: Rewrote commit message]
[wens@csie.org: Rebased onto v5.12]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 3bef1f39bc6e..1b0f7e4551ea 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -381,6 +381,11 @@ &usb20_otg {
 	status = "okay";
 };
 
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.31.1

