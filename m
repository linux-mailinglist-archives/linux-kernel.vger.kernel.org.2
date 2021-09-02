Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06643FF2F3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346886AbhIBSBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346845AbhIBSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:00:56 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF64C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:59:57 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id x19-20020a05620a099300b003f64d79cbbaso3151228qkx.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=bqDRLFptc44UKBzn+MUQ2EpaypVcZR2bwNWDPt0I16Q=;
        b=kaEccFS9pjl5QRSHoXDXY1chRXLliJunMfC8ysTZtjZQYrWwStlsNOwUkheC3Jp2hm
         CH3UfafyXH/qDnlYL8IVC+JpuEPO2i5AB5jNCQXcJeB8urA9jHxln9EqObsE4rXz93ax
         IWV1OnG4NREJl1tquHShvCB8n8NrBPZSUG0Q6yGPZV5/Q9TAKLyLmyeHowK88cHf7OWs
         M78P15F5prqVDgsit3mnGhiMhnAikVIgVaiMTJ6/rEGDNLt30vQwONVsgRvvteVrE6KE
         pi8TeZhhu510npjkeAa+JvKTH+D4hcutyaarAM1HLg87mkinZwPg5T2Nyqzy0PDtEDkt
         yAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=bqDRLFptc44UKBzn+MUQ2EpaypVcZR2bwNWDPt0I16Q=;
        b=YOGKPSDIycjXa0s8z2zJEFn/8zmnYURQrGL7PBPjK1Gn2hlu7oA2v90c6euVPgziLI
         Tv9xFbmebgQIIBwulwj0fo/lFHdgP3m4OlgF7nGZw45+Z9PgB9flNXAXsuLxZQA88HE6
         LRqte+shG4EA9bmNRrZNwtZF1oTuBGh/+mo0/89gO6WK+IufzdJKLqqMgBNCFzQPEE79
         raastw5QOA5+DkSL/O8KmG4ZAp3o/n8TC0cEBkR1hYUAE9RzosD+I/qsY3mwXFqZYlXn
         pfP31y3Ebj/lHprQtUtqh6QdRWXOXLoWmaaS+bMhrF9BdgmixgjB6BCN/Ruy5QlvULrO
         UrKw==
X-Gm-Message-State: AOAM530juAyqRXKldLBp/+PR5idCc6l4KJzYDpUFV3hYwBr+fhrkQZV3
        JB6G0DZV01NLXSy7k3A6nRDPXdc3o3Q=
X-Google-Smtp-Source: ABdhPJy6UYCXSDa2mdpOqNlJ+avFm6Ebh49VwTf2qXLaAbHbfRK3+ddkKi3GmcUaXF9ydYJ9K88Lkbp+5+8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:1c7d:d8a5:f41a:8b31])
 (user=seanjc job=sendgmr) by 2002:a05:6214:592:: with SMTP id
 bx18mr4250805qvb.26.1630605597084; Thu, 02 Sep 2021 10:59:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  2 Sep 2021 10:59:51 -0700
Message-Id: <20210902175951.1387989-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH] KVM: Remove unnecessary export of kvm_{inc,dec}_notifier_count()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't export KVM's MMU notifier count helpers, under no circumstance
should any downstream module, including x86's vendor code, have a
legitimate reason to piggyback KVM's MMU notifier logic.  E.g in the x86
case, only KVM's MMU should be elevating the notifier count, and that
code is always built into the core kvm.ko module.

Fixes: edb298c663fc ("KVM: x86/mmu: bump mmu notifier count in kvm_zap_gfn_range")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3e67c93ca403..140c7d311021 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -638,7 +638,6 @@ void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
 			max(kvm->mmu_notifier_range_end, end);
 	}
 }
-EXPORT_SYMBOL_GPL(kvm_inc_notifier_count);
 
 static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
@@ -690,8 +689,6 @@ void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
 	 */
 	kvm->mmu_notifier_count--;
 }
-EXPORT_SYMBOL_GPL(kvm_dec_notifier_count);
-
 
 static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
-- 
2.33.0.153.gba50c8fa24-goog

