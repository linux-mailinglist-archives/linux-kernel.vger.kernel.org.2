Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CDB354F71
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhDFJIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:08:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15134 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244785AbhDFJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:08:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FF1ns4cs3zpVQt;
        Tue,  6 Apr 2021 17:05:21 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 17:07:53 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] drm/nouveau/dmem: Remove duplicated header file inclusion
Date:   Tue, 6 Apr 2021 17:07:50 +0800
Message-ID: <20210406090750.2477-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210406090750.2477-1-thunder.leizhen@huawei.com>
References: <20210406090750.2477-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete one of the header files <nvif/if000c.h> that are included twice,
all included header files are then rearranged alphabetically.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 92987daa5e17d02..8e7a1b6598e0659 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -19,26 +19,23 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-#include "nouveau_dmem.h"
-#include "nouveau_drv.h"
-#include "nouveau_chan.h"
-#include "nouveau_dma.h"
-#include "nouveau_mem.h"
-#include "nouveau_bo.h"
-#include "nouveau_svm.h"
-
+#include <linux/hmm.h>
+#include <linux/sched/mm.h>
+#include <nvhw/class/cla0b5.h>
 #include <nvif/class.h>
-#include <nvif/object.h>
-#include <nvif/push906f.h>
 #include <nvif/if000c.h>
 #include <nvif/if500b.h>
 #include <nvif/if900b.h>
-#include <nvif/if000c.h>
-
-#include <nvhw/class/cla0b5.h>
+#include <nvif/object.h>
+#include <nvif/push906f.h>
 
-#include <linux/sched/mm.h>
-#include <linux/hmm.h>
+#include "nouveau_bo.h"
+#include "nouveau_chan.h"
+#include "nouveau_dma.h"
+#include "nouveau_dmem.h"
+#include "nouveau_drv.h"
+#include "nouveau_mem.h"
+#include "nouveau_svm.h"
 
 /*
  * FIXME: this is ugly right now we are using TTM to allocate vram and we pin
-- 
1.8.3


