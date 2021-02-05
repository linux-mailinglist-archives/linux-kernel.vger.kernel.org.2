Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0631023C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhBEB31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:29:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37302 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232729AbhBEB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:29:24 -0500
X-UUID: 2c312671aef94171a84c828fd4c0b4a8-20210205
X-UUID: 2c312671aef94171a84c828fd4c0b4a8-20210205
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 976503263; Fri, 05 Feb 2021 09:28:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Feb 2021 09:28:13 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Feb 2021 09:28:13 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>, Argus Lin <argus.lin@mediatek.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 0/5] Add PMIC wrapper support for Mediatek MT6873/8192 SoC IC
Date:   Fri, 5 Feb 2021 09:28:06 +0800
Message-ID: <1612488491-6149-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for new SoC MT6873/8192 to the pmic-wrap driver.

changes since v4:
- refine code about PWRAP_CAP_ARB capacity for better code quality.
- update correct pwrap node in the Mediatek MT8192 dtsi.

Hsin-Hsiung Wang (5):
  soc: mediatek: pwrap: use BIT() macro
  soc: mediatek: pwrap: add arbiter capability
  dt-bindings: mediatek: add compatible for MT6873/8192 pwrap
  soc: mediatek: pwrap: add pwrap driver for MT6873/8192 SoCs
  arm64: dts: mt8192: add pwrap node

 .../bindings/soc/mediatek/pwrap.txt           |  1 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 12 +++
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 97 ++++++++++++++++---
 3 files changed, 95 insertions(+), 15 deletions(-)

-- 
2.18.0

