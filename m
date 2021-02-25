Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76487325852
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhBYVDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbhBYUwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:52:39 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F1AC061A31
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a63so7644501yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=y8jiycfjUxxVO938X7a576VwC4HXLrVyvTnTPoiD+9s=;
        b=eNCsODt7UEHMvR1/ED+Zj+vz21xpXM/UQzn/+fZ0hiti6zgJjcBXAFJGQHgoD/KcQy
         xc3OLsfeE+yFMC3MvjVP05B16WvpjlNqzE1NopMAgH438ueOh4228lgH4WSj0nAXgqcA
         mva+SKPevaWJ3y9nlYApr3VMpwnHODzAu+a7GOwByn1VoWZcVNk5UQGztQ0s8Uy4Bun/
         ljpouolUDjt+bWiDo1feIAzeqKADIObgXHOHoJVmm5AN6K4tuJ62PAzDAQhe9qEJAMAc
         bAi251md3xfZs0xP3GRNhRf9F2s4LdBLL0qoF0OIac0BzUlZO4KiDMGb4j07161ctLbO
         wTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=y8jiycfjUxxVO938X7a576VwC4HXLrVyvTnTPoiD+9s=;
        b=ZmiMhF92JplrtgrZhnA9CWwvFRJU9DkInbKkR8d4qM7fDVnrjamJfOcveNOSWWgZMz
         5bpGgEMBCy5hJAAnvYQ46eeCwG4RmEhcYEdFZLv4RJfo0jajH41uDSgqz7afKkVCJ2IV
         GrziJ0UVhvOd2QqxfzHHY/IuKyPmlri3NjD4865OIyJOv9JfDh84nLIqxx+W6DO6Btgs
         w3XlQwYndc0Eg+yVI3xoxR2D9K+QOAIZ+pz6kKQasMIU7UrX/tVIq9rU8c7fdy/psfzP
         vugAxevmnaRlUmjjKU9fplfHRvZRyk0OPTJmggrWjVb7XEUcr9ngZeKm7ZbA/cOg9Rse
         fcng==
X-Gm-Message-State: AOAM532dTR5vu5ejzO/N1gW6XZ+YoGPHiH6lrq+T/GHusDRydtx9GGiM
        lQY3oN18bHU4MYX1HXo5E55Iwz5v1ug=
X-Google-Smtp-Source: ABdhPJwJMDv/GfYEkzf+62vi+Eu4Ngvn08CT2146trjLMXX0WtWN34n3K9I88D3lijgn6A2CyulqkDQl0pE=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:a25:6191:: with SMTP id v139mr6967857ybb.447.1614286137935;
 Thu, 25 Feb 2021 12:48:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 12:47:47 -0800
In-Reply-To: <20210225204749.1512652-1-seanjc@google.com>
Message-Id: <20210225204749.1512652-23-seanjc@google.com>
Mime-Version: 1.0
References: <20210225204749.1512652-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 22/24] KVM: x86/mmu: Use is_removed_spte() instead of open
 coded equivalents
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

Use the is_removed_spte() helper instead of open coding the check.

No functional change intended.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index bef0e1908e82..7f2c4760b84d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -490,7 +490,7 @@ static inline bool tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	 * Do not change removed SPTEs. Only the thread that froze the SPTE
 	 * may modify it.
 	 */
-	if (iter->old_spte == REMOVED_SPTE)
+	if (is_removed_spte(iter->old_spte))
 		return false;
 
 	if (cmpxchg64(rcu_dereference(iter->sptep), iter->old_spte,
@@ -565,7 +565,7 @@ static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
 	 * should be used. If operating under the MMU lock in write mode, the
 	 * use of the removed SPTE should not be necessary.
 	 */
-	WARN_ON(iter->old_spte == REMOVED_SPTE);
+	WARN_ON(is_removed_spte(iter->old_spte));
 
 	WRITE_ONCE(*rcu_dereference(iter->sptep), new_spte);
 
-- 
2.30.1.766.gb4fecdf3b7-goog

