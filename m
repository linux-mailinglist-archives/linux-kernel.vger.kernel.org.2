Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DFB333688
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhCJHnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:43:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36959 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232204AbhCJHmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:42:33 -0500
X-UUID: 815a1e554c3e4de5874394ecb9f3ac63-20210310
X-UUID: 815a1e554c3e4de5874394ecb9f3ac63-20210310
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 98255046; Wed, 10 Mar 2021 15:42:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Mar 2021 15:42:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Mar 2021 15:42:16 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 0/2] Revert "mailbox: mediatek: remove implementation related to atomic_exec"
Date:   Wed, 10 Mar 2021 15:42:10 +0800
Message-ID: <1615362132-30603-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series base linux 5.12-rc1
these two patches will cause home ui flick when cursor moved,
there is no fix solution yet, revert these patches first.

Yongqiang Niu (2):
  Revert "drm/mediatek: Make sure previous message done or be aborted
    before send"
  Revert "mailbox: mediatek: remove implementation related to
    atomic_exec"

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  1 -
 drivers/mailbox/mtk-cmdq-mailbox.c      | 80 +++++++++++++++++++++++++++++----
 2 files changed, 71 insertions(+), 10 deletions(-)

-- 
1.8.1.1.dirty

