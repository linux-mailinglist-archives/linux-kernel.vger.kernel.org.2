Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15D137275A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEDIkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhEDIhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:37:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FE7E611AE;
        Tue,  4 May 2021 08:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620117385;
        bh=NZ1P6Y4yYep6ONx/AY6RH6/uPPDWwuWoLAXJG6Alasc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3nR9wStIGk83O8g6VvXTVQS3MiTtcFt6g7UEIQtt0EoYa2gzhQQdv00mS4mVeOWc
         qnVAO+f2MtARtbO+Pm3MKiWTxmKoFSxlQki8Fc6gARBu0YXLf6YNciLvlGC6BHAI6D
         E7aetaeKOMH3aEhH1IjfkzMVEF9HuPfaFqtGAbNaVDbfHPl8nSv2H2fiEqpwuhUlrN
         3Pvgb0l+p1qp3V39pNAXKRTRAffA1NnWbJjgX3/PNiXcGyiwIVf+bk7ZmjXPB+5Ugn
         9AblgommFCWx6/CyCJ5TAsBbG4oc862eFog6/bDpU1ZUDHBs/YNhSvtoDo77NnP40a
         kxPAsGXMv3xLQ==
Received: by wens.tw (Postfix, from userid 1000)
        id 397795FC12; Tue,  4 May 2021 16:36:23 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: rockchip: rk3328: Enable USB3 for ROC-RK3328-CC
Date:   Tue,  4 May 2021 16:36:14 +0800
Message-Id: <20210504083616.9654-3-wens@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504083616.9654-1-wens@kernel.org>
References: <20210504083616.9654-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Enable USB3 nodes for the ROC-RK3328-CC board.

The separate power regulator is not added as it is controlled by the
same GPIO line as the existing VBUS regulators, so it is already
enabled. Also there is no port representation to tie the regulator to.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index a05732b59f38..bdf0ca07eae9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -363,6 +363,11 @@ &usb20_otg {
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

