Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71B5337999
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhCKQjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:39:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbhCKQis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615480727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cD6un+IZl15QRFcReXYKwmtzVs9ipkNNCoxE4zqgnAE=;
        b=BSZb5CXlsuKmB1q3PF1w6hcRoYD97pNybz16wdHZt+k6WTsaFgJ/BSWTKk7MdN4XEGYxcT
        h0wxG3H79DuTua4+SnHJWmQ1CthY6eA3Pxw6c5hBJ9QTSgw0fFgYStA8hfDwS7JS2TC46G
        WZAn60hxpa0kxPXphaXCxt/MhkNvSLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-5pXlbM6zODa0rITaPxhz0g-1; Thu, 11 Mar 2021 11:38:43 -0500
X-MC-Unique: 5pXlbM6zODa0rITaPxhz0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CEB61858F13;
        Thu, 11 Mar 2021 16:38:41 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C79EE18AAB;
        Thu, 11 Mar 2021 16:38:39 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Eric Paris <eparis@parisplace.org>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH] audit: further cleanup of AUDIT_FILTER_ENTRY deprecation
Date:   Thu, 11 Mar 2021 11:38:05 -0500
Message-Id: <ad54a5c360cf9566a59cc9fcc845444bf98edc69.1615411659.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the list parameter from the function call since the exit filter
list is the only remaining list used by this function.

This cleans up commit 5260ecc2e048
("audit: deprecate the AUDIT_FILTER_ENTRY filter")

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 434337ab6b2b..71ead2969eeb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -805,8 +805,7 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
  * (i.e., the state is AUDIT_SETUP_CONTEXT or AUDIT_BUILD_CONTEXT).
  */
 static void audit_filter_syscall(struct task_struct *tsk,
-					     struct audit_context *ctx,
-					     struct list_head *list)
+				 struct audit_context *ctx)
 {
 	struct audit_entry *e;
 	enum audit_state state;
@@ -815,7 +814,7 @@ static void audit_filter_syscall(struct task_struct *tsk,
 		return;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(e, list, list) {
+	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
 		if (audit_in_mask(&e->rule, ctx->major) &&
 		    audit_filter_rules(tsk, &e->rule, ctx, NULL,
 				       &state, false)) {
@@ -1627,8 +1626,7 @@ void __audit_free(struct task_struct *tsk)
 		context->return_valid = AUDITSC_INVALID;
 		context->return_code = 0;
 
-		audit_filter_syscall(tsk, context,
-				     &audit_filter_list[AUDIT_FILTER_EXIT]);
+		audit_filter_syscall(tsk, context);
 		audit_filter_inodes(tsk, context);
 		if (context->current_state == AUDIT_RECORD_CONTEXT)
 			audit_log_exit();
@@ -1735,8 +1733,7 @@ void __audit_syscall_exit(int success, long return_code)
 		else
 			context->return_code  = return_code;
 
-		audit_filter_syscall(current, context,
-				     &audit_filter_list[AUDIT_FILTER_EXIT]);
+		audit_filter_syscall(current, context);
 		audit_filter_inodes(current, context);
 		if (context->current_state == AUDIT_RECORD_CONTEXT)
 			audit_log_exit();
-- 
2.27.0

