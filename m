Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0333867C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhCLHUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:20:32 -0500
Received: from m12-17.163.com ([220.181.12.17]:47236 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhCLHUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=E1I51
        7xxvK7g3rGfwB8KIhZ2f7fCT3nY+bZTzzZ3FbM=; b=BiOu+anaQsAwAPlBp9LZ7
        xeCCYjX8TxUHzzs+WrE52Bb9a2LbU9z1R+fg+qLsFFT1I410tG0IKWpXmt9dnXj6
        HIf8bock8fp9qnumOImtmQVy98E7CftNMBMd0ZmvOiZomh0DpYIyBXKvKxmOq2+s
        qCxm0UHtwme/dfKQ7X0YrY=
Received: from yangjunlin.ccdomain.com (unknown [119.137.52.39])
        by smtp13 (Coremail) with SMTP id EcCowAAHBo7VFUtg3tQRpg--.3254S2;
        Fri, 12 Mar 2021 15:18:46 +0800 (CST)
From:   angkery <angkery@163.com>
To:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        sebastian.reichel@collabora.com, laurent.pinchart@ideasonboard.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] drm/omap: dsi: fix unsigned expression compared with zero
Date:   Fri, 12 Mar 2021 15:14:45 +0800
Message-Id: <20210312071445.1721-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAAHBo7VFUtg3tQRpg--.3254S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1DCr1fKr4rGr4xtw1UKFg_yoWDCFc_CF
        1Ivr13WrWUCF9rZr4ayay7Zry09F1SvFWrWr12qa4fA3yaqr9rJ3srCFyxXw1DCF4UtF95
        G3WDur1fZan7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0j0P7UUUUU==
X-Originating-IP: [119.137.52.39]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbiKxZTI1QHWs6ysAAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

r is "u32" always >= 0,mipi_dsi_create_packet may return little than zero.
so r < 0 condition is never accessible.

Fixes coccicheck warnings:
./drivers/gpu/drm/omapdrm/dss/dsi.c:2155:5-6:
WARNING: Unsigned expression compared with zero: r < 0

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 8e11612..b31d750 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2149,11 +2149,12 @@ static int dsi_vc_send_short(struct dsi_data *dsi, int vc,
 			     const struct mipi_dsi_msg *msg)
 {
 	struct mipi_dsi_packet pkt;
+	int ret;
 	u32 r;
 
-	r = mipi_dsi_create_packet(&pkt, msg);
-	if (r < 0)
-		return r;
+	ret = mipi_dsi_create_packet(&pkt, msg);
+	if (ret < 0)
+		return ret;
 
 	WARN_ON(!dsi_bus_is_locked(dsi));
 
-- 
1.9.1


