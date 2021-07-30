Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462683DC0C9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhG3WGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232564AbhG3WGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627682768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4BBOvgzxNUCJGeElx/7CJIgRVcb9Llih1duOoDbR4M=;
        b=EpYZVlmqqNcXKXJNz2llflEf1iG8xXx19BsL4CDcGPFU1SuC/Mk/vFzxAjjZmvNzzO5D5A
        K6s7YSc97hjlUQHP6j0sJGpIDa0wCrekME7o0ojcSwDIkYHUEYmpz33a7PxD28uestydSu
        HTNg/QyMjpYtUhBAmhdIvWYGShidfOc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-LNfuX7e3PdaAmx13p2mnWQ-1; Fri, 30 Jul 2021 18:06:07 -0400
X-MC-Unique: LNfuX7e3PdaAmx13p2mnWQ-1
Received: by mail-qk1-f199.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so6538430qki.15
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4BBOvgzxNUCJGeElx/7CJIgRVcb9Llih1duOoDbR4M=;
        b=pp9+B3ZuwGQJSUlKUyT0maLwjAeoY22K6syJD2mouAUy2yvE38fuKwe1AYgUM8b0hZ
         j9rnGrEUa3f8YO+9mlim9kwHjXonUzgxIb7wSl3spGagZVfLI5WJArvkKczQGntvNSyl
         QmktyUwG9MqNamtohQphAp0eh6B/83o60uf6htJz0ZvpwdpO77K3WFgJy0mq8ZDPgTvx
         VrDh3t+Hl/5Tg05tpfYp+JFFMratZLP0hKey+YQvpm4OG9ZZxnLKYS0d1G8YL9XIIRTs
         ncLejSqTGoHE5fF8FQG6930Th0mN2uN6RAwBauXGcRgddwWwgG2zT1+L0letC9c2dLbH
         v0UA==
X-Gm-Message-State: AOAM5310X1ed8I0kw2UeloguuKWmXpjiZIp7usRKP75c6AQGnIXTlrLh
        QH466PcN5wfS/yQoSAvSphrJPz2Eppr5rAUs4ixDzENaOI8YqQ1ZBC/oFDE66X3AN8mDCc0fn6q
        eZB8x8bE+mvznFdLo3+aAa/sY9cLEkKRLlDK/VL0S5O7ZwhYl6iNDD0VekU43ptGy5O1GpKK9Uw
        ==
X-Received: by 2002:a0c:df09:: with SMTP id g9mr5152077qvl.30.1627682766772;
        Fri, 30 Jul 2021 15:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8B8Fu0lZQSprSiVyqxCrIMRlql3zmCcV7iN3gkLx6KiU458PV2fSBpow9iSveEnl956h6FQ==
X-Received: by 2002:a0c:df09:: with SMTP id g9mr5152051qvl.30.1627682766549;
        Fri, 30 Jul 2021 15:06:06 -0700 (PDT)
Received: from t490s.. (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id d16sm1154974qtj.69.2021.07.30.15.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 15:06:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 7/7] KVM: X86: Optimize zapping rmap
Date:   Fri, 30 Jul 2021 18:06:05 -0400
Message-Id: <20210730220605.26377-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210730220455.26054-1-peterx@redhat.com>
References: <20210730220455.26054-1-peterx@redhat.com>
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
 arch/x86/kvm/mmu/mmu.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 111c37141dbe..9b2616760e23 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1027,6 +1027,34 @@ unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
 	return count;
 }
 
+/* Return true if rmap existed, false otherwise */
+static bool pte_list_destroy(struct kvm_rmap_head *rmap_head)
+{
+	struct pte_list_desc *desc, *next;
+	int i;
+
+	if (!rmap_head->val)
+		return false;
+
+	if (!(rmap_head->val & 1)) {
+		mmu_spte_clear_track_bits((u64 *)rmap_head->val);
+		goto out;
+	}
+
+	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
+
+	for (; desc; desc = next) {
+		for (i = 0; i < desc->spte_count; i++)
+			mmu_spte_clear_track_bits(desc->sptes[i]);
+		next = desc->more;
+		mmu_free_pte_list_desc(desc);
+	}
+out:
+	/* rmap_head is meaningless now, remember to reset it */
+	rmap_head->val = 0;
+	return true;
+}
+
 static struct kvm_rmap_head *__gfn_to_rmap(gfn_t gfn, int level,
 					   const struct kvm_memory_slot *slot)
 {
@@ -1418,18 +1446,7 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			  const struct kvm_memory_slot *slot)
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
+	return pte_list_destroy(rmap_head);
 }
 
 static bool kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-- 
2.31.1

