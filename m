Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3835C88F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbhDLOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:22:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49289 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237789AbhDLOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:22:11 -0400
X-UUID: 9e6971366be3411a8c3b7fe6304ab90e-20210412
X-UUID: 9e6971366be3411a8c3b7fe6304ab90e-20210412
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 378976004; Mon, 12 Apr 2021 22:21:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 22:21:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 22:21:47 +0800
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
Subject: [PATCH v7, 0/5] drm/mediatek: add support for mediatek SOC MT8192
Date:   Mon, 12 Apr 2021 22:21:41 +0800
Message-ID: <1618237306-17670-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 37C06683C033A3B4145435D9CCEE5594E74145835920BF6B87F3639135F85B752000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on Linux v5.12-rc2
and following patch:
https://patchwork.kernel.org/project/linux-mediatek/cover/1618236288-1617-1-git-send-email-yongqiang.niu@mediatek.com/

Change since v6:
- rebase


Yongqiang Niu (5):
  drm/mediatek: add component OVL_2L2
  drm/mediatek: add component POSTMASK
  drm/mediatek: add component RDMA4
  soc: mediatek: add mtk mutex support for MT8192
  drm/mediatek: add support for mediatek SOC MT8192

 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c   |   6 ++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  20 ++++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   6 ++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 102 ++++++++++++++++++++--------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  42 ++++++++++++
 drivers/soc/mediatek/mtk-mutex.c            |  35 ++++++++++
 7 files changed, 183 insertions(+), 29 deletions(-)

-- 
1.8.1.1.dirty

