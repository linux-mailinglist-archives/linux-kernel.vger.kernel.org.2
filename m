Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD53D865C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 05:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhG1D7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 23:59:21 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:46522 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234025AbhG1D7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 23:59:11 -0400
X-UUID: e7f3d67574be4876a04fef3e37c6f938-20210728
X-UUID: e7f3d67574be4876a04fef3e37c6f938-20210728
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 595493129; Wed, 28 Jul 2021 11:59:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 11:59:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 11:59:03 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <tzungbi@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v4 1/4] dt-bindings: remoteproc: mediatek: Add binding for mt8195 scp
Date:   Wed, 28 Jul 2021 11:58:56 +0800
Message-ID: <20210728035859.5405-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210728035859.5405-1-tinghan.shen@mediatek.com>
References: <20210728035859.5405-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8195 compatible to binding document. The description of required
properties are also modified to reflect the hardware change between
mt8183 and mt8195. The mt8195 doesn't have to control the scp clock on
kernel side.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
index 3f5f78764b60..d64466eefbe3 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
@@ -5,13 +5,15 @@ This binding provides support for ARM Cortex M4 Co-processor found on some
 Mediatek SoCs.
 
 Required properties:
-- compatible		Should be "mediatek,mt8183-scp"
+- compatible		Should be one of:
+				"mediatek,mt8183-scp"
+				"mediatek,mt8195-scp"
 - reg			Should contain the address ranges for memory regions:
 			SRAM, CFG, and L1TCM.
 - reg-names		Contains the corresponding names for the memory regions:
 			"sram", "cfg", and "l1tcm".
-- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
-- clock-names		Contains the corresponding name for the clock. This
+- clocks		Required by mt8183. Clock for co-processor (See: ../clock/clock-bindings.txt)
+- clock-names		Required by mt8183. Contains the corresponding name for the clock. This
 			should be named "main".
 
 Subnodes
-- 
2.18.0

