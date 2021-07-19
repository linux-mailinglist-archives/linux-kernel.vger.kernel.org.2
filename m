Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FDE3CD2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhGSKHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 06:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbhGSKHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:07:38 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F541C0613E1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 02:56:06 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id z6-20020a5d4c860000b029013a10564614so8624235wrs.15
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ToM5LGd9yFKNtYUInCRmxwlv14Vkpcedx2OC69eyExs=;
        b=jnbKDcOAOk2tJlEDs7bcxicOHljH0PrDLCq6CekugM0fVJCMwyzhRuLj4A8f+YzI4k
         IS7HwNRyj/txJNtmBi3fSo+YWQO3G/y4I3hjNMrK82HChzpG1HG0eZg0NWQmq4+LdBvK
         TQoiF+yO977gzIwlRBvykOORvCiNONiIq8EQHTaZxsykqzty35HsNCsVHtGzhM+agh6G
         uVUko0WhrSePAfAFzBuE3K0avxRFAUk2dDQemDZg6Ny+lm308lycNC3bbS1uNX5TrPAi
         3C0ZsBtVJ57MYpkE8fJYxgc3GCMoYnLbLD7BAzbqf25uvdCwEEMDm60CeCvqf0KglcbB
         UxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ToM5LGd9yFKNtYUInCRmxwlv14Vkpcedx2OC69eyExs=;
        b=TlWXr55i5QN0fZcVkkeMV+rin9qfbdFXX7dq0Z1OAgg3QlrffJz6d+SV2vlrNwvyAx
         GTFB+kxrVFPzs5JlJYXu3vNZxWlne/bXJ672iivKhLyK7OWGEvUGVwyEpP+U2nKfAGSu
         bqiYcpIKDPO0AabGXUP5JWgHJ2kGVf3nTc9S7D4b9oIgurXzlAn+MCCPRAr2qPH/RJpK
         cagTLxjjztZ5w6UT55WhQ9XBrXdNQzAowE++TJyPyxCOFXjZyVlbVaG8IdL12DiJRFM4
         rxekKzY5itrUT/7IiQii9LRc8brHztwAJYa09VnXa2BiYztDB2pttxw+zU8aBXmPh55W
         oigQ==
X-Gm-Message-State: AOAM531BKg+Ue1QlDvX+ZxpP/uw/yM9e7KJRG2lDLqWPilQH2YK0FbOM
        elcVGpBmRjbu7rYFFJaCeiSckVqbJTpd
X-Google-Smtp-Source: ABdhPJzgGJdAU0vtVnZruVhBnynMubFOxTgk0bZvp5vOKD+WWRlzrEeRgKopwaNKW+lR3zpb/2mloTXM4Szz
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1a96:a43f:6c2e:bb5a])
 (user=qperret job=sendgmr) by 2002:a05:600c:214a:: with SMTP id
 v10mr25899621wml.67.1626691688581; Mon, 19 Jul 2021 03:48:08 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:47:33 +0100
In-Reply-To: <20210719104735.3681732-1-qperret@google.com>
Message-Id: <20210719104735.3681732-13-qperret@google.com>
Mime-Version: 1.0
References: <20210719104735.3681732-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 12/14] KVM: arm64: Refactor pkvm_pgtable locking
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the hypervisor stage-1 locking in nVHE protected mode to expose
a new pkvm_create_mappings_locked() function. This will be used in later
patches to allow walking and changing the hypervisor stage-1 without
releasing the lock.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mm.c         | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 8ec3a5a7744b..c76d7136ed9b 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -23,6 +23,7 @@ int hyp_map_vectors(void);
 int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
 int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
 int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
 int __pkvm_create_mappings(unsigned long start, unsigned long size,
 			   unsigned long phys, enum kvm_pgtable_prot prot);
 unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index a8efdf0f9003..dde22e2a322a 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -67,7 +67,7 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 	return addr;
 }
 
-int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
+int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
 {
 	unsigned long start = (unsigned long)from;
 	unsigned long end = (unsigned long)to;
@@ -81,7 +81,8 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 		int err;
 
 		phys = hyp_virt_to_phys((void *)virt_addr);
-		err = __pkvm_create_mappings(virt_addr, PAGE_SIZE, phys, prot);
+		err = kvm_pgtable_hyp_map(&pkvm_pgtable, virt_addr, PAGE_SIZE,
+					  phys, prot);
 		if (err)
 			return err;
 	}
@@ -89,6 +90,17 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	return 0;
 }
 
+int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
+{
+	int ret;
+
+	hyp_spin_lock(&pkvm_pgd_lock);
+	ret = pkvm_create_mappings_locked(from, to, prot);
+	hyp_spin_unlock(&pkvm_pgd_lock);
+
+	return ret;
+}
+
 int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back)
 {
 	unsigned long start, end;
-- 
2.32.0.402.g57bb445576-goog

