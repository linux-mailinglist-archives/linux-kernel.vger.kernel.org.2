Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F265452E56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhKPJwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:52:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39378 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232326AbhKPJwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:36 -0500
X-UUID: cd9c244e7e0f4913898cfe75c63eaddc-20211116
X-UUID: cd9c244e7e0f4913898cfe75c63eaddc-20211116
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2124132109; Tue, 16 Nov 2021 17:49:36 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Nov 2021 17:49:35 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Nov
 2021 17:49:34 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 16 Nov 2021 17:49:33 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, <shuijing.li@mediatek.com>,
        <liangxu.xu@mediatek.com>, <xinlei.li@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3 0/2] seperate panel power control from panel prepare/unprepare
Date:   Tue, 16 Nov 2021 17:49:28 +0800
Message-ID: <20211116094930.11470-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 - Panel driver panel-boe-tv101wum-nl6.c provides the power sequence apis.
 - The apis are called before dsi poweron and after dsi poweroff.

Changes since v1:
 - Fix null point when dsi next bridge isn't a panel.
 - "dsi mmsys reset" is implement by
   https://patchwork.kernel.org/project/linux-mediatek/list/?series=515355

Jitao Shi (2):
  drm/panel: panel-boe-tv101wum-nl6: tune the power sequence to avoid
    leakage
  drm/mediatek: control panel's power before MIPI LP11

 drivers/gpu/drm/mediatek/mtk_dsi.c             | 28 ++++++--
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 88 +++++++++++++++++++-------
 include/drm/panel_boe_tv101wum_nl6.h           | 28 ++++++++
 3 files changed, 116 insertions(+), 28 deletions(-)
 create mode 100644 include/drm/panel_boe_tv101wum_nl6.h

-- 
2.12.5

