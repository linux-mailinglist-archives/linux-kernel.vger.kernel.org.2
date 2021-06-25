Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEBB3B46B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYPgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229950AbhFYPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624635263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjcyYxrINnzSou8d5xoDOd+Q0j+eHgX3Un7gw5UoKHs=;
        b=hVkyptULATs8P0sEl1mxjd7L+X9xEOJGkpo6HoaJrHCtEIWZ/n/epMyNolQmME6WceVvCz
        RxvVvKZ9o7/5BBtWSwVWhdHoN9mopQ7APHKe7wyHohmV9cBYyqGeQQubOkaIPGsX9+J3Yz
        1LSqA2sbH14dwPnY8srGeroOXqJWqCg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-nrDkN0ftM0yhvLif2f5HPg-1; Fri, 25 Jun 2021 11:34:22 -0400
X-MC-Unique: nrDkN0ftM0yhvLif2f5HPg-1
Received: by mail-il1-f199.google.com with SMTP id v10-20020a92c6ca0000b02901ee2cb4ded3so6392121ilm.14
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YjcyYxrINnzSou8d5xoDOd+Q0j+eHgX3Un7gw5UoKHs=;
        b=ogVmQ075T3/WWG8x6S+XFEc7NekRFTGmicP57zd1MePcQ3YaSwCqVUxkMNcviKUFAq
         7aeW0dOYnyxM9UTVPiOwtRsBJoI51yFi95p+WcdpnBakHiT6lTZe5FRj19qVqYPkAGdl
         cgUKHGRlV89ps1dWmbyVWKJwE4KC6rKdFLqOvv5Oz3jflgcYJXyaWUcVNqDYBhwbT5Uv
         8R79uHwaQU2xqz93L/57Ea3BI6jt/zpyS4szqQQOno8IK2dU/rRWzBqS4COCAc3cdbjd
         fEvZoxrE+87mFpvAj0YNKXJwi82eQbSWbBKAbYSFYC1QSCVwlyA+5YEMwDRuoSXWJmTQ
         zIiA==
X-Gm-Message-State: AOAM530xvXxdF2BEA8+JFkZtZEFIniv5X+D2zEhOuzA3kklfkSxqSCLK
        VG/ReMpD03dGNRbXMiqVWdPoN1zj9glWfAgxGWXd/hvItMx82MqKWovzqTjaK8ItJcWJTbRG3kW
        1UR1xIP93DGbq5z7sUBx1BJNlguThWRjEW18MiPOnwPB2uHI/LhapW9NhPCOFza4ldrxIXL4YPw
        ==
X-Received: by 2002:a6b:2b44:: with SMTP id r65mr8803109ior.99.1624635261386;
        Fri, 25 Jun 2021 08:34:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDrcMjN0grhcN1xdY2Kguub8DNog6SwRyubFGgLe1lkSEeK2CSuD5j9rsyWmXrReWuXadcJg==
X-Received: by 2002:a6b:2b44:: with SMTP id r65mr8803084ior.99.1624635261102;
        Fri, 25 Jun 2021 08:34:21 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id 67sm3126275iob.15.2021.06.25.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:34:20 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 9/9] KVM: X86: Optimize zapping rmap
Date:   Fri, 25 Jun 2021 11:34:19 -0400
Message-Id: <20210625153419.43671-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625153214.43106-1-peterx@redhat.com>
References: <20210625153214.43106-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using rmap_get_first() and rmap_remove() for zapping a huge rmap list could be
slow.  The easy way is to travers the rmap list, collecting the a/d bits and
free the slots along the way.

Provide a pte_list_destroy() and do exactly that.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 45 +++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ba0258bdebc4..45aac78dcabc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1014,6 +1014,38 @@ unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
 	return count;
 }
 
+/* Return true if rmap existed and callback called, false otherwise */
+static bool pte_list_destroy(struct kvm_rmap_head *rmap_head,
+			     int (*callback)(u64 *sptep))
+{
+	struct pte_list_desc *desc, *next;
+	int i;
+
+	if (!rmap_head->val)
+		return false;
+
+	if (!(rmap_head->val & 1)) {
+		if (callback)
+			callback((u64 *)rmap_head->val);
+		goto out;
+	}
+
+	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
+
+	while (desc) {
+		if (callback)
+			for (i = 0; i < desc->spte_count; i++)
+				callback(desc->sptes[i]);
+		next = desc->more;
+		mmu_free_pte_list_desc(desc);
+		desc = next;
+	}
+out:
+	/* rmap_head is meaningless now, remember to reset it */
+	rmap_head->val = 0;
+	return true;
+}
+
 static struct kvm_rmap_head *__gfn_to_rmap(gfn_t gfn, int level,
 					   struct kvm_memory_slot *slot)
 {
@@ -1403,18 +1435,7 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			  struct kvm_memory_slot *slot)
 {
-	u64 *sptep;
-	struct rmap_iterator iter;
-	bool flush = false;
-
-	while ((sptep = rmap_get_first(rmap_head, &iter))) {
-		rmap_printk("spte %p %llx.\n", sptep, *sptep);
-
-		pte_list_remove(rmap_head, sptep);
-		flush = true;
-	}
-
-	return flush;
+	return pte_list_destroy(rmap_head, mmu_spte_clear_track_bits);
 }
 
 static bool kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-- 
2.31.1

