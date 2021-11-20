Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD7457B64
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhKTEyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbhKTEyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:54:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D958C0613F1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso19205791ybj.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/oTaTNiB/LMk2r2BJ6BITqZh/xo7HcDPFHBzIC0aTcA=;
        b=WPlmQ7dQuJ1uI7rACN8ZUhfdEkZLX56UEjuNndMAQ3iodLsdQcL9W/dj6HIkAGfGWg
         gE/UXDx3nWZbpHuu/aKvd0BGF8Y4CZ2BlEA7MiIfyuqECWbUdflK4LGxOxWqxQvvKpQ6
         EQVb4iBn2Gx3tRIGBPzUvT7iWhRa1w8r3TgtlS/UWtpXedFuOfvUyhfyme3M40LIJZob
         TXrNtbo+dAE6JJVTciDHWD8Ic0AGa1fsGvhWwui5iozvPpNxdk/iGU+uO8LziEPfCEd1
         NkCtk3cMnlS1TSIOGe3/yzyzoPQknV+KE2gPFW6CCG1Eo5s9Tbqb93RJDQtnxPXJ5rYV
         3fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/oTaTNiB/LMk2r2BJ6BITqZh/xo7HcDPFHBzIC0aTcA=;
        b=KBJ6lB9tb3yZSvG4M/H8Hck3HeYWtk6JWro2c6feZv4FPAlKhNHzDfYGkKXibvkPTv
         NgaALYgbzDmd5dM45gJ578alYvUzb8IOwRUGJDEDu8UG6nwronuiVIO/7eFJ2r+XR30S
         JCZCQJRoh54/M+oGgqY5BI/W5Zedel5v4WAV6y/TXiaBzY16zQbhJGtu2YNLjJbtgZKt
         Zx/YjbX4MqXXRmeUyVCrHLU/V0e3IRifIUMs8gLNATKt5mTjiy2oRjNZUI1R/AqXTMYd
         1ah6y9fvVaRbXX/hi2zEMV4hbE1doHvsGM25JAC+NnliJUYrfQrtfQZm08fJC7CjNRDU
         /pyQ==
X-Gm-Message-State: AOAM5330rVrhnfDBVS62W6iHD5snvIAv1IguMtvjlfr3dWjJ/eYtI1kE
        0YP1fm7TcC+smgmhM0aUFeeSNDCZobw=
X-Google-Smtp-Source: ABdhPJzgMlxyALCEHUJnE+SUDIlZ0c3NP8y3yVfZGng2q/E/Do8yiX9PzEsWyaZAw1I4pV2C4IaOmjDRQYw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:d4d5:: with SMTP id m204mr47930487ybf.418.1637383856477;
 Fri, 19 Nov 2021 20:50:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 20 Nov 2021 04:50:19 +0000
In-Reply-To: <20211120045046.3940942-1-seanjc@google.com>
Message-Id: <20211120045046.3940942-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 01/28] KVM: x86/mmu: Use yield-safe TDP MMU root iter in MMU
 notifier unmapping
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

