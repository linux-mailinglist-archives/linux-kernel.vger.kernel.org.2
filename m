Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E882930A0C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 05:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhBAEAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 23:00:50 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48147 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229842AbhBAEAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 23:00:46 -0500
X-UUID: 2a98a505a9844201bb6a41b0e3dfeccb-20210201
X-UUID: 2a98a505a9844201bb6a41b0e3dfeccb-20210201
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yz.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1541827738; Mon, 01 Feb 2021 12:00:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Feb 2021 12:00:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Feb 2021 12:00:01 +0800
From:   <Yz.Wu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Seiya Wang <seiya.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Ryan Wu <Yz.Wu@mediatek.com>
Subject: [PATCH v4 0/2] Add Mediatek Efuse Device Node for MT8192 SoC
Date:   Mon, 1 Feb 2021 11:59:44 +0800
Message-ID: <1612151986-19820-1-git-send-email-Yz.Wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 084DA98BB6B544664E08C458F3B2B16396053EB59EA7AFD532E10E59CD4C693E2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wu <Yz.Wu@mediatek.com>

This patch adds efuse to read via NVMEM.

Ryan Wu (2):
  dt-bindings: nvmem: mediatek: add support for MediaTek mt8192 SoC
  arm64: dts: mt8192: add eFuse support for MT8192 SoC

 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi              | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.6.4

