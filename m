Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7944CCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhKJWd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbhKJWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:33:47 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28C4C061203
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:30:59 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y18-20020a17090abd1200b001a4dcd1501cso1807664pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LbThUuaOpzCbOzZAIPBZcmEtqbOiPlEJtesgwMaSYDQ=;
        b=GdALKheein9Cb85IAuoDwJOYJGpvSzm5GwacVa/XVjVCJl1ynuK+EpRV3FPQMTk9CY
         9THiBOiwH1i4LGVI97p6IPgtVpxwEkZy9Mtvs6Ih1BjdW80NRz43d0dlyG739eeZ666F
         ghqI8TdJmMwDdm2sify4R0wlPK7OVgv5K0iCLdiK0B406bBxCvjmd7gcFjZseXynMAHn
         UpZ/FahkjP9LPAUzx8xeLTKs98McpM+9hGDrgJK1DX/e8ezLHlPe9JLayL7KL4ijA157
         JzY89qViwsCprqSzX1+rheQPZNA0F8CzdLSQ4x7FnZIM15Gcjbj4v7E0BluWlP7pMBY4
         wXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LbThUuaOpzCbOzZAIPBZcmEtqbOiPlEJtesgwMaSYDQ=;
        b=Kyv+niKmM1oPVNRCb3H9lkQYsM6hTT9gxcrHF8f3WAMRv8F0iZ0yixHvFHidrqLl4h
         VsExosJ+Pz2bbRcmfZqWjCsnhrK8cIecKMn8rZWAad+UZfQKzI1c/9CqDUAgXYnqVe/K
         Eu/79gHunvjAmyAgPybC5xy5N/KbSN3VmMMaXsemSeQUc/rztqo8rUTN15DCnq4FDxUx
         wCu4sLPsAJC58ejLM26lOkYxWwHV3vTVUlZsMuY8H7BKa77nSpcKI9nBEzf8cH79eAHp
         Ik5INqPL0nWdvUsSx8pwUFTxlVqv1c084Y4GXBBzXR+BLmf/ZFx3hHQtofJs2wm/O8IM
         YjfQ==
X-Gm-Message-State: AOAM531+41GKEgAVGV40hmP04W/WmkfkcPbX/QRAf6wlCZxjFYWfLEGY
        H6ZwR//Wr/4H6v9VjVsHm42PSLGr+XEqX0eR21Gdi7xtUnAo9VwsZMg4khzjj4Kd7dwmZK0UI0n
        9Hdw3biBQM32IdDCY9pgvI4eA8OA9oERXRac5zSPUYGw1H2BQdtTYqT/fMBgFDgD+PLtnPeGB
X-Google-Smtp-Source: ABdhPJwVt+Qc1aJV9QEwJFviIGlNtIREHh7km4Ycaep0pTfsFtmaYAT/hX7M+OXMOkXF8niNc+7/1tfKcBRF
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:6586:7b2f:b259:2011])
 (user=bgardon job=sendgmr) by 2002:a17:90b:384d:: with SMTP id
 nl13mr2941669pjb.80.1636583459164; Wed, 10 Nov 2021 14:30:59 -0800 (PST)
Date:   Wed, 10 Nov 2021 14:30:04 -0800
In-Reply-To: <20211110223010.1392399-1-bgardon@google.com>
Message-Id: <20211110223010.1392399-14-bgardon@google.com>
Mime-Version: 1.0
References: <20211110223010.1392399-1-bgardon@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC 13/19] KVM: x86/mmu: Factor out the meat of reset_tdp_shadow_zero_bits_mask
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the implementation of reset_tdp_shadow_zero_bits_mask to a
helper function which does not require a vCPU pointer. The only element
of the struct kvm_mmu context used by the function is the shadow root
level, so pass that in too instead of the mmu context.

No functional change intended.


Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1e890509b93f..fdf0f15ab19d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4450,17 +4450,14 @@ static inline bool boot_cpu_is_amd(void)
  * possible, however, kvm currently does not do execution-protection.
  */
 static void
-reset_tdp_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
-				struct kvm_mmu *context)
+build_tdp_shadow_zero_bits_mask(struct rsvd_bits_validate *shadow_zero_check,
+				int shadow_root_level)
 {
-	struct rsvd_bits_validate *shadow_zero_check;
 	int i;
 
-	shadow_zero_check = &context->shadow_zero_check;
-
 	if (boot_cpu_is_amd())
 		__reset_rsvds_bits_mask(shadow_zero_check, reserved_hpa_bits(),
-					context->shadow_root_level, false,
+					shadow_root_level, false,
 					boot_cpu_has(X86_FEATURE_GBPAGES),
 					false, true);
 	else
@@ -4470,12 +4467,20 @@ reset_tdp_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 	if (!shadow_me_mask)
 		return;
 
-	for (i = context->shadow_root_level; --i >= 0;) {
+	for (i = shadow_root_level; --i >= 0;) {
 		shadow_zero_check->rsvd_bits_mask[0][i] &= ~shadow_me_mask;
 		shadow_zero_check->rsvd_bits_mask[1][i] &= ~shadow_me_mask;
 	}
 }
 
+static void
+reset_tdp_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
+				struct kvm_mmu *context)
+{
+	build_tdp_shadow_zero_bits_mask(&context->shadow_zero_check,
+					context->shadow_root_level);
+}
+
 /*
  * as the comments in reset_shadow_zero_bits_mask() except it
  * is the shadow page table for intel nested guest.
-- 
2.34.0.rc0.344.g81b53c2807-goog

