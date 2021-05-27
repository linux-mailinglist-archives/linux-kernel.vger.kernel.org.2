Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4309E39370B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhE0UYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:24:42 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:33752 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbhE0UYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:24:37 -0400
Received: by mail-io1-f47.google.com with SMTP id a6so1901912ioe.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KJxarqOA5UAquH//zCAX9LSHqifUGG7qrEUJvYDCc/U=;
        b=MJ4qRjPH+B/mZZLNs5dl6YKqQ7fGQFda9TqpqI36/Dcoawo4vlmG3pHuWrRZYeS5ei
         It0+7y/69vp8cF3+xpwN55M16OId82CaxRl5/Q3J68x93RaXlpPDwCpiexVG5nBvriYJ
         REj2xm6PFYAZj8pdmsWdivw1GD+H/gqBvez+bVeXqMYnttPmWpBjzuvDyMgb5fLYWKQJ
         987FFlBlTc7q9dMtMUkOeJTB1A6NlaP6n6qATmC0AjSeVgYA1sNUPY2B7A7ucLCww37o
         V9/TorKXvx1SQ7efnuk0ScE2yZJUy4Nd1uyLGO3bE63xm7v4NjiZBX/fYXIfTXkTEE/X
         vLlA==
X-Gm-Message-State: AOAM530w9wGq8mNu8vlAr0Bfm4vEO7fzRVe++OxfZl2NVdSPwsgviJwN
        Ul3yhBhQm0EANArLadRoLDg=
X-Google-Smtp-Source: ABdhPJxsn+SDwP9x+hJL6MjuV5MUCe6IUz/t7g9fKuhdYGZIkDHkFYbJomPtSesAxzn4jGs6bChgZA==
X-Received: by 2002:a02:ba08:: with SMTP id z8mr5241195jan.74.1622146982921;
        Thu, 27 May 2021 13:23:02 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id y18sm1829721ili.18.2021.05.27.13.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:02 -0700 (PDT)
Date:   Thu, 27 May 2021 20:23:01 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.13-rc4
Message-ID: <YK//pZfXvXnEFbuT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This contains a cleanup to lib/percpu-refcount.c and an update to the
MAINTAINERS file to more formally take over support for lib/percpu*.

A few things I expect to have ready for-5.14, percpu depopulation
(queued) and an updated to percpu memcg accounting (wip from Roman
Gushchin).

Thanks,
Dennis

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.13-fixes

for you to fetch changes up to c547addba7096debac4f99cdfe869a32a81081e2:

  MAINTAINERS: Add lib/percpu* as part of percpu entry (2021-05-13 04:50:30 +0000)

----------------------------------------------------------------
Nikolay Borisov (2):
      percpu_ref: Don't opencode percpu_ref_is_dying
      MAINTAINERS: Add lib/percpu* as part of percpu entry

 MAINTAINERS           | 2 ++
 lib/percpu-refcount.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..9599e313d7f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14317,10 +14317,12 @@ PER-CPU MEMORY ALLOCATOR
 M:	Dennis Zhou <dennis@kernel.org>
 M:	Tejun Heo <tj@kernel.org>
 M:	Christoph Lameter <cl@linux.com>
+L:	linux-mm@kvack.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git
 F:	arch/*/include/asm/percpu.h
 F:	include/linux/percpu*.h
+F:	lib/percpu*.c
 F:	mm/percpu*.c
 
 PER-TASK DELAY ACCOUNTING
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index a1071cdefb5a..af9302141bcf 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -275,7 +275,7 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 	wait_event_lock_irq(percpu_ref_switch_waitq, !data->confirm_switch,
 			    percpu_ref_switch_lock);
 
-	if (data->force_atomic || (ref->percpu_count_ptr & __PERCPU_REF_DEAD))
+	if (data->force_atomic || percpu_ref_is_dying(ref))
 		__percpu_ref_switch_to_atomic(ref, confirm_switch);
 	else
 		__percpu_ref_switch_to_percpu(ref);
@@ -385,7 +385,7 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	WARN_ONCE(ref->percpu_count_ptr & __PERCPU_REF_DEAD,
+	WARN_ONCE(percpu_ref_is_dying(ref),
 		  "%s called more than once on %ps!", __func__,
 		  ref->data->release);
 
@@ -465,7 +465,7 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	WARN_ON_ONCE(!(ref->percpu_count_ptr & __PERCPU_REF_DEAD));
+	WARN_ON_ONCE(!percpu_ref_is_dying(ref));
 	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
 
 	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
