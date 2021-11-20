Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED24457B6F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhKTEzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbhKTEyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:54:38 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185A6C0613F9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:03 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id r15-20020a63ec4f000000b002e582189837so5027297pgj.20
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=kRbBWHboZP166wiM9/QeB9lQ+gE9kRnPxnSqNsfgwok=;
        b=PaFW80wYiFDjQHdAjCLfmrfN14ZfxWumhDxGPUy1CIq4CB+K+vmmCN0v9pwe9CmRkk
         Mr8x1gI36HiXTdKDOZO9gpQq8sTuF5HaIVdwq87aF821wthnTJwvKCzVMZFzGcmKCLvw
         LqgytiuJ/wnzY2SJvQZ2QIKvBpHyvbJUGKRnCg5U1L+KZ/FwsjBPdgut5KwWGEy2aioG
         5Fz72Vqmm/fqc/ns+MGH+BWwJTC1oDlCn88kgnN5gVaSodOxA4LBleVeji22e1FgXtjs
         i119cpqtAXxBKZ8B3BSyAkFo6N3w573O0EUOtB6mTTzW0ODt2cA0Yk4wK/xSEINKHW/m
         rPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=kRbBWHboZP166wiM9/QeB9lQ+gE9kRnPxnSqNsfgwok=;
        b=zmZMmYNMHuSXBJSe16mM0iPbz2Mr4YOGUQWgpy5twsdtkVCByBVCGJXHrYhOcmjFwY
         arDpVAh5IYSFeImETqQ/DRc5t2bAFuaVx7JUZUVOHnhD0QLaos7Gzy7RBvFgwHop1I6I
         72k2joqAycbAKOc4BRf+Um1X0sRs1wlD+v/7lMquNqvuHSodF11Vj0YxZF+hsZs8tiDf
         8+VM6MmmOXeXfjAKA2404hBduNeImQaBOda0EztnBJhRU3IytjVvWoGD96Qv/cXKVlEQ
         keOtaCZhpaqVrlJ/HVgVGqaFv1jRcXcy4XZXVKBg7ECgWzzjhZT+vQtp+u5d1m1I7L8y
         F5+g==
X-Gm-Message-State: AOAM530KLV0EAwVDoWhLYzeNF8a2E5siy9cDqxAdV3vUQay4OfGYCysf
        DzBWchY767nx+L2skuELPSazjHRUiTk=
X-Google-Smtp-Source: ABdhPJx71YmvgsfQ/dG6SeLwEb0pLrv37b/SWXKbwOSeZ8ogkSRm2uXGsXL7Ih5xQRkauHVuOjsgO9U0Y2E=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:390c:: with SMTP id
 y12mr737512pjb.0.1637383862178; Fri, 19 Nov 2021 20:51:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 20 Nov 2021 04:50:23 +0000
In-Reply-To: <20211120045046.3940942-1-seanjc@google.com>
Message-Id: <20211120045046.3940942-6-seanjc@google.com>
Mime-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 05/28] KVM: x86/mmu: Check for present SPTE when clearing
 dirty bit in TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong93@linux.alibaba.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly check for preset SPTEs when clearing dirty bits in the TDP
MMU.  This isn't strictly required for correctness, as setting the dirty
bit in a defunct SPTE will not change the SPTE from !PRESENT to PRESENT.
However, the guarded MMU_WARN_ON() in spte_ad_need_write_protect() would
complain if anyone actually turned on KVM's MMU debugging.

Fixes: a6a0b05da9f3 ("kvm: x86/mmu: Support dirty logging for the TDP MMU")
Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 1db8496259ad..c575df121b19 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1246,6 +1246,9 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (tdp_mmu_iter_cond_resched(kvm, &iter, false, true))
 			continue;
 
+		if (!is_shadow_present_pte(iter.old_spte))
+			continue;
+
 		if (spte_ad_need_write_protect(iter.old_spte)) {
 			if (is_writable_pte(iter.old_spte))
 				new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
-- 
2.34.0.rc2.393.gf8c9666880-goog

