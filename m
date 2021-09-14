Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6C40AC77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhINLid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:38:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51632 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232024AbhINLic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:38:32 -0400
X-UUID: 9629ee9c86854d509c63fd7e5df02153-20210914
X-UUID: 9629ee9c86854d509c63fd7e5df02153-20210914
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 476458489; Tue, 14 Sep 2021 19:37:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 19:37:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 19:37:07 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v4 00/13] MT8195 SMI support
Date:   Tue, 14 Sep 2021 19:36:50 +0800
Message-ID: <20210914113703.31466-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset mainly adds SMI support for mt8195.

Comparing with the previous version, add two new functions:
a) add smi sub common
b) add initial setting for smi-common and smi-larb.

Change note:
v4:1) base on v5.15-rc1
   2) In the dt-binding:
      a. add "else mediatek,smi: false." in the yaml.
      b. Remove mediatek,smi_sub_common. since we have only 2 level currently,
      It should be smi-sub-common if that node has "mediatek,smi". otherwise,
      it is smi-common.

v3: https://lore.kernel.org/linux-mediatek/20210810080859.29511-1-yong.wu@mediatek.com/
   1)in the dt-binding:
       a. change mediatek,smi type from phandle-array to phandle from Rob.
       b. Add a new bool property (mediatek,smi_sub_common)
          to indicate if this is smi-sub-common.
   2)change the clock using bulk parting.
     keep the smi-common's flag. more strict.
   3) more comment about larb initial setting.
       
v2: https://lore.kernel.org/linux-mediatek/20210715121209.31024-1-yong.wu@mediatek.com/
    rebase on v5.14-rc1
    1) Adjust clk_bulk flow: use devm_clk_bulk_get for necessary clocks.
    2) Add two new little patches:
       a) use devm_platform_ioremap_resource
       b) Add error handle for smi_probe

v1: https://lore.kernel.org/linux-mediatek/20210616114346.18812-1-yong.wu@mediatek.com/

Yong Wu (13):
  dt-bindings: memory: mediatek: Add mt8195 smi binding
  dt-bindings: memory: mediatek: Add mt8195 smi sub common
  memory: mtk-smi: Use clk_bulk clock ops
  memory: mtk-smi: Rename smi_gen to smi_type
  memory: mtk-smi: Adjust some code position
  memory: mtk-smi: Add error handle for smi_probe
  memory: mtk-smi: Add device link for smi-sub-common
  memory: mtk-smi: Add clocks for smi-sub-common
  memory: mtk-smi: Use devm_platform_ioremap_resource
  memory: mtk-smi: mt8195: Add smi support
  memory: mtk-smi: mt8195: Add initial setting for smi-common
  memory: mtk-smi: mt8195: Add initial setting for smi-larb
  MAINTAINERS: Add entry for MediaTek SMI

 .../mediatek,smi-common.yaml                  |  34 +-
 .../memory-controllers/mediatek,smi-larb.yaml |   3 +
 MAINTAINERS                                   |   8 +
 drivers/memory/mtk-smi.c                      | 596 ++++++++++--------
 4 files changed, 393 insertions(+), 248 deletions(-)

-- 
2.18.0


