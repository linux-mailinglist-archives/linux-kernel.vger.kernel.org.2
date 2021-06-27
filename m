Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA53B5299
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 10:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhF0IuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 04:50:15 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:42328 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhF0IuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 04:50:14 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 0A31ACF056;
        Sun, 27 Jun 2021 16:47:45 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12363T139708910794496S1624783659924687_;
        Sun, 27 Jun 2021 16:47:46 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <456593cc75213b8b0db436fb9310d05b>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-RCPT-COUNT: 7
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Andy Yan <andy.yan@rock-chips.com>
To:     hjc@rock-chips.com, heiko@sntech.de,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/rockchip: Check iommu itself instead of it's parent for device_is_available
Date:   Sun, 27 Jun 2021 16:47:37 +0800
Message-Id: <20210627084737.309163-1-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When iommu itself is disabled in dts, we should
fallback to non-iommu buffer, check iommu parent
is meanless here.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 212bd87c0c4a..0d20c8cc1ffa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -366,7 +366,7 @@ static int rockchip_drm_platform_of_probe(struct device *dev)
 		}
 
 		iommu = of_parse_phandle(port->parent, "iommus", 0);
-		if (!iommu || !of_device_is_available(iommu->parent)) {
+		if (!iommu || !of_device_is_available(iommu)) {
 			DRM_DEV_DEBUG(dev,
 				      "no iommu attached for %pOF, using non-iommu buffers\n",
 				      port->parent);
-- 
2.25.1



