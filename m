Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330133CA291
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhGOQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhGOQoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:44:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D71EB6128D;
        Thu, 15 Jul 2021 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626367284;
        bh=uyg8T9TNPb3ezXODwBGeW2rhMyNTLnpO4b7LmIATlXo=;
        h=From:To:Cc:Subject:Date:From;
        b=WZWj9S+0r0s5f8KR65OVvi2f/czleiyx7mCnQgjV7WqZI6sgLmbuWxvhAKiqqOTQS
         aMVLWUrias2HMFeqT6vj4biVRCDC/HT9zpHzz+TtJg9nzvQRn3Gc8lySV4nObm4T0R
         wSC7KEW4gtUFYYIR8P9qUNGhIgVah0HbXUt1qOQhhg4UQ38HY0mOJv8ocL2xbnPc42
         schfN58MgVU/9owMT1mcf7ESoJHU99cDl10XDc1HrGT2QrLk3zQgkZH3vb1NlyhIFj
         NiqIMmJYgXL99IsBVcdIzO6NACbUdBlBYlQHVI8JrMV/1vNe35zGSV9GNi+605HG5E
         ioGLxNKG1CuwQ==
From:   matthias.bgg@kernel.org
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org,
        Simon South <simon@simonsouth.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Guillaume Gardet <guillaume.gardet@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Disable CDN DP on Pinebook Pro
Date:   Thu, 15 Jul 2021 18:41:01 +0200
Message-Id: <20210715164101.11486-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The CDN DP needs a PHY and a extcon to work correctly. But no extcon is
provided by the device-tree, which leads to an error:
cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* missing extcon or phy
cdn-dp: probe of fec00000.dp failed with error -22

Disable the CDN DP to make graphic work on the Pinebook Pro.

Reported-by: Guillaume Gardet <guillaume.gardet@arm.com>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 2b5f001ff4a6..9e5d07f5712e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -385,10 +385,6 @@ mains_charger: dc-charger {
 	};
 };
 
-&cdn_dp {
-	status = "okay";
-};
-
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_b>;
 };
-- 
2.31.1

