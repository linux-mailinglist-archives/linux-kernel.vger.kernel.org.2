Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB5B416A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbhIXDlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:41:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37176 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244047AbhIXDlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:41:16 -0400
X-UUID: e5daf91db8344c0b9267e786a4569ebe-20210924
X-UUID: e5daf91db8344c0b9267e786a4569ebe-20210924
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1456224560; Fri, 24 Sep 2021 11:39:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Sep 2021 11:39:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Sep 2021 11:39:39 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v7 6/6] arm64: dts: mt8183: change rpmsg property name
Date:   Fri, 24 Sep 2021 11:39:35 +0800
Message-ID: <20210924033935.2127-7-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210924033935.2127-1-tinghan.shen@mediatek.com>
References: <20210924033935.2127-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The the rpmsg property name is changed to "mediatek," to sync with the
vendor name defined in vendor-prefixes.yaml.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 8e9cf36a9a41..bc4bbcf457ee 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -754,7 +754,7 @@
 
 	cros_ec {
 		compatible = "google,cros-ec-rpmsg";
-		mtk,rpmsg-name = "cros-ec-rpmsg";
+		mediatek,rpmsg-name = "cros-ec-rpmsg";
 	};
 };
 
-- 
2.18.0

