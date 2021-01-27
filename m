Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B758305051
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhA0D7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhA0CzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 21:55:10 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE55C0698C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:52:07 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id cq1so393714pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6V+09PYy3UBnK+L5rrj+ECCvyFqSJJIBq/ZXEMb2bJM=;
        b=ZoXfkY6au+f9VFrzVzXn/35yEt+V21ErdfK8UUzPrDekTn3WXfhm9eokWBKcVeDxw0
         RnxGM/kYI4sBGjcH5Ae0InpMZaDF5VMiUppOOVtmAmpgsHaGS4syx9rR86kW7L8kI4Ex
         7LO43eOWui4WqSuKneoZU0Yt+j3ZYxr3c1nAIwP86DabwPYijOrzHH6xk7kxpaowPyRm
         +cJwiC+JSlJmhhLfC77cLAp9zbzNZImMO4LKp0OZPkGayi+1H7A1VlG1hSB+j+3d5o5y
         FjZU87dG076x+MhAdS+tD2IEXFA/rPeXmuRYVh3krmuenfek1Vxq+wrfSAJyPwP/xXl7
         fi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6V+09PYy3UBnK+L5rrj+ECCvyFqSJJIBq/ZXEMb2bJM=;
        b=Cj+Dku67sUMF5EhcuaZe8LLqSK85EYNvqjyPAvlhslGc4kN75r2W8h0AnrYWHKrvpZ
         GClM2wxgl+JgmYYFTB57UdZlUSCBx+CJk9krFlQMOmB0Olo2LPudxrWqH8VUx29/m74V
         RgI44VEIcVXmUm3bjCRK9Q9e6+D1RIbYnbAtoXHfQTqdD4SZurAOfKvOLZNWPyb+xmNM
         cek8vm9Pmrjwb4L9erNXrOfcauQoeObAJ2bwrz8fhkhs6aVbefuvZfBO/ydNreVFhFEp
         UiDI1/6wcQ6xk8/wnqABzpFwdSAwkHcdOT/u1I0l8Hcarr1sjpWO9Mxb2feJU7V+27ln
         1SQg==
X-Gm-Message-State: AOAM532lwprqAZ4FI0Yp+jyHjaHRvQfvo8lFz2IVhssTX/LYPgXmTik5
        JfdQfXwKpv+XRg/fdlkHxT4=
X-Google-Smtp-Source: ABdhPJxG93aTh/GJHmqgHwPVDToiUD50bsK4nleE+bEmiDF3YI5EPUAQ3i9ngScJETfZAvBosksT2g==
X-Received: by 2002:a17:903:31ca:b029:e0:ee2:c076 with SMTP id v10-20020a17090331cab02900e00ee2c076mr7841800ple.58.1611715926642;
        Tue, 26 Jan 2021 18:52:06 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id h12sm346472pgs.7.2021.01.26.18.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:52:06 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     paul@paul-moore.com
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v2] audit: Make audit_filter_syscall() return void
Date:   Tue, 26 Jan 2021 18:51:43 -0800
Message-Id: <20210127025144.24253-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

No invoker uses the return value of audit_filter_syscall().
So make it return void, and amend the comment of
audit_filter_syscall().

Changes since v1:
- amend the comment of audit_filter_syscall().

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ce8c9e2279ba..434337ab6b2b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -799,12 +799,12 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
 	return rule->mask[word] & bit;
 }
 
-/* At syscall entry and exit time, this filter is called if the
- * audit_state is not low enough that auditing cannot take place, but is
- * also not high enough that we already know we have to write an audit
- * record (i.e., the state is AUDIT_SETUP_CONTEXT or AUDIT_BUILD_CONTEXT).
+/* At syscall exit time, this filter is called if the audit_state is
+ * not low enough that auditing cannot take place, but is also not
+ * high enough that we already know we have to write an audit record
+ * (i.e., the state is AUDIT_SETUP_CONTEXT or AUDIT_BUILD_CONTEXT).
  */
-static enum audit_state audit_filter_syscall(struct task_struct *tsk,
+static void audit_filter_syscall(struct task_struct *tsk,
 					     struct audit_context *ctx,
 					     struct list_head *list)
 {
@@ -812,7 +812,7 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
 	enum audit_state state;
 
 	if (auditd_test_task(tsk))
-		return AUDIT_DISABLED;
+		return;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, list, list) {
@@ -821,11 +821,11 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
 				       &state, false)) {
 			rcu_read_unlock();
 			ctx->current_state = state;
-			return state;
+			return;
 		}
 	}
 	rcu_read_unlock();
-	return AUDIT_BUILD_CONTEXT;
+	return;
 }
 
 /*
-- 
2.25.1

