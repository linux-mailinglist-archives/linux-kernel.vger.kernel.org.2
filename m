Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AB8396E46
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhFAHz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:55:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39600 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233142AbhFAHz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:55:58 -0400
X-UUID: 52d472c5f2bf47cfa8a9c1ec5446390f-20210601
X-UUID: 52d472c5f2bf47cfa8a9c1ec5446390f-20210601
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 488264301; Tue, 01 Jun 2021 15:54:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 15:54:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 15:54:10 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [v3 1/0] Add basic node support for Mediatek MT8195 SoC 
Date:   Tue, 1 Jun 2021 15:53:49 +0800
Message-ID: <20210601075350.31515-1-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA55 and 4 CA78 cores.
MT8195 share many HW IP with MT65xx series.
This patchset was tested on MT8195 evaluation board to shell.

Based on v5.13-rc4

Changes in v3
Add spi and pinctrl nodes

Changes in v2
Fix make dt_binding_check warning in mediatek,ufs-phy.yaml
Update usb phy and ufs phy nodes in mt8195.dtsi

Seiya Wang (1):
  arm64: dts: Add Mediatek SoC MT8195 and evaluation board dts and
    Makefile

 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts |  29 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 561 ++++++++++++++++++++++++++++
 3 files changed, 591 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi

--
2.14.1

