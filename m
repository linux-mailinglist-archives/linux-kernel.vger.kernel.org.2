Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD8333EF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCQLKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:10:44 -0400
Received: from m12-13.163.com ([220.181.12.13]:51104 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhCQLKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aG9PL
        GfCbgZItHrxOJqHyjNFlL/xfuALIBa53rMsoSY=; b=ApK6Y+exknHjMND+oObGv
        tLnrCqVigeXl1Sy1gUHse9PTioYIK5GP2i6Hj9cetC65DlxkbR5v5kIU61D6aBRL
        sqnLEcL13F7W7xHoTFul+de01O0LOLqPNZqRSZ1gnWEjG9NEmz4vIU73BSdJGSCN
        chICbTazTv7mRaBYjwMvx0=
Received: from COOL-20200911ZP.ccdomain.com (unknown [218.94.48.178])
        by smtp9 (Coremail) with SMTP id DcCowABHzhZ2zVFgT9axBg--.14457S2;
        Wed, 17 Mar 2021 17:36:06 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        lyude@redhat.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tangchunyou@yulong.com
Subject: [PATCH] nouveau/nvkm/subdev/devinit/mcp89.c:Unneeded variable
Date:   Wed, 17 Mar 2021 17:35:45 +0800
Message-Id: <20210317093545.354-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABHzhZ2zVFgT9axBg--.14457S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1kGryxWrWkZw1kCr1UGFg_yoWDAFX_AF
        1rZrn3Wr4FkrnxuFsrAr1xJF9agwnFvF4vvF1Iqas3W347Ww43Xr1qgr1avrWDWr1rZF98
        K3WvqrnxXrWjgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8ZiSJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbipQZYUVUMc2xcnAAAss
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@yulong.com>

disable,delete disable and return 0

Signed-off-by: tangchunyou <tangchunyou@yulong.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c
index fb90d47..a9cdf24 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c
@@ -32,7 +32,6 @@
 	struct nvkm_device *device = init->subdev.device;
 	u32 r001540 = nvkm_rd32(device, 0x001540);
 	u32 r00154c = nvkm_rd32(device, 0x00154c);
-	u64 disable = 0;
 
 	if (!(r001540 & 0x40000000)) {
 		nvkm_subdev_disable(device, NVKM_ENGINE_MSPDEC, 0);
@@ -48,7 +47,7 @@
 	if (!(r00154c & 0x00000200))
 		nvkm_subdev_disable(device, NVKM_ENGINE_CE, 0);
 
-	return disable;
+	return 0;
 }
 
 static const struct nvkm_devinit_func
-- 
1.9.1


