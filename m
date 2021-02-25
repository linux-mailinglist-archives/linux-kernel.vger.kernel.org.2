Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C870F325851
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhBYVD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhBYUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:52:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EA8C061A32
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:49:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p136so7625229ybc.21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=wygaDEDOrN320QX+DWUCOdywurQj1DTKqvUyYvvMFVc=;
        b=XBC/vyeLmlxmeTcNjRlbqndRFXV+OZIx4QATdTRaHc1LavPxAbhNt3VVKMB9y3UVST
         1tpr+Hi90L0/JFgKAzP4XqkVHr8L3PP8fjUn7CUwzfeiS7KYy+QonEMof+4S0Rc8xPj+
         kP7bjvKDGpSZQXG/IUUY+IJzoqcvjUskD/Ye24nnzM9VHLhVVxQ91yd5E5AtcjTHzCdk
         nKNL5qO+xSHMZyLjXkhhNmc8IlsQ3hFFBYBZIll65QqzbADKcYbHTRnw92DgrqQ88DB6
         jO+kb/ADc4XSnonJlCOjR24kcqI/o9XmUcw0bp0z8ZHNHSjnb51y2qS17+zOkNn6RnCr
         z38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=wygaDEDOrN320QX+DWUCOdywurQj1DTKqvUyYvvMFVc=;
        b=Wn8eMVG9RJHWbaegE3NLie4F1nZT+4QcVfwp6hHXXADkJl7eFqjeqzSDaltN+uW/2X
         AeOksVN3w1n9/dm7+AC4DwmhHR883cqm/+8YwgSF8znfsWlnodgY/dljOQRnf68X8Qxz
         OIEWUVR6d7xOF0Cmtqzcf0Kq4/JkIf/bs4/wScXlXbJsbCMP0ysmWLU/i6N+OrD2+mib
         RuaJWcEu12d5jqi6Eu758cTHTLnMeOt56J4OtiEw6goqccnSFgw58Tz1K75Y1WLdsJ3L
         1H9tBDhiLaD7oB070f/PukvR1qTD/C8A8WRNGOy7VttooCKIhfn8HekAYekMRruKJuJV
         IH6g==
X-Gm-Message-State: AOAM531FEK8jBWtcPT18kLcvK9DsX+ffxZaRoDKVC7/4OMu/AKBN8+K2
        MerzDb54xWghyqeiKcPE1ZtYCodzi8Q=
X-Google-Smtp-Source: ABdhPJzLHrCi7n/k+RGSDGErQ6Z/2NGtl3jE/sgHMSbkuQMSHmfEfyHVaWh3au5M/Qq0b4enfZio+I+VsQE=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a25:9108:: with SMTP id v8mr6916513ybl.321.1614286140867;
 Thu, 25 Feb 2021 12:49:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 12:47:48 -0800
In-Reply-To: <20210225204749.1512652-1-seanjc@google.com>
Message-Id: <20210225204749.1512652-24-seanjc@google.com>
Mime-Version: 1.0
References: <20210225204749.1512652-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 23/24] KVM: x86/mmu: Use low available bits for removed SPTEs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use low "available" bits to tag REMOVED SPTEs.  Using a high bit is
moderately costly as it often causes the compiler to generate a 64-bit
immediate.  More importantly, this makes it very clear REMOVED_SPTE is
a value, not a flag.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 11 ++++++++++-
 arch/x86/kvm/mmu/spte.h | 11 +++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index e07aabb23b8a..66d43cec0c31 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -277,7 +277,16 @@ void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask)
 				  SHADOW_NONPRESENT_OR_RSVD_MASK_LEN)))
 		mmio_value = 0;
 
-	WARN_ON((mmio_value & mmio_mask) != mmio_value);
+	/*
+	 * The masked MMIO value must obviously match itself and a removed SPTE
+	 * must not get a false positive.  Removed SPTEs and MMIO SPTEs should
+	 * never collide as MMIO must set some RWX bits, and removed SPTEs must
+	 * not set any RWX bits.
+	 */
+	if (WARN_ON((mmio_value & mmio_mask) != mmio_value) ||
+	    WARN_ON(mmio_value && (REMOVED_SPTE & mmio_mask) == mmio_value))
+		mmio_value = 0;
+
 	shadow_mmio_value = mmio_value;
 	shadow_mmio_mask  = mmio_mask;
 	shadow_mmio_access_mask = access_mask;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 2fad4ccd3679..b53036d9ddf3 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -174,13 +174,16 @@ extern u64 __read_mostly shadow_nonpresent_or_rsvd_mask;
  * non-present intermediate value. Other threads which encounter this value
  * should not modify the SPTE.
  *
- * This constant works because it is considered non-present on both AMD and
- * Intel CPUs and does not create a L1TF vulnerability because the pfn section
- * is zeroed out.
+ * Use a semi-arbitrary value that doesn't set RWX bits, i.e. is not-present on
+ * bot AMD and Intel CPUs, and doesn't set PFN bits, i.e. doesn't create a L1TF
+ * vulnerability.  Use only low bits to avoid 64-bit immediates.
  *
  * Only used by the TDP MMU.
  */
-#define REMOVED_SPTE (1ull << 59)
+#define REMOVED_SPTE	0x5a0ULL
+
+/* Removed SPTEs must not be misconstrued as shadow present PTEs. */
+static_assert(!(REMOVED_SPTE & SPTE_MMU_PRESENT_MASK));
 
 static inline bool is_removed_spte(u64 spte)
 {
-- 
2.30.1.766.gb4fecdf3b7-goog

