Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820CF39026A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhEYN2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:28:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48769 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233192AbhEYN1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:27:14 -0400
X-UUID: aa624e9df87345d3aab3a9e263f07b6a-20210525
X-UUID: aa624e9df87345d3aab3a9e263f07b6a-20210525
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1475453381; Tue, 25 May 2021 21:25:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 May 2021 21:25:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 May 2021 21:25:38 +0800
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
Subject: [v3 0/2] Add MediaTek MT8192 clock provider device nodes
Date:   Tue, 25 May 2021 21:24:57 +0800
Message-ID: <20210525132459.8741-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- this series is based on v5.13-rc3 and dependents on
"Mediatek MT8192 clock support"[1].
- add devcie tree reviewer to list.

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=487577

chun-jie.chen (2):
  arm64: dts: mediatek: Add mt8192 clock controllers
  arm64: dts: mediatek: Correct UART0 bus clock of MT8192

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 165 ++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

--
2.18.0

