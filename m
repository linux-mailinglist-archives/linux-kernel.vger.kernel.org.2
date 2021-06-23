Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3440B3B16E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFWJdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:33:04 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:50801 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230019AbhFWJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:32:55 -0400
X-UUID: cc8c3ed99da24e189df5556f89913480-20210623
X-UUID: cc8c3ed99da24e189df5556f89913480-20210623
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 884459214; Wed, 23 Jun 2021 17:30:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 17:30:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 17:30:26 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v5, 0/3] support gce on mt8192 platform
Date:   Wed, 23 Jun 2021 17:30:20 +0800
Message-ID: <1624440623-4585-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v3:
-rebase on linux 5.13-rc1

Change since v3:
-fix review comment in v2

Change since v2:
- add controy_by_sw for mt8192

Change since v1:
- move out shift jump patch
- remove useless patch


Yongqiang Niu (3):
  dt-binding: gce: add gce header file for mt8192
  arm64: dts: mt8192: add gce node
  mailbox: cmdq: add mt8192 support

 .../devicetree/bindings/mailbox/mtk-gce.txt        |   7 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |  10 +
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  10 +
 include/dt-bindings/gce/mt8192-gce.h               | 335 +++++++++++++++++++++
 4 files changed, 359 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8192-gce.h

-- 
1.8.1.1.dirty

