Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0318E3A9970
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhFPLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:46:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60453 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231293AbhFPLqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:46:07 -0400
X-UUID: eaa4fc46f8d949179b2b4466298c972d-20210616
X-UUID: eaa4fc46f8d949179b2b4466298c972d-20210616
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1033287267; Wed, 16 Jun 2021 19:43:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 19:43:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 19:43:54 +0800
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
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>
Subject: [PATCH 0/9] MT8195 SMI support
Date:   Wed, 16 Jun 2021 19:43:37 +0800
Message-ID: <20210616114346.18812-1-yong.wu@mediatek.com>
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

Yong Wu (9):
  dt-bindings: memory: mediatek: Add mt8195 smi binding
  dt-bindings: memory: mediatek: Add mt8195 smi sub common
  memory: mtk-smi: Use clk_bulk instead of the clk ops
  memory: mtk-smi: Rename smi_gen to smi_type
  memory: mtk-smi: Adjust some code position
  memory: mtk-smi: Add smi sub common support
  memory: mtk-smi: mt8195: Add smi support
  memory: mtk-smi: mt8195: Add initial setting for smi-common
  memory: mtk-smi: mt8195: Add initial setting for smi-larb

 .../mediatek,smi-common.yaml                  |  31 +-
 .../memory-controllers/mediatek,smi-larb.yaml |   3 +
 drivers/memory/mtk-smi.c                      | 568 ++++++++++--------
 3 files changed, 347 insertions(+), 255 deletions(-)

-- 
2.18.0


