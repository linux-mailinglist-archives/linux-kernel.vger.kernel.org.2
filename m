Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDA731EC35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 17:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhBRQX7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Feb 2021 11:23:59 -0500
Received: from mx1.emlix.com ([136.243.223.33]:57522 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhBRNi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:38:59 -0500
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 2C08060016;
        Thu, 18 Feb 2021 13:37:12 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] simplify copy_mm()
Date:   Thu, 18 Feb 2021 13:37:11 +0100
Message-ID: <2072685.XptgVkyDqn@devpool47>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All this can happen without a single goto.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 kernel/fork.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..1cad8c622b34 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1382,7 +1382,6 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct mm_struct *mm, *oldmm;
-	int retval;
 
 	tsk->min_flt = tsk->maj_flt = 0;
 	tsk->nvcsw = tsk->nivcsw = 0;
@@ -1409,21 +1408,15 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm = oldmm;
-		goto good_mm;
+	} else {
+		mm = dup_mm(tsk, current->mm);
+		if (!mm)
+			return -ENOMEM;
 	}
 
-	retval = -ENOMEM;
-	mm = dup_mm(tsk, current->mm);
-	if (!mm)
-		goto fail_nomem;
-
-good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
 	return 0;
-
-fail_nomem:
-	return retval;
 }
 
 static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
-- 
2.30.0


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



