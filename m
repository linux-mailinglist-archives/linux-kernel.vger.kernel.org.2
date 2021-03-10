Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC1D33366D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhCJHb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhCJHba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:31:30 -0500
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Mar 2021 23:31:17 PST
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC091C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=C5c3qyNcj+
        yM0eWSk6JHCF/keE9ww6gJQ/zxKfWTSLo=; b=fAVwDAcw17hDMuosu7ykZ9BR0D
        YzO5PyVWPFk6hxcbFD/wlzGOjbcXZo8TFWMpFk4/fvBCEN7/scMgOOuekT+pD/K7
        IElfl0crrBjvMXLxp4ie4c9O95UQwm04JdzlDqFjpdi/oTzFd787mnR6hBYq5wD0
        fKlYxndo0XsgCbQ14=
Received: from ubuntu.localdomain (unknown [114.214.224.243])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCnk2BOdEhgGDsCAA--.1553S4;
        Wed, 10 Mar 2021 15:25:02 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     gustavo@embeddedor.com, gregkh@suse.de, mikew@google.com
Cc:     linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] drivers/firmware: Fix double free in dmi_sysfs_register_handle
Date:   Tue,  9 Mar 2021 23:24:59 -0800
Message-Id: <20210310072459.5029-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCnk2BOdEhgGDsCAA--.1553S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JF18try3Kw43try5Kw18Grg_yoWDJrX_CF
        W5tryfWw48KF4aqr1avw1Fvr9Iva1vv3s7CrWSy3Wayry3Xw48Xr4jgw1xZrW7WFyIyFWk
        Ar1DKry8Cr4IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0D
        UUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A double free bug was found in drivers/firmware/dmi-sysfs.c.
In the implementation of dmi_sysfs_register_handle, it calls
dmi_system_event_log() to initialize entry->child. If
kobject_init_and_add() failed, entry->child is freed. But
unfortunately, out_err branch in dmi_sysfs_register_handle
will freed entry->child twice!

Fixes: 925a1da7477fc ("firmware: Break out system_event_log in dmi-sysfs")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/firmware/dmi-sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 8b8127fa8955..ad97bbd37206 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -631,7 +631,6 @@ static void __init dmi_sysfs_register_handle(const struct dmi_header *dh,
 
 	return;
 out_err:
-	kobject_put(entry->child);
 	kobject_put(&entry->kobj);
 	return;
 }
-- 
2.25.1


