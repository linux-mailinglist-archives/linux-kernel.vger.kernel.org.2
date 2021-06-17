Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506693AADDE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFQHoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:44:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40638 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229666AbhFQHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:44:16 -0400
X-UUID: 2bc6f1cdb9354397be6d45292bb56b4a-20210617
X-UUID: 2bc6f1cdb9354397be6d45292bb56b4a-20210617
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1423397580; Thu, 17 Jun 2021 15:41:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 15:41:39 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 15:41:39 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH] spmi: of: Populate fwnode in of_spmi_register_devices
Date:   Thu, 17 Jun 2021 15:41:33 +0800
Message-ID: <1623915693-18727-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the of_devlink feature to work across spmi devices. This
avoid unnecessary probe deferrals of spmi devices, defers consumers of spmi
devices till the spmi devices probe, and allows spmi drivers to implement
sync_state() callbacks.

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
 drivers/spmi/spmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 51f5aeb65b3b..0e679a483ce9 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -498,6 +498,7 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 			continue;
 
 		sdev->dev.of_node = node;
+		sdev->dev.fwnode = of_fwnode_handle(node);
 		sdev->usid = (u8)reg[0];
 
 		err = spmi_device_add(sdev);
-- 
2.18.0

