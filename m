Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F03F6D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 04:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbhHYCvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 22:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbhHYCvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 22:51:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC1DC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:51:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j187so20028457pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 19:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKfFXl/BbyfwmX4rHQZ3Hn9r2Vj8gM4pm+E9o5QNLKs=;
        b=oaGWPYaI37IRjoaH+TWQNDm536ZSBnteIXFbFsJIRWONl2RyxSjvpCkJJrafPE3qwl
         pl0f54VAY8Mz5RYN+8THqTSTxc21EI+8plqLain6+3Q9Gou8B6mXg0c3sjVuLkmW7d8T
         ZU62l23yObbhBMHnhzBMg2wEecMY0BP6dWXHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKfFXl/BbyfwmX4rHQZ3Hn9r2Vj8gM4pm+E9o5QNLKs=;
        b=bKjppvTtvGqP/YNBo/GQ36IGxo0ZNX7DE/Sv5aTpATsj6IjphSIxZ+zNlX28S/8BvG
         mTtv6e2RNULgpnXwtITMa3KddYNIoYPhQ61aznxL3FwLkQGMwsOP+Ttv2OEeTct0JbrJ
         COuwlLRRNvaZRlSOssolWJ6j1NnSObbRdgi9M9HvxBqpRi7ORhnX6lYccLXraMbQgb6k
         c5GPNq8tl813dhADa8Dst3t20k5zsiUF38VtZd8AWk3Ng5W0aC80yTz8OgQId96+kuVB
         L+B/QC0nGsjvBdkLbby0HaCNKUt8pW9fM6yn+4hAWckTmyxEulq9Rnh2CgvF73Fx7++O
         DTRA==
X-Gm-Message-State: AOAM5332sc82ZuoSUEG7xR9kd/bfPPO9B73Dead0cQfG29laXvnfpSYQ
        9gQoYrolehShbKWRGH2E1+dl+Q==
X-Google-Smtp-Source: ABdhPJwBwxXyy2P4z2kutpUEa/D8L7EFlg94RCzvp0UEeNsPtaucsoMQia1pwsRo6utZst0JN8IfvA==
X-Received: by 2002:a62:e914:0:b029:3dd:a1d0:be57 with SMTP id j20-20020a62e9140000b02903dda1d0be57mr42699866pfh.11.1629859863420;
        Tue, 24 Aug 2021 19:51:03 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d273:c78c:fce8:a0e2])
        by smtp.gmail.com with UTF8SMTPSA id nl9sm3856717pjb.33.2021.08.24.19.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:51:03 -0700 (PDT)
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
Subject: [PATCH v3 4/4] KVM: mmu: remove over-aggressive warnings
Date:   Wed, 25 Aug 2021 11:50:09 +0900
Message-Id: <20210825025009.2081060-5-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
In-Reply-To: <20210825025009.2081060-1-stevensd@google.com>
References: <20210825025009.2081060-1-stevensd@google.com>
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
index d2b99c2f7dfa..88ceded7f022 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -623,13 +623,6 @@ static int mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
 
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
index 5c47ea93df23..e5ddf238ec64 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -168,7 +168,7 @@ bool kvm_is_zone_device_pfn(kvm_pfn_t pfn)
 	 * the device has been pinned, e.g. by get_user_pages().  WARN if the
 	 * page_count() is zero to help detect bad usage of this helper.
 	 */
-	if (!pfn_valid(pfn) || WARN_ON_ONCE(!page_count(pfn_to_page(pfn))))
+	if (!pfn_valid(pfn) || !page_count(pfn_to_page(pfn)))
 		return false;
 
 	return is_zone_device_page(pfn_to_page(pfn));
-- 
2.33.0.rc2.250.ged5fa647cd-goog

