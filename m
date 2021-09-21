Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD44138CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhIURmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:42:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43910 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhIURmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:42:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18LHf0GX073594;
        Tue, 21 Sep 2021 12:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632246060;
        bh=ZEvcd4bKdnvDOnbLEfPXK8/ZuovFhRySDpkPisyUCDY=;
        h=From:To:CC:Subject:Date;
        b=BuBhC5kWcoTZJR+0UGDdJdUSfh2gKQd3zjJbdJUOhJ1nzTcdCzEc0AsdJxYqrDNxc
         8V1JUA15gOX46kZvRkNbRX4dtuIro1Grdx7TThGGlW9HpHuB/Wg5+f/0aqIAcZ2hhJ
         uryZeNOqZrBi+x1pOFX//19o5bsbYnz1PnrzV7jg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18LHf0MK029037
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Sep 2021 12:41:00 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 21
 Sep 2021 12:41:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 21 Sep 2021 12:41:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18LHf0Mw060468;
        Tue, 21 Sep 2021 12:41:00 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>, <nikhil.nd@ti.com>,
        <r-ravikumar@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] drm/bridge: cdns-dsi: Make sure to to create proper aliases for dt
Date:   Tue, 21 Sep 2021 12:40:59 -0500
Message-ID: <20210921174059.17946-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MODULE_DEVICE_TABLE to the device tree table to create required
aliases needed for module to be loaded with device tree based platform.

Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index d8a15c459b42..829e1a144656 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -1284,6 +1284,7 @@ static const struct of_device_id cdns_dsi_of_match[] = {
 	{ .compatible = "cdns,dsi" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, cdns_dsi_of_match);
 
 static struct platform_driver cdns_dsi_platform_driver = {
 	.probe  = cdns_dsi_drm_probe,
-- 
2.32.0

