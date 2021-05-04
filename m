Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5237275C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEDIka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhEDIhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:37:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FE2C613C3;
        Tue,  4 May 2021 08:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620117385;
        bh=siPwZ678h5F4YQrRY5Ht9/0Lprn948BNV0by6FKBrlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gssOHQy7tLUQn2dH5Q6aV+jFxmzNdJ9k8GH8bshXqjhfjluJgEVktZhqx/owX/NsB
         fdwlXayAXCTE+PoWySrazHOjEGVD1XfnP0nWpMWnW8T9oWppf+HTSrG+6i4Ulhd4ZL
         KENv/b04jCdIeRf05SFtP+R+Ol14GsJ6EkC/qQ+yyTdCB2v8ws0r2d1p7sDrSSmAuC
         KG7AiyIf27Fhzks2LCebS5RattapFvHHFa0+zxf8YMzt2DTCnGdEBu/Wm5Vhf0PfCb
         x90U/l7aC7rrhX7oF3AUlZlNtqQwMT1/2/F54OCbJ+G+acOR1o9VXOGcoPw1Yhaduq
         9Whe9T9iWmjNQ==
Received: by wens.tw (Postfix, from userid 1000)
        id 415E95FC30; Tue,  4 May 2021 16:36:23 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: rockchip: rk3328: Enable USB3 for Rock Pi E
Date:   Tue,  4 May 2021 16:36:15 +0800
Message-Id: <20210504083616.9654-4-wens@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210504083616.9654-1-wens@kernel.org>
References: <20210504083616.9654-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Enable USB3 nodes for the Rock Pi E board.

The VBUS regulator device node was added when the board was first
introduced.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index c02059c0a954..018a3a5075c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -380,6 +380,11 @@ &uart2 {
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

