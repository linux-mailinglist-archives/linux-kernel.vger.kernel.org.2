Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B13AF127
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhFURBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhFURAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:54 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7BC0A2F83
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:31:32 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id h10-20020ac87d4a0000b029024eccb9d079so4364662qtb.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fh4N55vsJGr/owgyo59+w03kBoNEzSNeOYDe9RDAnqA=;
        b=NztFXzrOAUEp0IO07vkl0QNPtHvTIOd1gMWUm52bht+wYI2WLBSRkIp2KSCTakma8o
         wmNUNMlRrsbvpQ5W4lWjUcI3DdF9pqnqDhcHuhiGIJy5fUrkoilLAClHvL1xWIAVUibj
         b9HYvax/cp82xsqKmWoKWdSuKCMZvwGg7cK/7iBXpqOLe0M7dhZfHgW7Wwcsm9B12xJc
         cups2bHdRZEHQt0hf70ASS/7Bso0YwYvp/Rt0pIlX+dqWml775joSlylHx9YrcFQKvR4
         T1wx7oDA1W/nLUIA0yVM1Nb6tW8+Lsls4wadWBjKIN+0whiWv95b7Y4eX1Cpixg+t9G9
         0ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fh4N55vsJGr/owgyo59+w03kBoNEzSNeOYDe9RDAnqA=;
        b=uidf9B5B0WjnpD+TU+joSTCEu7rSQ3nenCQVnli9mVeJRBK+283k0sRC8+CKS5gHbG
         5XIkMLPtlpS3OEZ8xJekjEyTPziamG3PE/zoXLmx84wpmDDubdj41fiJH2+FYoi7lZz7
         ZWZOgM8DW66ipZxoPirOO3aAAYSWg8xxqB1X/lhD+oKy/i3Ctbvz2uae4KDbyTAy+o0p
         /hhaAVayEpkIZetTqoyRlbzO0Yc/oDNQFa81nuvnTARyRfp5ukuUZIXma402DQnKp/Dp
         9SXXFMsdlHGfAkqI24L3g1W+OfwOy5jkK9L/XGbEB4RbuUmIeIZiGNyULvEL8crRZ0uK
         G40A==
X-Gm-Message-State: AOAM5303uusQunqMP6Z5ypwoTH12EA5JMXTYn60O9p5ra3clC1wd/Jq2
        evnzqDIj9svcZDAQYrGSqqaGVV2W4/I=
X-Google-Smtp-Source: ABdhPJwcjMvWwvufDanli233viItQbtnVC+lc7c2oSyhEvGEQmCtvu5Kb17yJPP8nCCneLfzy2mtVaMFBV0=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:2742:338c:f077:6d85])
 (user=pgonda job=sendgmr) by 2002:a25:d694:: with SMTP id n142mr33012654ybg.349.1624293091163;
 Mon, 21 Jun 2021 09:31:31 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:31:16 -0700
In-Reply-To: <20210621163118.1040170-1-pgonda@google.com>
Message-Id: <20210621163118.1040170-2-pgonda@google.com>
Mime-Version: 1.0
References: <20210621163118.1040170-1-pgonda@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 1/3] KVM, SEV: Refactor out function for unregistering
 encrypted regions
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out helper function for freeing the encrypted region list.

Signed-off-by: Peter Gonda <pgonda@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
 arch/x86/kvm/svm/sev.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 46e339c84998..5af46ff6ec48 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1767,11 +1767,25 @@ int svm_vm_copy_asid_from(struct kvm *kvm, unsigned int source_fd)
 	return ret;
 }
 
+static void __unregister_region_list_locked(struct kvm *kvm,
+					    struct list_head *mem_regions)
+{
+	struct enc_region *pos, *q;
+
+	lockdep_assert_held(&kvm->lock);
+
+	if (list_empty(mem_regions))
+		return;
+
+	list_for_each_entry_safe(pos, q, mem_regions, list) {
+		__unregister_enc_region_locked(kvm, pos);
+		cond_resched();
+	}
+}
+
 void sev_vm_destroy(struct kvm *kvm)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
-	struct list_head *head = &sev->regions_list;
-	struct list_head *pos, *q;
 
 	if (!sev_guest(kvm))
 		return;
@@ -1795,13 +1809,7 @@ void sev_vm_destroy(struct kvm *kvm)
 	 * if userspace was terminated before unregistering the memory regions
 	 * then lets unpin all the registered memory.
 	 */
-	if (!list_empty(head)) {
-		list_for_each_safe(pos, q, head) {
-			__unregister_enc_region_locked(kvm,
-				list_entry(pos, struct enc_region, list));
-			cond_resched();
-		}
-	}
+	__unregister_region_list_locked(kvm, &sev->regions_list);
 
 	mutex_unlock(&kvm->lock);
 
-- 
2.32.0.288.g62a8d224e6-goog

