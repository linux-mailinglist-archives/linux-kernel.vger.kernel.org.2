Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2323527A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhDBIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:55:57 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:59524 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhDBIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:55:53 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id A3C5F40010F;
        Fri,  2 Apr 2021 16:55:51 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/nouveau: fix potential abnormal lock/unlock
Date:   Fri,  2 Apr 2021 01:55:47 -0700
Message-Id: <20210402085549.77050-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTkpITUkYTh1DSB5MVkpNSkxITkhMTkpCTk9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6PRw*ST8UCipKDTgCCQ81
        ThwaCQ5VSlVKTUpMSE5ITE5JSUxDVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFJSEJNNwY+
X-HM-Tid: 0a7891cbbd49d991kuwsa3c5f40010f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:
drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c:115:3-9: preceding lock on line 109
drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c:98:2-8: preceding lock on line 95

As we see, function nvkm_fifo_chan_inst & nvkm_fifo_chan_chid both
use spin_lock_irqsave, but no spin_unlock_irqrestore in if/return
branch, seems like a potential bug?

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
index 2ed4ff05d207..e3f624d97644 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c
@@ -95,6 +95,7 @@ nvkm_fifo_chan_inst(struct nvkm_fifo *fifo, u64 inst, unsigned long *rflags)
 	spin_lock_irqsave(&fifo->lock, flags);
 	if ((chan = nvkm_fifo_chan_inst_locked(fifo, inst))) {
 		*rflags = flags;
+		spin_unlock_irqrestore(&fifo->lock, flags);
 		return chan;
 	}
 	spin_unlock_irqrestore(&fifo->lock, flags);
@@ -112,6 +113,7 @@ nvkm_fifo_chan_chid(struct nvkm_fifo *fifo, int chid, unsigned long *rflags)
 			list_del(&chan->head);
 			list_add(&chan->head, &fifo->chan);
 			*rflags = flags;
+			spin_unlock_irqrestore(&fifo->lock, flags);
 			return chan;
 		}
 	}
-- 
2.31.0

