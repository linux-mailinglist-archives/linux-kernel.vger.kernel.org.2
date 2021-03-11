Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7315C336D78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhCKIDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhCKIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:03:03 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D8BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 00:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=7Vw7cyxGgI
        XCeVV3/ziy/1ezsGIffwcjH1zfDgFjFv8=; b=lWgSNpkRE6FxxJzHAGub3Gse40
        cOZW259WsznJ9xj0wcL0uuXeJpmxBSz4hrhPMYMNgCwCe3cstr3HLG+mXsPSPbsO
        0CetCDNeI8j+WagBB7CfHkVAZlLNa80eRU9cKhTf2W9md0AknhszTbFSdeKCTR4d
        LYPcDJ4qlltpoV0i4=
Received: from ubuntu.localdomain (unknown [114.214.226.60])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHjR2ozklg0JcKAA--.2630S4;
        Thu, 11 Mar 2021 16:02:48 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] lib/test_kmod: Fix a use after free in register_test_dev_kmod
Date:   Thu, 11 Mar 2021 00:02:46 -0800
Message-Id: <20210311080246.11635-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCHjR2ozklg0JcKAA--.2630S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4UuF1xXrW8Ww13KryDZFb_yoWfurb_ua
        18Aw4Dur1DJrn8u347ZwsYvan7AF42yr4xJ34DtFWDXryjqrs8J34xZr1kJa9xurW3XrWa
        g3y09r1UK398ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb0PfJ
        UUUUU==
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In register_test_dev_kmod, it calls free_test_dev_kmod() to free
test_dev. But free_test_dev_kmod() can't set the original pointer
test_dev to NULL, because the test_dev was passed by it's value
not reference.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 lib/test_kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index 38c250fbace3..aa8a2a563d7e 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1124,7 +1124,6 @@ static void free_test_dev_kmod(struct kmod_test_device *test_dev)
 		free_test_dev_info(test_dev);
 		kmod_config_free(test_dev);
 		vfree(test_dev);
-		test_dev = NULL;
 	}
 }
 
@@ -1149,6 +1148,7 @@ static struct kmod_test_device *register_test_dev_kmod(void)
 	if (ret) {
 		pr_err("could not register misc device: %d\n", ret);
 		free_test_dev_kmod(test_dev);
+		test_dev = NULL;
 		goto out;
 	}
 
-- 
2.25.1


