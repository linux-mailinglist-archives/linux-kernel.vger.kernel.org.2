Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D863A457A7E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 02:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhKTBxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 20:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhKTBxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 20:53:18 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638E4C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 17:50:11 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 4-20020a170902c20400b0014381f710d5so5514371pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 17:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=/oTaTNiB/LMk2r2BJ6BITqZh/xo7HcDPFHBzIC0aTcA=;
        b=Y17iUQxETsjV0XAmZHTD+ZjD5tMQk/NOpkpraqf9BW2+v5JR2eBy3f1p4yCP1mV3uC
         PUm9MEBvTS93oMslh7RgrsjIn7MwY6k54gJbA1d9WbMvca4OO99KHtuRdpvxgnR+uFI8
         LbTg7u6ztPgJXa9z5xh0G849CN6AM529jrtRS41dtzaJTlu8O0VHwLxmLIcdHfTH1nzT
         oEv7OW24KEsMMt+gNB/z1zgrC8XGFXUhCRr2vRbVD3sdbBDeSfePKELcnp6wMPAU86Cf
         f8n5fBHLETiqOcQskna/SG3gZC+RBCd39PIXox+DkR1QIc46GJKsFIYBprHQib5cj5Zr
         bLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=/oTaTNiB/LMk2r2BJ6BITqZh/xo7HcDPFHBzIC0aTcA=;
        b=TXSUVTGkcOmgU8txwAinzcLR2nWKYT+N3QM6cLrje1Lz/3Z5cos2qHQEtKNEYxrtUw
         jujCNvDLW4jIa87ClKzI5VbdRz/tI0p970toZhPQhuz2VWiRJqmFr8RQNBbQ9+TrjJRp
         E/XaKDPh1P/lK7wpGpkdUzcbuZFEIxvSiSQxO0xHkPeQm5fj0PHVDjmvxuODcVA6wVCp
         x0azPSnuk4PnWDtMARxnJxLXqh6gdZmi9SDhB5d5Xbo3KOBeV8t+s9wtoKVmoovyZLO4
         ghmMgqL3oWV/7olvJA93yGgtNoO4pnHeLpX3DADcxi/1stUFfLHW6IGTPwhzfMWWZg8e
         AAtA==
X-Gm-Message-State: AOAM532s+l/zCiBjBn2A3rFE6izKzQ8cZUEnQOrsswVSXVITKVH7xt7h
        M/XvHNcVVPoHAVRuOtEBkh6A/0VdUII=
X-Google-Smtp-Source: ABdhPJw57b08V0yHzRvjztHGvC6NDI5qlJErpxBPqWosR83M55tCfe2R+c09/5jVgLkTn+wpYzGFXH7ZbEQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3a89:: with SMTP id
 om9mr5591281pjb.29.1637373010794; Fri, 19 Nov 2021 17:50:10 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 20 Nov 2021 01:50:08 +0000
Message-Id: <20211120015008.3780032-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] KVM: x86/mmu: Use yield-safe TDP MMU root iter in MMU
 notifier unmapping
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the yield-safe variant of the TDP MMU iterator when handling an
unmapping event from the MMU notifier, as most occurences of the event
allow yielding.

Fixes: e1eed5847b09 ("KVM: x86/mmu: Allow yielding during MMU notifier unmap/zap, if possible")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 377a96718a2e..a29ebff1cfa0 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1031,7 +1031,7 @@ bool kvm_tdp_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
 {
 	struct kvm_mmu_page *root;
 
-	for_each_tdp_mmu_root(kvm, root, range->slot->as_id)
+	for_each_tdp_mmu_root_yield_safe(kvm, root, range->slot->as_id, false)
 		flush |= zap_gfn_range(kvm, root, range->start, range->end,
 				       range->may_block, flush, false);
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

