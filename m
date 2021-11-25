Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2BD45D65C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353491AbhKYIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348819AbhKYIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:41:25 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683BAC06175E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 00:38:14 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:1511:ffa3:275:45dd])
        by laurent.telenet-ops.be with bizsmtp
        id NYe92600J5CGg7701Ye9RP; Thu, 25 Nov 2021 09:38:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqAGe-0009GZ-T1; Thu, 25 Nov 2021 09:38:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mqAGe-000LUN-AK; Thu, 25 Nov 2021 09:38:08 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Finn Thain <fthain@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next] nubus: Rename pde_data var to fix conflict with external function
Date:   Thu, 25 Nov 2021 09:38:08 +0100
Message-Id: <20211125083808.82560-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from drivers/nubus/proc.c:24:
drivers/nubus/proc.c: In function ‘nubus_proc_rsrc_show’:
./include/linux/proc_fs.h:123:21: error: called object ‘pde_data’ is not a function or function pointer
  123 | #define PDE_DATA(i) pde_data(i)
      |                     ^~~~~~~~
drivers/nubus/proc.c:112:13: note: in expansion of macro ‘PDE_DATA’
  112 |  pde_data = PDE_DATA(inode);
      |             ^~~~~~~~
drivers/nubus/proc.c:110:30: note: declared here
  110 |  struct nubus_proc_pde_data *pde_data;
      |                              ^~~~~~~~

Fix this by renaming the local variable to "pde".  Do this everywhere
for consistency.

Reported-by: noreply@ellerman.id.au
Fixes: e7e935db128e724f ("fs: proc: store PDE()->data into inode->i_private")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Not fixed by commit 5de6353a96bec91d ("proc: remove PDE_DATA()
completely"), which just removes the macro indirection.
---
 drivers/nubus/proc.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 22fb11da519bfc43..aff1c5d257cd8183 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -93,30 +93,30 @@ struct nubus_proc_pde_data {
 static struct nubus_proc_pde_data *
 nubus_proc_alloc_pde_data(unsigned char *ptr, unsigned int size)
 {
-	struct nubus_proc_pde_data *pde_data;
+	struct nubus_proc_pde_data *pde;
 
-	pde_data = kmalloc(sizeof(*pde_data), GFP_KERNEL);
-	if (!pde_data)
+	pde = kmalloc(sizeof(*pde), GFP_KERNEL);
+	if (!pde)
 		return NULL;
 
-	pde_data->res_ptr = ptr;
-	pde_data->res_size = size;
-	return pde_data;
+	pde->res_ptr = ptr;
+	pde->res_size = size;
+	return pde;
 }
 
 static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
-	struct nubus_proc_pde_data *pde_data;
+	struct nubus_proc_pde_data *pde;
 
-	pde_data = pde_data(inode);
-	if (!pde_data)
+	pde = pde_data(inode);
+	if (!pde)
 		return 0;
 
-	if (pde_data->res_size > m->size)
+	if (pde->res_size > m->size)
 		return -EFBIG;
 
-	if (pde_data->res_size) {
+	if (pde->res_size) {
 		int lanes = (int)proc_get_parent_data(inode);
 		struct nubus_dirent ent;
 
@@ -124,11 +124,11 @@ static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
 			return 0;
 
 		ent.mask = lanes;
-		ent.base = pde_data->res_ptr;
+		ent.base = pde->res_ptr;
 		ent.data = 0;
-		nubus_seq_write_rsrc_mem(m, &ent, pde_data->res_size);
+		nubus_seq_write_rsrc_mem(m, &ent, pde->res_size);
 	} else {
-		unsigned int data = (unsigned int)pde_data->res_ptr;
+		unsigned int data = (unsigned int)pde->res_ptr;
 
 		seq_putc(m, data >> 16);
 		seq_putc(m, data >> 8);
@@ -142,18 +142,18 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 			     unsigned int size)
 {
 	char name[9];
-	struct nubus_proc_pde_data *pde_data;
+	struct nubus_proc_pde_data *pde;
 
 	if (!procdir)
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
 	if (size)
-		pde_data = nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
+		pde = nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
 	else
-		pde_data = NULL;
+		pde = NULL;
 	proc_create_single_data(name, S_IFREG | 0444, procdir,
-			nubus_proc_rsrc_show, pde_data);
+			nubus_proc_rsrc_show, pde);
 }
 
 void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
-- 
2.25.1

