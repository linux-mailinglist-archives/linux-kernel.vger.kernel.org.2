Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77E8372EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhEDRTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhEDRTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:19:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BF4C061353
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 10:18:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so12561608ybp.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=la9oY1bxuLYI2LhjbikVYGCKhsj27XYDlkUaBPeOjcE=;
        b=jn7iGmXk2tM9WVcHBi3kVdO4RzzftrZfQjnK+KwLY8ldx7zkeKX1Ji8siS6FGY4sOb
         hweay/CtK/y3qJ+aMkl1CKVsa8O4blH0Z4ObvgtaA2EAlo2umn8s6Yh6lEjq/vkfVOmF
         AK9du+htAn4roZgYlRNomur8QSNZN5lnsPUhd8pyzyLcBrUpSHk5yIC2W8XPaQ8UU0Wa
         MyUHUKhTVHjSOjjUBrcay/jqEBB7LOLLdxPljAg5aA0jtOfrTs3W+zClQqkcPIj//3SO
         rJJBBQCpm9MsJldnED0rOfmLYLzH9G9mmBS54TnM4bqZvRA+SMbAbru+RuE520OCxPQ7
         5mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=la9oY1bxuLYI2LhjbikVYGCKhsj27XYDlkUaBPeOjcE=;
        b=oLf5tuZxrlV7YulKubgMGUey0/b0P1OWpc2TGKEbCAEEds71DzHRHrxhWxcyIi0P/n
         jJ5yZlAE1tGJlkApjvH7Qi7u3MDNuSt0EyVEX13emouPlz1kf7h7zAj8aOTAN1Cn6jDJ
         Nu/A6/6R6ej/xV4VRNfyJ1vew39iG7+R3MbBjBjX/UvT0mRkNuBY5XFAtvc3L03kMVpd
         iURGavW50O/HF3zYOR6z8g/+5DjMuRP8poJeVUKiC3ZHXllve3K2q8omIDe9JG8+oFss
         p6ev8OzeIijB4iOk2GMko9PK0VRwk0sUvo8rxgaOiWUDZq8NtA5R4nP3u8gS0CgvlmvX
         H0Aw==
X-Gm-Message-State: AOAM533qYYZ/dKd15jOpZRg4jn/KvYczlknedYpev+45vPM9notqVPLo
        M2DpOmlJc7LV3pgIvBLYauknLN+MV6A=
X-Google-Smtp-Source: ABdhPJwwHw598d//FTS6A9v+yJFz6d3uPtTa/zkCcvmZHBETLX5230DxHwzzjkufCXdGKaG2q1I+ZkEAJBc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a05:6902:120a:: with SMTP id
 s10mr34885283ybu.91.1620148698033; Tue, 04 May 2021 10:18:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 10:17:34 -0700
In-Reply-To: <20210504171734.1434054-1-seanjc@google.com>
Message-Id: <20210504171734.1434054-16-seanjc@google.com>
Mime-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 15/15] KVM: x86: Hide RDTSCP and RDPID if MSR_TSC_AUX probing failed
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If probing MSR_TSC_AUX failed, hide RDTSCP and RDPID, and WARN if either
feature was reported as supported.  In theory, such a scenario should
never happen as both Intel and AMD state that MSR_TSC_AUX is available if
RDTSCP or RDPID is supported.  But, KVM injects #GP on MSR_TSC_AUX
accesses if probing failed, faults on WRMSR(MSR_TSC_AUX) may be fatal to
the guest (because they happen during early CPU bringup), and KVM itself
has effectively misreported RDPID support in the past.

Note, this also has the happy side effect of omitting MSR_TSC_AUX from
the list of MSRs that are exposed to userspace if probing the MSR fails.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index c96f79c9fff2..bf0f74ce4974 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -567,6 +567,21 @@ void kvm_set_cpu_caps(void)
 		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |
 		F(PMM) | F(PMM_EN)
 	);
+
+	/*
+	 * Hide RDTSCP and RDPID if either feature is reported as supported but
+	 * probing MSR_TSC_AUX failed.  This is purely a sanity check and
+	 * should never happen, but the guest will likely crash if RDTSCP or
+	 * RDPID is misreported, and KVM has botched MSR_TSC_AUX emulation in
+	 * the past, e.g. the sanity check may fire if this instance of KVM is
+	 * running as L1 on top of an older, broken KVM.
+	 */
+	if (WARN_ON((kvm_cpu_cap_has(X86_FEATURE_RDTSCP) ||
+		     kvm_cpu_cap_has(X86_FEATURE_RDPID)) &&
+		     !kvm_is_supported_user_return_msr(MSR_TSC_AUX))) {
+		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP);
+		kvm_cpu_cap_clear(X86_FEATURE_RDPID);
+	}
 }
 EXPORT_SYMBOL_GPL(kvm_set_cpu_caps);
 
-- 
2.31.1.527.g47e6f16901-goog

