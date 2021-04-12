Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ADD35C838
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbhDLOFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:05:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40195 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242133AbhDLOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:05:14 -0400
X-UUID: a31a3040b37f4cb483768e4522d2b267-20210412
X-UUID: a31a3040b37f4cb483768e4522d2b267-20210412
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 681847970; Mon, 12 Apr 2021 22:04:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 22:04:51 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 22:04:50 +0800
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
Subject: [PATCH v5, 0/4] soc: mediatek: mmsys: add mt8192 mmsys support
Date:   Mon, 12 Apr 2021 22:04:44 +0800
Message-ID: <1618236288-1617-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 67328E97F3056148482F62F7740128E2AC02CFD2990A87D1B2F4B07527D542662000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

base 5.12-rc2 and
https://patchwork.kernel.org/project/linux-mediatek/patch/20210330110423.3542163-1-hsinyi@chromium.org/

Change since v4:
- use routing table

Yongqiang Niu (4):
  soc: mediatek: mmsys: add component OVL_2L2
  soc: mediatek: mmsys: add component POSTMASK
  soc: mediatek: mmsys: add component RDMA4
  soc: mediatek: mmsys: Add mt8192 mmsys routing table

 drivers/soc/mediatek/mt8192-mmsys.h    | 68 ++++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c       |  7 ++++
 include/linux/soc/mediatek/mtk-mmsys.h |  3 ++
 3 files changed, 78 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8192-mmsys.h

-- 
1.8.1.1.dirty

