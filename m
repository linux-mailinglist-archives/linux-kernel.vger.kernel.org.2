Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E36132BCB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383344AbhCCObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842973AbhCCKXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D439EC08ED3D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:15:33 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614766530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gxU8470dDzAP7HfvUdBdyr9yxuJ8C0WR83TSoe4VBA=;
        b=wLaCikomf2P6Oxm8LIkmjrb2bU8FHRzOEM+Zn+K7vd9QyjJUARrXvuhMFL88IItMKCOsRn
        2hDuK5Mnk3QdNZzEwWQmyf1eQYobSHwhTwd1p8dTI2391RtfI5hyCbkIPCZX7o4CBlC1Wv
        iHvrF0ClHe9/Rhh0/zWVMHgUf7+W2XRgG/P2DIoR9SQyDkKnMDVY6LcIbCcECFfvP8q5UV
        niyBrtP93QzOwVS8HadngtRCjvIq+dFJ2q96eSrl+m6K3z1O0e+Agurp7QAqz8CyL+D2De
        PAG5YaMcTmKJrQM5jUNXEMZlR04GTOga9sVvTV7Bhn34MAOmSaYLjzmWxF7FYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614766530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gxU8470dDzAP7HfvUdBdyr9yxuJ8C0WR83TSoe4VBA=;
        b=ZrmfNsNhxCMROF7acvjvPMYwc+pkJ+Mwz+JUMkCX84ooKIniSA/zPyo4modHCjo7nioLhF
        FROcGMLz0zwxUfDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH next v4 02/15] mtd: mtdoops: synchronize kmsg_dumper
Date:   Wed,  3 Mar 2021 11:15:15 +0100
Message-Id: <20210303101528.29901-3-john.ogness@linutronix.de>
In-Reply-To: <20210303101528.29901-1-john.ogness@linutronix.de>
References: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmsg_dumper can be called from any context and CPU, possibly
from multiple CPUs simultaneously. Since the writing of the buffer
can occur from a later scheduled work queue, the oops buffer must
be protected against simultaneous dumping.

Use an atomic bit to mark when the buffer is protected. Release the
protection in between setting the buffer and the actual writing in
order for a possible panic (immediate write) to be written during
the scheduling of a previous oops (delayed write).

An atomic bit (rather than a spinlock) was chosen so that no
scheduling or preemption side-effects would be introduced. The MTD
kmsg_dumper may dump directly or it may be delayed (via scheduled
work). Depending on the context, different MTD callbacks are used.
For example, mtd_write() expects to be called in a non-atomic
context and may take a mutex.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/mtd/mtdoops.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 774970bfcf85..8bbfba40a554 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -52,6 +52,7 @@ static struct mtdoops_context {
 	int nextcount;
 	unsigned long *oops_page_used;
 
+	unsigned long oops_buf_busy;
 	void *oops_buf;
 } oops_cxt;
 
@@ -180,6 +181,9 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	u32 *hdr;
 	int ret;
 
+	if (test_and_set_bit(0, &cxt->oops_buf_busy))
+		return;
+
 	/* Add mtdoops header to the buffer */
 	hdr = cxt->oops_buf;
 	hdr[0] = cxt->nextcount;
@@ -190,7 +194,7 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 				      record_size, &retlen, cxt->oops_buf);
 		if (ret == -EOPNOTSUPP) {
 			printk(KERN_ERR "mtdoops: Cannot write from panic without panic_write\n");
-			return;
+			goto out;
 		}
 	} else
 		ret = mtd_write(mtd, cxt->nextpage * record_size,
@@ -203,6 +207,8 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	memset(cxt->oops_buf, 0xff, record_size);
 
 	mtdoops_inc_counter(cxt);
+out:
+	clear_bit(0, &cxt->oops_buf_busy);
 }
 
 static void mtdoops_workfunc_write(struct work_struct *work)
@@ -276,8 +282,11 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
 	if (reason == KMSG_DUMP_OOPS && !dump_oops)
 		return;
 
+	if (test_and_set_bit(0, &cxt->oops_buf_busy))
+		return;
 	kmsg_dump_get_buffer(dumper, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
 			     record_size - MTDOOPS_HEADER_SIZE, NULL);
+	clear_bit(0, &cxt->oops_buf_busy);
 
 	if (reason != KMSG_DUMP_OOPS) {
 		/* Panics must be written immediately */
@@ -394,6 +403,7 @@ static int __init mtdoops_init(void)
 		return -ENOMEM;
 	}
 	memset(cxt->oops_buf, 0xff, record_size);
+	cxt->oops_buf_busy = 0;
 
 	INIT_WORK(&cxt->work_erase, mtdoops_workfunc_erase);
 	INIT_WORK(&cxt->work_write, mtdoops_workfunc_write);
-- 
2.20.1

