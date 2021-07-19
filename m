Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33ED3CCC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhGSD1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:27:47 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:34708
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S234340AbhGSD1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=gp16xo6Je5Ku95asxZPGq3l2dkIwJVFpuYxRFDxL/74=; b=0
        rxuqd+L49txZJ3+VRfCzZ4IQ9vZLWB1D0xOezPll13hqQPE5ztdtJ70fOkOgv7G6
        KqJ/1TLmHQrorZpfSli75hN2aVO3m3IdURdIGeFoh3D4M/wk0+hMUv/oArzOWwtu
        bNBxVodzXj9ev2ry5O/uSVpguzBeTJ5Bizu/lbdKS0=
Received: from localhost.localdomain (unknown [10.162.86.133])
        by app2 (Coremail) with SMTP id XQUFCgBXXSV28PRgJyHnBA--.224S3;
        Mon, 19 Jul 2021 11:24:38 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] w1: Convert from atomic_t to refcount_t on w1_cb_block->refcnt
Date:   Mon, 19 Jul 2021 11:24:36 +0800
Message-Id: <1626665076-49234-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgBXXSV28PRgJyHnBA--.224S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3tF17ZrW3tr1UZr1kXwb_yoW8ZrW8pF
        sIv3yUAay3Ka1xWF12ya40ya43Z3WkAF97Kryj93s3ur9aqrnrAF4kKr1qyr4YyFZ7JrZr
        ZF4IgFy5AFs8Ww7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUb7KsUUUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/w1/w1_netlink.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index fa490aa4407c..a24e09bb13ab 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2003 Evgeniy Polyakov <zbr@ioremap.net>
  */
 
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
@@ -17,7 +18,7 @@
  * allocation.
  */
 struct w1_cb_block {
-	atomic_t refcnt;
+	refcount_t refcnt;
 	u32 portid; /* Sending process port ID */
 	/* maximum value for first_cn->len */
 	u16 maxlen;
@@ -61,7 +62,7 @@ static u16 w1_reply_len(struct w1_cb_block *block)
 
 static void w1_unref_block(struct w1_cb_block *block)
 {
-	if (atomic_sub_return(1, &block->refcnt) == 0) {
+	if (refcount_dec_and_test(&block->refcnt)) {
 		u16 len = w1_reply_len(block);
 		if (len) {
 			cn_netlink_send_mult(block->first_cn, len,
@@ -609,7 +610,7 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 			w1_netlink_send_error(cn, msg, nsp->portid, -ENOMEM);
 			return;
 		}
-		atomic_set(&block->refcnt, 1);
+		refcount_set(&block->refcnt, 1);
 		block->portid = nsp->portid;
 		memcpy(&block->request_cn, cn, sizeof(*cn) + cn->len);
 		node = (struct w1_cb_node *)(block->request_cn.data + cn->len);
@@ -675,7 +676,7 @@ static void w1_cn_callback(struct cn_msg *cn, struct netlink_skb_parms *nsp)
 
 		err = 0;
 
-		atomic_inc(&block->refcnt);
+		refcount_inc(&block->refcnt);
 		node->async.cb = w1_process_cb;
 		node->block = block;
 		node->msg = (struct w1_netlink_msg *)((u8 *)&block->request_cn +
-- 
2.7.4

