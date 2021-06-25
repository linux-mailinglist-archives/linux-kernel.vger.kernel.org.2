Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273C23B46A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFYPer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhFYPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624635140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=INi7/NQmQ1q6t1hySvPoVbZhD1CFSoMp7ejAC0hIDQg=;
        b=OUGK4cXxdX+eavEabksLCKN1z8QRL9QoiHCu+8/hTHV1NiiDrfUa31k49ZF3WTsaEFLCgj
        tK3YivKrFjmTg70VHlAExTTl+T236cbNa+2HJFnRLRO7QlUSoyaNa9kww970Pj1k+frPpG
        SaeiPbyaWoK7LHD2D2OCmwq3pjt8o7c=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-_ObaF1VBPnaj103FmUGGOQ-1; Fri, 25 Jun 2021 11:32:19 -0400
X-MC-Unique: _ObaF1VBPnaj103FmUGGOQ-1
Received: by mail-io1-f71.google.com with SMTP id n41-20020a0566023429b02904f14fe3958cso1354778ioz.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=INi7/NQmQ1q6t1hySvPoVbZhD1CFSoMp7ejAC0hIDQg=;
        b=f2MYglhzHpPOg/axhiwjdqE0aWYfp24MpJs0uu5HWJgdSfb8kSKf9OGRBy34xOPoLO
         n6e4thXa8MpCr2QopL2WVuDRBO6W+a9/+YfjO0Osr1FCmu365KxellJnFZUmwCYMH1uU
         ZUh1nDOryzxL/ir2TKhlvQXyjHVUfUC7TbvFr4X1QgMNDJZAebDfASmkXpJ77YeD5HSl
         CTHPoa6TtDNBYDZDKP0/jZeeSqQUIRBAKj1/iSffrCzV9ZiLM3PgLDxkWo3fZCzCCMgw
         5pCSHD6Xf2kFd4q1tGJ+/OkY7jY0GhIpz+QzZSJRgXmVmKZRn8UuL4dyny6AEsZj2d3m
         4DWA==
X-Gm-Message-State: AOAM533KN2mcD74g0u6DTvzBsQys1LhCCKfYUZNgb3O79RepjClFFEwY
        JDoQDirJI8qTeI7o2GpIBJWn5KU184g/z+4ASvhrFQbn/WWOVGgOTPKswIxxfOelScjYDFl5khE
        FFL7Twx4dBm9n+6sU5Ypg1Ojzh4SeomAbDqRgAsaS54VkXKcRrD4ByyW5cJMfVt/lHfjcQ/DiMQ
        ==
X-Received: by 2002:a05:6638:3fa:: with SMTP id s26mr10138684jaq.16.1624635138345;
        Fri, 25 Jun 2021 08:32:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGLqINrVZS5FKrdcEe4KyJJCkXQZcmXAZYbOxtJXj3K1ST9f/AyKv8aClT53i5y2FrxTEjdA==
X-Received: by 2002:a05:6638:3fa:: with SMTP id s26mr10138658jaq.16.1624635138108;
        Fri, 25 Jun 2021 08:32:18 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id s8sm3668772ilj.51.2021.06.25.08.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:32:17 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, peterx@redhat.com,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 1/9] KVM: X86: Add per-vm stat for max rmap list size
Date:   Fri, 25 Jun 2021 11:32:06 -0400
Message-Id: <20210625153214.43106-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625153214.43106-1-peterx@redhat.com>
References: <20210625153214.43106-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new statistic max_mmu_rmap_size, which stores the maximum size of rmap
for the vm.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu/mmu.c          | 2 ++
 arch/x86/kvm/x86.c              | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 974cbfb1eefe..d798650ad793 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1209,6 +1209,7 @@ struct kvm_vm_stat {
 	u64 lpages;
 	u64 nx_lpage_splits;
 	u64 max_mmu_page_hash_collisions;
+	u64 max_mmu_rmap_size;
 };
 
 struct kvm_vcpu_stat {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b888385d1933..eb16c1dbbb32 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2696,6 +2696,8 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	if (is_shadow_present_pte(*sptep)) {
 		if (!was_rmapped) {
 			rmap_count = rmap_add(vcpu, sptep, gfn);
+			if (rmap_count > vcpu->kvm->stat.max_mmu_rmap_size)
+				vcpu->kvm->stat.max_mmu_rmap_size = rmap_count;
 			if (rmap_count > RMAP_RECYCLE_THRESHOLD)
 				rmap_recycle(vcpu, sptep, gfn);
 		}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8166ad113fb2..d83ccf35ce99 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -237,6 +237,7 @@ const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
 	STATS_DESC_ICOUNTER(VM, mmu_unsync),
 	STATS_DESC_ICOUNTER(VM, lpages),
 	STATS_DESC_ICOUNTER(VM, nx_lpage_splits),
+	STATS_DESC_PCOUNTER(VM, max_mmu_rmap_size),
 	STATS_DESC_PCOUNTER(VM, max_mmu_page_hash_collisions)
 };
 static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
-- 
2.31.1

