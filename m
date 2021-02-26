Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798B2325B20
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhBZBFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhBZBFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:05:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB9EC06178B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:03:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v126so8334670ybc.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 17:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=qpS7GnYM+VvVuInH7Q+CEmlH+I0WNjfKsvpZu1wz92s=;
        b=Wben5QyU96ys7KjMGaMwlDENkCrkljjCcTiQK7iqau4peOpcza4F9Nu5kai1mo7aHB
         wowSzju/bwAwXxMLBGdCBG3Vo3x9rviVRz5Bk2xXxl9lZFfBrZy5gPg76k2B1MiGnBZy
         BcTRRAQTdJGX5yu2za10oYQgWodsHWF7se0NAl4wk46k+/GYHyff5aK0LaPO/32P/h5h
         ysdX8JS1qvkkbBMKYR58Otttd3LX2dAeIRbplsgtg76qqHHjwyXvqaHd2ZnwC86bE+6b
         1OvbirwMVSUNB8bsMJ8pgQs4PBIzbhuhTg3iR7hvgH2lzMLXU6ypMAU9kWXpApmGDcTx
         e5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=qpS7GnYM+VvVuInH7Q+CEmlH+I0WNjfKsvpZu1wz92s=;
        b=pfY98j/4PhaFjPJPKoH5qiJaEHzqc4jlbkSZlreyKIvzSpXvjLD5SdhmXzmfL1HtPg
         M3KI85ZHqiAMZ9t3q9a/PmSX8yLNx7Xm1EeQDPbc53D6bkaUZ/GWlLAlEwEuthOCVxmp
         jiOD38Zk9VH3T9MhtF+h/wJAfcpu7tByHdGnYN/kqoS9/+BLLLw5EAQPyqNfHmJhzLqc
         xMfMfBQIfpu5juY+7S3rnmVIBt4i2C8O0kqa9TiIHMG7Pixfp2iFJ3UdDminZarXkm55
         Ve76dj3VzFkPEDvX09+QFGOMeLPU6RZOtoRaGoa8HVcPJR24tao3B2sEpdXjgrEoyFEN
         K0ag==
X-Gm-Message-State: AOAM53024+TTeQyKudpO9AIFavSoIfMT+o+2FxBqtGVIQ1ddIxM0m3mj
        Es9VPZHH5RMCgS8bNMYOhCPSpI+vNig=
X-Google-Smtp-Source: ABdhPJxAv8NLAGkTg59FY3aLxcVqNtcoJWj9Dd9vAhOtBjufQnxrIDaMn2J+HNxN+TdwAN5N5mOfq/PEVIY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a05:6902:6ac:: with SMTP id
 j12mr867837ybt.440.1614301421040; Thu, 25 Feb 2021 17:03:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 17:03:27 -0800
In-Reply-To: <20210226010329.1766033-1-seanjc@google.com>
Message-Id: <20210226010329.1766033-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210226010329.1766033-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 3/5] KVM: x86/mmu: Use 'end' param in TDP MMU's test_age_gfn()
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

Use the @end param when aging a GFN instead of hardcoding the walk to a
single GFN.  Unlike tdp_set_spte(), which simply cannot work with more
than one GFN, aging multiple GFNs would not break, though admittedly it
would be weird.  Be nice to the casual reader and don't make them puzzle
out why the end GFN is unused.

No functional change intended.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 020f2e573f44..9ce8d226b621 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -997,12 +997,12 @@ int kvm_tdp_mmu_age_hva_range(struct kvm *kvm, unsigned long start,
 }
 
 static int test_age_gfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-			struct kvm_mmu_page *root, gfn_t gfn, gfn_t unused,
-			unsigned long unused2)
+			struct kvm_mmu_page *root, gfn_t gfn, gfn_t end,
+			unsigned long unused)
 {
 	struct tdp_iter iter;
 
-	tdp_root_for_each_leaf_pte(iter, root, gfn, gfn + 1)
+	tdp_root_for_each_leaf_pte(iter, root, gfn, end)
 		if (is_accessed_spte(iter.old_spte))
 			return 1;
 
-- 
2.30.1.766.gb4fecdf3b7-goog

