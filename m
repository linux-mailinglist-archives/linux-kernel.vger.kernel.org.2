Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7714C444C65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhKDAaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhKDA2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:28:46 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B739C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 17:26:09 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id e6-20020a637446000000b002993ba24bbaso2380590pgn.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 17:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=LkuPu2MAmPCt3jWV5gNi6FOTigPIaUyFE38xvFpYcwQ=;
        b=fQ2bhoWoTNjz/8iYeFRgk8xE8v2Objy7+s+fRs3Xbjqo7xemtwELytlJkHcmrH+I8M
         nF5+PPWzNIVtCFCIG/25evZjDbhEXHDEYI4QPrbiUqkMtJe/NqQSXDqAkRrWHvTsM3jA
         SrPBKggz5NoPesjkkd2VEpQQcxnugvWHDTSR8XA4/eYqple6lXn1XqFKMNVmaihp1/C5
         Wp0hIBRrvn/u5O+ODQm5fCPzEDbT4Tydnp6dW0bf7m2CqdK9fPiOK1MYaFjy9+H/z58g
         ImoAfZaL85IvUdUGLtGquAHeWwmvPs8y2pam7sWV2Bi4gxyPO2lJ2+0Gm/fMDsQ6WkmD
         xZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=LkuPu2MAmPCt3jWV5gNi6FOTigPIaUyFE38xvFpYcwQ=;
        b=Y8bGrhgRdkmVu3Qj7nXQrOlaY6zYpeBBLRBH4IiWF+CF2foUFwrQseWMX615Jk6aZA
         9F5lXr8HyQK7c0BXen21QX0zIe1DjfpidEpx5i5LeXZVcjri/2/RoAkannvEOqrb38lO
         Oben9RDzBgWjTe0hJwP1HmmLch9CqOIY6saTTlXAzZcS6AnRVd4ADsf2FIjacT0jxTt2
         BzCqm5Qw3tbuNL923/l7Qp7D5fUjs1o+2Lwt6ipcnx4crCW56rPaCF8kR9alx9BtYH0k
         7GO2hsDqHe/5sMBRxYEy75f2XA2CAFFwMdaOxI4jW3ApKO7rw/nVFkpGOAhu/EybezNc
         2Ruw==
X-Gm-Message-State: AOAM533hmRQIryLLJrvcF3l+eom7m5pndcilPLwq3VrktyqsCmI4ptj7
        e2KtAiT/l+oQUa8IGyD6IHNTTBuDplA=
X-Google-Smtp-Source: ABdhPJzeKw7Ie9jZTvrBx1qRvJ+/3gb9DtrWa/OZ/zOTtW8+RR4Bzhv/NHzsa4hGJ6ZmrRjYSntDBRUHEEc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ecca:b0:141:e920:3b71 with SMTP id
 a10-20020a170902ecca00b00141e9203b71mr22220776plh.10.1635985568621; Wed, 03
 Nov 2021 17:26:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Nov 2021 00:25:07 +0000
In-Reply-To: <20211104002531.1176691-1-seanjc@google.com>
Message-Id: <20211104002531.1176691-7-seanjc@google.com>
Mime-Version: 1.0
References: <20211104002531.1176691-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v5.5 06/30] KVM: Use "new" memslot's address space ID instead
 of dedicated param
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

Now that the address space ID is stored in every slot, including fake
slots used for deletion, use the slot's as_id instead of passing in the
redundant information as a param to kvm_set_memslot().  This will greatly
simplify future memslot work by avoiding passing a large number of
variables around purely to honor @as_id.

Drop a comment in the DELETE path about new->as_id being provided purely
for debug, as that's now a lie.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e5c2d10f6111..39a64e02a43a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1536,7 +1536,7 @@ static void kvm_copy_memslots_arch(struct kvm_memslots *to,
 
 static int kvm_set_memslot(struct kvm *kvm,
 			   const struct kvm_userspace_memory_region *mem,
-			   struct kvm_memory_slot *new, int as_id,
+			   struct kvm_memory_slot *new,
 			   enum kvm_mr_change change)
 {
 	struct kvm_memory_slot *slot, old;
@@ -1559,7 +1559,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 	 */
 	mutex_lock(&kvm->slots_arch_lock);
 
-	slots = kvm_dup_memslots(__kvm_memslots(kvm, as_id), change);
+	slots = kvm_dup_memslots(__kvm_memslots(kvm, new->as_id), change);
 	if (!slots) {
 		mutex_unlock(&kvm->slots_arch_lock);
 		return -ENOMEM;
@@ -1579,7 +1579,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 		 * dropped by update_memslots anyway.  We'll also revert to the
 		 * old memslots if preparing the new memory region fails.
 		 */
-		slots = install_new_memslots(kvm, as_id, slots);
+		slots = install_new_memslots(kvm, new->as_id, slots);
 
 		/* From this point no new shadow pages pointing to a deleted,
 		 * or moved, memslot will be created.
@@ -1601,7 +1601,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 		 * to retrieve memslots *after* acquiring slots_arch_lock, thus
 		 * the active memslots are guaranteed to be fresh.
 		 */
-		kvm_copy_memslots_arch(slots, __kvm_memslots(kvm, as_id));
+		kvm_copy_memslots_arch(slots, __kvm_memslots(kvm, new->as_id));
 	}
 
 	/*
@@ -1618,7 +1618,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 		WARN_ON_ONCE(change != KVM_MR_CREATE);
 		memset(&old, 0, sizeof(old));
 		old.id = new->id;
-		old.as_id = as_id;
+		old.as_id = new->as_id;
 	}
 
 	/* Copy the arch-specific data, again after (re)acquiring slots_arch_lock. */
@@ -1629,7 +1629,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 		goto out_slots;
 
 	update_memslots(slots, new, change);
-	slots = install_new_memslots(kvm, as_id, slots);
+	slots = install_new_memslots(kvm, new->as_id, slots);
 
 	/*
 	 * Update the total number of memslot pages before calling the arch
@@ -1651,7 +1651,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 
 out_slots:
 	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
-		slots = install_new_memslots(kvm, as_id, slots);
+		slots = install_new_memslots(kvm, new->as_id, slots);
 	else
 		mutex_unlock(&kvm->slots_arch_lock);
 	kvfree(slots);
@@ -1723,13 +1723,9 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 		memset(&new, 0, sizeof(new));
 		new.id = id;
-		/*
-		 * This is only for debugging purpose; it should never be
-		 * referenced for a removed memslot.
-		 */
 		new.as_id = as_id;
 
-		return kvm_set_memslot(kvm, mem, &new, as_id, KVM_MR_DELETE);
+		return kvm_set_memslot(kvm, mem, &new, KVM_MR_DELETE);
 	}
 
 	new.as_id = as_id;
@@ -1792,7 +1788,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 			bitmap_set(new.dirty_bitmap, 0, new.npages);
 	}
 
-	r = kvm_set_memslot(kvm, mem, &new, as_id, change);
+	r = kvm_set_memslot(kvm, mem, &new, change);
 	if (r)
 		goto out_bitmap;
 
-- 
2.33.1.1089.g2158813163f-goog

