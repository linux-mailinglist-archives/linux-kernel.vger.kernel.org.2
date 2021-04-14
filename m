Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F535F688
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351905AbhDNOrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344861AbhDNOrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC694610FC;
        Wed, 14 Apr 2021 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618411609;
        bh=mV0aVkgGwraofiwbxZzUURU+kqmVHxLHqfUqgDMGMTY=;
        h=From:To:Cc:Subject:Date:From;
        b=XKly5Hl5D4cNiuuozFA63HKdiJ+3SQ77WQpLjIMuU6fuRjjnYg0Zu5WfpcJwnkta9
         wd1gDYbvDKEcPIpResLcNLsrfTV3LvVbc5pDlkZUY/jCyI98dmLRovyNki3Tmcl5Ik
         XWjzwBUd2iLOuEmKHD9gJIhi85PbDgkL1m5drmy2jfhITZangHna7gnIe/QvkCcs8h
         2xheWYaJYlPsf+Y2Hrp7KufwqKDfv9zt/PJzBbmm5o+5LTr3VC4b1WMEyvUcX5LXNK
         ngt9g3LStBpXkG5Dw/ahVzPlLdgJz5+aq2+/fXaClpo2wAh4nXi3VVPe8sTnyVaVCn
         ez2ooJtEyXfjg==
From:   matthias.bgg@kernel.org
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: mt8183-pumpkin: fix dtbs_check warning
Date:   Wed, 14 Apr 2021 16:46:40 +0200
Message-Id: <20210414144643.17435-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Fix unit names to make dtbs_check happy.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index eb6e595c2975..0aff5eb52e88 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -32,7 +32,7 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		scp_mem_reserved: scp_mem_region {
+		scp_mem_reserved: scp_mem_region@50000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x50000000 0 0x2900000>;
 			no-map;
@@ -55,7 +55,7 @@ led-green {
 		};
 	};
 
-	ntc@0 {
+	ntc {
 		compatible = "murata,ncp03wf104";
 		pullup-uv = <1800000>;
 		pullup-ohm = <390000>;
-- 
2.30.2

