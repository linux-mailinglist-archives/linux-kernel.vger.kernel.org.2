Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DA30CAEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhBBTFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbhBBTC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:02:27 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FBDC061A2B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:58:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z9so12574103plg.19
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AT93/ogWHXZz20/nWmto+tVuhh8JYGtfkCQW8Y2OAc4=;
        b=r5R8y+ePnaAaeFSdFKCGU7w4lreH34R3dbk7cfBMhYkTaOHLEhd2TwMXIbp2vgFYi3
         Gd/u1N8eXJchw09Pj82KEmSH5oCErngyK4OhDuq+mzuwOp3lpfgSp9+1HQ27i7YJXnmr
         k90Cuvq3phZ7aKAKk8rsgizzFnYhuzngDJeoGoxSPmCgG0nPlJsipQTbR/jfIztrVdmH
         PChpmj8LgDQ5h6LSSW2KJf/diK7nV4A5xnjbi3T91sat9hXOZuoS8B9rCG2oy0PPUbzE
         oeBetr1O4R4IPOqoZ61HiXZTMb2cSBR6jwSXXgE8SEYEVw4HV027RlgtmhDE63G10nUC
         4ISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AT93/ogWHXZz20/nWmto+tVuhh8JYGtfkCQW8Y2OAc4=;
        b=cKSXAsr1znSoQzkEGhO6MHjIAATDggzzuwV6NgRg4gEMHLL2cG7b89hmciFYYByjQ5
         ezYOcmB+l/fy9ROyFbLPf+rF1MACiMe9lVjRz93ZDCntPUhMnGR4UsvSoqeOl/Gx/4Op
         wE5OlrMKlcmXMpq5Zf1CiPw49rFVA17qHoPuL67t2fVNsMEviDJwPEi1two0FcWb2FKs
         YaFnh7hN1znyyblIeNu+H37J5mposvDMicl0jN1bcrMBugsK/13UhSSy/KCqmMcAD5ls
         1ZMXCsp/yqGSApz1wsNK1O70L8HVbKnI7html5NhHSBVdXUDLKwJaUERxdUzSaGKy35g
         2I1Q==
X-Gm-Message-State: AOAM533XXspYjiiICpOE0hmGliFKcx01BmZnttNr9GxVq6vlnq4+SaAV
        O/WRQuKSBprgr9qEOSo91jKArc2t+6T8iqu70v/t7x3Otd2lNu+/w/KwmG9+FqPWqW12Xo9cDp7
        uJdtxFY5zbbvhhl2k+WnxjrS3br70DYIws7psj2BeP1hpRJxTRjXUyRLtoO8BQX/OmCgsVbOu
X-Google-Smtp-Source: ABdhPJwCA8GyUrhXpxf2tdjZ130kf6w37Af0AcDtX/wCAZtKVUM1t3M3pKL4+fHk82e59W3QYalqp5VOzjzD
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a17:90a:8d83:: with SMTP id
 d3mr614671pjo.0.1612292298314; Tue, 02 Feb 2021 10:58:18 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:28 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-23-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 22/28] KVM: x86/mmu: Mark SPTEs in disconnected pages as removed
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When clearing TDP MMU pages what have been disconnected from the paging
structure root, set the SPTEs to a special non-present value which will
not be overwritten by other threads. This is needed to prevent races in
which a thread is clearing a disconnected page table, but another thread
has already acquired a pointer to that memory and installs a mapping in
an already cleared entry. This can lead to memory leaks and accounting
errors.

Reviewed-by: Peter Feiner <pfeiner@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7a2cdfeac4d2..0dd27e000dd0 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -334,9 +334,10 @@ static void handle_removed_tdp_mmu_page(struct kvm *kvm, u64 *pt,
 {
 	struct kvm_mmu_page *sp = sptep_to_sp(pt);
 	int level = sp->role.level;
-	gfn_t gfn = sp->gfn;
+	gfn_t base_gfn = sp->gfn;
 	u64 old_child_spte;
 	u64 *sptep;
+	gfn_t gfn;
 	int i;
 
 	trace_kvm_mmu_prepare_zap_page(sp);
@@ -345,16 +346,39 @@ static void handle_removed_tdp_mmu_page(struct kvm *kvm, u64 *pt,
 
 	for (i = 0; i < PT64_ENT_PER_PAGE; i++) {
 		sptep = pt + i;
+		gfn = base_gfn + (i * KVM_PAGES_PER_HPAGE(level - 1));
 
 		if (shared) {
-			old_child_spte = xchg(sptep, 0);
+			/*
+			 * Set the SPTE to a nonpresent value that other
+			 * threads will not overwrite. If the SPTE was
+			 * already marked as removed then another thread
+			 * handling a page fault could overwrite it, so
+			 * set the SPTE until it is set from some other
+			 * value to the removed SPTE value.
+			 */
+			for (;;) {
+				old_child_spte = xchg(sptep, REMOVED_SPTE);
+				if (!is_removed_spte(old_child_spte))
+					break;
+				cpu_relax();
+			}
 		} else {
 			old_child_spte = READ_ONCE(*sptep);
-			WRITE_ONCE(*sptep, 0);
+
+			/*
+			 * Marking the SPTE as a removed SPTE is not
+			 * strictly necessary here as the MMU lock should
+			 * stop other threads from concurrentrly modifying
+			 * this SPTE. Using the removed SPTE value keeps
+			 * the shared and non-atomic cases consistent and
+			 * simplifies the function.
+			 */
+			WRITE_ONCE(*sptep, REMOVED_SPTE);
 		}
-		handle_changed_spte(kvm, kvm_mmu_page_as_id(sp),
-			gfn + (i * KVM_PAGES_PER_HPAGE(level - 1)),
-			old_child_spte, 0, level - 1, shared);
+		handle_changed_spte(kvm, kvm_mmu_page_as_id(sp), gfn,
+				    old_child_spte, REMOVED_SPTE, level - 1,
+				    shared);
 	}
 
 	kvm_flush_remote_tlbs_with_address(kvm, gfn,
-- 
2.30.0.365.g02bc693789-goog

