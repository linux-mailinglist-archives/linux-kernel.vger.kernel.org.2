Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73F43CCDB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhGSGBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 02:01:48 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:58407
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229906AbhGSGBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=NQYPHYKWyImTIt81fB2YSWliTUObkR6rOuO5JzaQPuU=; b=k
        bTyJfpYgjWbNMqFrWuhaxIan+V5S9V9FhKQfE7zprqRstEqa8S0Q7c5Ys+WhSQ9H
        9c3dJTtketxyl+/vVXEWN0qDRRleOPm24djBw/9BUu9ujHggyWpPJCvjDPEmMR3v
        5c6RUubvbuk4Im7itMKMrDyzoLAUqxAee02IYdTCqQ=
Received: from localhost.localdomain (unknown [10.162.86.133])
        by app1 (Coremail) with SMTP id XAUFCgAnCGl+FPVgDhOJAA--.1226S3;
        Mon, 19 Jul 2021 13:58:22 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] coda: Convert from atomic_t to refcount_t on coda_vm_ops->refcnt
Date:   Mon, 19 Jul 2021 13:58:19 +0800
Message-Id: <1626674299-55672-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgAnCGl+FPVgDhOJAA--.1226S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry3tF17ZrWxtw47XF1rtFb_yoW8Zr1UpF
        4ak3WjkFs8G3Z3G3W8AF48Xr13tr18G3WUXFyjg34aqrnagwsYvrWkGw1jyrs8JFZ7ur9x
        Way5t345uw47taUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/coda/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index ef5ca22bfb3e..66fb420f4e77 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -8,6 +8,7 @@
  * to the Coda project. Contact Peter Braam <coda@cs.cmu.edu>.
  */
 
+#include <linux/refcount.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
@@ -28,7 +29,7 @@
 #include "coda_int.h"
 
 struct coda_vm_ops {
-	atomic_t refcnt;
+	refcount_t refcnt;
 	struct file *coda_file;
 	const struct vm_operations_struct *host_vm_ops;
 	struct vm_operations_struct vm_ops;
@@ -98,7 +99,7 @@ coda_vm_open(struct vm_area_struct *vma)
 	struct coda_vm_ops *cvm_ops =
 		container_of(vma->vm_ops, struct coda_vm_ops, vm_ops);
 
-	atomic_inc(&cvm_ops->refcnt);
+	refcount_inc(&cvm_ops->refcnt);
 
 	if (cvm_ops->host_vm_ops && cvm_ops->host_vm_ops->open)
 		cvm_ops->host_vm_ops->open(vma);
@@ -113,7 +114,7 @@ coda_vm_close(struct vm_area_struct *vma)
 	if (cvm_ops->host_vm_ops && cvm_ops->host_vm_ops->close)
 		cvm_ops->host_vm_ops->close(vma);
 
-	if (atomic_dec_and_test(&cvm_ops->refcnt)) {
+	if (refcount_dec_and_test(&cvm_ops->refcnt)) {
 		vma->vm_ops = cvm_ops->host_vm_ops;
 		fput(cvm_ops->coda_file);
 		kfree(cvm_ops);
@@ -189,7 +190,7 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
 		cvm_ops->vm_ops.open = coda_vm_open;
 		cvm_ops->vm_ops.close = coda_vm_close;
 		cvm_ops->coda_file = coda_file;
-		atomic_set(&cvm_ops->refcnt, 1);
+		refcount_set(&cvm_ops->refcnt, 1);
 
 		vma->vm_ops = &cvm_ops->vm_ops;
 	}
-- 
2.7.4

