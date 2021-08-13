Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EBE3EAE61
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhHMCIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:08:06 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34458 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234875AbhHMCIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:08:05 -0400
X-UUID: de68473641a345ddbd1207169226d919-20210813
X-UUID: de68473641a345ddbd1207169226d919-20210813
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 244095969; Fri, 13 Aug 2021 10:07:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 13 Aug 2021 10:07:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 10:07:34 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <thierry.reding@gmail.com>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [V1] drm/panel: panel-simple: Add delay for LG LP120UP1
Date:   Fri, 13 Aug 2021 10:06:30 +0800
Message-ID: <20210813020630.12052-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power sequence for LG LP120UP1.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 21939d4..15cefb0 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2886,6 +2886,11 @@ static const struct panel_desc lg_lp120up1 = {
 		.width = 267,
 		.height = 183,
 	},
+	.delay = {
+		.prepare = 200,
+		.enable = 50,
+		.unprepare = 500,
+	},
 	.connector_type = DRM_MODE_CONNECTOR_eDP,
 };
 
-- 
2.6.4

