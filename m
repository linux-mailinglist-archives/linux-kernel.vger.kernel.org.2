Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C50436B436
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhDZNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:44:59 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B82E3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Z5dYL92soI
        e1zCX4KnWqBol19mkqukfrcusK0USJEK4=; b=fZ2H2dgm6s8l+Ep3YZJEAvfuTe
        gNp7EJpMkZlDkfxBlVQ3fpUJQhXkt7mv9jPhJs/dPq06SwMjPp/kcXQe0T0mx2PQ
        sMXmxAnKTYP0YsQIydL1grC0Rf25n4gPMR8+2+XnWXBYf5y2f4KkZdCXoi+0s+8U
        0K3RaGTntCRiYoOSg=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXnESdw4ZgAiFLAA--.5743S4;
        Mon, 26 Apr 2021 21:43:57 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     ogabbay@kernel.org, arnd@arndb.de, obitton@habana.ai
Cc:     linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] habanalabs/gaudi: Fix a potential use after free in gaudi_memset_device_memory
Date:   Mon, 26 Apr 2021 06:43:46 -0700
Message-Id: <20210426134346.6126-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCXnESdw4ZgAiFLAA--.5743S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWUWr17Cw45CFyrtry5Jwb_yoW8XF4DpF
        47Ja4Yk345WwsrAF4DJr4DZa1rA3Wrta1kKay7C3yFgrZ0qas3JryUCF92vrWj9FWay3W7
        Ar1Yvry5CayDCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUjkhLUUUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our code analyzer reported a uaf.

In gaudi_memset_device_memory, cb is get via hl_cb_kernel_create()
with 2 refcount.
If hl_cs_allocate_job() failed, the execution runs into release_cb
branch. One ref of cb is dropped by hl_cb_put(cb) and could be freed
if other thread also drops one ref. Then cb is used by cb->id later,
which is a potential uaf.

My patch add a variable 'id' to accept the value of cb->id before the
hl_cb_put(cb) is called, to avoid the potential uaf.

Fixes: 423815bf02e25 ("habanalabs/gaudi: remove PCI access to SM block")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9152242778f5..ecdedd87f8cc 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5546,6 +5546,7 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	struct hl_cs_job *job;
 	u32 cb_size, ctl, err_cause;
 	struct hl_cb *cb;
+	u64 id;
 	int rc;
 
 	cb = hl_cb_kernel_create(hdev, PAGE_SIZE, false);
@@ -5612,8 +5613,9 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	}
 
 release_cb:
+	id = cb->id;
 	hl_cb_put(cb);
-	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, id << PAGE_SHIFT);
 
 	return rc;
 }
-- 
2.25.1


