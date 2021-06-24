Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AF83B3568
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhFXSQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232460AbhFXSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624558441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qCTE+G8btEQabyXMZ8pmtQF1JICGOfEU2RElhMZ1+8k=;
        b=byQMSY/5+53TFNjPX0TeGcQznEiCXwJ2htzICIBoazPanCXfeYPxrWoHsz/s3K1g8QcK7k
        dCLwE22yqIkZ4lVWRAefPyduoeb7373sYWeA8rAQcrrqu8MpMTvMK3jwVevBLOibi/RwPi
        HWhOAbi5IcBIQAutZ2sbsHKeUSgq0KQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-l-TlRRfcNYGMNA0OwFEmlw-1; Thu, 24 Jun 2021 14:14:00 -0400
X-MC-Unique: l-TlRRfcNYGMNA0OwFEmlw-1
Received: by mail-qv1-f69.google.com with SMTP id eb2-20020ad44e420000b029025a58adfc6bso7909290qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCTE+G8btEQabyXMZ8pmtQF1JICGOfEU2RElhMZ1+8k=;
        b=EB3ikRVbenXapPsbErPVJb+MV/G/lBT7gjFndjT3An+MXHqSdyYydEpZ0X/bGSbESV
         1CxjLQYZH7HGxrkY1Td7VPOiXumfclTUbKOoT2PQdCL9IXB9FEW3bKt1Mfq6UUl9bE4t
         cis9aEIQTBlIY2847BbKugCl63QtJq7lO/kl07g9f/MiiOxYUWBfltixu1/YJap6apaf
         zCuNHKaOZRP2IPPTdpo4eXM5Xf5+X7D9L2pQ6dPVbY1dHTCxIzLUPG5UYiIKFbYxFWFM
         gcdeG77iT3bnkSJpTbxdoBEjOz1MgNYU9Wc7JKHZdxDUgR7LnThvH+4eOnK+MeAp0soE
         mJOQ==
X-Gm-Message-State: AOAM531NPADOxtYS2MdmnWbEvBOTw2zneq22Iw6M9m9dZlLJ+QiF5GDZ
        eRxeHEUYNKAbgToItfBn57BSz4gcUjKf07T71K8AF7ExYYI2N2ReEJ7QdIuAhBhnxqYNF45jHvy
        7H+Lur8ahYNlWtCSk4g+MJHFF
X-Received: by 2002:a05:620a:484:: with SMTP id 4mr6994627qkr.437.1624558439999;
        Thu, 24 Jun 2021 11:13:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0LKAndulLpSV+fntL9ldHDDtswfF5CXYy8ioMeUBK1qfG/kGRqlgzLDVV9hZuBaru2K3QPw==
X-Received: by 2002:a05:620a:484:: with SMTP id 4mr6994614qkr.437.1624558439818;
        Thu, 24 Jun 2021 11:13:59 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b7sm2529301qti.21.2021.06.24.11.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:13:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, peterx@redhat.com,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/9] KVM: X86: Add per-vm stat for max rmap list size
Date:   Thu, 24 Jun 2021 14:13:48 -0400
Message-Id: <20210624181356.10235-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624181356.10235-1-peterx@redhat.com>
References: <20210624181356.10235-1-peterx@redhat.com>
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
index 55efbacfc244..937bc8021f7a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1138,6 +1138,7 @@ struct kvm_vm_stat {
 	ulong lpages;
 	ulong nx_lpage_splits;
 	ulong max_mmu_page_hash_collisions;
+	ulong max_mmu_rmap_size;
 };
 
 struct kvm_vcpu_stat {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5e60b00e8e50..6dd338738118 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2602,6 +2602,8 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	if (is_shadow_present_pte(*sptep)) {
 		if (!was_rmapped) {
 			rmap_count = rmap_add(vcpu, sptep, gfn);
+			if (rmap_count > vcpu->kvm->stat.max_mmu_rmap_size)
+				vcpu->kvm->stat.max_mmu_rmap_size = rmap_count;
 			if (rmap_count > RMAP_RECYCLE_THRESHOLD)
 				rmap_recycle(vcpu, sptep, gfn);
 		}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bbc4e04e67ad..4aa3cc6ae5d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -257,6 +257,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VM_STAT("largepages", lpages, .mode = 0444),
 	VM_STAT("nx_largepages_splitted", nx_lpage_splits, .mode = 0444),
 	VM_STAT("max_mmu_page_hash_collisions", max_mmu_page_hash_collisions),
+	VM_STAT("max_mmu_rmap_size", max_mmu_rmap_size),
 	{ NULL }
 };
 
-- 
2.31.1

