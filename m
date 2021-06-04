Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B359D39B0CB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFDDVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:21:17 -0400
Received: from m12-11.163.com ([220.181.12.11]:49487 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhFDDVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pZeW5
        XWw0/CemuoVaTv0dyhtE+ayHz1bZ2XZZs9jt14=; b=CgTpXGwsEFO7CuL+XT+So
        xl5IlEiUZ+9UfMSP5B0841r/PHyAlPqHA3JZnTiz23eJFMlgZa3h/g0+Hu4JMTTy
        FASH6PMf3vp79U9njbB8C8xd2dYekQi59V5HoIpw/lt/hSD4f3QCk4wCNC1WqfLr
        1VbIZSMzcIF6lPM9ubFJ8E=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowAAnL3+1m7lgFIBlgA--.924S2;
        Fri, 04 Jun 2021 11:19:18 +0800 (CST)
From:   lijian_8010a29@163.com
To:     spock@gentoo.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: uvesafb: Removed unnecessary 'return'
Date:   Fri,  4 Jun 2021 11:18:20 +0800
Message-Id: <20210604031820.137327-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAnL3+1m7lgFIBlgA--.924S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWxGrW3CF1fAr4fWw1fCrg_yoWDJwb_Ca
        17Zr92gryqyws2yF48Kr43AFWIya1UX3ZrZFnIqr9xAasrXF4fZr42vr4qgFyUXr4kAFy3
        uF4Dur10yr4rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5niSJUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiHRanUFSIrCTJmwAAs6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lijian <lijian@yulong.com>

Removed unnecessary 'return' in void function uvesafb_vbe_getmonspecs()
and uvesafb_cn_callback().

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/uvesafb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 4df6772802d7..28f353da668c 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -106,7 +106,6 @@ static void uvesafb_cn_callback(struct cn_msg *msg, struct netlink_skb_parms *ns
 		memcpy(task->buf, utask + 1, task->t.buf_len);
 
 	complete(task->done);
-	return;
 }
 
 static int uvesafb_helper_start(void)
@@ -748,8 +747,6 @@ static void uvesafb_vbe_getmonspecs(struct uvesafb_ktask *task,
 			fb_add_videomode(&info->monspecs.modedb[i],
 					&info->modelist);
 	}
-
-	return;
 }
 
 static void uvesafb_vbe_getstatesize(struct uvesafb_ktask *task,
-- 
2.25.1

