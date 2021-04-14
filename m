Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC21C35EE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349622AbhDNHTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:19:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60734 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349613AbhDNHS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:18:57 -0400
X-UUID: ade66faf05784904a521eabd83a78d9e-20210414
X-UUID: ade66faf05784904a521eabd83a78d9e-20210414
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yz.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 227712550; Wed, 14 Apr 2021 15:18:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 15:18:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 15:18:17 +0800
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
Subject: [PATCH v5 0/2] Add Mediatek Efuse Device Node for MT8192 SoC
Date:   Wed, 14 Apr 2021 15:17:47 +0800
Message-ID: <1618384669-30070-1-git-send-email-Yz.Wu@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4C53F4EF08B6449ACA368C13CBF9431EFCD3E84CA088F6F4E24B34B705A35E732000:8
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

