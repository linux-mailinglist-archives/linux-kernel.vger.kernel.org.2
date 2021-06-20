Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A773ADE11
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFTLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:17:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46675 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229541AbhFTLRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:17:20 -0400
X-UUID: 19cb3f1bdab44152a1812d68f21463a9-20210620
X-UUID: 19cb3f1bdab44152a1812d68f21463a9-20210620
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1502927123; Sun, 20 Jun 2021 19:15:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 20 Jun 2021 19:15:02 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 20 Jun 2021 19:15:01 +0800
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v6, 0/2] soc: mediatek: mmsys: add mt8192 mmsys support
Date:   Sun, 20 Jun 2021 19:14:56 +0800
Message-ID: <1624187698-29040-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

base 5.13-rc1

Change since v5:
- squash ddp component into one patch
- add 8192 mmsys compatible data

Yongqiang Niu (2):
  soc: mediatek: mmsys: add comp OVL_2L2/POSTMASK/RDMA4
  soc: mediatek: mmsys: Add mt8192 mmsys routing table

 drivers/soc/mediatek/mt8192-mmsys.h    | 68 ++++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c       | 11 ++++++
 include/linux/soc/mediatek/mtk-mmsys.h |  3 ++
 3 files changed, 82 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8192-mmsys.h

-- 
1.8.1.1.dirty

