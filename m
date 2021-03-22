Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD223445C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCVNbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCVNau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:30:50 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94F58C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Q83FapeUZM
        ksG2KVMf8gbgQd7rcobSRZOvC7hnjIPqM=; b=Siao5FVfD9Rp6WlPJfq2wPeqoD
        f8ZCme+qtzG4fFttq4WdTyvEkgI7TBomQRYe2zjSTrWysBeKIycWBBbz24E2hLaJ
        MZok48avdGaGjlWOdeFuBHfg5O6hUqDdfJ2oCPHaTOfB5MAK17vicvGuWif+qQVd
        I8WhhPJv0zRpJ3stY=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygC3vaUCnFhgcegNAA--.4695S4;
        Mon, 22 Mar 2021 21:30:42 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] firmware/dmi-sysfs: Fix a double free in dmi_sysfs_register_handle
Date:   Mon, 22 Mar 2021 06:30:39 -0700
Message-Id: <20210322133039.4740-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygC3vaUCnFhgcegNAA--.4695S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1rur18GrW3WryrJrW3GFg_yoWkXwc_Cr
        yvqryFgw48KFWUKFsxAw1a9ry3KFWkX3s7Xr4SyF1ayr9xXw4rur4jgr17Zr13Wry8KF4D
        Cr1Dury8Crs7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUzHqxUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of DMI_ENTRY_SYSTEM_EVENT_LOG, it calls
dmi_system_event_log(entry). If dmi_system_event_log()
failed, it will free the entry->child and return err.

But in the out_err branch, the entry->child will be freed
again. My patch adds a new label "out_err1" to avoid freeing
entry->child twice.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/firmware/dmi-sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 8b8127fa8955..fd498f2037a8 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -622,16 +622,17 @@ static void __init dmi_sysfs_register_handle(const struct dmi_header *dh,
 		break;
 	}
 	if (*ret)
-		goto out_err;
+		goto out_err1;
 
 	/* Create the raw binary file to access the entry */
 	*ret = sysfs_create_bin_file(&entry->kobj, &dmi_entry_raw_attr);
 	if (*ret)
-		goto out_err;
+		goto out_err2;
 
 	return;
-out_err:
+out_err2:
 	kobject_put(entry->child);
+out_err1:
 	kobject_put(&entry->kobj);
 	return;
 }
-- 
2.25.1


