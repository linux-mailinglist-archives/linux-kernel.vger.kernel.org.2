Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA8735ABB8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhDJHkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:40:41 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:32374 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhDJHkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:40:40 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 7D2C14000DE;
        Sat, 10 Apr 2021 15:40:22 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lyude Paul <lyude@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] drm/nouveau/nvkm: Remove unnecessary assignment
Date:   Sat, 10 Apr 2021 15:40:00 +0800
Message-Id: <20210410074012.1258923-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQhpJT1ZJQ0xKHRoZQ0gdTBhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46Tio*ND8RDhlJIjwWChdI
        Hk9PCjFVSlVKTUpDS09LT0lIS05DVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJSU9CNwY+
X-HM-Tid: 0a78bab9814ad991kuws7d2c14000de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The declaration with assignment here is confusing.
Remove the unnecessary assignment.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
index 96aca0edfa3c..c51bac76174c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c
@@ -313,7 +313,7 @@ nv50_instobj_dtor(struct nvkm_memory *memory)
 	struct nv50_instobj *iobj = nv50_instobj(memory);
 	struct nvkm_instmem *imem = &iobj->imem->base;
 	struct nvkm_vma *bar;
-	void *map = map;
+	void *map;
 
 	mutex_lock(&imem->mutex);
 	if (likely(iobj->lru.next))
-- 
2.25.1

