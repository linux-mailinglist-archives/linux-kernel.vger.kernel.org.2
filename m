Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AD4339172
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhCLPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:35:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37155 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232054AbhCLPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:35:08 -0500
X-UUID: 587e38193977447a9686ac83f10f885c-20210312
X-UUID: 587e38193977447a9686ac83f10f885c-20210312
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 270732600; Fri, 12 Mar 2021 23:34:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Mar 2021 23:34:51 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Mar 2021 23:34:51 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <drinkcat@chromium.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v6 0/5] Add PMIC wrapper support for Mediatek MT6873/8192 SoC IC
Date:   Fri, 12 Mar 2021 23:34:41 +0800
Message-ID: <1615563286-22126-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for new SoC MT6873/8192 to the pmic-wrap driver.
This series is based on Weiyi's patches[1].

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/1608642587-15634-7-git-send-email-weiyi.lu@mediatek.com/

changes since v5:
- rebase to Linux 5.12

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

