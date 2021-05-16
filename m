Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE43821EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 01:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhEPXHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 19:07:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231953AbhEPXHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 19:07:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCB85B1DD;
        Sun, 16 May 2021 23:06:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org
Subject: [PATCH RFC 5/9] arm64: dts: rockchip: rk1808k-toybrick-m0: Suppress vGIC interrupt
Date:   Mon, 17 May 2021 01:05:47 +0200
Message-Id: <20210516230551.12469-6-afaerber@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516230551.12469-1-afaerber@suse.de>
References: <20210516230551.12469-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the kernel getting stuck after:

[    1.175956] kvm [1]: IPA Size Limit: 40 bits
[    1.177164] kvm [1]: vgic-v2@ff320000
[    1.177545] kvm [1]: GIC system register CPU interface enabled

or when dropping GICV reg entry:

[    1.176001] kvm [1]: IPA Size Limit: 40 bits
[    1.177191] kvm [1]: GICv3: no GICV resource entry
[    1.177664] kvm [1]: disabling GICv2 emulation
[    1.178115] kvm [1]: GIC system register CPU interface enabled

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts b/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts
index 2f8075d2391c..15293a8576c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts
+++ b/arch/arm64/boot/dts/rockchip/rk1808k-toybrick-m0.dts
@@ -48,6 +48,10 @@ &cpu1 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+&gic {
+	/delete-property/ interrupts;
+};
+
 &uart2 {
 	status = "okay";
 	clocks = <&xin24m>;
-- 
2.31.1

