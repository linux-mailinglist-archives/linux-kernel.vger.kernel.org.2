Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A073359E83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhDIMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:23:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16865 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:23:25 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGy091Yytz9xX2;
        Fri,  9 Apr 2021 20:20:57 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.196) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 20:22:59 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <l.stach@pengutronix.de>, <linux+etnaviv@armlinux.org.uk>,
        <christian.gmeiner@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <etnaviv@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH -next] drm/etnaviv: remove unneeded if-null-free check
Date:   Fri, 9 Apr 2021 20:22:31 +0800
Message-ID: <20210409122231.8391-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.176.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:

drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:616:2-8: WARNING:
 NULL check before some freeing functions is not needed.
drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:618:2-8: WARNING:
 NULL check before some freeing functions is not needed.
drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:620:2-8: WARNING:
 NULL check before some freeing functions is not needed.
drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:622:2-8: WARNING:
 NULL check before some freeing functions is not needed.

Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index d05c35994579..bd0d66ebf314 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -612,14 +612,10 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 err_submit_cmds:
 	if (ret && (out_fence_fd >= 0))
 		put_unused_fd(out_fence_fd);
-	if (stream)
-		kvfree(stream);
-	if (bos)
-		kvfree(bos);
-	if (relocs)
-		kvfree(relocs);
-	if (pmrs)
-		kvfree(pmrs);
+	kvfree(stream);
+	kvfree(bos);
+	kvfree(relocs);
+	kvfree(pmrs);
 
 	return ret;
 }
-- 
2.31.1

