Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76E63173F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhBJXIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhBJXHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:07:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD34C061788
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:06:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j128so4258389ybc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=u5agusI6ac1ZBmmg02mLrOPHFue6wiHDevsOWTqiwyY=;
        b=nCnbGdPG+yNhWiOeR88w0ANcwJCfkjyTH8YtC/jZD3yLRLYE4mUjg3Om7/5pXTNNnb
         10RSr5D4T7S2RIgqBi4drrXNVKkmOZEknL3snDlEjObJjo3GWdeOmTQ8xl/7CW8g3F6N
         swsgRPUqr8v10PldITx8F8LQA8EM9rr1jpkkuPJodYa8+O2B9m7zW3d5HvAdehqVPzOo
         8Nxaao2qyyeE6/NRgHD5VqyMapsqnqRVMqY8p8uTlF6CLYzD71RXXzYtn7VryQ5Ks00T
         Onw4pBLrfNn68kjnZpr2YQPTlK3KQ7vf10WP/QsIYk6OG4d1hkb/zwUVc9dKQkStGiE0
         Ousw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=u5agusI6ac1ZBmmg02mLrOPHFue6wiHDevsOWTqiwyY=;
        b=AwVKpH32BHnnmiY85uCndkcoPtKyfUucsZ0RZLC6ECr9yhPJ5YqmOkuUX5RBr5ORvK
         AI9aSEXL1Z3KzrV8RnQogMPMYpQhxunkBY3EqcH1MIkVKQkiGUHBdAOPOL7iOKLE+q9Z
         4aFU+rUSwBk++EzLH59Da5f6/gVWBcPjIWiHb0+mJRnpTd9Qti3/v0pRZ2CWceOUi2Eq
         P7/qVPHIRT70Olg+mcFMCmJaecDOLg7XzRW3YniGdNhCRjq+kqyTAQvZK0uf5ZNjV83d
         MN3ZgBeljv6laP/NB/YRy4Nm3gjLFIGTlO8aL5iKxCgUwwxgAUa5Il7R0U8zQ2nGjPe6
         cQ7Q==
X-Gm-Message-State: AOAM530jgzVxCumWgg+tLxWFV3VJWV0qpLflCH4KK0v4MSlpAeoET0EH
        rwKKBIn6Iu2TtdBh/HHFXcaBUy7Y3bY=
X-Google-Smtp-Source: ABdhPJycTcvRtJ64GeUWyqK0vyZbklWTM01vrk+CfDQE1TBRfeJwQdaWqSFrRvNthsNIZERKrXkxLwkqKbA=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
 (user=seanjc job=sendgmr) by 2002:a25:2ac3:: with SMTP id q186mr6830175ybq.213.1612998396762;
 Wed, 10 Feb 2021 15:06:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Feb 2021 15:06:12 -0800
In-Reply-To: <20210210230625.550939-1-seanjc@google.com>
Message-Id: <20210210230625.550939-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210210230625.550939-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 02/15] KVM: selftests: Expose align() helpers to tests
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor align() to work with non-pointers, add align_ptr() for use with
pointers, and expose both helpers so that they can be used by tests
and/or other utilities.  The align() helper in particular will be used
to ensure gpa alignment for hugepages.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 15 +++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 11 +----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2d7eb6989e83..4b5d2362a68a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -79,6 +79,21 @@ struct vm_guest_mode_params {
 };
 extern const struct vm_guest_mode_params vm_guest_mode_params[];
 
+/* Aligns x up to the next multiple of size. Size must be a power of 2. */
+static inline uint64_t align(uint64_t x, uint64_t size)
+{
+	uint64_t mask = size - 1;
+
+	TEST_ASSERT(size != 0 && !(size & (size - 1)),
+		    "size not a power of 2: %lu", size);
+	return ((x + mask) & ~mask);
+}
+
+static inline void *align_ptr(void *x, size_t size)
+{
+	return (void *)align((unsigned long)x, size);
+}
+
 int kvm_check_cap(long cap);
 int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
 int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 960f4c5129ff..584167c6dbc7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -21,15 +21,6 @@
 #define KVM_UTIL_PGS_PER_HUGEPG 512
 #define KVM_UTIL_MIN_PFN	2
 
-/* Aligns x up to the next multiple of size. Size must be a power of 2. */
-static void *align(void *x, size_t size)
-{
-	size_t mask = size - 1;
-	TEST_ASSERT(size != 0 && !(size & (size - 1)),
-		    "size not a power of 2: %lu", size);
-	return (void *) (((size_t) x + mask) & ~mask);
-}
-
 /*
  * Capability
  *
@@ -757,7 +748,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 		    region->mmap_start, errno);
 
 	/* Align host address */
-	region->host_mem = align(region->mmap_start, alignment);
+	region->host_mem = align_ptr(region->mmap_start, alignment);
 
 	/* As needed perform madvise */
 	if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
-- 
2.30.0.478.g8a0d178c01-goog

