Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056CD39C812
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 14:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFEMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 08:20:31 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:34106 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhFEMUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 08:20:30 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id 9303838015E;
        Sat,  5 Jun 2021 20:18:40 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/etnaviv: remove NULL check which is not needed
Date:   Sat,  5 Jun 2021 05:18:38 -0700
Message-Id: <20210605121838.8357-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkhNTVZJTBkYGUwaHkNMSU9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Cio*NT8VAQk2MRgWCCs2
        KgNPCypVSlVKTUlJQ0JOTklKS05PVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFKQkJPNwY+
X-HM-Tid: 0a79dc1c6bfdd994kuws9303838015e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL check before kvfree functions is not needed.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index b390dd4d60b7..d741b1d735f7 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -80,8 +80,7 @@ static void etnaviv_gem_prime_release(struct etnaviv_gem_object *etnaviv_obj)
 	/* Don't drop the pages for imported dmabuf, as they are not
 	 * ours, just free the array we allocated:
 	 */
-	if (etnaviv_obj->pages)
-		kvfree(etnaviv_obj->pages);
+	kvfree(etnaviv_obj->pages);
 
 	drm_prime_gem_destroy(&etnaviv_obj->base, etnaviv_obj->sgt);
 }
-- 
2.31.0

