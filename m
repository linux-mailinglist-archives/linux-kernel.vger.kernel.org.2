Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB6F3324B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhCIMHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:07:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35859 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230173AbhCIMHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:07:20 -0500
X-UUID: a0feffcbd81f44ce95b09b34c67b5c84-20210309
X-UUID: a0feffcbd81f44ce95b09b34c67b5c84-20210309
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1280078577; Tue, 09 Mar 2021 20:07:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Mar 2021 20:07:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Mar 2021 20:07:15 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wendell Lin <Wendell.Lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Macpaul Lin <Macpaul.Lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Evan Green <evgreen@chromium.org>, <Yong.Wu@mediatek.com>,
        Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: [PATCH v9 4/4] arm64: defconfig: add CONFIG_COMMON_CLK_MT6765_XXX clocks
Date:   Tue, 9 Mar 2021 20:05:38 +0800
Message-ID: <1615291538-9799-5-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1615291538-9799-1-git-send-email-macpaul.lin@mediatek.com>
References: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
 <1615291538-9799-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FDAF47F11F74DEFFB31581AA99BF3EADAD476DBDEB9F270F6DFD6775057A74402000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Owen Chen <owen.chen@mediatek.com>

Enable MT6765 clock configs, include topckgen, apmixedsys,
infracfg, and subsystem clocks.

Signed-off-by: Owen Chen <owen.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d612f633b771..553137e81b8e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -622,6 +622,12 @@ CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_TPS65132=m
 CONFIG_REGULATOR_VCTRL=m
+CONFIG_COMMON_CLK_MT6765_AUDIOSYS=y
+CONFIG_COMMON_CLK_MT6765_CAMSYS=y
+CONFIG_COMMON_CLK_MT6765_MMSYS=y
+CONFIG_COMMON_CLK_MT6765_IMGSYS=y
+CONFIG_COMMON_CLK_MT6765_VCODECSYS=y
+CONFIG_COMMON_CLK_MT6765_MIPI0ASYS=y
 CONFIG_RC_CORE=m
 CONFIG_RC_DECODERS=y
 CONFIG_RC_DEVICES=y
-- 
2.18.0

