Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11DA453C00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhKPWA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhKPWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:00:19 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547BC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:57:22 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k22-20020a635a56000000b002df9863aa74so190565pgm.19
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RcxO89LsZtHgdWSYVweaJQPcYAbZUnKnBWG821s8zas=;
        b=sadMJNIDL9S3tfFJIrrJR2oyw/Fpm76XFjUCAQxx5qAVWIfC1+8OULcZFMJktCxOlk
         tjU8MxNlVgGMBPq1Oc0bUjfB2bB7hK3Rg33hxLGdi0+HdDCir3/JiqMwjY16IK9oLj3L
         5toksxo5EbqhHJHXksLvDXWhH8nj5han4FAR8DMJLIJqyUxKokkZfqavlMO97qvmhcb6
         i5D0W/5LrZnSdelv0TJVhDNsBNPLITY6FhKwUpgthNfmATlnUZfLLqWESkX2LX+ypW/i
         z2ANTtjj5hLbZS9PJALUGqhUQgDxMzgEUYqmqUqDtAWjjDOn2ZB5sfPHVZFx0fRac1v7
         m9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RcxO89LsZtHgdWSYVweaJQPcYAbZUnKnBWG821s8zas=;
        b=GzbaWPJiAN/jAykW3ff+UH6Lqd59WoPlMc4NAGrWReB8ZdREGriyPeVS/5+qmkOBol
         OmSaBN1LJDFUBbyfnhOxt2bmIbeKyFdfkJTO9ETmEDOLANexo+i94Bq4t83cDK4QTAOz
         f06Ks/s5RgM+phlpsBuJCThTysPerNn0T0xszq+VF4Mb/FbtcjaR7ufho0KdSS5ltSez
         XYwXu77erc5cD9LWiFXii+18it+IMV5aBaCqv6fMzcytoEXwe6x3QAouxUuoeqvX3ev0
         fI3aBB09rAvpNgkh7ai1zOJJDJpYIw2ei+jR2lCUkP/QFMUydvAkZOudWeU49MVQY49H
         OJAw==
X-Gm-Message-State: AOAM533czVJkW9HI//jQhY/fgxjr1Z5x+nvthDpAMs0uIQQDs8fX1mqX
        kKJAo7vGs1RQet55eBjQaAd84SrC1/s=
X-Google-Smtp-Source: ABdhPJw97ZImSXy/35Rbj61WyaJeUIeljhV1L18+fR0M/gOLQuFIwGLtXq43ozIk7RQDTw8knKOeaXWo9zI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:91d1:d198:1088:5801])
 (user=surenb job=sendgmr) by 2002:a63:86c1:: with SMTP id x184mr1591868pgd.295.1637099841832;
 Tue, 16 Nov 2021 13:57:21 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:57:15 -0800
In-Reply-To: <20211116215715.645231-1-surenb@google.com>
Message-Id: <20211116215715.645231-2-surenb@google.com>
Mime-Version: 1.0
References: <20211116215715.645231-1-surenb@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 2/2] mm/oom_kill: allow process_mrelease to run under
 mmap_lock protection
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With exit_mmap holding mmap_write_lock during free_pgtables call,
process_mrelease does not need to elevate mm->mm_users in order to
prevent exit_mmap from destrying pagetables while __oom_reap_task_mm
is walking the VMA tree. The change prevents process_mrelease from
calling the last mmput, which can lead to waiting for IO completion
in exit_aio.

Fixes: 337546e83fc7 ("mm/oom_kill.c: prevent a race between process_mrelease and exit_mmap")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/oom_kill.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..67780386f478 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1169,15 +1169,15 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		goto put_task;
 	}
 
-	if (mmget_not_zero(p->mm)) {
-		mm = p->mm;
-		if (task_will_free_mem(p))
-			reap = true;
-		else {
-			/* Error only if the work has not been done already */
-			if (!test_bit(MMF_OOM_SKIP, &mm->flags))
-				ret = -EINVAL;
-		}
+	mm = p->mm;
+	mmgrab(mm);
+
+	if (task_will_free_mem(p))
+		reap = true;
+	else {
+		/* Error only if the work has not been done already */
+		if (!test_bit(MMF_OOM_SKIP, &mm->flags))
+			ret = -EINVAL;
 	}
 	task_unlock(p);
 
@@ -1188,13 +1188,16 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 		ret = -EINTR;
 		goto drop_mm;
 	}
-	if (!__oom_reap_task_mm(mm))
+	/*
+	 * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
+	 * possible change in exit_mmap is seen
+	 */
+	if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
 		ret = -EAGAIN;
 	mmap_read_unlock(mm);
 
 drop_mm:
-	if (mm)
-		mmput(mm);
+	mmdrop(mm);
 put_task:
 	put_task_struct(task);
 	return ret;
-- 
2.34.0.rc1.387.gb447b232ab-goog

