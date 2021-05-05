Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3B373F75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhEEQVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbhEEQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:21:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF8C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:20:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 12so3329757lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=48bh1+Y1vcaUPSucq70xwYXG4pAt+NIt0VPqq6H+naE=;
        b=Ti+h4fdPntP/Z9GhcCKPby+JaBJzOz4csNEsXIHwlglqE8ig+S3DLM5Srf/eZHMAl6
         PwzQnWryfs9DcGkjOActAiMMjwTTYwOI1xC7QEmUjynLIYpLVy1Ntvq/PLbKIEY7GEK2
         CBPHe2gy0W6PiNCu0R4NgpjWQ4x2ABw7noikXLoWdGXApW74rhvOxApkzE7Gv25YN42i
         tYLI3gOmSneJk5/tu51fWJi/km+tLQx2eYQD/WlStUThYoYsEGkmbqsjWnwnuinQYMIz
         iuZj+/L8FV9+8c7NIpqyay+Q8bvAOxM9iMjE77SScaf+ZBm7eIxgkHKz8EyPCnaByAc/
         JdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=48bh1+Y1vcaUPSucq70xwYXG4pAt+NIt0VPqq6H+naE=;
        b=fAYOX3n6T1u9bfZzzVSs8v1DUKc/Y+DlD4Qdchiz4U1OZo27b/TPzSpzKZcNYZVVyH
         TAbZGlZNnpS3qxeG+l10lzxUg5IfIlbqUi8tO4QM5yra/RRGMTHT6V6Ga8cReys3WCVG
         c94LdH4kU7w2jUbCWDAfn4/ww9ZybEXzY7LZQXf6BSxGti+MSXim37aS8Eu2goJw8Ken
         vgQs9YBDZF840K+RaiD4MS6CyPcogKnRp5fNOKImiIBJCYXHsbXS8eQzrnv/GPDVp+lM
         mE/zynprYj+kwNa+HxFmwF1oVuxbfwAddMPwi+80GNId4ubLGHv1wg6so4rMPx+iKGyE
         1beA==
X-Gm-Message-State: AOAM5304c5ihhbsEPagtwteGyshT6C2Hd3Nk7C95bbcN2ImB+BzEU/L8
        RuJT1AOpechTiyglWhD2/co=
X-Google-Smtp-Source: ABdhPJzgdokOT5BeULVmw0ArOI6ornF4+3ln7HIZNPLrOYe6WziNoWNnr3V/UmzEX6vpxuvFd/isUQ==
X-Received: by 2002:ac2:563a:: with SMTP id b26mr12943375lff.324.1620231601848;
        Wed, 05 May 2021 09:20:01 -0700 (PDT)
Received: from kitten-GF63-Thin-9SCSR (dy571hqwysp-9f10wvwqy-4.rev.dnainternet.fi. [2001:14bb:677:5336:407b:3fd2:57d2:8c9a])
        by smtp.gmail.com with ESMTPSA id x207sm639269lff.234.2021.05.05.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 09:20:01 -0700 (PDT)
From:   Roni Nevalainen <catmaster.kissa@gmail.com>
X-Google-Original-From: Roni Nevalainen <kitten@kittenz.dev>
Date:   Wed, 5 May 2021 19:19:58 +0300
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] audit: add blank line after variable declarations
Message-ID: <YJLFrrsN2jOx9ooS@kitten-GF63-Thin-9SCSR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning in auditsc.c:

WARNING: Missing a blank line after declarations

Signed-off-by: Roni Nevalainen <kitten@kittenz.dev>
---
 kernel/auditsc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 175ef6f3ea4e..0a9a1569f1ea 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -160,6 +160,7 @@ static const struct audit_nfcfgop_tab audit_nfcfgs[] = {
 static int audit_match_perm(struct audit_context *ctx, int mask)
 {
 	unsigned n;
+
 	if (unlikely(!ctx))
 		return 0;
 	n = ctx->major;
@@ -239,6 +240,7 @@ static int put_tree_ref(struct audit_context *ctx, struct audit_chunk *chunk)
 {
 	struct audit_tree_refs *p = ctx->trees;
 	int left = ctx->tree_count;
+
 	if (likely(left)) {
 		p->c[--left] = chunk;
 		ctx->tree_count = left;
@@ -259,6 +261,7 @@ static int put_tree_ref(struct audit_context *ctx, struct audit_chunk *chunk)
 static int grow_tree_refs(struct audit_context *ctx)
 {
 	struct audit_tree_refs *p = ctx->trees;
+
 	ctx->trees = kzalloc(sizeof(struct audit_tree_refs), GFP_KERNEL);
 	if (!ctx->trees) {
 		ctx->trees = p;
@@ -277,6 +280,7 @@ static void unroll_tree_refs(struct audit_context *ctx,
 {
 	struct audit_tree_refs *q;
 	int n;
+
 	if (!p) {
 		/* we started with empty chain */
 		p = ctx->first_trees;
@@ -303,6 +307,7 @@ static void unroll_tree_refs(struct audit_context *ctx,
 static void free_tree_refs(struct audit_context *ctx)
 {
 	struct audit_tree_refs *p, *q;
+
 	for (p = ctx->first_trees; p; p = q) {
 		q = p->next;
 		kfree(p);
@@ -313,6 +318,7 @@ static int match_tree_refs(struct audit_context *ctx, struct audit_tree *tree)
 {
 	struct audit_tree_refs *p;
 	int n;
+
 	if (!tree)
 		return 0;
 	/* full ones */
@@ -1225,6 +1231,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 	switch (context->type) {
 	case AUDIT_SOCKETCALL: {
 		int nargs = context->socketcall.nargs;
+
 		audit_log_format(ab, "nargs=%d", nargs);
 		for (i = 0; i < nargs; i++)
 			audit_log_format(ab, " a%d=%lx", i,
@@ -1240,6 +1247,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 		if (osid) {
 			char *ctx = NULL;
 			u32 len;
+
 			if (security_secid_to_secctx(osid, &ctx, &len)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
@@ -1289,6 +1297,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 		break;
 	case AUDIT_MQ_GETSETATTR: {
 		struct mq_attr *attr = &context->mq_getsetattr.mqstat;
+
 		audit_log_format(ab,
 			"mqdes=%d mq_flags=0x%lx mq_maxmsg=%ld mq_msgsize=%ld "
 			"mq_curmsgs=%ld ",
@@ -1325,6 +1334,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 static inline int audit_proctitle_rtrim(char *proctitle, int len)
 {
 	char *end = proctitle + len - 1;
+
 	while (end > proctitle && !isprint(*end))
 		end--;
 
@@ -1513,6 +1523,7 @@ static void audit_log_exit(void)
 
 		case AUDIT_BPRM_FCAPS: {
 			struct audit_aux_data_bprm_fcaps *axs = (void *)aux;
+
 			audit_log_format(ab, "fver=%x", axs->fcap_ver);
 			audit_log_cap(ab, "fp", &axs->fcap.permitted);
 			audit_log_cap(ab, "fi", &axs->fcap.inheritable);
@@ -1765,6 +1776,7 @@ static inline void handle_one(const struct inode *inode)
 	struct audit_tree_refs *p;
 	struct audit_chunk *chunk;
 	int count;
+
 	if (likely(!inode->i_fsnotify_marks))
 		return;
 	context = audit_context();
@@ -1806,8 +1818,10 @@ static void handle_path(const struct dentry *dentry)
 	seq = read_seqbegin(&rename_lock);
 	for(;;) {
 		struct inode *inode = d_backing_inode(d);
+
 		if (inode && unlikely(inode->i_fsnotify_marks)) {
 			struct audit_chunk *chunk;
+
 			chunk = audit_tree_lookup(inode);
 			if (chunk) {
 				if (unlikely(!put_tree_ref(context, chunk))) {
@@ -2285,6 +2299,7 @@ void __audit_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 {
 	struct audit_context *context = audit_context();
+
 	context->mq_getsetattr.mqdes = mqdes;
 	context->mq_getsetattr.mqstat = *mqstat;
 	context->type = AUDIT_MQ_GETSETATTR;
@@ -2298,6 +2313,7 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
@@ -2362,6 +2378,7 @@ int __audit_socketcall(int nargs, unsigned long *args)
 void __audit_fd_pair(int fd1, int fd2)
 {
 	struct audit_context *context = audit_context();
+
 	context->fds[0] = fd1;
 	context->fds[1] = fd2;
 }
@@ -2379,6 +2396,7 @@ int __audit_sockaddr(int len, void *a)
 
 	if (!context->sockaddr) {
 		void *p = kmalloc(sizeof(struct sockaddr_storage), GFP_KERNEL);
+
 		if (!p)
 			return -ENOMEM;
 		context->sockaddr = p;
@@ -2510,6 +2528,7 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 void __audit_log_capset(const struct cred *new, const struct cred *old)
 {
 	struct audit_context *context = audit_context();
+
 	context->capset.pid = task_tgid_nr(current);
 	context->capset.cap.effective   = new->cap_effective;
 	context->capset.cap.inheritable = new->cap_effective;
@@ -2521,6 +2540,7 @@ void __audit_log_capset(const struct cred *new, const struct cred *old)
 void __audit_mmap_fd(int fd, int flags)
 {
 	struct audit_context *context = audit_context();
+
 	context->mmap.fd = fd;
 	context->mmap.flags = flags;
 	context->type = AUDIT_MMAP;
@@ -2686,6 +2706,7 @@ void audit_seccomp_actions_logged(const char *names, const char *old_names,
 struct list_head *audit_killed_trees(void)
 {
 	struct audit_context *ctx = audit_context();
+
 	if (likely(!ctx || !ctx->in_syscall))
 		return NULL;
 	return &ctx->killed_trees;
-- 
2.30.2

