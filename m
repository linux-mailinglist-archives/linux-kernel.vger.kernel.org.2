Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF9B40C4FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhIOMQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:16:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49060 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhIOMQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:16:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FCElqC070388;
        Wed, 15 Sep 2021 07:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631708087;
        bh=KpLPhlM0LkudEzDGM0tHwWlIvGPMnCVz/SZsoL6gATk=;
        h=From:To:CC:Subject:Date;
        b=oHp1VGbCIdeQs1EP1Fm7LXRO1veUEaopYNJztEVAC6Dju3AtpnEWHdyocU9wcc4F0
         ZjuAcZWlOdz471Dl9SvYQ0S6IaZBZTmz4ragzxoQPdCR6fAn6q5O2kMXwueYD1d2eO
         oRpLBREqcoujyMGCgcLSoD1+KonRMrTzQDnARPss=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FCEl6p112946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 07:14:47 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 07:14:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 07:14:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FCElxu093712;
        Wed, 15 Sep 2021 07:14:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: Makefile: Collate AM64 platforms together
Date:   Wed, 15 Sep 2021 07:14:42 -0500
Message-ID: <20210915121442.27112-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the platforms are grouped together per SoC. This helps
keep the Makefile readable as newer platforms get added to the list.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index d56c742f5a10..7bfc543a578c 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -15,5 +15,4 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
 
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
-
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
-- 
2.32.0

