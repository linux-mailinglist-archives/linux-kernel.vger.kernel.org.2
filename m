Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F38F44CCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhKJWda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhKJWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:33:22 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71503C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:30:34 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v63-20020a632f42000000b002cc65837088so2242535pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yCz7cyLf3zj3rbp6D5rVcRB8/oAS85nKHiPmUvql15M=;
        b=puwXdgsXTast2KMlehXXil09T6tXG+5+d6LEEM/ydxzkNwv1r7hW2iYVdYZ6szgVjq
         yPbJmvrEH12zVvIWThdbLT9grVe1r9BFT+gL0xWprjJiHVuqRyrNozWyfPBjifT/qXCf
         tRHBX+U0uQGPybDAqM01+aVKn1MDnv1HRc5y0KR9XPWCNqmQZg/hpJTwu8A0LfU+xs0k
         /LjK+2zXB97JjmCHERHbMDSVSHQpMtaEc7NWp7B538R2v7AFOoNbTfJNH16lhaNdIf4l
         pvuaKbzwAfjD3/CuHkJys/P3YrixNkaZwduTHuKEwJbmEXngoAd73rSlXcXiGbk3IKU+
         Qncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yCz7cyLf3zj3rbp6D5rVcRB8/oAS85nKHiPmUvql15M=;
        b=biz+EhCfICMC1+bl7/x4gO6Fqpc4k7Bg8gCc3AmX7UhtxanUgHXibQgSyihdJfR+Oh
         yCEjzupuLqgX0CI2IXD+71FZmQc7YCD9/FbB3kKXiu98j6s8L1gsZri8ho0EH6I8PI2t
         rq6ZqMzaravOaGVq/spYKHVZUqzrbfBh7qYinnLZA7zfxoNTShEv+sonU5TQlxGvFJam
         EnP8KLuF01k/B7AyAkY+acun0Si7Okk16VS9HKNaUaFVq9WjxXTxbOEAgfa+zhAE1sXU
         +hdjgqYjSn7karM/U1BFBliXb5TZ1aitrj5kJRIhuTb8aaZ89k4m7ie0SQa8eoC5oWYY
         7Sqg==
X-Gm-Message-State: AOAM533Pc6uIvOpHYQwEYCTzjCFNsxtBU9Gtr+GBnZCn6XdAf8EeiE2P
        HHWM7WCefU+53TZH/pQue3soARb3X64wj/VdBZ6GTG08WlUbZmPdZRzvP6M1fptZiGeqForAnlb
        v2FcTlQWWIRPsRsXJ+PwYPbGsTKO9WcjxbZlweTMj+amwSPu6NcNUyGWVjuzkawYpdj745/zt
X-Google-Smtp-Source: ABdhPJxpMsqYTyzUV1XtB8oPH6XSH/mhtghcJCEb8GMNVlWHOgVZ5EhWP4YdliIdeqQu7u5r2KSoqvuL4HAE
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:6586:7b2f:b259:2011])
 (user=bgardon job=sendgmr) by 2002:a05:6a00:2349:b0:49f:db1d:c378 with SMTP
 id j9-20020a056a00234900b0049fdb1dc378mr2436949pfj.53.1636583433793; Wed, 10
 Nov 2021 14:30:33 -0800 (PST)
Date:   Wed, 10 Nov 2021 14:29:55 -0800
In-Reply-To: <20211110223010.1392399-1-bgardon@google.com>
Message-Id: <20211110223010.1392399-5-bgardon@google.com>
Mime-Version: 1.0
References: <20211110223010.1392399-1-bgardon@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC 04/19] KVM: x86/mmu: Yield while processing disconnected_sps
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

When preparing to free disconnected SPs, the list can accumulate many
entries; enough that it is likely necessary to yeild while queuing RCU
callbacks to free the SPs.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index a448f0f2d993..c2a9f7acf8ef 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -513,7 +513,8 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
  * being removed from the paging structure and this function being called.
  */
 static void handle_disconnected_sps(struct kvm *kvm,
-				    struct list_head *disconnected_sps)
+				    struct list_head *disconnected_sps,
+				    bool can_yield, bool shared)
 {
 	struct kvm_mmu_page *sp;
 	struct kvm_mmu_page *next;
@@ -521,6 +522,16 @@ static void handle_disconnected_sps(struct kvm *kvm,
 	list_for_each_entry_safe(sp, next, disconnected_sps, link) {
 		list_del(&sp->link);
 		call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
+
+		if (can_yield &&
+		    (need_resched() || rwlock_needbreak(&kvm->mmu_lock))) {
+			rcu_read_unlock();
+			if (shared)
+				cond_resched_rwlock_read(&kvm->mmu_lock);
+			else
+				cond_resched_rwlock_write(&kvm->mmu_lock);
+			rcu_read_lock();
+		}
 	}
 }
 
@@ -599,7 +610,7 @@ static inline bool tdp_mmu_zap_spte_atomic(struct kvm *kvm,
 	 */
 	WRITE_ONCE(*rcu_dereference(iter->sptep), 0);
 
-	handle_disconnected_sps(kvm, &disconnected_sps);
+	handle_disconnected_sps(kvm, &disconnected_sps, false, true);
 
 	return true;
 }
@@ -817,7 +828,8 @@ static bool zap_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 
 	if (!list_empty(&disconnected_sps)) {
 		kvm_flush_remote_tlbs(kvm);
-		handle_disconnected_sps(kvm, &disconnected_sps);
+		handle_disconnected_sps(kvm, &disconnected_sps,
+					can_yield, shared);
 		flush = false;
 	}
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

