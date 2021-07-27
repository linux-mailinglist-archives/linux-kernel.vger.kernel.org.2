Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2F03D6BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 04:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhG0Bwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 21:52:39 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51496 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233727AbhG0Bwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 21:52:36 -0400
X-UUID: bfc80708d5e041d39685954e3d7981a2-20210727
X-UUID: bfc80708d5e041d39685954e3d7981a2-20210727
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1889454468; Tue, 27 Jul 2021 10:33:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 10:33:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 27 Jul 2021 10:33:00 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [v6 0/2] Add MediaTek MT8192 clock provider device nodes
Date:   Tue, 27 Jul 2021 10:32:03 +0800
Message-ID: <20210727023205.20319-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on v5.14-rc1 and depends on [1].

change since v5:
- no change (rebased to 5.14)

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=521127

Chun-Jie Chen (2):
  arm64: dts: mediatek: Add mt8192 clock controllers
  arm64: dts: mediatek: Correct UART0 bus clock of MT8192

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 165 ++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)


base-commit: c977bba059550dba24ac6233b11c69f4edc1a968
prerequisite-patch-id: 82ced16215cdd31201c6146ddb5c30bc17525996
prerequisite-patch-id: 7f2137e77cfc439c2e4b4e4369a6d6b48fec1ece
prerequisite-patch-id: 15f52bb664f0f0436627d056a53afefb0b99f67a
prerequisite-patch-id: 479b44dfdc6d7b367c0d441d8635d2dc02466057
prerequisite-patch-id: 5df1858972e343d3750cdda1063655fc232eb831
prerequisite-patch-id: 7e63a29430f65c2a0d56d7353df884645d70ed8c
prerequisite-patch-id: 2a6200e8a05329d51aaa4fd63aacfbba66d16177
prerequisite-patch-id: 604d2702c4217b77de3dc305ff08f630ba38fdb4
prerequisite-patch-id: d3ece2688dbd45eee248a8c6ba3206c0c673c904
prerequisite-patch-id: 1bebe1cd9b267c974cae50c3df8c0f8f4f0b0b3d
prerequisite-patch-id: 3b34fe85667da5287bde9fd2378359be4a126266
prerequisite-patch-id: 5d3d139212ab304739b75f7638251703b95948d5
prerequisite-patch-id: 621291b21be177a63eaf6769aa6d2ee8ddb2ea2b
prerequisite-patch-id: 024f786586b409420782d24218b15f05f6476667
prerequisite-patch-id: 946aae93303bde26226289dc389c94de96a9dacd
prerequisite-patch-id: b3ddf6f2079c3c269bd24091243030a971c43cbc
prerequisite-patch-id: 5c0e0308aa8eb06ca6df6f5467bc925f2cc106ad
prerequisite-patch-id: d4e481acd8b970f08d3e4da9c8fc0ad6e1fff551
prerequisite-patch-id: 99db7309fbe1b9f73a07e25d5174db8976c77a2c
prerequisite-patch-id: cffbc99e9e60f6db43cf7879f17e05c5b041d312
-- 
2.18.0

