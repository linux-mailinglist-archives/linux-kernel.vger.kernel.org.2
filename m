Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFA3263BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBZOGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:06:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:54902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhBZOEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:04:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 244BCB080;
        Fri, 26 Feb 2021 14:03:21 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 08/13] arm64: dts: marvell: armada-ap80x: Mark config-space bus as 64bit-mmio-broken
Date:   Fri, 26 Feb 2021 15:03:00 +0100
Message-Id: <20210226140305.26356-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Marvell's Armada-AP806 erratum #582743 the bus can't handle 64bit
MMIO accesses.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 6614472100c2..a009458edf24 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -54,6 +54,7 @@ config-space@f0000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
+			64bit-mmio-broken;
 			ranges = <0x0 0x0 0xf0000000 0x1000000>;
 
 			smmu: iommu@5000000 {
-- 
2.30.1

