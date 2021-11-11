Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9B744D106
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhKKE4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:56:42 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48784 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229699AbhKKE4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:56:39 -0500
X-UUID: cdd2fb37af2044a3884bf40e1a2a5e8a-20211111
X-UUID: cdd2fb37af2044a3884bf40e1a2a5e8a-20211111
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1736305020; Thu, 11 Nov 2021 12:53:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 11 Nov 2021 12:53:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Nov 2021 12:53:47 +0800
From:   James Lo <james.lo@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        James Lo <james.lo@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v14 0/3] Add SPMI support for Mediatek SoC IC
Date:   Thu, 11 Nov 2021 12:53:41 +0800
Message-ID: <20211111045344.11664-1-james.lo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for new SoC MT6873/MT8192/MT8195 to the spmi driver.
This series is based on Chun-Jie's patches[1].

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=521655

changes since v13:
- rebase to v5.15-rc1.
- merge two patch(1,2) to one patch(1) to fix yaml error
  patch 1. dt-bindings: spmi: modify the constraint of reg property
  patch 2. dt-bindings: spmi: document binding for the Mediatek SPMI controller

James Lo (3):
  dt-bindings: spmi: modify the constraint of reg property
  spmi: mediatek: Add support for MT6873/8192
  spmi: mediatek: Add support for MT8195

Henry Chen (1):
  spmi: mediatek: Add support for MT8195

Hsin-Hsiung Wang (3):
  dt-bindings: spmi: modify the constraint of reg property
  dt-bindings: spmi: document binding for the Mediatek SPMI controller
  spmi: mediatek: Add support for MT6873/8192

 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      |  76 +++
 .../devicetree/bindings/spmi/spmi.yaml        |   3 +-
 drivers/spmi/Kconfig                          |  11 +
 drivers/spmi/Makefile                         |   1 +
 drivers/spmi/spmi-mtk-pmif.c                  | 542 ++++++++++++++++++
 5 files changed, 632 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
 create mode 100644 drivers/spmi/spmi-mtk-pmif.c

--
2.18.0

