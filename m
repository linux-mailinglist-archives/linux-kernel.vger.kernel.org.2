Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C7B348E96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCYLKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:10:52 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:47062 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhCYLKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:10:39 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id C58D29803E4;
        Thu, 25 Mar 2021 19:10:33 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Tomi Valkeinen <tomba@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wan Jiabing <wanjiabing@vivo.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] [v2] drivers: gpu: drm: Remove duplicate declaration
Date:   Thu, 25 Mar 2021 19:10:24 +0800
Message-Id: <20210325111028.864628-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTx9MTx8eSR0aTB4fVkpNSk1NTEtNSE9LQ05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6PCo*Aj8VKD4NKw9CCigR
        TQ8KCjdVSlVKTUpNTUxLTUhPT0NNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJSEhPNwY+
X-HM-Tid: 0a7869143022d992kuwsc58d29803e4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct dss_device has been declared. Remove the duplicate.
And sort these forward declarations alphabetically.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Sort forward declarations alphabetically.
---
 drivers/gpu/drm/omapdrm/dss/omapdss.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index a40abeafd2e9..040d5a3e33d6 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -48,16 +48,15 @@
 #define DISPC_IRQ_ACBIAS_COUNT_STAT3	(1 << 29)
 #define DISPC_IRQ_FRAMEDONE3		(1 << 30)
 
-struct dss_device;
-struct omap_drm_private;
-struct omap_dss_device;
 struct dispc_device;
+struct drm_connector;
 struct dss_device;
 struct dss_lcd_mgr_config;
+struct hdmi_avi_infoframe;
+struct omap_drm_private;
+struct omap_dss_device;
 struct snd_aes_iec958;
 struct snd_cea_861_aud_if;
-struct hdmi_avi_infoframe;
-struct drm_connector;
 
 enum omap_display_type {
 	OMAP_DISPLAY_TYPE_NONE		= 0,
-- 
2.25.1

