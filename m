Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E894735F4E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351390AbhDNNfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:35:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60306 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351379AbhDNNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:35:47 -0400
X-UUID: d50bd9637d1440b5b945737d1e2930f8-20210414
X-UUID: d50bd9637d1440b5b945737d1e2930f8-20210414
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1462332318; Wed, 14 Apr 2021 21:35:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 21:35:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 21:35:21 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [v2,PATCH 0/3] mt8183 dpi supports dual edge
Date:   Wed, 14 Apr 2021 21:35:13 +0800
Message-ID: <1618407316-10042-1-git-send-email-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
modify unused code

v1:
DPI can sample on falling, rising or both edge.
When DPI sample the data both rising and falling edge.
It can reduce half data io pins.

Rex-BC Chen (3):
  drm/mediatek: dpi dual edge sample mode support
  drm/mediatek: config mt8183 driver data to support dual edge sample
  drm/mediatek: dpi: add bus format negotiation

 drivers/gpu/drm/mediatek/mtk_dpi.c | 102 +++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 5 deletions(-)

-- 
2.18.0

