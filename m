Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32F3532C8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 08:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhDCGJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 02:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhDCGJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 02:09:30 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32D80C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 23:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=qvyDwjK3gB
        UMTEGBVUtjhKDw8xoAbkmOgHLuEiQzyI0=; b=aDf5WqUXQcYzjU906LFwIrXNti
        1V7A3eKqAQARjHrDn5lS745f2rvKBm01WsvzQJLaug4CmPMdnYZ7CAQ3X0RBWaqh
        6I8R+hzb6yDq6iWYtVA4R9tMYZ7g+NY4hXwN78R7jjrZaCKXpdPyGZ10WwpNs9F0
        A6IFLP1/41Q5HysZo=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygC3vn6DBmhg3HGPAA--.1127S4;
        Sat, 03 Apr 2021 14:09:07 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     han.xu@nxp.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, bbrezillon@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] mtd: nand: gpmi: Fix a double free in gpmi_nand_init
Date:   Fri,  2 Apr 2021 23:09:05 -0700
Message-Id: <20210403060905.5251-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygC3vn6DBmhg3HGPAA--.1127S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWDGF45Wry7WFy7WF4fGrg_yoW8GrWDpr
        Wa9anrGF4qqrWkt3ZrZa1rZr15Aan5Wry8GFW5W34rZFnIqr4j9F9rtF12vF47uF4UtF4x
        Xrn8Wwn8Ar4UAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUjylk7UUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the callee gpmi_alloc_dma_buffer() failed to alloc memory for
this->raw_buffer, gpmi_free_dma_buffer() will be called to free
this->auxiliary_virt. But this->auxiliary_virt is still a non-NULL
and valid ptr.

Then gpmi_alloc_dma_buffer() returns err and gpmi_free_dma_buffer()
is called again to free this->auxiliary_virt in err_out. This causes
a double free.

As gpmi_free_dma_buffer() has already called in gpmi_alloc_dma_buffer's
error path, so it should return err directly instead of releasing the dma
buffer again.

Fixes: 4d02423e9afe6 ("mtd: nand: gpmi: Fix gpmi_nand_init() error path")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 3fa8c22d3f36..4d08e4ab5c1b 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -2449,7 +2449,7 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	this->bch_geometry.auxiliary_size = 128;
 	ret = gpmi_alloc_dma_buffer(this);
 	if (ret)
-		goto err_out;
+		return ret;
 
 	nand_controller_init(&this->base);
 	this->base.ops = &gpmi_nand_controller_ops;
-- 
2.25.1


