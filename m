Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7B36F1E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhD2VT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbhD2VTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:19:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1C4C061342
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:19:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c8-20020a25a2c80000b02904eda0a22b5dso20431655ybn.17
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mFEL1a6aUCqpk4hZSWwrim39XPZlMuhgczIiyiJU3Hk=;
        b=QoIvPIfNc4daBsgyq7HoomFzUjFl28lBXn6OC3BTTU0TFQtx+vaUXnMgDGoZv87SHZ
         +iDWWmphxqbcA0cHJKI1fiyKrP9qINdh4l5asfLbzi1CaOky8QNS8V4iACDbFW+Xefpr
         WskLfTKP0Pk8PnepZS09HRmbxb8H9v3CT9pRtwTwcVAeu24YPWZhPhAXbZQ2eZsRpFr/
         TS9qXCMxsH5YAFNk/yLSILxFD/hUanDMUoooFYWCYdwchTEPSnq0Gayq5zoJDmUAZZtI
         J8mMUc+ZW520waefGFYIlhjXOsHE5St5/VXM08TBgkVVU1e7Kao+Oy53Sl4JfuSvMesm
         ztKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mFEL1a6aUCqpk4hZSWwrim39XPZlMuhgczIiyiJU3Hk=;
        b=jEgWUQlP9Fhe7pmrUFZQBSBpVm0SRtCXHC9bEPrxvy9RfUmC76jaW1J2QQ/M2Y6Wyq
         1aIfAeBsygZIrE/WnCfMi79e6gkEJ5FCciYMZ6Fv9BIcPqZaRGQuNITkIXbCG+antb1U
         lTokSr/3oarvgTLgIH/pEeYJ5wo2lC1ksVdhSdlv2+BetW6OOPiEP1etFuA/lj9zrnz5
         1VAYuJSBhxjxbnb0FvIuc17/UPAWiT3c0XXaV85+9GW/VQdc9kb1qCNtBe/a+pNV2nrD
         BhxojEKYteAF1FgRFCrd/2edm2qM4x6lAAqsVDB+Tdhe7TmnjbD3jSHl0Wpny74ACgeM
         Y7XQ==
X-Gm-Message-State: AOAM532+//i31kHBO7BOu4hyt7iEqS/pBAPcd0Mi03oty6DruUj8/oMt
        Y6zXJ3jaW+dMilHDD2zhlMXlfF8ulN0S5OaVPS+X87SpHXdnQFJRheq5L2tjYCP4q2s9YR1kzuO
        5FkwnN7sKid9Vo7EzovXv7NxHGwpRY4xQGbkVxhanGuULVCeaRsSVxdmaDikyEQiokp7KqHl3
X-Google-Smtp-Source: ABdhPJx7pm5xPEQiP+I1G1fbjQZ0XfY8/nduo0ZV1m6C+Xt9+OiGj1+WB3jXutNMXULR2+S4HiCFAwrWzMuu
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:1a18:9719:a02:56fb])
 (user=bgardon job=sendgmr) by 2002:a25:cf8c:: with SMTP id
 f134mr2184198ybg.216.1619731140835; Thu, 29 Apr 2021 14:19:00 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:18:31 -0700
In-Reply-To: <20210429211833.3361994-1-bgardon@google.com>
Message-Id: <20210429211833.3361994-6-bgardon@google.com>
Mime-Version: 1.0
References: <20210429211833.3361994-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 5/7] KVM: mmu: Refactor memslot copy
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out copying kvm_memslots from allocating the memory for new ones
in preparation for adding a new lock to protect the arch-specific fields
of the memslots.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 virt/kvm/kvm_main.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2799c6660cce..c8010f55e368 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1306,6 +1306,18 @@ static struct kvm_memslots *install_new_memslots(struct kvm *kvm,
 	return old_memslots;
 }
 
+static size_t kvm_memslots_size(int slots)
+{
+	return sizeof(struct kvm_memslots) +
+	       (sizeof(struct kvm_memory_slot) * slots);
+}
+
+static void kvm_copy_memslots(struct kvm_memslots *from,
+			      struct kvm_memslots *to)
+{
+	memcpy(to, from, kvm_memslots_size(from->used_slots));
+}
+
 /*
  * Note, at a minimum, the current number of used slots must be allocated, even
  * when deleting a memslot, as we need a complete duplicate of the memslots for
@@ -1315,19 +1327,16 @@ static struct kvm_memslots *kvm_dup_memslots(struct kvm_memslots *old,
 					     enum kvm_mr_change change)
 {
 	struct kvm_memslots *slots;
-	size_t old_size, new_size;
-
-	old_size = sizeof(struct kvm_memslots) +
-		   (sizeof(struct kvm_memory_slot) * old->used_slots);
+	size_t new_size;
 
 	if (change == KVM_MR_CREATE)
-		new_size = old_size + sizeof(struct kvm_memory_slot);
+		new_size = kvm_memslots_size(old->used_slots + 1);
 	else
-		new_size = old_size;
+		new_size = kvm_memslots_size(old->used_slots);
 
 	slots = kvzalloc(new_size, GFP_KERNEL_ACCOUNT);
 	if (likely(slots))
-		memcpy(slots, old, old_size);
+		kvm_copy_memslots(old, slots);
 
 	return slots;
 }
-- 
2.31.1.527.g47e6f16901-goog

