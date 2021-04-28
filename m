Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334CC36D076
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 04:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbhD1CKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 22:10:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49981 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236818AbhD1CKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 22:10:05 -0400
X-UUID: 3f093d49dbf848679c7199f17b9aa5fe-20210428
X-UUID: 3f093d49dbf848679c7199f17b9aa5fe-20210428
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 864058796; Wed, 28 Apr 2021 10:08:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Apr 2021 10:08:55 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Apr 2021 10:08:53 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1] MTK_MMSYS tristrate support
Date:   Wed, 28 Apr 2021 10:08:50 +0800
Message-ID: <1619575731-23388-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MTK_MMSYS tristrate support

Chun-Hung Wu (1):
  [ALPS05103552] soc: mediatek: MTK_MMSYS tristrate support

 drivers/soc/mediatek/Kconfig     | 2 +-
 drivers/soc/mediatek/mtk-mmsys.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
1.8.1.1.dirty

