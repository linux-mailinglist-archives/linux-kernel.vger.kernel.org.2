Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8C345518
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhCWBrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhCWBrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:47:19 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23E66C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=XcjGkHVa6C
        nee3IqKp4QVabZFCLc/bBbQsfdChM0o8M=; b=JxgXXgrPjt06IXfD+VfFyt55xH
        rfybtg0zY7Ipzrz2pOjyfe7kCglsSbH693814QChtOgpNQWSuB7N3OO3dAaFQIMx
        IsIdu1PxcDfXYiSRTfGLAlWO+2JVBq4p0I3wD/J3isBRHcRhKaJUbWAG+tSys/n7
        /g4LCOa5RRLjhk0Ww=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAHTZySSFlgFboXAA--.232S4;
        Tue, 23 Mar 2021 09:46:59 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     oleksandr_andrushchenko@epam.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] gpu/xen: Fix a use after free in xen_drm_drv_init
Date:   Mon, 22 Mar 2021 18:46:56 -0700
Message-Id: <20210323014656.10068-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygAHTZySSFlgFboXAA--.232S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4fXw1fCFy8Xw4kWry5twb_yoW8Xw47pF
        4fZFy5KrWUtws2kr15A3Wku3W5JanrKa1fGr9xA3y3Cw45ZFy09a15t34xuFyUArWfCrn5
        tr9xXFyUAFyDCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUmNtcUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function displback_changed, has the call chain
displback_connect(front_info)->xen_drm_drv_init(front_info).
We can see that drm_info is assigned to front_info->drm_info
and drm_info is freed in fail branch in xen_drm_drv_init().

Later displback_disconnect(front_info) is called and it calls
xen_drm_drv_fini(front_info) cause a use after free by
drm_info = front_info->drm_info statement.

My patch has done two things. First fixes the fail label which
drm_info = kzalloc() failed and still free the drm_info.
Second sets front_info->drm_info to NULL to avoid uaf.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/gpu/drm/xen/xen_drm_front.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 30d9adf31c84..9f14d99c763c 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -521,7 +521,7 @@ static int xen_drm_drv_init(struct xen_drm_front_info *front_info)
 	drm_dev = drm_dev_alloc(&xen_drm_driver, dev);
 	if (IS_ERR(drm_dev)) {
 		ret = PTR_ERR(drm_dev);
-		goto fail;
+		goto fail_dev;
 	}
 
 	drm_info->drm_dev = drm_dev;
@@ -551,8 +551,10 @@ static int xen_drm_drv_init(struct xen_drm_front_info *front_info)
 	drm_kms_helper_poll_fini(drm_dev);
 	drm_mode_config_cleanup(drm_dev);
 	drm_dev_put(drm_dev);
-fail:
+fail_dev:
 	kfree(drm_info);
+	front_info->drm_info = NULL;
+fail:
 	return ret;
 }
 
-- 
2.25.1


