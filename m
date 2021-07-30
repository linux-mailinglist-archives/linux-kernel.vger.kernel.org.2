Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1E3DC164
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhG3W7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhG3W7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:59:52 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C065C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:59:46 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id on10-20020a17090b1d0ab029017773c0b9aeso5738380pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=9ncP48pmN4Ci01oF1W88DG8WSTju1eWdQa4Lz01EI4I=;
        b=S9U/7kbnNHeRVptR7ZYbDatTggvsTxb4oBtv55hGK33ime4Gl4Oj368COnoS7NZp8O
         bh0jsV8SCX65qQLQmls8tn8c3JxBs0NbQFEkrId/QJkg69xRngyp4Qnkkc2o7UCQNeQF
         5qMLPQEQuVpr/zulDWvwuovYq/zgCPXBANLrASo21zp24WDuXyqGqZYnOAzlDmfJgf40
         AbaZSIAJ3QG/zxNsf22lZzoGqjpxGlNU8vBJHSkGoO18tIY/a+c/2OomANcbDnTkjYxx
         JAKf1zBL7MAS8B1O3P3EOxCNm2BJ8LP4hIru0YNKY7SKlVNQGZSXg185xDyyxdZ33i4Y
         rR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=9ncP48pmN4Ci01oF1W88DG8WSTju1eWdQa4Lz01EI4I=;
        b=gf0PfGo+VH7HrVihvU/ES6lWrCvnfAXtE1TOePuG3gogxca/+7MNdN9FxQTWoRdF9d
         0ePMq/mVCeuHhINDbwVCR3JaE2ohTbQwTlIcVuysYyi851IksTDb9AwyM96VwtH835bP
         E1vlaQpk7Gz52aZTZLncvcJmevDFEgRsM9t3MmmTUpENRQiBKA4HNjbRZ9tssIgNDpUW
         O8DWMAByGJ4ETyLsFEWmDyueK/dyC/WoTa+Ih+0arK4t+5E1vjTOtlMHib1ClCd8VLZP
         agQDqH8qdXwWWfGTaVclxXCzef415X2Ara3ZprjK4DHScFy6RZoCj0MAVJ/2hGt/bDam
         V1VQ==
X-Gm-Message-State: AOAM530RUHTIB3bOTkd81lLGOkNZQATiZzFLfDhE7ZVU836Kh68Pa8TI
        TqW8h91Sbqux67zGR0xFFMBYrDRLtaug
X-Google-Smtp-Source: ABdhPJxJTEcU1T/Pp8EdstFVdYpYzwoODHnhIZWBfVWzmLeXI3/vDjjYQduXinkZDpj/F9vz5YO2rbmLYDp2
X-Received: from mihenry-linux-desktop.kir.corp.google.com ([2620:15c:29:204:a198:4c3e:b951:58e3])
 (user=mizhang job=sendgmr) by 2002:a17:90a:fe0b:: with SMTP id
 ck11mr5413401pjb.11.1627685985634; Fri, 30 Jul 2021 15:59:45 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Fri, 30 Jul 2021 15:59:37 -0700
In-Reply-To: <20210730225939.3852712-1-mizhang@google.com>
Message-Id: <20210730225939.3852712-2-mizhang@google.com>
Mime-Version: 1.0
References: <20210730225939.3852712-1-mizhang@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v3 1/3] KVM: x86/mmu: Remove redundant spte present check in mmu_set_spte
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop an unnecessary is_shadow_present_pte() check when updating the rmaps
after installing a non-MMIO SPTE.  set_spte() is used only to create
shadow-present SPTEs, e.g. MMIO SPTEs are handled early on, mmu_set_spte()
runs with mmu_lock held for write, i.e. the SPTE can't be zapped between
writing the SPTE and updating the rmaps.

Opportunistically combine the "new SPTE" logic for large pages and rmaps.

No functional change intended.

Suggested-by: Ben Gardon <bgardon@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b888385d1933..442cc554ebd6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2690,15 +2690,13 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 
 	pgprintk("%s: setting spte %llx\n", __func__, *sptep);
 	trace_kvm_mmu_set_spte(level, gfn, sptep);
-	if (!was_rmapped && is_large_pte(*sptep))
-		++vcpu->kvm->stat.lpages;
 
-	if (is_shadow_present_pte(*sptep)) {
-		if (!was_rmapped) {
-			rmap_count = rmap_add(vcpu, sptep, gfn);
-			if (rmap_count > RMAP_RECYCLE_THRESHOLD)
-				rmap_recycle(vcpu, sptep, gfn);
-		}
+	if (!was_rmapped) {
+		if (is_large_pte(*sptep))
+			++vcpu->kvm->stat.lpages;
+		rmap_count = rmap_add(vcpu, sptep, gfn);
+		if (rmap_count > RMAP_RECYCLE_THRESHOLD)
+			rmap_recycle(vcpu, sptep, gfn);
 	}
 
 	return ret;
-- 
2.32.0.554.ge1b32706d8-goog

