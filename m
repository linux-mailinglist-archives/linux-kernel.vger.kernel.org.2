Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D958377A32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 04:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhEJCoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 22:44:20 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:44808 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhEJCoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 22:44:19 -0400
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m176216.qiye.163.com (Hmail) with ESMTPA id 6EDB0C20100;
        Mon, 10 May 2021 10:43:14 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] vdpa_sim_blk: remove duplicate include of linux/blkdev.h
Date:   Mon, 10 May 2021 10:43:03 +0800
Message-Id: <20210510024307.7143-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkMfGFYfQ0pKShpNGRkZTxpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxA6Azo*Cz8WHT8vTgktNBpI
        HUsKFChVSlVKTUlLTUpPTkJPQk5IVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKQ0NPNwY+
X-HM-Tid: 0a795428404ad976kuws6edb0c20100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7d189f617f83f ("vdpa_sim_blk: implement ramdisk behaviour")
linux/blkdev.h was included here causing the duplicate include.
Remove the later duplicate include.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 5bfe1c281645..a790903f243e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -15,7 +15,6 @@
 #include <linux/blkdev.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
-#include <linux/blkdev.h>
 #include <uapi/linux/virtio_blk.h>
 
 #include "vdpa_sim.h"
-- 
2.20.1

