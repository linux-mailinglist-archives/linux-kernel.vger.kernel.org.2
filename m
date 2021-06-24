Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0083B357A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhFXSRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232517AbhFXSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624558527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6oYmAaxF1m0ypshAXrxOXpFe7grcqzSbU76jZq5pQc4=;
        b=PNcu9gTMi97F66d0LiYo67JVbAUYFKlr/MIK6OYUE6fBl7krxNXcQtVkXON77CAW9eE/Mj
        Ax2N1i+xtBjgYar7XWzG8Lc/l97jOx3UXCNDkXErePCiT25zO+4PIqmB8k7ACHepChQJ06
        mMy50XhwfR0mHYEBsU5BNFxjVosLqHE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233--VMB3eZAMWCtBkHryGmQQA-1; Thu, 24 Jun 2021 14:15:25 -0400
X-MC-Unique: -VMB3eZAMWCtBkHryGmQQA-1
Received: by mail-io1-f71.google.com with SMTP id a24-20020a5d95580000b029044cbcdddd23so5090073ios.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oYmAaxF1m0ypshAXrxOXpFe7grcqzSbU76jZq5pQc4=;
        b=U8v0Bj6ctFwlIAvLrYB+QCV3z+akhm2ZVSQuQfL66HWExM2ywyJlhMudv79IOVQcxP
         KaJUfxOXIrgX/cAdmlaKWlx96rBQai8WPd+a9MvOChS6aT8f2V72jgENp0PHo266eGHT
         7EWUY9JHDAIvfUaFL+TfiWLqGPhDii7fWTigeH1ndqQkT1Z+ggUZJJZy5mwNsgupbSSR
         PQJLjbdkc1XoN2ujfD9Kv3Z+AsHktCQQYa0AN7pjVUj2YCwBJz26yUgEHo8ucArAOPu0
         LO3G1V/kLyGQP9KziTj2FFI0Qa5nmwF0uXzQp8BqipArdGi70Jgku+8LZ6EP3ho4BAW1
         In9w==
X-Gm-Message-State: AOAM5313AybltkFPWE7jcdbJs+GZatrgtKOO/HbY4d8dEHc90EXRqR0B
        RjW2x4zq30JWrSHvsBwGK96pLCCh0GSjqePgL+ba2/6SduA7bBnHzZqGUTO2UKjutiYWyUrBM82
        r2D4TT6U37OHCGT6etXe8K56i
X-Received: by 2002:a92:2004:: with SMTP id j4mr4627820ile.53.1624558525339;
        Thu, 24 Jun 2021 11:15:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJaP8C3FxzWVbVxDDMkYVrrRulTZoc5GrgopLwqVo4msNj6pOvE/OkExDtHEmU59FudWjoFg==
X-Received: by 2002:a92:2004:: with SMTP id j4mr4627786ile.53.1624558524837;
        Thu, 24 Jun 2021 11:15:24 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id m19sm2170100ilj.52.2021.06.24.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:15:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 9/9] KVM: X86: Optimize zapping rmap
Date:   Thu, 24 Jun 2021 14:15:23 -0400
Message-Id: <20210624181523.11065-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624181356.10235-1-peterx@redhat.com>
References: <20210624181356.10235-1-peterx@redhat.com>
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
index b21e52dfc27b..719fb6fd0aa0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -954,6 +954,38 @@ unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
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
@@ -1310,18 +1342,7 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
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

