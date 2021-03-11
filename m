Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE54337B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCKSB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCKSBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:01:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:01:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q77so26618510ybq.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=0hIsya0NPg3LraqUh9U14zv4tDyz3lAbAtT3O6KMbxI=;
        b=kViAvDBzbyxZqyKRKrGS5AptEYuUi9oYcEnG60YN58mxT00AUqITV3I11Y+z9uN/ce
         pXUrGMUEldjoLpWK/xnQ3ESQ4g52cJUG7ie2cBDAyzJqZgbtj7FBj75EcN+VhcCctcvy
         A5Qz29luD76h6ydg59eXDLYzdRN56k9MxnzgfALOhHa7MN7Xb6FK8sNySmlxJPAeXht/
         w+wDBy9Q9zQo5OcRkcsdx+owECuvGehGkeW3i6BxDK3cxI15FGxH9yKO2Z+wEQw+ujF0
         A0rbaA+zXSTzxZOcuh3E9dun0NYuCoN0WaxaqCc/cqiL2xVeZHFy9n3oE90rPBjoGleK
         m4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=0hIsya0NPg3LraqUh9U14zv4tDyz3lAbAtT3O6KMbxI=;
        b=iuC1tyJMV9NIZC0uVy2PV4Pk+qM4BONuxUrPJPO2Wd/AMvM+nSR696py7yL9jLjUtG
         2jbauEe47pbB8Loi86nRgdl4/8MpVCXJVipizzaPTGAR8U80e5Is816chpC36POA4c0Q
         sWNbWt85NpkJUs2YLHm4zWZxq9SaFBmXyMyWZ9+POwLqCDbMHhIo+TrXvCbSa++HdJ7f
         9t81CqnwnBPGKzoBqDk/2++hlKN3t+oxWKAXq+28oDEkzj2mHVrBhb49Rs76jwAh6rH9
         aYCaJKEIA/dTITwjegLArzK7WvYfLwU8bArdkiWBDKNh/FcRXw2c2XUaomI/xcZbPKmX
         KAUg==
X-Gm-Message-State: AOAM532VqONSYn4o9S4TE9TLIYgeIbcpNMNLZbqgZs6Aq5r8AY+vwilq
        Jjm4ciDMvEEv/+4F6TW4JEupaNsGeKM=
X-Google-Smtp-Source: ABdhPJylQ6J6dAviKLv4ULtSSEsMJZ6skvXuUU4nlEFTt4EJSBPKsNrFY1Lo+yI7hOazITJ+8wVkHa/s3NQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:c4e3:28f1:33df:26ba])
 (user=seanjc job=sendgmr) by 2002:a25:dccc:: with SMTP id y195mr13360755ybe.182.1615485662412;
 Thu, 11 Mar 2021 10:01:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 Mar 2021 10:00:57 -0800
Message-Id: <20210311180057.1582638-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2] mm/mmu_notifiers: Esnure range_end() is paired with range_start()
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Rientjes <rientjes@google.com>,
        Ben Gardon <bgardon@google.com>,
        Michal Hocko <mhocko@suse.com>,
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

If one or more notifiers fails .invalidate_range_start(), invoke
.invalidate_range_end() for "all" notifiers.  If there are multiple
notifiers, those that did not fail are expecting _start() and _end() to
be paired, e.g. KVM's mmu_notifier_count would become imbalanced.
Disallow notifiers that can fail _start() from implementing _end() so
that it's unnecessary to either track which notifiers rejected _start(),
or had already succeeded prior to a failed _start().

Note, the existing behavior of calling _start() on all notifiers even
after a previous notifier failed _start() was an unintented "feature".
Make it canon now that the behavior is depended on for correctness.

As of today, the bug is likely benign:

  1. The only caller of the non-blocking notifier is OOM kill.
  2. The only notifiers that can fail _start() are the i915 and Nouveau
     drivers.
  3. The only notifiers that utilize _end() are the SGI UV GRU driver
     and KVM.
  4. The GRU driver will never coincide with the i195/Nouveau drivers.
  5. An imbalanced kvm->mmu_notifier_count only causes soft lockup in the
     _guest_, and the guest is already doomed due to being an OOM victim.

Fix the bug now to play nice with future usage, e.g. KVM has a potential
use case for blocking memslot updates in KVM while an invalidation is
in-progress, and failure to unblock would result in said updates being
blocked indefinitely and hanging.

Found by inspection.  Verified by adding a second notifier in KVM that
periodically returns -EAGAIN on non-blockable ranges, triggering OOM,
and observing that KVM exits with an elevated notifier count.

Fixes: 93065ac753e4 ("mm, oom: distinguish blockable mode for mmu notifiers=
")
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: stable@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>
Cc: Ben Gardon <bgardon@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Reimplemented as suggested by Jason.  Only functional change relative
    to Jason's suggestion is to check invalidate_range_end before calling t=
o
    avoid a NULL pointer dereference.  I also added more comments, hopefull=
y
    they're helpful...

v1: https://lkml.kernel.org/r/20210310213117.1444147-1-seanjc@google.com

 include/linux/mmu_notifier.h | 10 +++++-----
 mm/mmu_notifier.c            | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index b8200782dede..1a6a9eb6d3fa 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -169,11 +169,11 @@ struct mmu_notifier_ops {
 	 * the last refcount is dropped.
 	 *
 	 * If blockable argument is set to false then the callback cannot
-	 * sleep and has to return with -EAGAIN. 0 should be returned
-	 * otherwise. Please note that if invalidate_range_start approves
-	 * a non-blocking behavior then the same applies to
-	 * invalidate_range_end.
-	 *
+	 * sleep and has to return with -EAGAIN if sleeping would be required.
+	 * 0 should be returned otherwise. Please note that notifiers that can
+	 * fail invalidate_range_start are not allowed to implement
+	 * invalidate_range_end, as there is no mechanism for informing the
+	 * notifier that its start failed.
 	 */
 	int (*invalidate_range_start)(struct mmu_notifier *subscription,
 				      const struct mmu_notifier_range *range);
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 61ee40ed804e..459d195d2ff6 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -501,10 +501,33 @@ static int mn_hlist_invalidate_range_start(
 						"");
 				WARN_ON(mmu_notifier_range_blockable(range) ||
 					_ret !=3D -EAGAIN);
+				/*
+				 * We call all the notifiers on any EAGAIN,
+				 * there is no way for a notifier to know if
+				 * its start method failed, thus a start that
+				 * does EAGAIN can't also do end.
+				 */
+				WARN_ON(ops->invalidate_range_end);
 				ret =3D _ret;
 			}
 		}
 	}
+
+	if (ret) {
+		/*
+		 * Must be non-blocking to get here.  If there are multiple
+		 * notifiers and one or more failed start, any that succeeded
+		 * start are expecting their end to be called.  Do so now.
+		 */
+		hlist_for_each_entry_rcu(subscription, &subscriptions->list,
+					 hlist, srcu_read_lock_held(&srcu)) {
+			if (!subscription->ops->invalidate_range_end)
+				continue;
+
+			subscription->ops->invalidate_range_end(subscription,
+								range);
+		}
+	}
 	srcu_read_unlock(&srcu, id);
=20
 	return ret;
--=20
2.31.0.rc2.261.g7f71774620-goog

