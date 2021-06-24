Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB23B356F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhFXSQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232625AbhFXSQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624558448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhjhdzRJGuZzb8Uq4F9J7OQePoxIE2i+1r2VEiCpXU8=;
        b=DYT1DXMznO/hHwYtbY5UN5sa+Qoc/SstcTqB5NiPHqCWDxnGq2Zi1ouV/xJZqBvDwEBiol
        Wth08y5mtwpSESirbhfOqmcyemrjzUCsdlXT/4sR5JshdxsE/sDQ6BGEnj4hxw57W+VGjJ
        JxBPJocbNWuCl4+4zY5zoS07PYFFv9c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-QZgubjarNqGnmOamRZTaTg-1; Thu, 24 Jun 2021 14:14:07 -0400
X-MC-Unique: QZgubjarNqGnmOamRZTaTg-1
Received: by mail-qv1-f71.google.com with SMTP id cu3-20020a05621417c3b0290272a51302bdso7876558qvb.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 11:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhjhdzRJGuZzb8Uq4F9J7OQePoxIE2i+1r2VEiCpXU8=;
        b=Z6/LwtYRIUi9U7b551SymH71jZZny1qZlttoJQ7/zYkoYs2zfu7MqTeILhw9dnsULh
         Poo9ogab4HEtEuwhKb9q4EwUeG8FdINQ3kFg/r7xdTfpoXSBJzrjwXchDKHWDvJUwwJd
         eZEjQLDqviHc1bMIzXaNSRNPsYAkhNWFYhNNeEspt7eIUG7c1H3yZcDKTc1JBrjUL2Gu
         FXJHSo4bBi/Hk6R5sUWwPzUryn+DhCVBN/nkeeP5OHJI2q58VYRlalIOyP13L9DPxnZR
         T6O2qYQ/rVjbobIjGovytuH8B6pjiUYRYw7/poXmdOkrYQrerX+jGjKUfzvnnrSim9Gh
         oS7w==
X-Gm-Message-State: AOAM530fvuoDvX+sTKGza8FlFTm72yQ9042XBZaTDNdDYjY+XuQn7etN
        GoUyJ9Bq9xoVdgeIsA0Efj4Ar+PQ9+VLf3/z0AyQvowLN4vtZmE7f/OPL5S+qT9Cv29u4l/+TZ+
        q+vR/viC6KWob8vWwepz7lVrs
X-Received: by 2002:a37:b947:: with SMTP id j68mr7058561qkf.486.1624558446673;
        Thu, 24 Jun 2021 11:14:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyi77u9hQpo3cu5comp042O3ws2nw3qgLSs4sLThHjFTBtBf8S3k7Or4hGpuETo3oZS4Dx5w==
X-Received: by 2002:a37:b947:: with SMTP id j68mr7058543qkf.486.1624558446472;
        Thu, 24 Jun 2021 11:14:06 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id b7sm2529301qti.21.2021.06.24.11.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:14:05 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, peterx@redhat.com,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5/9] KVM: X86: Introduce kvm_mmu_slot_lpages() helpers
Date:   Thu, 24 Jun 2021 14:13:52 -0400
Message-Id: <20210624181356.10235-6-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210624181356.10235-1-peterx@redhat.com>
References: <20210624181356.10235-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce kvm_mmu_slot_lpages() to calculcate lpage_info and rmap array size.
The other __kvm_mmu_slot_lpages() can take an extra parameter of npages rather
than fetching from the memslot pointer.  Start to use the latter one in
kvm_alloc_memslot_metadata().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/x86.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4aa3cc6ae5d4..d2acbea2f3b5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -269,6 +269,20 @@ static struct kmem_cache *x86_fpu_cache;
 
 static struct kmem_cache *x86_emulator_cache;
 
+static inline unsigned long
+__kvm_mmu_slot_lpages(struct kvm_memory_slot *slot, unsigned long npages,
+		      int level)
+{
+	return gfn_to_index(slot->base_gfn + npages - 1,
+			    slot->base_gfn, level) + 1;
+}
+
+static inline unsigned long
+kvm_mmu_slot_lpages(struct kvm_memory_slot *slot, int level)
+{
+	return __kvm_mmu_slot_lpages(slot, slot->npages, level);
+}
+
 /*
  * When called, it means the previous get/set msr reached an invalid msr.
  * Return true if we want to ignore/silent this failed msr access.
@@ -10933,8 +10947,7 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 		int lpages;
 		int level = i + 1;
 
-		lpages = gfn_to_index(slot->base_gfn + npages - 1,
-				      slot->base_gfn, level) + 1;
+		lpages = __kvm_mmu_slot_lpages(slot, npages, level);
 
 		slot->arch.rmap[i] =
 			kvcalloc(lpages, sizeof(*slot->arch.rmap[i]),
-- 
2.31.1

