Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FB343E78
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCVKxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhCVKxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:53:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B135861585;
        Mon, 22 Mar 2021 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616410400;
        bh=dgFzVnRh0FbIORkPoqNN87sf585VX/uTn2y5kQW8Hro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCiV//so53WUOq7dRrF8KK3IJ4Lpd9GKJ8HbUGEsYSesGyXSRjqhwVzVCwranxQ7r
         VM9b4tNbRwXFCRHmZUQEqcQL6vVhOXjXDcbO5T1LrcYp8AMH+FuQXQbjX+o2ZspSy2
         qxmOK1A1aJhvQt8H70vzrL7bM/yAVUyB4hRuABBIukZkAnPZnV2FcfzMr5yodk9iZP
         y7fQywTeomlVUGK8LIiT9C8/cqI9CnpaRhCkvqLpQhZpYZW+ljo1sP8OmIgXtteBfD
         sSt5McPUvfdHshGgD6WIf+DWHyOMTCFGSt6CyRdDyaW5Y2eiS9jn5+5T0nBNTPiP0z
         DqrnwpU7et9Eg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Yue Zou <zouyue3@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] vgaarb: avoid -Wempty-body warnings
Date:   Mon, 22 Mar 2021 11:53:00 +0100
Message-Id: <20210322105307.1291840-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210322105307.1291840-1-arnd@kernel.org>
References: <20210322105307.1291840-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a few warnings for an empty macro:

drivers/gpu/drm/qxl/qxl_drv.c: In function 'qxl_pci_probe':
drivers/gpu/drm/qxl/qxl_drv.c:131:50: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  131 |                 vga_put(pdev, VGA_RSRC_LEGACY_IO);
      |                                                  ^
drivers/gpu/drm/qxl/qxl_drv.c: In function 'qxl_pci_remove':
drivers/gpu/drm/qxl/qxl_drv.c:159:50: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  159 |                 vga_put(pdev, VGA_RSRC_LEGACY_IO);

Change this to an inline function to make it more robust and avoid
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/vgaarb.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index fc6dfeba04a5..dc6ddce92066 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -112,7 +112,9 @@ static inline int vga_get_uninterruptible(struct pci_dev *pdev,
 #if defined(CONFIG_VGA_ARB)
 extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
 #else
-#define vga_put(pdev, rsrc)
+static inline void vga_put(struct pci_dev *pdev, unsigned int rsrc)
+{
+}
 #endif
 
 
-- 
2.29.2

