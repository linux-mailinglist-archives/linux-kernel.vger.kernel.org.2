Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B39348816
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhCYEvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:51:07 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:64732 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCYEui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:50:38 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 96B9D9802DD;
        Thu, 25 Mar 2021 12:50:35 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Tomi Valkeinen <tomba@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drivers: gpu: drm: Remove duplicate declaration
Date:   Thu, 25 Mar 2021 12:50:19 +0800
Message-Id: <20210325045022.847135-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS0pPGkpISRpDTU5IVkpNSk1NT0xDSE1KSkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6KCo6GD8cMD48ARcjDh0h
        PQwwCjVVSlVKTUpNTU9MQ0hNT01DVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0xPNwY+
X-HM-Tid: 0a7867b85184d992kuws96b9d9802dd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct dss_device has been declared at 51st line. 
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/omapdrm/dss/omapdss.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index a40abeafd2e9..2658aadee09a 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -52,7 +52,6 @@ struct dss_device;
 struct omap_drm_private;
 struct omap_dss_device;
 struct dispc_device;
-struct dss_device;
 struct dss_lcd_mgr_config;
 struct snd_aes_iec958;
 struct snd_cea_861_aud_if;
-- 
2.25.1

