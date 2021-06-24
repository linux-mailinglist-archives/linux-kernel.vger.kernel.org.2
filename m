Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32E3B356E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhFXSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232601AbhFXSQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624558446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ny4N/dv5g7DO3oaKKsT3k5Lo/RLroZYI+1qWA8iS2Y=;
        b=i4hQ4JNrDXb07Ey5sILHPCkpkCzZR3IFYcMcDJ/Fcfss7e3wcjhInZarDw4mfZuvbH5sc1
        NF2SWijnKUlmjf9KqMOGye7cjwDNnseM+c7dJhmiMRCOgiwkECXwc0k8nDDlADntilZs8U
        Lh9mSHThnwztZwRdy6adu5ES0rke++A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-sozsfDfMP06KUd8wYYFwmA-1; Thu, 24 Jun 2021 14:14:05 -0400
X-MC-Unique: sozsfDfMP06KUd8wYYFwmA-1
Received: by mail-qk1-f197.google.com with SMTP id i3-20020a05620a1503b02903b2ffa0a87fso6520711qkk.18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ny4N/dv5g7DO3oaKKsT3k5Lo/RLroZYI+1qWA8iS2Y=;
        b=ILFp2dhljAX43fhnWqPqpfhxH8VFTTKTa81WNofbGxRIU1Ftmg8FicRMoKNuncYnCJ
         gQZfsasMjJNJdNU5M/FAYudvDqMYf/dHKtq3vuYLBK6A/WmMEU+TySEQRavOxvzyeXvL
         Krv/qQcpcVFjHe6VQ4PJkTwjsj7sHPQkccdSJjPj7xU2ICCFoYXouu7O+DSfEvem5z2g
         gKCDSN4zLfE4p3cFMKiavk0eKbPUjrKHICrhCNF9xOH9ZIcmfnd8FJRJcZdrzZNYAFNe
         fBmrX6PujYO4wKa3xkYlvdQYi1HYovAj87o7bKmjAgtN6zBgJxT2vHCdq3x8r4VFK6O7
         KZsQ==
X-Gm-Message-State: AOAM533/StehXiZhcfhZYgNkbWfxpHQD5VYB8M+GXhW4/SIVinRgbGip
        vYFfYkYi0zH3QJczGFK3AxOyKUiw0Ke/pILFIoemDMdjt9A3slfdyc/Q9kepsGducCEhw7Y+Afw
        XdxGk2wjO5zZ9YulVc7rFx1f0
X-Received: by 2002:a37:f510:: with SMTP id l16mr7017488qkk.205.1624558444850;
        Thu, 24 Jun 2021 11:14:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5xeg8fkVzCvznQIXVQuhoVQJFpwIzM0cNNpma6+xzwHDzRQWv3casplWNqC4T8UNyOmhZfQ==
X-Received: by 2002:a37:f510:: with SMTP id l16mr7017476qkk.205.1624558444679;
        Thu, 24 Jun 2021 11:14:04 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b7sm2529301qti.21.2021.06.24.11.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:14:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, peterx@redhat.com,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 4/9] KVM: X86: Introduce pte_list_count() helper
Date:   Thu, 24 Jun 2021 14:13:51 -0400
Message-Id: <20210624181356.10235-5-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624181356.10235-1-peterx@redhat.com>
References: <20210624181356.10235-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is used to count the number of rmap entries in the rmap list
pointed by the kvm_rmap_head.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c          | 21 +++++++++++++++++++++
 arch/x86/kvm/mmu/mmu_internal.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6dd338738118..80263ecb1de3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -927,6 +927,27 @@ static void pte_list_remove(struct kvm_rmap_head *rmap_head, u64 *sptep)
 	__pte_list_remove(sptep, rmap_head);
 }
 
+unsigned int pte_list_count(struct kvm_rmap_head *rmap_head)
+{
+	struct pte_list_desc *desc;
+	unsigned int i, count = 0;
+
+	if (!rmap_head->val)
+		return 0;
+	else if (!(rmap_head->val & 1))
+		return 1;
+
+	desc = (struct pte_list_desc *)(rmap_head->val & ~1ul);
+
+	while (desc) {
+		for (i = 0; (i < PTE_LIST_EXT) && desc->sptes[i]; i++)
+			count++;
+		desc = desc->more;
+	}
+
+	return count;
+}
+
 static struct kvm_rmap_head *__gfn_to_rmap(gfn_t gfn, int level,
 					   struct kvm_memory_slot *slot)
 {
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index d64ccb417c60..3cd1a878ffeb 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -126,6 +126,7 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 				    struct kvm_memory_slot *slot, u64 gfn);
 void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 					u64 start_gfn, u64 pages);
+unsigned int pte_list_count(struct kvm_rmap_head *rmap_head);
 
 /*
  * Return values of handle_mmio_page_fault, mmu.page_fault, and fast_page_fault().
-- 
2.31.1

