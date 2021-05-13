Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DDB3800E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEMXaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhEMXaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:30:12 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:150:448b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C93C061756;
        Thu, 13 May 2021 16:29:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 1AAC8220A40;
        Fri, 14 May 2021 01:29:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MY-t12a_7eoI; Fri, 14 May 2021 01:28:55 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 5/7] ARM: dts: sun8i: V3: add codec analog frontend to V3 dts
Date:   Fri, 14 May 2021 01:30:22 +0200
Message-Id: <20210513233024.2076725-6-t.schramm@manjaro.org>
In-Reply-To: <20210513233024.2076725-1-t.schramm@manjaro.org>
References: <20210513233024.2076725-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3 SoC has a different analog codec frontend than the V3s
SoC. The frontend used on the V3 SoC is compatible with the on used in
the Allwinner H3 SoC.
This patch adds the corresponding node to the Allwinner V3 dtsi.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm/boot/dts/sun8i-v3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3.dtsi
index c279e13583ba..8af790d286b9 100644
--- a/arch/arm/boot/dts/sun8i-v3.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3.dtsi
@@ -9,6 +9,11 @@ &ccu {
 	compatible = "allwinner,sun8i-v3-ccu";
 };
 
+&codec_analog {
+	compatible = "allwinner,sun8i-v3-codec-analog",
+		     "allwinner,sun8i-h3-codec-analog";
+};
+
 &emac {
 	/delete-property/ phy-handle;
 	/delete-property/ phy-mode;
-- 
2.31.1

