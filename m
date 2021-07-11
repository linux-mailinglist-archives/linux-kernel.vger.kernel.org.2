Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388093C3AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 08:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGKG47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 02:56:59 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:45266 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229544AbhGKG4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 02:56:53 -0400
X-UUID: 95fff9e6adaf45afafd769fe17e608a5-20210711
X-UUID: 95fff9e6adaf45afafd769fe17e608a5-20210711
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 80348313; Sun, 11 Jul 2021 14:53:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 11 Jul 2021 14:53:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 11 Jul 2021 14:53:53 +0800
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
Subject: [PATCHi v3] drm/mediatek: adjust rdma fifo threshold calculate formula
Date:   Sun, 11 Jul 2021 14:53:50 +0800
Message-ID: <1625986431-27399-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change since v2:
- add more commit message


Yongqiang Niu (1):
  drm/mediatek: adjust rdma fifo threshold calculate formula

 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.1.1.dirty

