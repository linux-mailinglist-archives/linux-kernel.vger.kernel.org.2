Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB413DD272
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhHBJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:00:23 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:54942 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232797AbhHBJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:00:22 -0400
X-UUID: 753824cad39942afb4423d7b88fc64c4-20210802
X-UUID: 753824cad39942afb4423d7b88fc64c4-20210802
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 897656668; Mon, 02 Aug 2021 17:00:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Aug 2021 17:00:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 2 Aug 2021 17:00:05 +0800
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
Subject: [PATCH v8, 0/2] soc: mediatek: mmsys: add mt8192 mmsys support
Date:   Mon, 2 Aug 2021 16:59:31 +0800
Message-ID: <1627894773-23872-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

base v5.14-rc1

Yongqiang Niu (2):
  soc: mediatek: mmsys: add comp OVL_2L2/POSTMASK/RDMA4
  soc: mediatek: mmsys: Add mt8192 mmsys routing table

 drivers/soc/mediatek/mt8192-mmsys.h    | 67 ++++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c       | 11 ++++++
 include/linux/soc/mediatek/mtk-mmsys.h |  3 ++
 3 files changed, 81 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8192-mmsys.h

-- 
1.8.1.1.dirty

