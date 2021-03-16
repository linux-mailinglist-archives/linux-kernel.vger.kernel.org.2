Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859AB33CC13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhCPD1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:27:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57918 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230177AbhCPD01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:26:27 -0400
X-UUID: 08ec2b288ac447708e491901afcd8170-20210316
X-UUID: 08ec2b288ac447708e491901afcd8170-20210316
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 702542839; Tue, 16 Mar 2021 11:26:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 11:26:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 11:26:22 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [RESEND,v4,0/2] Add check for max clock rate in mode_valid
Date:   Tue, 16 Mar 2021 11:26:17 +0800
Message-ID: <1615865179-22051-1-git-send-email-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
  add Author and add patch description

Rex-BC Chen (2):
  drm/mediatek: mtk_dpi: Add check for max clock rate in mode_valid
  drm/mediatek: mtk_dpi: Add dpi config for mt8192

 drivers/gpu/drm/mediatek/mtk_dpi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.18.0

