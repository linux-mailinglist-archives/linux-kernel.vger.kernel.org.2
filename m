Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC55A460DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 04:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377263AbhK2DuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 22:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377253AbhK2DsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 22:48:16 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46833C061784
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:43:58 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b68so15376846pfg.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Hs2KkuD2RvJU1MuHxuaC5QQB7g97DRylbbix/DEyMM=;
        b=k6uPJkAreyLqR/oL85kAD76M20sYasXKj1QbtK3CkHo3sgCCQCC4FWtVOblMCLxb/z
         bPi22S2w7YghmBm3Kka1/UIGGiA8AiUT2+RMrGmqVQlt4EUYiTQn1smbFmUJatk/XJub
         u6epHvK0KKlesLZEIUpl4jFhfksZXtlcfSic4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Hs2KkuD2RvJU1MuHxuaC5QQB7g97DRylbbix/DEyMM=;
        b=tccwx9x1cgeF5X9P0HrPa2h2oLjRpDcIiixCkvje8heaQ0zTU5nCCJNyigIA0pbaVQ
         Z52vo6+pKf4VZ8+3dDe3Ju9q0MrZcuOKFAbXKIDfxP1R4ErYPPdOItDN9HJ2QQObSzym
         AiYU/rAZSCNbJejxt7D8glE2fvt55uEG6v8esUuPaTOl7AZkVbwDJkv791vhfPFG7PQk
         OHpcRXZCR7n4nTiliwGattt/0Oh3ub0ambdMllAYs1TbeMCLfhv6825KqPxK/vqV8NHQ
         za+IeiK1ipDz4+tzuybQY8tyqkVOXCdtvSENUlkevDZkTD5/zo2imfEALKUfF7NHH2Kp
         rcNg==
X-Gm-Message-State: AOAM533LT0QJdBF58Ygrmv0ILB3F1SDZJy1AMxV9mDFtKe7Y1UqYrNDL
        JcQmhLrmoEFvFI2G5gD1YH2t/g==
X-Google-Smtp-Source: ABdhPJwtRlhKS2AxEOFgBKvN/CyDcHjbqYa75A4CX+1o9/zI6sOg74qnXMkTRUr57A+X+/j0+SotFg==
X-Received: by 2002:a63:c044:: with SMTP id z4mr33793003pgi.335.1638157437859;
        Sun, 28 Nov 2021 19:43:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:72d1:80f6:e1c9:ed0a])
        by smtp.gmail.com with UTF8SMTPSA id y8sm15439643pfi.56.2021.11.28.19.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 19:43:57 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v5 4/4] KVM: mmu: remove over-aggressive warnings
Date:   Mon, 29 Nov 2021 12:43:17 +0900
Message-Id: <20211129034317.2964790-5-stevensd@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211129034317.2964790-1-stevensd@google.com>
References: <20211129034317.2964790-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Remove two warnings that require ref counts for pages to be non-zero, as
mapped pfns from follow_pfn may not have an initialized ref count.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 arch/x86/kvm/mmu/mmu.c | 7 -------
 virt/kvm/kvm_main.c    | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0626395ff1d9..7c4c7fededf0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -621,13 +621,6 @@ static int mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
 
 	pfn = spte_to_pfn(old_spte);
 
-	/*
-	 * KVM does not hold the refcount of the page used by
-	 * kvm mmu, before reclaiming the page, we should
-	 * unmap it from mmu first.
-	 */
-	WARN_ON(!kvm_is_reserved_pfn(pfn) && !page_count(pfn_to_page(pfn)));
-
 	if (is_accessed_spte(old_spte))
 		kvm_set_pfn_accessed(pfn);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 16a8a71f20bf..d81edcb3e107 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -170,7 +170,7 @@ bool kvm_is_zone_device_pfn(kvm_pfn_t pfn)
 	 * the device has been pinned, e.g. by get_user_pages().  WARN if the
 	 * page_count() is zero to help detect bad usage of this helper.
 	 */
-	if (!pfn_valid(pfn) || WARN_ON_ONCE(!page_count(pfn_to_page(pfn))))
+	if (!pfn_valid(pfn) || !page_count(pfn_to_page(pfn)))
 		return false;
 
 	return is_zone_device_page(pfn_to_page(pfn));
-- 
2.34.0.rc2.393.gf8c9666880-goog

