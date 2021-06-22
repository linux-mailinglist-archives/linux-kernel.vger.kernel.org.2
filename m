Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12873B0C32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhFVSDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhFVSCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:02:55 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C28C0613A2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:05 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id x13-20020a0cfe0d0000b0290264540cb5d3so2301658qvr.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ylpxsJVZqQHxCprlfV+E9MmLtYIbNcUZULCnv1BFgJI=;
        b=rcY3HHbecxnEiFCqLojmywKuoaLKVAuXKbtUoVUOvKUNNepltkBW7wdfYnc20myoXE
         K/LzfMBHLYxNcc/MyC7m/JFMPxGZE/kFQqlfR3bhZf2z6aukTiZ/8oT3bNAR3xag3dWW
         7Pw5m1NohI5cVu+tdtbaO79J7rQaY++6PUWcymh7wMBU6mYG1EzJcppXg1nB5vmBqKup
         /eikxs+Ow+H0iuv1nRHcGVRBRacilJbLxXMB8mvk11jS20FqDHt9h19XlKZ4HRjqpmhK
         r2dn1PKU9Cr9R79gJojIQfPl4Gi09Yw6aZvBwAv5nK1oLE8PlV/YT3FX9vLcWO4z4STm
         yTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ylpxsJVZqQHxCprlfV+E9MmLtYIbNcUZULCnv1BFgJI=;
        b=dDg3dSrrjTQEC40Ask79dPM4sVkgXoAIXoAIOmGzKufkZ7a1wlQfJFbHIwog7cdQe1
         pq7BnOBlvXRUtzbHR7Xu340J5S5aiBiUiytQylaAS+b7RAklcoShCHZrtnfx1zXEn5aQ
         RGhT0GLmatoKBsREQgvouJDnUm6QOUF8KjIz75ayRW3D696WXuaNwGQQaGWlwpYBe94G
         53+4TfsPkR2xPURMzTA4tL03mhn4jXznDQOwi8U+fWrFq4diEwxx1qZZGuYJyMTb/LXs
         afOocK1XwhhwUQoLzEukho1QA+tpNODpxpDZZV91CJ6A8+37eI+g6/e+IMSBu1IcOvru
         Bn0g==
X-Gm-Message-State: AOAM530iEzWnXjq2wAR7SU7qHmRTdW8abvVBh3MIE+4LH6PdUfbsoEve
        mxOuq3WdRwzPjDCWLW/9obOmwly+oqc=
X-Google-Smtp-Source: ABdhPJy86ED/Y4SC0aZmOaWshiCQsGt9u3jeW/uIQb9VsZgmX8MEPWpFhtoiRUhTvFl3ZCOes71q838ZLA8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a25:bcd0:: with SMTP id l16mr6673381ybm.55.1624384744928;
 Tue, 22 Jun 2021 10:59:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:15 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-31-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 30/54] KVM: x86/mmu: Use MMU's role to get CR4.PSE for
 computing rsvd bits
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the MMU's role to get CR4.PSE when calculating reserved bits for the
guest's PTEs.  Practically speaking, this is a glorified nop as the role
always come from vCPU state for the relevant flows, but converting to
the roles will provide consistency once everything else is converted, and
will Just Work if the "always comes from vCPU" behavior were ever to
change (unlikely).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ffcaede019e4..e912d9a83e22 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4216,7 +4216,7 @@ static void reset_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 				vcpu->arch.reserved_gpa_bits,
 				context->root_level, context->nx,
 				guest_cpuid_has(vcpu, X86_FEATURE_GBPAGES),
-				is_pse(vcpu),
+				is_cr4_pse(context),
 				guest_cpuid_is_amd_or_hygon(vcpu));
 }
 
-- 
2.32.0.288.g62a8d224e6-goog

