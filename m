Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D0F3D6612
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhGZRNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhGZRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 13:13:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4967EC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:54:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e145-20020a2550970000b029056eb288352cso11712193ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=btPFck1XzpE3aBH1Nm3kzDvWZMQLegGwPNOaeKtJDeI=;
        b=Uw2Y7dstn1klTtFavjKJYv6imv/nRJZdjGus8S7vEDypmeFKTEeiTiAPic5mjTvmN1
         SmFPjksQQazwFhsaqlxv9rSFVtbtkGRmdSPSI3iwLrtUahPoCVWTAZj73EDjzLbLFAdQ
         AIrh+YYmw7qYqA59UIL2dy0K5Gfk10WTJiXEe2RSPZgYZAalpxsTnCrG+xu/Wa3055QL
         UdRKL4B7EG/FY7iKu6xGvo/UGhmNLgrxgfR8P16tABrGA6zgEsawICui24GeBiHI0u9D
         YVjIS+7JOy/MX9Jymr2azwpOE2vUjy7RuOKBL94dNVcD2VUFU4lXki6FOyasHwnuXMAu
         i96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=btPFck1XzpE3aBH1Nm3kzDvWZMQLegGwPNOaeKtJDeI=;
        b=jcGex09XVmZagZFQhOb6Cy87ab9IS/u2E1sKRHG6v475emJnqT4xDxZXpplP8Qh32k
         LmCYLwVYXyoBQSjb1ml95+L/FWjaHVepO9K9E3/oidMw5fUmyEVh4K/1pWYv017wLcWO
         67kmNd06/D/qcHF4RdhWZNkfV53PGLepoLuoryUnnN5zIIK8w4UJ0B32ouj88IhYxsbo
         dQF1+EeyX6apBJOrpUCtqcJnABVt/dEzAdpAHcA08DBPZLh0LjVtFTC3fS4PMqi3XE5v
         zlgwt4ND2BYA66ZCXRjJ06/GZ6N1vF2n2nddf1d3UADkukTo6A2nDp5oAuwOhDr9nPeI
         NAzg==
X-Gm-Message-State: AOAM530DYEW/B46+/hANsB8BfCLosdCTzQvXobjT2fao28FryHDqhulm
        ORzDi0Y8vzF6+fqgv8TXKVT0ZTspbzhT
X-Google-Smtp-Source: ABdhPJxbWjqm+qvuS5zbnPd0y4Yutx6fHaBzxcJFAe0ph999LdcGRPHqHceXJ/pOUHzCB2QSmmaKGjh4nkGh
X-Received: from mihenry-linux-desktop.kir.corp.google.com ([2620:15c:29:204:93c5:105:4dbc:13cf])
 (user=mizhang job=sendgmr) by 2002:a25:188b:: with SMTP id
 133mr24756922yby.80.1627322046468; Mon, 26 Jul 2021 10:54:06 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 26 Jul 2021 10:53:55 -0700
In-Reply-To: <20210726175357.1572951-1-mizhang@google.com>
Message-Id: <20210726175357.1572951-2-mizhang@google.com>
Mime-Version: 1.0
References: <20210726175357.1572951-1-mizhang@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 1/3] KVM: x86/mmu: Remove redundant spte present check in mmu_set_spte
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jing Zhang <jingzhangos@google.com>
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
2.32.0.432.gabb21c7263-goog

