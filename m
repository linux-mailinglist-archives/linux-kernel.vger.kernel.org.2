Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD23CB5BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhGPKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:12:15 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:57939
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S235911AbhGPKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=HSEDz8NEiEK2wmxERWyQQQp6heMkOA9rgedFWxtRjsw=; b=O
        nIDfCxLFHHrUnDHbwML2Edd964FAv4jpjlGRHF46IMFE8yHnJIPK+uAX0ArExtWU
        f+IyT6b/H0X9wW/zFDZqb5hDMbPiDYVeICptYExI++6E6WmE7NSdbywo9zZN7lRh
        zAMSKHvQ7Vz0QpXCfQKwJX65kYCf6Bi2PzrDF5cWmc=
Received: from localhost.localdomain (unknown [10.162.86.133])
        by app2 (Coremail) with SMTP id XQUFCgB3fyelWvFgI_LPBA--.40344S3;
        Fri, 16 Jul 2021 18:08:37 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn
Subject: [PATCH] jffs2: Convert from atomic_t to refcount_t on jffs2_xattr_datum->refcnt
Date:   Fri, 16 Jul 2021 18:08:12 +0800
Message-Id: <1626430101-26718-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgB3fyelWvFgI_LPBA--.40344S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWfury5KFW7Jr17KFW3ZFb_yoWrJF17pr
        Z8Ja4rJF4rWr1fCr90yw18Zw1akr40krWvqrW5Jw1fuFyxtw1Svas5KryrAr1UZrs7Jr9I
        vF1jgr1YkF15Ww7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/jffs2/xattr.c | 14 +++++++-------
 fs/jffs2/xattr.h |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..f7e959817ff1 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -352,7 +352,7 @@ static struct jffs2_xattr_datum *create_xattr_datum(struct jffs2_sb_info *c,
 		    && xd->value_len==xsize
 		    && !strcmp(xd->xname, xname)
 		    && !memcmp(xd->xvalue, xvalue, xsize)) {
-			atomic_inc(&xd->refcnt);
+			refcount_inc(&xd->refcnt);
 			return xd;
 		}
 	}
@@ -372,7 +372,7 @@ static struct jffs2_xattr_datum *create_xattr_datum(struct jffs2_sb_info *c,
 	strcpy(data, xname);
 	memcpy(data + name_len + 1, xvalue, xsize);
 
-	atomic_set(&xd->refcnt, 1);
+	refcount_set(&xd->refcnt, 1);
 	xd->xid = ++c->highest_xid;
 	xd->flags |= JFFS2_XFLAGS_HOT;
 	xd->xprefix = xprefix;
@@ -404,7 +404,7 @@ static struct jffs2_xattr_datum *create_xattr_datum(struct jffs2_sb_info *c,
 static void unrefer_xattr_datum(struct jffs2_sb_info *c, struct jffs2_xattr_datum *xd)
 {
 	/* must be called under down_write(xattr_sem) */
-	if (atomic_dec_and_lock(&xd->refcnt, &c->erase_completion_lock)) {
+	if (refcount_dec_and_lock(&xd->refcnt, &c->erase_completion_lock)) {
 		unload_xattr_datum(c, xd);
 		xd->flags |= JFFS2_XFLAGS_DEAD;
 		if (xd->node == (void *)xd) {
@@ -621,7 +621,7 @@ void jffs2_xattr_free_inode(struct jffs2_sb_info *c, struct jffs2_inode_cache *i
 	for (ref = ic->xref; ref; ref = _ref) {
 		_ref = ref->next;
 		xd = ref->xd;
-		if (atomic_dec_and_test(&xd->refcnt)) {
+		if (refcount_dec_and_test(&xd->refcnt)) {
 			unload_xattr_datum(c, xd);
 			jffs2_free_xattr_datum(xd);
 		}
@@ -851,7 +851,7 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 			}
 			ref->xd = xd;
 			ref->ic = ic;
-			atomic_inc(&xd->refcnt);
+			refcount_inc(&xd->refcnt);
 			ref->next = ic->xref;
 			ic->xref = ref;
 		}
@@ -862,7 +862,7 @@ void jffs2_build_xattr_subsystem(struct jffs2_sb_info *c)
 		list_for_each_entry_safe(xd, _xd, &c->xattrindex[i], xindex) {
 			xdatum_count++;
 			list_del_init(&xd->xindex);
-			if (!atomic_read(&xd->refcnt)) {
+			if (!refcount_read(&xd->refcnt)) {
 				dbg_xattr("xdatum(xid=%u, version=%u) is orphan.\n",
 					  xd->xid, xd->version);
 				xd->flags |= JFFS2_XFLAGS_DEAD;
@@ -1322,7 +1322,7 @@ int jffs2_verify_xattr(struct jffs2_sb_info *c)
 void jffs2_release_xattr_datum(struct jffs2_sb_info *c, struct jffs2_xattr_datum *xd)
 {
 	/* must be called under spin_lock(&c->erase_completion_lock) */
-	if (atomic_read(&xd->refcnt) || xd->node != (void *)xd)
+	if (refcount_read(&xd->refcnt) || xd->node != (void *)xd)
 		return;
 
 	list_del(&xd->xindex);
diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
index 720007b2fd65..75742f948d20 100644
--- a/fs/jffs2/xattr.h
+++ b/fs/jffs2/xattr.h
@@ -14,6 +14,7 @@
 
 #include <linux/xattr.h>
 #include <linux/list.h>
+#include <linux/refcount.h>
 
 #define JFFS2_XFLAGS_HOT	(0x01)	/* This datum is HOT */
 #define JFFS2_XFLAGS_BIND	(0x02)	/* This datum is not reclaimed */
@@ -29,7 +30,7 @@ struct jffs2_xattr_datum
 	uint16_t xprefix;		/* see JFFS2_XATTR_PREFIX_* */
 
 	struct list_head xindex;	/* chained from c->xattrindex[n] */
-	atomic_t refcnt;		/* # of xattr_ref refers this */
+	refcount_t refcnt;		/* # of xattr_ref refers this */
 	uint32_t xid;
 	uint32_t version;
 
-- 
2.7.4

