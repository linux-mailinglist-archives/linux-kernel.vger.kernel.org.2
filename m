Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB5836E3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 06:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbhD2Dqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 23:46:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38552 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237116AbhD2Dql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 23:46:41 -0400
X-UUID: 6237e3a9ae3040b8ba946f44d9de7c69-20210429
X-UUID: 6237e3a9ae3040b8ba946f44d9de7c69-20210429
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 388143764; Thu, 29 Apr 2021 11:45:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Apr 2021 11:45:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Apr 2021 11:45:50 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [v3,PATCH 0/3] mt8183 dpi supports dual edge
Date:   Thu, 29 Apr 2021 11:45:45 +0800
Message-ID: <20210429034548.28030-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
Modify clock rate for dual edge setting.
Add more bridge function.

v2:
Modify unused code

v1:
DPI can sample on falling, rising or both edge.
When DPI sample the data both rising and falling edge.
It can reduce half data io pins.

Rex-BC Chen (3):
  drm/mediatek: dpi dual edge sample mode support
  drm/mediatek: config mt8183 driver data to support dual edge sample
  drm/mediatek: dpi: add bus format negotiation

 drivers/gpu/drm/mediatek/mtk_dpi.c | 107 +++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 6 deletions(-)

-- 
2.18.0

