Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A153936D0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 05:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhD1DNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 23:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhD1DNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 23:13:35 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40F4FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=fb8NZokAK0
        9b9vDcttiOYDputy4GXGLlnj9ebUVNq70=; b=RErqkb2ovIfW4NtivaJ52FfBIl
        UJgCAJ6IOfrxbmhQJhF3Q5mJ51K7/J3olPbAhnmTd+IizgapWgrnaH/VVzDK2R9J
        CLmLapB4wTan47fTjk3hmC2sYEfHLpIc6jrs2uObA9zuyZJ4gAXGgmLQsDJbuOJK
        onlDpK+R5zLIs1kWE=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDHzjas0ohggtlXAA--.978S4;
        Wed, 28 Apr 2021 11:12:44 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] orangefs: Fix a use after free in purge_waiting_ops
Date:   Tue, 27 Apr 2021 20:12:36 -0700
Message-Id: <20210428031236.3613-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygDHzjas0ohggtlXAA--.978S4
X-Coremail-Antispam: 1UD129KBjvJXoW7trWkuF47WF4kAr1DGw4fGrg_yoW8ArW8pF
        4vkF17KF18Xw48Xan7Xa93Gw1IgrWvqr1fGasrGw4DGa1YqrnIqrZ5Kry5Zr4rAF95ZrW5
        ZF40y3sIqayYyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JU3CzZUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In purge_waiting_ops, op is freed in set_op_state_purged()
when op->upcal.type is a cancel type via op_release().But
later the freed op is dereferenced in gossip_debug() via
get_opname_string(op) and op->op_state.

My patch adds variables 'opname' and 'op_state' to avoid
the uaf. But i see that op->op_state could be changed in
a lock environment and i think move all the check condition
outside set_op_state_purged() could be redundant.

Could you give some advice on how to handle the op->op_state?

Fixes: 9d9e7ba9ee8f3 ("Orangefs: improve gossip statements")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 fs/orangefs/waitqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/waitqueue.c b/fs/orangefs/waitqueue.c
index beafc33d57be..e00c74051936 100644
--- a/fs/orangefs/waitqueue.c
+++ b/fs/orangefs/waitqueue.c
@@ -34,6 +34,8 @@ static void orangefs_clean_up_interrupted_operation(struct orangefs_kernel_op_s
 void purge_waiting_ops(void)
 {
 	struct orangefs_kernel_op_s *op, *tmp;
+	char *opname;
+	int op_state;
 
 	spin_lock(&orangefs_request_list_lock);
 	list_for_each_entry_safe(op, tmp, &orangefs_request_list, list) {
@@ -41,12 +43,14 @@ void purge_waiting_ops(void)
 			     "pvfs2-client-core: purging op tag %llu %s\n",
 			     llu(op->tag),
 			     get_opname_string(op));
+		opname = get_opname_string(op);
+		op_state = op->op_state;
 		set_op_state_purged(op);
 		gossip_debug(GOSSIP_DEV_DEBUG,
 			     "%s: op:%s: op_state:%d: process:%s:\n",
 			     __func__,
-			     get_opname_string(op),
-			     op->op_state,
+			     opname,
+			     op_state,
 			     current->comm);
 	}
 	spin_unlock(&orangefs_request_list_lock);
-- 
2.25.1


