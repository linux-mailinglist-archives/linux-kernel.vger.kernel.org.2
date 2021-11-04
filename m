Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B67444C52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhKDAaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhKDA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:28:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155DC061205
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 17:26:07 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 134-20020a62198c000000b0047bf0981003so2352642pfz.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=d5eBGhjOdraOb8ROBhsskw4veY1ejlVUg/ty/xkC83c=;
        b=L0C1v+L5WkKOg/1UpzG68qTukZN83qwmMd/ueUN7ewuot9u43aTlXxZMHBpBnaC7/S
         e6lXD4GKbCtYx2tBTmg/D1dxn24ATg3EXOzk/ufgGhsCdxjkWD3S/Oet9+81xR7BjiXX
         KsSER1qqH3/ReOXKXEOMxEw+ZWZNMNrHAG+1wsXmgAmQGJdPsauAqWgxGa2bXM3eqrsd
         MHAblvb9KsqWTWqMYMO09zCzubyhjCK3PZcX9W1VDJfzaXxKjt1+UDPCWwyzZTqBxXQG
         LYMbx+aWi+q//Eh8G56e8rXxUsD7RwW0EkMLPRzsJeTaMSzf+hbvycjlYJ8jReWzoeCU
         NYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=d5eBGhjOdraOb8ROBhsskw4veY1ejlVUg/ty/xkC83c=;
        b=z5REL2xQiLntz4GiQxaXrzUYPGMeakR6OKb2z76BF94jMol3JFimbzxRdTQGKsR9SF
         J/tUTEon9UGhsixDv/HuL8eO8fVl7+DafZLEbRkAqj9r9uqUd4uM1FO54i+N/Kqo5AdM
         4MeclpYW3LQlYuUMxJNYpOin4W54ERUfxwnThUA8IoWu2y3cT/gBgVWNXE0PxJz6RmRE
         S6icmyP0X7Tz1AEVyR6mLahXJDXDJ51U7UEMs5/hPloeeYUutarPPUiPNRVT+matZ37h
         t7qBnfqWgbRNwIEYDm9Xjuj4T7O+NzwJCE04NA3bYGNTYd+hmzFMtmaVvMVHuqkgGTvV
         8ABQ==
X-Gm-Message-State: AOAM533An1B/TbIk3Uz0+bc7Oj+euEgyGFKwq2lT7J+3eawwwesvNs8N
        JlBj8nXMapdHD/qmh5KZlqZN7EF0mqY=
X-Google-Smtp-Source: ABdhPJwR/8S2bf9OYImnNTGTvQtJKx+tPqKxegkkAxc8UN7P/Djj1xJRY5WUZbtpalPRRv4cuF26HKA4p5A=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr261267pjh.1.1635985566550; Wed, 03 Nov 2021 17:26:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Nov 2021 00:25:06 +0000
In-Reply-To: <20211104002531.1176691-1-seanjc@google.com>
Message-Id: <20211104002531.1176691-6-seanjc@google.com>
Mime-Version: 1.0
References: <20211104002531.1176691-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v5.5 05/30] KVM: Resync only arch fields when slots_arch_lock
 gets reacquired
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

There is no need to copy the whole memslot data after releasing
slots_arch_lock for a moment to install temporary memslots copy in
kvm_set_memslot() since this lock only protects the arch field of each
memslot.

Just resync this particular field after reacquiring slots_arch_lock.

Note, this also eliminates the need to manually clear the INVALID flag
when restoring memslots; the "setting" of the INVALID flag was an
unwanted side effect of copying the entire memslots.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
[sean: tweak shortlog, note INVALID flag in changelog, revert comment]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6171ddb3e31c..e5c2d10f6111 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1500,12 +1500,6 @@ static size_t kvm_memslots_size(int slots)
 	       (sizeof(struct kvm_memory_slot) * slots);
 }
 
-static void kvm_copy_memslots(struct kvm_memslots *to,
-			      struct kvm_memslots *from)
-{
-	memcpy(to, from, kvm_memslots_size(from->used_slots));
-}
-
 /*
  * Note, at a minimum, the current number of used slots must be allocated, even
  * when deleting a memslot, as we need a complete duplicate of the memslots for
@@ -1524,11 +1518,22 @@ static struct kvm_memslots *kvm_dup_memslots(struct kvm_memslots *old,
 
 	slots = kvzalloc(new_size, GFP_KERNEL_ACCOUNT);
 	if (likely(slots))
-		kvm_copy_memslots(slots, old);
+		memcpy(slots, old, kvm_memslots_size(old->used_slots));
 
 	return slots;
 }
 
+static void kvm_copy_memslots_arch(struct kvm_memslots *to,
+				   struct kvm_memslots *from)
+{
+	int i;
+
+	WARN_ON_ONCE(to->used_slots != from->used_slots);
+
+	for (i = 0; i < from->used_slots; i++)
+		to->memslots[i].arch = from->memslots[i].arch;
+}
+
 static int kvm_set_memslot(struct kvm *kvm,
 			   const struct kvm_userspace_memory_region *mem,
 			   struct kvm_memory_slot *new, int as_id,
@@ -1569,9 +1574,10 @@ static int kvm_set_memslot(struct kvm *kvm,
 		slot->flags |= KVM_MEMSLOT_INVALID;
 
 		/*
-		 * We can re-use the memory from the old memslots.
-		 * It will be overwritten with a copy of the new memslots
-		 * after reacquiring the slots_arch_lock below.
+		 * We can re-use the old memslots, the only difference from the
+		 * newly installed memslots is the invalid flag, which will get
+		 * dropped by update_memslots anyway.  We'll also revert to the
+		 * old memslots if preparing the new memory region fails.
 		 */
 		slots = install_new_memslots(kvm, as_id, slots);
 
@@ -1588,12 +1594,14 @@ static int kvm_set_memslot(struct kvm *kvm,
 		mutex_lock(&kvm->slots_arch_lock);
 
 		/*
-		 * The arch-specific fields of the memslots could have changed
-		 * between releasing the slots_arch_lock in
-		 * install_new_memslots and here, so get a fresh copy of the
-		 * slots.
+		 * The arch-specific fields of the now-active memslots could
+		 * have been modified between releasing slots_arch_lock in
+		 * install_new_memslots and re-acquiring slots_arch_lock above.
+		 * Copy them to the inactive memslots.  Arch code is required
+		 * to retrieve memslots *after* acquiring slots_arch_lock, thus
+		 * the active memslots are guaranteed to be fresh.
 		 */
-		kvm_copy_memslots(slots, __kvm_memslots(kvm, as_id));
+		kvm_copy_memslots_arch(slots, __kvm_memslots(kvm, as_id));
 	}
 
 	/*
@@ -1642,13 +1650,10 @@ static int kvm_set_memslot(struct kvm *kvm,
 	return 0;
 
 out_slots:
-	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
-		slot = id_to_memslot(slots, new->id);
-		slot->flags &= ~KVM_MEMSLOT_INVALID;
+	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
 		slots = install_new_memslots(kvm, as_id, slots);
-	} else {
+	else
 		mutex_unlock(&kvm->slots_arch_lock);
-	}
 	kvfree(slots);
 	return r;
 }
-- 
2.33.1.1089.g2158813163f-goog

