Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CFB35C4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbhDLLTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:19:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36368 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237720AbhDLLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:19:13 -0400
X-UUID: 6daa5e11bce24eecac98f2b0f015ac4f-20210412
X-UUID: 6daa5e11bce24eecac98f2b0f015ac4f-20210412
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1894990616; Mon, 12 Apr 2021 19:18:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 19:18:47 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 19:18:46 +0800
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
Subject: [PATCH v2, 0/5] Revert "mailbox: mediatek: remove implementation related to atomic_exec"
Date:   Mon, 12 Apr 2021 19:18:40 +0800
Message-ID: <1618226325-31927-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 389E8F4DE8E8662A451C1C9F583FBEB83B881827185D9C0ABC3A443A8DB4570F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series base linux 5.12-rc2
these patches will cause home ui flick when cursor moved,
there is no fix solution yet, revert these patches first.

change since v1:
add mtk-gce.txt and dts modification

Yongqiang Niu (5):
  Revert "drm/mediatek: Make sure previous message done or be aborted
    before send"
  Revert "mailbox: mediatek: remove implementation related to
    atomic_exec"
  Revert "dt-bindings: mailbox: mtk-gce: fix incorrect mbox-cells value"
  Revert "arm64: dts: mediatek: mt8183: fix gce incorrect mbox-cells
    value"
  arm64: dts: mediatek: mt8183: add gce information for mmsys

 .../devicetree/bindings/mailbox/mtk-gce.txt        |  2 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  5 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  1 -
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 80 +++++++++++++++++++---
 4 files changed, 76 insertions(+), 12 deletions(-)

-- 
1.8.1.1.dirty

