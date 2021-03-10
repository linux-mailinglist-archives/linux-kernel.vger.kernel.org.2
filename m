Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B625B3349DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhCJVcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhCJVbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:31:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD759C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:31:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y7so22816707ybh.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=6zFz1na/xQ1K4cFFaYIhngDFvy1L6Rfcvb/ohgSzv34=;
        b=ZpacngMpkTe50hu+4MmmZ9mDxTjiKTOau858QXWt9fGgl9XI0CVhFcWlsfFk2rcjji
         Y2N+nza3ZlGHA6BcotE31mzQQikWGpvEq1Q1SN+/ZBZvglHUm0SrDkty+gV/DgETLZzy
         Gv3prnDZZNR+3Jj3MRJg+ycmKe5XAiH3Gepck4sJ2xOij3z18tRJg/+Ukz/AWSZPIsvf
         Gj/BG6DgqJs98mNUQmf/pDBYnYPiyBUehAusrqDBpfhoDtTdVhWOSN7U0j5CVF6p8ZJA
         nh7kf+zGgz3wvwGCfhgAy7nDml0NU5uGzrT3N+NVf9uED0sVjXxpebvwIL8kSHI84es1
         /oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=6zFz1na/xQ1K4cFFaYIhngDFvy1L6Rfcvb/ohgSzv34=;
        b=OlIh56JN29AxchRLZJvy9av1i2mYT27bm+xP03yt5Sj4Mm+RnkVc8rxvEa3qxK9kEf
         eJes8p3lmOQtQt7hDw9N8LS5L/H/3ubwyVlIoIAbZYbwjgC3l4gKJOHIBcuxVXMAmeCO
         sFL0/BpVX8nLQFEuB3c2vYAfBo+VVv58SdcYSKP2uAJa4InfklljbehLd5fkuWO/rlwv
         xr7t9YfWcrGMYJUBGmd7Z/8jLNqEd1LjxvyZ9Eikl93ZbtxPvqGpKiXYcIegrH8peo0/
         4oTW2Uo+DlxBYwacHsygvU4EHOyR7spmIxHWUXTgYdB2rs1tzhk17h2EyethXp7xZYCn
         ZEBQ==
X-Gm-Message-State: AOAM531aq3z7dRp88lEs6DghNZjhjkWm+diDAkSES0Qxth8qYqeM+OW8
        Ahnb+xiQ8zSLgyNg7tspazTsBxWfdKo=
X-Google-Smtp-Source: ABdhPJz4oo0IZDanHo1iwUxfV6RdFiPpFC+E/fradMAqbkrsr5TR349ePu7+xhg92qQXD/a2oL7cT2Nu0pU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e4dd:6c31:9463:f8da])
 (user=seanjc job=sendgmr) by 2002:a25:a002:: with SMTP id x2mr7418118ybh.13.1615411886828;
 Wed, 10 Mar 2021 13:31:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Mar 2021 13:31:17 -0800
Message-Id: <20210310213117.1444147-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] mm/oom_kill: Ensure MMU notifier range_end() is paired with range_start()
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Ben Gardon <bgardon@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke the MMU notifier's .invalidate_range_end() callbacks even if one
of the .invalidate_range_start() callbacks failed.  If there are multiple
notifiers, the notifier that did not fail may have performed actions in
its ...start() that it expects to unwind via ...end().  Per the
mmu_notifier_ops documentation, ...start() and ...end() must be paired.

The only in-kernel usage that is fatally broken is the SGI UV GRU driver,
which effectively blocks and sleeps fault handlers during ...start(), and
unblocks/wakes the handlers during ...end().  But, the only users that
can fail ...start() are the i915 and Nouveau drivers, which are unlikely
to collide with the SGI driver.

KVM is the only other user of ...end(), and while KVM also blocks fault
handlers in ...start(), the fault handlers do not sleep and originate in
killable ioctl() calls.  So while it's possible for the i915 and Nouveau
drivers to collide with KVM, the bug is benign for KVM since the process
is dying and KVM's guest is about to be terminated.

So, as of today, the bug is likely benign.  But, that may not always be
true, e.g. there is a potential use case for blocking memslot updates in
KVM while an invalidation is in-progress, and failure to unblock would
result in said updates being blocked indefinitely and hanging.

Found by inspection.  Verified by adding a second notifier in KVM that
periodically returns -EAGAIN on non-blockable ranges, triggering OOM,
and observing that KVM exits with an elevated notifier count.

Fixes: 93065ac753e4 ("mm, oom: distinguish blockable mode for mmu notifiers=
")
Cc: stable@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>
Cc: Ben Gardon <bgardon@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 mm/oom_kill.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index bc65ba4f5192..acc3ba8b2ed7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -546,12 +546,10 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 						vma, mm, vma->vm_start,
 						vma->vm_end);
 			tlb_gather_mmu(&tlb, mm);
-			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
-				tlb_finish_mmu(&tlb);
+			if (!mmu_notifier_invalidate_range_start_nonblock(&range))
+				unmap_page_range(&tlb, vma, range.start, range.end, NULL);
+			else
 				ret =3D false;
-				continue;
-			}
-			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
 			mmu_notifier_invalidate_range_end(&range);
 			tlb_finish_mmu(&tlb);
 		}
--=20
2.30.1.766.gb4fecdf3b7-goog

