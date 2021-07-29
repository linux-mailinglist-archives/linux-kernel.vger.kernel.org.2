Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDC3DA443
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhG2N3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbhG2N24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3AC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:53 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z16-20020ac87cb00000b029025bf786be09so2727624qtv.20
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AlIcs6je/4eH5g1VpJMJ6MIaoeGclfxxvTq2IG6FTnE=;
        b=PojaLSp2J3h7SGHoj/wg3sKvQEJru11qmRDv6TPyUDNP0v2sIgCgjnQcQBfVvjJIBd
         yvSNbLe1o+nRvt4gE0x+yU5fyEqbr0b5rs+ag4a5W3POPPbpSKs5xgMCz0wnKXhZeNQJ
         Jz8fp9z+v6v263KlELujgmCZkDPY4LwdYCPTuK3m51ARcYRoysYF4I+3aFi/t2XpYMF3
         LZR4+yesCGdVYduYfwUa+43g/OSLzHdoLEJ6HOnuqE+eHQa2gYpDnE7HKgtttm2Q3g6D
         wMuKjYgK7mmdnQTrjI/+6Qfcz2yvwA+zA0dgaLkl/O6s+UYLBYYi6gfD4pqB6YDAw10Q
         LWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AlIcs6je/4eH5g1VpJMJ6MIaoeGclfxxvTq2IG6FTnE=;
        b=lTGzBT2O5s2mC9hUBTMh9HAeinjqa1T73fV1B1muE710OjajiEv1f/ZVfq+Ns0UqBE
         e44OjSMiAN0wwfAJKgZpPXqnrj10usPVokdxwlylcaMOwb0vokEyPn4+NhX7ZBKk1dgO
         6iUrygPyrWPL0rp8c1wWREifh9pTJAlcltkHZdorUdjiXj04BjcsaA9+wbQyRboMY/ws
         ktq08oSby77vDG7KlG/GlFOLNsWCVW6T6khftJne/39Tufqom/Gt2wDjBlC+g+nTYK2v
         1LKfKF8wmo2LlZnGRURTbp9qKUI/FIYgJg44SAhm88HGpl8Wb6TQwYSpt6tQZc7O7DVc
         b75Q==
X-Gm-Message-State: AOAM530BzEq6y+VebU+XuKY52a3Rx5uvKG/WQJ4SGVz4m//0N0qiKSoQ
        V6yMrlf41rOMJaAkRq3is0bAMn8bQgUB
X-Google-Smtp-Source: ABdhPJwjclaLvF9NNfuY6mTQNdmoAJ3rTkidxuL1gXdxsvT/IfAhg+ijqY4w89EJuF24aa4xY4D+MGf/w1eo
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:20c8:: with SMTP id
 8mr1933136qve.4.1627565332854; Thu, 29 Jul 2021 06:28:52 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:28:10 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-14-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 13/21] KVM: arm64: Expose host stage-2 manipulation helpers
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

We will need to manipulate the host stage-2 page-table from outside
mem_protect.c soon. Introduce two functions allowing this, and make
them usable to users of mem_protect.h.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 ++
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index ae355bfd8c01..47c2a0c51612 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -49,6 +49,8 @@ extern struct host_kvm host_kvm;
 int __pkvm_prot_finalize(void);
 int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
 
+int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
+int host_stage2_set_owner_locked(u64 start, u64 end, u8 owner_id);
 int kvm_host_prepare_stage2(void *pgt_pool_base);
 void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 70c57d2c3024..a7f6134789e0 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -272,6 +272,21 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
 	return 0;
 }
 
+int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot)
+{
+	hyp_assert_lock_held(&host_kvm.lock);
+
+	return host_stage2_try(__host_stage2_idmap, start, end, prot);
+}
+
+int host_stage2_set_owner_locked(u64 start, u64 end, u8 owner_id)
+{
+	hyp_assert_lock_held(&host_kvm.lock);
+
+	return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
+			       start, end - start, &host_s2_pool, owner_id);
+}
+
 static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
 {
 	/*
@@ -309,7 +324,7 @@ static int host_stage2_idmap(u64 addr)
 	if (ret)
 		goto unlock;
 
-	ret = host_stage2_try(__host_stage2_idmap, range.start, range.end, prot);
+	ret = host_stage2_idmap_locked(range.start, range.end, prot);
 unlock:
 	hyp_spin_unlock(&host_kvm.lock);
 
-- 
2.32.0.432.gabb21c7263-goog

